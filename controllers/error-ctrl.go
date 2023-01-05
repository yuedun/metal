package controllers

import (
	"github.com/beego/beego/v2/server/web"
)

// 需要beego.Run之前注册beego.ErrorController(&controllers.ErrorController{})
// 定义错误控制器
type ErrorController struct {
	web.Controller
}

// 定义404错误, 调用例子: this.Abort("404")
// func (c *ErrorController) Error404() {
// 	// 模板参数
// 	c.Data["content"] = "页面不见了"
// 	// 自定义404错误页面模板
// 	c.TplName = "admin/404.html"
// }

// 定义403错误, 调用例子: this.Abort("403")
func (c *ErrorController) Error403() {
	session := c.GetSession("loginUser")
	userPermission := session.(*UserPermission)
	// 模板参数
	c.Data["username"] = userPermission.User.Username
	c.Data["content"] = "无访问权限"

	// 自定义404错误页面模板
	c.TplName = "admin/404.html"
}

// 定义500错误, 调用例子: c.Abort("500")
// func (c *ErrorController) Error500() {
// 	session := c.GetSession("loginUser")
// 	userPermission := session.(*UserPermission)
// 	// 模板参数
// 	c.Data["username"] = userPermission.User.Username
// 	c.Data["content"] = "服务跑了"
// 	c.TplName = "admin/500.html"
// }

// 定义db错误， 调用例子: c.Abort("Db")
// func (c *ErrorController) ErrorDb() {
// 	session := c.GetSession("loginUser")
// 	userPermission := session.(*UserPermission)
// 	// 模板参数
// 	c.Data["username"] = userPermission.User.Username
// 	c.Data["content"] = "数据库挂逼了"
// 	c.TplName = "admin/dberror.html"
// }
