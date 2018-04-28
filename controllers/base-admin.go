package controllers

import (
	"fmt"
	"metal/models"
	"strings"

	"github.com/astaxie/beego/context"
)

type AdminBaseController struct {
	BaseController
}

type UserPermission struct {
	User       models.User
	Privileges string //特权
}

// 后台权限验证
var HasAdminPermission = func(ctx *context.Context) {
	fmt.Println(">>>>>>>>>>>>>admin auth权限验证，第一级")
	loginUser := ctx.Input.CruSession.Get("loginUser")
	fmt.Println(ctx.Input.URL())
	if loginUser == nil && ctx.Input.URL() != "/admin/login" && ctx.Input.URL() != "/admin/to-login" {
		fmt.Println("用户未登录")
		ctx.Redirect(302, "/admin/login")
	}
}

/**
 * 这个函数主要是为了用户扩展用的，这个函数会在下面定义的这些 Method 方法之前执行，用户可以重写这个函数实现类似用户验证之类
 */
func (c *AdminBaseController) Prepare() {
	// admin-user-ctrl和user-index-ctrl都继承了base-ctrl，所以都会自动执行该方法，可以做一些校验，但不适合做权限校验
	// 因为前端用户界面不需要权限验证，管理后台才需要
	session := c.GetSession("loginUser")
	if session != nil {
		userPermission := session.(*UserPermission)
		c.Data["username"] = userPermission.User.UserName
	}
	fmt.Println(">>>>>>>>>>>>>Prepare后端权限校验，第二级")
	ctrl, runMethod := c.GetControllerAndAction() // 获取controller和method
	fmt.Println(">>run-method:", ctrl+":"+runMethod)
	if session != nil {
		privileges := session.(*UserPermission).Privileges
		if !strings.Contains(privileges, ctrl+":"+runMethod) {
			c.Data["json"] = ErrorMsg("权限不足")
			c.ServeJSON()
		}
	}
}
