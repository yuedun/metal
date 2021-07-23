package api

import (
	"encoding/json"
	"fmt"
	"metal/controllers"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/util"
	"strconv"
	"strings"
	"time"

	"github.com/beego/beego/v2/core/logs"
)

type UserAPIController struct {
	controllers.AdminBaseController
}

//登录接口
func (c *UserAPIController) ToLogin() {
	var mobile = c.GetString("mobile")
	var password = c.GetString("password")

	user := &User{Mobile: mobile}
	err := user.GetByMobile()
	if err != nil {
		logs.Error(err)
		c.Data["json"] = controllers.ErrorData(err)
	} else if user.Status == 0 {
		c.Data["json"] = controllers.ErrorMsg("该账号已禁用，不能登录！")
	} else if user.Password != util.GetMD5(password) {
		c.Data["json"] = controllers.ErrorMsg("密码不正确！")
	} else {
		group := new(Groups)
		roleList, err := group.GetGroupByUserId(user.Id)
		if err != nil {
			c.Data["json"] = controllers.ErrorData(err)
		}
		var privileges []string
		for _, v := range roleList {
			strArr := strings.Split(v.Groups, ",")
			privileges = append(privileges, strArr...)
		}
		userPermission := new(controllers.UserPermission)
		userPermission.User = *user
		userPermission.Privileges = privileges
		c.SetSession("loginUser", userPermission)
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
		c.Data["json"] = controllers.SuccessData(nil)
	}
	c.ServeJSON()
}

/**
 * 登出
 */
func (c *UserAPIController) LoginOut() {
	c.DelSession("loginUser")
	c.Redirect("/admin/page/login", 302)
}

/**
 * 新建用户
 */
func (c *UserAPIController) Post() {
	args := map[string]string{}
	body := c.Ctx.Input.RequestBody //接收raw body内容
	json.Unmarshal(body, &args)
	mobile := args["mobile"]
	username := args["username"] // 只能接收url后面的参数，不能接收body中的参数
	sex := args["sex"]
	email := args["email"]
	addr := args["addr"]
	description := args["description"]
	password := util.GeneratePassword(mobile)
	createdAt := time.Now()
	updatedAt := time.Now()

	var user = new(User)
	user.UserName = username
	user.Gender, _ = strconv.Atoi(sex)
	user.Mobile = mobile
	user.Email = email
	user.Addr = addr
	user.Description = description
	user.Password = password
	user.CreatedAt = createdAt
	user.UpdatedAt = updatedAt

	id, err := user.Save()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = controllers.ErrorData(err)
	} else {
		c.Data["json"] = controllers.SuccessData(id)
	}
	c.ServeJSON()
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
		c.Data["json"] = controllers.ErrorData(err)
	}
	c.Data["json"] = controllers.SuccessData(userObj)
	c.ServeJSON()
}

/**
 * 修改用户
 */
func (c *UserAPIController) UpdateUser() {
	userId, _ := c.GetInt("userId")
	username := c.GetString("username") // 只能接收url后面的参数，不能接收body中的参数
	email := c.GetString("email")
	gender, _ := c.GetInt("gender")
	mobile := c.GetString("mobile")
	addr := c.GetString("addr")
	desc := c.GetString("desc")
	updatedAt := time.Now()

	var user = new(User)
	user.Id = uint(userId)
	user.UserName = username
	user.Gender = gender
	user.Email = email
	user.Mobile = mobile
	user.Addr = addr
	user.Description = desc
	user.UpdatedAt = updatedAt
	upId, err := user.Update()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = controllers.ErrorData(err)
	} else {
		c.Data["json"] = controllers.SuccessData(upId)
	}
	c.ServeJSON()
}

/**
 * 用户列表接口
 * /admin/page/users
 */
func (c *UserAPIController) UserList() {
	args := c.GetString("search") //搜索框
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	user := new(User)
	var userVOList = make([]UserVO, 10)
	var param = make(map[string]string)
	param["mobile"] = args
	param["username"] = args
	list, total, err := user.GetAllByCondition(param, start, perPage)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = controllers.ErrorData(err)
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
		c.Data["json"] = controllers.SuccessData(data)
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
		c.Data["json"] = controllers.ErrorData(err)
	} else {
		c.Data["json"] = controllers.SuccessData(id64)
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
		c.Data["json"] = controllers.ErrorData(err)
	} else {
		c.Data["json"] = controllers.SuccessData(id64)
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
		c.Data["json"] = controllers.ErrorData(err)
	} else {
		c.Data["json"] = controllers.SuccessData(id64)
	}
	c.ServeJSON()
}
