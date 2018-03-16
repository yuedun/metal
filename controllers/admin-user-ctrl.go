package controllers

import (
	"fmt"
	. "metal/models"
	"strconv"
	"time"
)

type UserController struct {
	BaseController
}

var SexMap = map[int]string{0: "女", 1: "男"}

func (c *UserController) Login() {
	c.TplName = "admin/login.html"
}
func (c *UserController) ToLogin() {
	//args := map[string]string{}
	//body := c.Ctx.Input.RequestBody//接收raw body内容
	//json.Unmarshal(body, &args)
	//mobile := args["mobile"]
	//password := args["password"]
	var mobile = c.GetString("mobile")
	var password = c.GetString("password")
	user := &User{Mobile: mobile}
	err := user.GetByMobile()
	if err != nil {
		c.Data["json"] = map[string]any{"msg": fmt.Sprint(err), "code": 1}
	} else if user.Password != password {
		c.Data["json"] = map[string]any{"msg": "密码不正确", "code": 1}
	} else {
		c.SetSession("loginUser", user)
		c.Data["json"] = map[string]any{"msg": "ok", "code": 0}
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
	fmt.Println(">>>>>session:", c.GetSession("loginUser"))
	c.TplName = "admin/index.html"
}

func (c *UserController) UserAddRoute() {
	c.TplName = "admin/user-add.html"
}

func (c *UserController) Post() {
	username := c.GetString("username") //只能接收url后面的参数，不能接收body中的参数
	sex, _ := c.GetInt("sex")
	mobile := c.GetString("mobile")
	email := c.GetString("email")
	addr := c.GetString("addr")
	description := c.GetString("description")
	createdAt := time.Now()
	updatedAt := time.Now()
	user := &User{
		Username:    username,
		Gender:      sex,
		Mobile:      mobile,
		Email:       email,
		Addr:        addr,
		Description: description,
		CreatedAt:   createdAt,
		UpdatedAt:   updatedAt,
	}
	id, err := user.Save()
	if nil != err {
		c.Data["json"] = map[string]any{"msg": err}
	} else {
		c.Data["json"] = map[string]any{"msg": id}
	}
	//c.ServeJSON()
	c.Redirect("/admin/user-list", 302)
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * c.Ctx.Input.Param(":id")
 */
func (c *UserController) UserGet() {
	idstr := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idstr)
	user := &User{Id: id}
	userObj, err := user.GetById()
	fmt.Println(userObj)
	if err != nil {
		c.Data["json"] = map[string]any{"msg": err}
	}
	c.Data["json"] = map[string]any{"msg": err, "result": userObj}
	c.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * c.Ctx.Input.Param(":id")
 */
func (c *UserController) Put() {
	userId, _ := c.GetInt("userId")
	username := c.GetString("username") //只能接收url后面的参数，不能接收body中的参数
	email := c.GetString("email")
	gender, _ := c.GetInt("gender")
	mobile := c.GetString("mobile")
	addr := c.GetString("addr")
	updatedAt := time.Now()
	user := &User{Id: userId, Username: username, Gender: gender, Email: email, Mobile: mobile, Addr: addr, UpdatedAt: updatedAt}
	upId, err := user.Update()
	if nil != err {
		c.Data["json"] = map[string]any{"result": false, "msg": err}
	} else {
		c.Data["json"] = map[string]any{"result": true, "msg": upId}
	}
	c.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * c.Ctx.Input.Param(":id")
 */
func (c *UserController) UserListRoute() {
	//user := new(User)
	//var userPojo = []UserVO{}
	//userList, err := user.GetAll()
	//for index, u := range userList {
	//	userp := new(UserVO)
	//	userp.User = u
	//	userp.Gender = SexMap[u.Gender]
	//	userp.CreatedAt = u.CreatedAt.Format("2006-01-02 15:04:05")
	//	userp.UpdatedAt = u.UpdatedAt.Format("2006-01-02 15:04:05")
	//	userPojo = append(userPojo[:index], *userp)
	//}
	//if nil != err {
	//	c.Data["json"] = map[string]any{"msg": err}
	//	c.ServeJSON()
	//}
	//c.Data["userList"] = userPojo
	//c.Data["total"] = len(userPojo)
	c.Data["Title"] = "用户列表"
	c.TplName = "admin/user-list.html"
}

/**
 * 通过ajax获取数据
 * /admin/users
 */
func (c *UserController) UserList() {
	args := c.Input() //获取所有参数
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	user := new(User)
	var userVOList = []UserVO{}
	userList, total, err := user.GetAllByCondition(args, start, perPage)
	for index, u := range userList {
		userVo := new(UserVO)
		userVo.User = u
		userVo.Gender = SexMap[u.Gender]
		userVo.CreatedAt = u.CreatedAt.Format("2006-01-02 15:04:05")
		userVo.UpdatedAt = u.UpdatedAt.Format("2006-01-02 15:04:05")
		userVOList = append(userVOList[:index], *userVo)
	}
	if nil != err {
		c.Data["json"] = map[string]any{"msg": err}
	} else {
		c.Data["json"] = map[string]any{
			"result": userVOList,
			"total":  total,
			"msg":    "ok",
		}
	}
	//time.Sleep(time.Second*2)
	c.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * c.Ctx.Input.Param(":id")
 */
func (c *UserController) DeleteUser() {
	id, _ := c.GetInt("userId")
	user := &User{Id: id}
	id64, err := user.Delete()
	if nil != err {
		c.Data["json"] = map[string]any{"result": false, "msg": err}
	} else {
		c.Data["json"] = map[string]any{"result": true, "msg": id64}
	}
	c.ServeJSON()
}
