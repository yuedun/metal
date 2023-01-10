package api

import (
	"bytes"
	"encoding/base64"
	"encoding/gob"
	"fmt"
	"metal/controllers"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/service"
	"metal/util"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/config"
	"github.com/beego/beego/v2/core/logs"
)

type UserAPIController struct {
	controllers.AdminBaseController
}

// 登录接口
func (c *UserAPIController) ToLogin() {
	var err error
	var code int
	var data interface{}
	defer func(start time.Time) {
		var rsp controllers.Result
		rsp.Code = code
		rsp.Cost = time.Since(start).Milliseconds()
		rsp.Msg = http.StatusText(code)
		if err != nil {
			rsp.Msg = fmt.Sprintf("%s - %s", rsp.Msg, err.Error())
			logs.Error(rsp.Msg)
			c.Data["json"] = c.ErrorData(err, code)
		} else {
			c.Data["json"] = c.SuccessData(data)
		}
		c.ServeJSON()
	}(time.Now())
	var mobile = c.GetString("mobile") //or email
	var password = c.GetString("password")
	var remember, _ = c.GetBool("remember")

	user := &User{Mobile: mobile}
	err = user.GetByMobile()
	salt, err := config.String("salt")
	if err != nil {
		logs.Error("not found salt")
		code = http.StatusInternalServerError
		return
	}
	if user.Status == 0 {
		err = fmt.Errorf("该账号已禁用，不能登录！")
		code = http.StatusForbidden
		return
	} else if user.Password != util.GetMD5(password, salt) {
		err = fmt.Errorf("密码不正确！")
		code = http.StatusBadRequest
		return
	}

	permissionSrv := service.NewPermissionService(orm.NewOrm())
	roleList, err1 := permissionSrv.GetPermissionsByUserId(user.Id)
	if err1 != nil {
		err = err1
		code = http.StatusInternalServerError
		return
	}
	//获取权限保存到session中
	var privileges []string
	for _, v := range roleList {
		strArr := strings.Split(v.Permissions, ",")
		privileges = append(privileges, strArr...)
	}
	userPermission := new(controllers.UserPermission)
	userPermission.User = *user
	userPermission.Privileges = privileges
	c.SetSession("loginUser", userPermission)
	if remember {
		//存储token到数据库
		buf := new(bytes.Buffer)
		//gob编码
		enc := gob.NewEncoder(buf)
		if err := enc.Encode(userPermission); err != nil {
			fmt.Println(err)
		}
		encoded := base64.StdEncoding.EncodeToString(buf.Bytes())
		logs.Debug(encoded)
		// user.Token = encoded
		// user.Update("token")
		// data = encoded
	}
	// c.Ctx.Input.IP()获取到的是Nginx内网ip，需要在Nginx配置proxy_set_header Remote_addr $remote_addr;
	ip := c.Ctx.Input.Header("Remote_addr")
	if ip != "" {
		//第三方接口不稳定，会阻塞整体，所以放到协程中
		go func() {
			ipBody := new(util.IPBody)
			err := util.GetIpGeography(ip, ipBody)
			if err == nil {
				loginLog := new(Log)
				// mark := fmt.Sprintf("登录IP:%s，物理地址：%s %s %s %s", ip, ipBody.Data.Country, ipBody.Data.Area, ipBody.Data.Region, ipBody.Data.City)
				mark := fmt.Sprintf("登录IP:%s，物理地址：%s", ip, ipBody.Content.Address)
				loginLog.Save(mark)
			}
		}()
	}
}

/**
 * 登出
 */
func (c *UserAPIController) LoginOut() {
	c.DelSession("loginUser")
	c.Redirect("/admin/page/login", 302)
}

