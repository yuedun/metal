package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	//	"fmt"
	. "metal/models"

	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

func (c *MainController) Get() {
	c.Data["Website"] = "http://yuedun.duapp.com"
	c.Data["Email"] = "huo.win.n@gmail.com"
	c.TplExt = "html"
	//默认tpl或html后缀
	c.TplName = "index.html"
}
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

type CategoryController struct {
	beego.Controller
}

func (c *CategoryController) Get() {
	c.Data["Website"] = "http://yuedun.duapp.com"
	c.Data["Email"] = "huo.win.n@gmail.com"
	c.TplName = "category.html"
}

type AboutController struct {
	beego.Controller
}

func (c *AboutController) Get() {
	c.Data["Website"] = "http://yuedun.duapp.com"
	c.Data["Email"] = "huo.win.n@gmail.com"
	c.TplName = "about.html"
}
