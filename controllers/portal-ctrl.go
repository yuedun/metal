package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"github.com/astaxie/beego"
	"github.com/microcosm-cc/bluemonday"
	"github.com/russross/blackfriday"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"time"
)

type PortalController struct {
	BaseController
}

//用户如果没有进行注册，那么就会通过反射来执行对应的函数，如果注册了就会通过 interface 来进行执行函数
//官方文档说可以提高性能
// func (c *PortalController) URLMapping() {
// 	c.Mapping("Get", c.Get)
// 	c.Mapping("MyRoute", c.MyRoute)
// }

//首页
// @router / [get]
func (c *PortalController) Get() {
	pageNo, err := c.GetInt("pageNo")
	if err != nil {
		pageNo = 0
	}
	pageSize, err := c.GetInt("pageSize")
	if err != nil {
		pageSize = 5
	}
	skip := pageNo * pageSize
	params := map[string]string{}
	article := &Article{}
	articleList, total, err := article.GetArticlesByCondition(params, skip, pageSize)
	if nil != err {
		c.Data["articleList"] = []Article{}
		c.Data["total"] = 0
	} else {
		for index, art := range articleList {
			input := []byte(art.Content)
			unsafe := blackfriday.Run(input)
			html := bluemonday.UGCPolicy().SanitizeBytes(unsafe)
			art.Content = string(html)
			articleList[index] = art
		}
		c.Data["articleList"] = articleList
		c.Data["total"] = total
		c.Data["pageNo"] = pageNo
		c.Data["pageSize"] = pageSize
		beego.Info(">>>>>>>>>", total)
	}
	beego.Info("访问ip:", c.Ctx.Input.Header("Remote_addr"))
	//默认tpl或html后缀
	c.TplName = "index.html"
}

// @router /test [get]
func (c *PortalController) MyRoute() {
	c.Data["content"] = "这是一个自定义控制器"
	user := &User{}
	userList, err := user.GetAll()
	if nil != err {
		beego.Error(err)
		c.Data["json"] = map[string]any{"msg": err}
		c.ServeJSON()
	}
	c.Data["userList"] = userList
	c.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要

}

// @router /user [post]
func (c *PortalController) AddUser() {
	username := c.GetString("username")
	password := c.GetString("password")

	var user = new(User)
	user.UserName = username
	user.Password = password
	user.CreatedAt = time.Now()
	user.UpdatedAt = time.Now()

	_, err := user.Save()
	if nil != err {
		beego.Error(err)
		c.Data["json"] = map[string]any{"msg": err}
		c.ServeJSON()
	}
	userList, err := user.GetAll()
	c.Data["userList"] = userList
	c.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要
}

// @route /getUserByName [get]
func (c *PortalController) GetUser() {
	username := c.Ctx.Input.Param(":username")
	user := &User{UserName: username}
	err := user.GetByName()
	if nil != err {
		beego.Error(err)
		c.Data["json"] = map[string]any{"result": false, "msg": c.Ctx.Input.Params()}
	} else {
		c.Data["json"] = map[string]any{"result": true, "msg": user}
	}
	c.ServeJSON()
}

// @router /category [get]
func (c *PortalController) Category() {
	c.TplName = "category.html"
}

// @router /about [get]
func (c *PortalController) About() {
	c.TplName = "about.html"
}