// 新建用户
func (c *UserAPIController) CreateUser() {
	var err error
	var code int
	var data any
	defer func(start time.Time) {
		var rsp controllers.Result
		rsp.Code = code
		rsp.Cost = time.Since(start).Milliseconds()
		rsp.Msg = http.StatusText(code)
		if err != nil {
			rsp.Msg = fmt.Sprintf("%s - %s", rsp.Msg, err.Error())
			logs.Error(rsp.Msg)
			c.Data["json"] = c.ErrorData(err, code)
		} else {
			c.Data["json"] = c.SuccessData(data)
		}
		c.ServeJSON()
	}(time.Now())
	args := map[string]string{}
	c.BindJSON(&args)
	logs.Debug(">>>>>>>>", args)
	mobile := args["mobile"]
	if mobile == "" {
		code = http.StatusBadRequest
		err = fmt.Errorf("手机号不能为空！")
		return
	}
	username := args["username"] // 只能接收url后面的参数，不能接收body中的参数
	if username == "" {
		code = http.StatusBadRequest
		err = fmt.Errorf("名称不能为空！")
		return
	}
	sex := args["sex"]
	email := args["email"]
	addr := args["addr"]
	description := args["description"]
	salt, err := config.String("salt")
	if err != nil {
		logs.Error("not found salt")
		code = http.StatusInternalServerError
		err = fmt.Errorf("not found salt")
	}
	logs.Debug("salt", salt)
	password := util.GeneratePassword(mobile, salt) //metal+手机后4位

	var user = new(User)
	user.Username = username
	user.Gender, _ = strconv.Atoi(sex)
	user.Mobile = mobile
	user.Email = email
	user.Addr = addr
	user.Description = description
	user.Password = password

	id, err1 := user.Save()
	if nil != err1 {
		logs.Error(err)
		err = err1
		return
	}
	data = id
}

/**
 * 通过如下方式获取路由参数
 * /admin/page/user/:id
 * c.Ctx.Input.Param(":id")
 */
func (c *UserAPIController) UserGet() {
	idstr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idstr)
	user := new(User)
	user.Id = uint(id)
	userObj, err := user.GetById()
	if err != nil {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(userObj)
	c.ServeJSON()
}

/**
 * 修改用户
 */
func (c *UserAPIController) UpdateUser() {
	var form struct {
		UserId   uint   `json:"userId"`
		Username string `json:"username"`
		Email    string `json:"email"`
		Gender   int    `json:"gender"`
		Mobile   string `json:"mobile"`
		Addr     string `json:"addr"`
		Desc     string `json:"desc"`
	}
	c.Bind(&form)
	logs.Debug("%+v", form)

	user := User{
		Username:    form.Username,
		Gender:      form.Gender,
		Email:       form.Email,
		Mobile:      form.Mobile,
		Addr:        form.Addr,
		Description: form.Desc,
	}
	user.Id = form.UserId
	user.UpdatedAt = time.Now()
	upId, err := user.Update("username", "gender", "email", "mobile", "addr", "description")
	if nil != err {
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(upId)
	}
	c.ServeJSON()
}

/**
 * 用户列表接口
 * /admin/page/users
 */
func (c *UserAPIController) UserList() {
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	username := c.GetString("username")
	mobile := c.GetString("mobile")
	email := c.GetString("email")
	user := new(User)
	var userVOList = make([]UserVO, 0)
	var param = make(map[string]string)
	param["mobile"] = mobile
	param["username"] = username
	param["email"] = email
	list, total, err := user.GetUserList(param, start, perPage)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		for index, u := range list {
			userVo := new(UserVO)
			userVo.User = u
			userVo.Gender = SexMap[u.Gender]
			userVo.CreatedAt = u.CreatedAt.Format("2006-01-02 15:04:05")
			userVo.UpdatedAt = u.UpdatedAt.Format("2006-01-02 15:04:05")
			userVOList = append(userVOList[:index], *userVo)
		}
		data := map[string]any{
			"result": userVOList,
			"total":  total,
		}
		c.Data["json"] = c.SuccessData(data)
	}
	c.ServeJSON()
}

/**
 * 禁用用户
 */
func (c *UserAPIController) DisableUser() {
	id, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	var user = new(User)
	user.Id = uint(id)
	user.Status = 0
	id64, err := user.UpdateStatus()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(id64)
	}
	c.ServeJSON()
}

/**
 * 启用用户
 */
func (c *UserAPIController) EnableUser() {
	id, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	var user = new(User)
	user.Id = uint(id)
	user.Status = 1
	id64, err := user.UpdateStatus()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(id64)
	}
	c.ServeJSON()
}

/**
 * 删除用户
 */
func (c *UserAPIController) DeleteUser() {
	id, _ := c.GetInt("userId")
	var user = new(User)
	user.Id = uint(id)
	user.Status = 0
	id64, err := user.Delete()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(id64)
	}
	c.ServeJSON()
}
