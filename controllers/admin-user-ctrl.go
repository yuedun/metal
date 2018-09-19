package controllers

import (
	"encoding/json"
	"fmt"
	"log"
	. "metal/models" // 点操作符导入的包可以省略报名直接使用公有属性和方法
	"metal/util"
	"strconv"
	"strings"
	"time"
)

type UserController struct {
	AdminBaseController
}

func (c *UserController) Login() {
	c.TplName = "admin/login.html"
}
func (c *UserController) ToLogin() {
	var mobile = c.GetString("mobile")
	var password = c.GetString("password")
	c.Ctx.Input.IP()
	// c.Ctx.Input.IP()获取到的是Nginx内网ip，需要在Nginx配置proxy_set_header Remote_addr $remote_addr;
	ip := c.Ctx.Input.Header("Remote_addr")
	if ip != "" {
		ipBody := new(util.IPBody)
		util.GetIpGeography(ip, ipBody)
		loginLog := new(Log)
		mark := fmt.Sprintf("登录IP:%s，物理地址：%s %s %s %s", ip, ipBody.Data.Country, ipBody.Data.Area, ipBody.Data.Region, ipBody.Data.City)
		loginLog.Save(mark)
	}

	user := &User{Mobile: mobile}
	err := user.GetByMobile()
	if err != nil {
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else if user.Status == 0 {
		c.Data["json"] = ErrorMsg("该账号已禁用，不能登录！")
	} else if user.Password != util.GetMD5(password) {
		c.Data["json"] = ErrorMsg("密码不正确！")
	} else {
		group := new(Groups)
		roleList, err := group.GetGroupByUserId(user.Id)
		if err != nil {
			c.Data["json"] = ErrorData(err)
		}
		var privileges []string
		for _, v := range roleList {
			strArr := strings.Split(v.Groups, ",")
			privileges = append(privileges, strArr...)
		}
		userPermission := new(UserPermission)
		userPermission.User = *user
		userPermission.Privileges = privileges
		c.SetSession("loginUser", userPermission)
		c.Data["json"] = SuccessData(nil)
	}
	c.ServeJSON()
}

/**
 * 登出
 */
func (c *UserController) LoginOut() {
	c.DelSession("loginUser")
	c.Redirect("/admin/login", 302)
}

func (c *UserController) Welcome() {
	c.TplName = "admin/index.html"
}

func (c *UserController) UserAddRoute() {
	c.TplName = "admin/user-add.html"
}

/**
 * 新建用户
 */
func (c *UserController) Post() {
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
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(id)
	}
	c.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * c.Ctx.Input.Param(":id")
 */
func (c *UserController) UserGet() {
	idstr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idstr)
	user := new(User)
	user.Id = uint(id)
	userObj, err := user.GetById()
	log.Println(userObj)
	if err != nil {
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	}
	c.Data["json"] = SuccessData(userObj)
	c.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 */
func (c *UserController) Put() {
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
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(upId)
	}
	c.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 */
func (c *UserController) UserListRoute() {
	c.Data["Title"] = "用户列表"
	c.TplName = "admin/user-list.html"
}

/**
 * 通过ajax获取数据
 * /admin/users
 */
func (c *UserController) UserList() {
	args := c.GetString("search") // 获取所有参数
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	user := new(User)
	var userVOList = make([]UserVO, 10)
	var param = make(map[string]string)
	param["mobile"] = args
	param["username"] = args
	userList, total, err := user.GetAllByCondition(param, start, perPage)
	if nil != err {
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else {
		for index, u := range userList {
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
		c.Data["json"] = SuccessData(data)
	}
	c.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 */
func (c *UserController) DeleteUser() {
	id, _ := c.GetInt("userId")
	var user = new(User)
	user.Id = uint(id)
	user.Status = 0
	id64, err := user.Delete()
	if nil != err {
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(id64)
	}
	c.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 */
// @router /get-logs-route
func (c *UserController) GetLogsRoute() {
	c.Data["Title"] = "日志列表"
	c.TplName = "admin/logs.html"
}

/**
 * 通过如下方式获取路由参数
 */
// @router /logs [get]
func (c *UserController) GetLogs() {
	var logModel = new(Log)
	logs, err := logModel.GetLogs()
	if nil != err {
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else {
		data := map[string]any{
			"result": logs,
			"total":  len(logs),
		}
		c.Data["json"] = SuccessData(data)
	}
	c.ServeJSON()
}
