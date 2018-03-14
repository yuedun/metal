package controllers

import (
	"fmt"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
)

type BaseController struct {
	beego.Controller
}

/**
 * 给interface起个别名，这样是不是简短很多了
 */
type any = interface{}

/**
 * 这个函数主要是为了用户扩展用的，这个函数会在下面定义的这些 Method 方法之前执行，用户可以重写这个函数实现类似用户验证之类
 */
func (this *BaseController) Prepare() {
	//admin-user-ctrl和user-index-ctrl都继承了base-ctrl，所以都会自动执行该方法，可以做一些校验，但不适合做权限校验
	//因为前端用户界面不需要权限验证，管理后台才需要
	fmt.Println(">>>>>>>>>>>>>Prepare前后端通用校验")
}

// 后台权限验证
var HasAdminPermission = func(ctx *context.Context) {
	fmt.Println(">>>>>>>>>>>>>admin auth权限验证")
	loginUser := ctx.Input.CruSession.Get("loginUser")
	if loginUser == nil && ctx.Input.URL() != "/admin/login" && ctx.Input.URL() != "/admin/to-login" {
		fmt.Println("用户未登录")
		ctx.Redirect(302, "/admin/login")
	}
}

// 前端权限验证
var HasIndexPermission = func(ctx *context.Context) {
	fmt.Println(">>>>>>>>>>>>>index auth")
}

//自定义404错误页面
// func (c *BaseController) Error404() {
//     c.Data["content"] = "page not found"
//     c.TplName = "404.html"
// }
