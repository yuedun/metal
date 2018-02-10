package controllers

import (
	"fmt"
	. "metal/models"
	"strconv"
	"time"

	"github.com/astaxie/beego"
)

type UserController struct {
	beego.Controller
}

var SexMap = map[int]string{0: "女", 1: "男"}

func (this *UserController) Login() {
	this.TplName = "admin/login.html"
}
func (this *UserController) ToLogin() {
	fmt.Println(">>>>>>>>>>>>tologin")
	this.Redirect("/admin/welcome", 302)
}
func (this *UserController) Welcome() {
	this.TplName = "admin/index.html"
}

func (this *UserController) UserAdd() {
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
	user := &Users{
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
	fmt.Println(">>>>>>>>>", idstr)
	id, _ := strconv.Atoi(idstr)
	user := &Users{Id: id}
	userObj, _ := user.FindUserById()
	this.Data["user"] = userObj
	this.TplName = "admin/user-show.html"
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * this.Ctx.Input.Param(":id")
 */
func (this *UserController) Put() {
	userId, _ := this.GetInt("id")
	username := this.GetString("username") //只能接收url后面的参数，不能接收body中的参数
	email := this.GetString("email")
	user := &Users{Id: userId, Username: username, Email: email}
	upId, err := user.UpdateUser()
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
func (this *UserController) UserList() {
	user := new(Users)
	var userPojo = []UserPOJO{}
	userList, err := user.FindAllUser()
	for index, u := range userList {
		userp := new(UserPOJO)
		userp.Users = u
		userp.Gender = SexMap[u.Gender]
		userp.CreatedAt = u.CreatedAt.Format("2006-01-02 15:04:05")
		userp.UpdatedAt = u.UpdatedAt.Format("2006-01-02 15:04:05")
		userPojo = append(userPojo[:index], *userp)
	}
	if nil != err {
		this.Data["json"] = map[string]any{"msg": err}
		this.ServeJSON()
	}
	this.Data["userList"] = userPojo
	this.Data["total"] = len(userPojo)
	this.TplName = "admin/user-list.html"
}

/**
 * 通过如下方式获取路由参数
 * /admin/user/:id
 * this.Ctx.Input.Param(":id")
 */
func (this *UserController) Delete() {
	idstr, err := this.GetInt("userId")

	user := &Users{Id: idstr}
	id, err := user.DeleteUser()
	if nil != err {
		this.Data["json"] = map[string]any{"result": false, "msg": err}
	} else {
		this.Data["json"] = map[string]any{"result": true, "msg": id}
	}
	this.ServeJSON()
}
