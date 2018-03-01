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

func (this *UserController) Login() {
	this.TplName = "admin/login.html"
}
func (this *UserController) ToLogin() {
	//args := map[string]string{}
	//body := this.Ctx.Input.RequestBody//接收raw body内容
	//json.Unmarshal(body, &args)
	//mobile := args["mobile"]
	//password := args["password"]
	var mobile = this.GetString("mobile")
	var password = this.GetString("password")
	user := &User{Mobile: mobile}
	err := user.GetByMobile()
	if err != nil {
		this.Data["json"] = map[string]any{"msg": fmt.Sprint(err), "code": 1}
	} else if user.Password != password {
		this.Data["json"] = map[string]any{"msg": "密码不正确", "code": 1}
	} else {
		this.SetSession("loginUser", user)
		this.Data["json"] = map[string]any{"msg": "ok", "code": 0}
	}
	this.ServeJSON()
}

/**
 * 登出
 */
func (this *UserController) LoginOut() {
	this.DelSession("loginUser")
	this.Redirect("/admin/login", 302)
}

func (this *UserController) Welcome() {
	fmt.Println(">>>>>session:", this.GetSession("loginUser"))
	this.TplName = "admin/index.html"
}

func (this *UserController) UserAddRoute() {
	this.TplName = "admin/user-add.html"
}

func (this *UserController) Post() {
	username := this.GetString("username") //只能接收url后面的参数，不能接收body中的参数
	sex, _ := this.GetInt("sex")
	mobile := this.GetString("mobile")
	email := this.GetString("email")
	addr := this.GetString("addr")
	description := this.GetString("description")
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
		this.Data["json"] = map[string]any{"msg": err}
	} else {
		this.Data["json"] = map[string]any{"msg": id}
	}
	//this.ServeJSON()
	this.Redirect("/admin/user-list", 302)
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * this.Ctx.Input.Param(":id")
 */
func (this *UserController) UserGet() {
	idstr := this.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(idstr)
	user := &User{Id: id}
	userObj, err := user.GetById()
	fmt.Println(userObj)
	if err != nil {
		this.Data["json"] = map[string]any{"msg": err}
	}
	this.Data["json"] = map[string]any{"msg": err, "result": userObj}
	this.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * this.Ctx.Input.Param(":id")
 */
func (this *UserController) Put() {
	userId, _ := this.GetInt("userId")
	username := this.GetString("username") //只能接收url后面的参数，不能接收body中的参数
	email := this.GetString("email")
	gender, _ := this.GetInt("gender")
	mobile := this.GetString("mobile")
	addr := this.GetString("addr")
	updatedAt := time.Now()
	user := &User{Id: userId, Username: username, Gender: gender, Email: email, Mobile: mobile, Addr: addr, UpdatedAt: updatedAt}
	upId, err := user.Update()
	if nil != err {
		this.Data["json"] = map[string]any{"result": false, "msg": err}
	} else {
		this.Data["json"] = map[string]any{"result": true, "msg": upId}
	}
	this.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * this.Ctx.Input.Param(":id")
 */
func (this *UserController) UserListRoute() {
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
	//	this.Data["json"] = map[string]any{"msg": err}
	//	this.ServeJSON()
	//}
	//this.Data["userList"] = userPojo
	//this.Data["total"] = len(userPojo)
	this.Data["Title"] = "用户列表"
	this.TplName = "admin/user-list.html"
}

/**
 * 通过ajax获取数据
 * /admin/users
 */
func (this *UserController) UserList() {
	args := this.Input() //获取所有参数
	start, _ := this.GetInt("start")
	perPage, _ := this.GetInt("perPage")
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
		this.Data["json"] = map[string]any{"msg": err}
	} else {
		this.Data["json"] = map[string]any{"result": userVOList, "total": total, "msg": "ok"}
	}
	//time.Sleep(time.Second*2)
	this.ServeJSON()
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * this.Ctx.Input.Param(":id")
 */
func (this *UserController) DeleteUser() {
	id, _ := this.GetInt("userId")
	user := &User{Id: id}
	id64, err := user.Delete()
	if nil != err {
		this.Data["json"] = map[string]any{"result": false, "msg": err}
	} else {
		this.Data["json"] = map[string]any{"result": true, "msg": id64}
	}
	this.ServeJSON()
}
