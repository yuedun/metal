package controllers

import (
	"fmt"
	. "metal/models"
	"time"

	"github.com/astaxie/beego"
)

type UserController struct {
	beego.Controller
}

var SexMap = map[int]string{0: "女", 1: "男"}

func (this *UserController) UserAdd() {
	this.TplName = "admin/user-add.html"
}

func (this *UserController) Post() {
	username := this.GetString("username") //只能接收url后面的参数，不能接收body中的参数
	sex, _ := this.GetInt("sex")
	createdAt := time.Now() //.Format("2006-01-02 15:04:05")
	updatedAt := time.Now() //.Format("2006-01-02 15:04:05")
	user := &Users{Username: username, Gender: SexMap[sex], CreatedAt: createdAt, UpdatedAt: updatedAt}
	id, err := user.AddUser()
	if nil != err {
		this.Data["json"] = map[string]interface{}{"msg": err}
		this.ServeJSON()
	}
	fmt.Print(id, err)
	this.Redirect("/admin/user-list", 302)
}
func (this *UserController) GetUser() {
	username := this.Ctx.Input.Param(":username")
	user := &Users{Username: username}
	user, err := user.FindUser()
	if nil != err {
		this.Data["json"] = map[string]interface{}{"result": false, "msg": this.Ctx.Input.Params()}
	} else {
		this.Data["json"] = map[string]interface{}{"result": true, "msg": user}
	}
	this.ServeJSON()
}

func (this *UserController) Put() {
	userId, _ := this.GetInt("id")
	username := this.GetString("username") //只能接收url后面的参数，不能接收body中的参数
	email := this.GetString("email")
	user := &Users{Id: userId, Username: username, Email: email}
	upId, err := user.UpdateUser()
	if nil != err {
		this.Data["json"] = map[string]interface{}{"result": false, "msg": err}
	} else {
		this.Data["json"] = map[string]interface{}{"result": true, "msg": upId}
	}
	this.ServeJSON()
}
func (this *UserController) UserList() {
	user := new(Users)
	var userPojo = []UserPOJO{}
	userList, err := user.FindAllUser()
	for index, u := range userList {
		userp := new(UserPOJO)
		userp.UserObj = u
		userp.CreatedAtStr = u.CreatedAt.Format("2006-01-02 15:04:05")
		userp.UpdatedAtStr = u.UpdatedAt.Format("2006-01-02 15:04:05")
		userPojo = append(userPojo[:index], *userp)
	}
	if nil != err {
		this.Data["json"] = map[string]interface{}{"msg": err}
		this.ServeJSON()
	}
	this.Data["userList"] = userPojo
	this.Data["total"] = len(userPojo)
	this.TplName = "admin/user-list.html"
}
