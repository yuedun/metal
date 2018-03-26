package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	//	"fmt"
	"log"
	. "metal/models"
	"time"
)

type MainController struct {
	BaseController
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
	//默认tpl或html后缀
	c.TplName = "index.html"
}

// @router /test [get]
func (c *MainController) MyRoute() {
	c.Data["Website"] = "http://yuedun.duapp.com"
	c.Data["Email"] = "huo.win.n@gmail.com"
	c.Data["content"] = "这是一个自定义控制器"
	user := &User{}
	userList, err := user.GetAll()
	if nil != err {
		log.Print(err)
		c.Data["json"] = map[string]any{"msg": err}
		c.ServeJSON()
	}
	c.Data["userList"] = userList
	c.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要

}

// @router /user [post]
func (c *MainController) AddUser() {
	username := c.GetString("username")
	password := c.GetString("password")

	var user = new(User)
	user.UserName = username
	user.Password = password
	user.CreatedAt = time.Now()
	user.UpdatedAt = time.Now()

	_, err := user.Save()
	if nil != err {
		log.Print(err)
		c.Data["json"] = map[string]any{"msg": err}
		c.ServeJSON()
	}
	userList, err := user.GetAll()
	c.Data["userList"] = userList
	c.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要
}

// @route /getUserByName [get]
func (c *MainController) GetUser() {
	username := c.Ctx.Input.Param(":username")
	user := &User{UserName: username}
	err := user.GetByName()
	if nil != err {
		log.Print(err)
		c.Data["json"] = map[string]any{"result": false, "msg": c.Ctx.Input.Params()}
	} else {
		c.Data["json"] = map[string]any{"result": true, "msg": user}
	}
	c.ServeJSON()
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
