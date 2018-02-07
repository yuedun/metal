package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	//	"fmt"
	"fmt"
	. "metal/models"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
	"time"
)

// 权限验证
var HasIndexPermission = func(ctx *context.Context) {
	fmt.Println(">>>>>>>>>>>>>index auth")
}

type MainController struct {
	beego.Controller
}

//用户如果没有进行注册，那么就会通过反射来执行对应的函数，如果注册了就会通过 interface 来进行执行函数
//官方文档说可以提高性能
// func (this *MainController) URLMapping() {
// 	this.Mapping("Get", this.Get)
// 	this.Mapping("MyRoute", this.MyRoute)
// }

//注解路由
// @router / [get]
func (this *MainController) Get() {
	this.Data["Website"] = "http://yuedun.duapp.com"
	this.Data["Email"] = "huo.win.n@gmail.com"
	//默认tpl或html后缀
	this.TplName = "index.html"
}

// @router /test [get]
func (this *MainController) MyRoute() {
	this.Data["Website"] = "http://yuedun.duapp.com"
	this.Data["Email"] = "huo.win.n@gmail.com"
	this.Data["content"] = "这是一个自定义控制器"
	user := &Users{}
	userList, err := user.FindAllUser()
	if nil != err {
		this.Data["json"] = map[string]any{"msg": err}
		this.ServeJSON()
	}
	this.Data["userList"] = userList
	this.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要

}

// @router /user [post]
func (this *MainController) AddUser() {
	username := this.GetString("username")
	password := this.GetString("password")
	user := &Users{
		Username:  username,
		Password:  password,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}
	_, err := user.Save()
	if nil != err {
		this.Data["json"] = map[string]any{"msg": err}
		this.ServeJSON()
	}
	userList, err := user.FindAllUser()
	this.Data["userList"] = userList
	this.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要
}

// @route /getUserByName [get]
func (this *MainController) GetUser() {
	username := this.Ctx.Input.Param(":username")
	user := &Users{Username: username}
	user, err := user.FindUser()
	if nil != err {
		this.Data["json"] = map[string]any{"result": false, "msg": this.Ctx.Input.Params()}
	} else {
		this.Data["json"] = map[string]any{"result": true, "msg": user}
	}
	this.ServeJSON()
}

// @router /category [get]
func (this *MainController) Category() {
	this.Data["Website"] = "http://yuedun.duapp.com"
	this.Data["Email"] = "huo.win.n@gmail.com"
	this.TplName = "category.html"
}

// @router /about [get]
func (this *MainController) About() {
	this.Data["Website"] = "http://yuedun.duapp.com"
	this.Data["Email"] = "huo.win.n@gmail.com"
	this.TplName = "about.html"
}
