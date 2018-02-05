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
// func (c *MainController) URLMapping() {
// 	c.Mapping("Get", c.Get)
// 	c.Mapping("MyRoute", c.MyRoute)
// }

//注解路由
// @router / [get]
func (c *MainController) Get() {
	c.Data["Website"] = "http://yuedun.duapp.com"
	c.Data["Email"] = "huo.win.n@gmail.com"
	c.TplExt = "html"
	//默认tpl或html后缀
	c.TplName = "index.html"
}

// @router /test [get]
func (c *MainController) MyRoute() {
	c.Data["Website"] = "http://yuedun.duapp.com"
	c.Data["Email"] = "huo.win.n@gmail.com"
	c.Data["content"] = "这是一个自定义控制器"
	user := &Users{}
	userList, err := user.FindAllUser()
	if nil != err {
		c.Data["json"] = map[string]interface{}{"msg": err}
		c.ServeJSON()
	}
	c.Data["userList"] = userList
	c.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要

}

// @router /user [post]
func (this *MainController) AddUser() {
	var username = this.GetString("username")
	var password = this.GetString("password")
	user := &Users{
		Username: username,
		Password: password,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}

	id, err:=user.AddUser()
	if err !=nil {
		fmt.Printf("%v", err)
		this.Data["json"] = map[string]interface{}{"msg": err}
		this.ServeJSON()
	} else {
		fmt.Printf(">>id:%d", id)
		this.TplName = "myroute.html"
	}
}

// @route /getUserByName [get]
func (this *MainController) GetUser() {
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

// @router /category [get]
func (c *MainController) Category() {
	c.Data["Website"] = "http://yuedun.duapp.com"
	c.Data["Email"] = "huo.win.n@gmail.com"
	c.TplName = "category.html"
}

// @router /about [get]
func (c *MainController) About() {
	c.Data["Website"] = "http://yuedun.duapp.com"
	c.Data["Email"] = "huo.win.n@gmail.com"
	c.TplName = "about.html"
}
