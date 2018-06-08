package controllers

import (
	"fmt"
	"github.com/astaxie/beego/context"
	"metal/models"
)

type AdminBaseController struct {
	BaseController
}

type UserPermission struct {
	User       models.User
	Privileges []string //特权
}

// 后台权限验证
var HasAdminPermission = func(ctx *context.Context) {
	loginUser := ctx.Input.CruSession.Get("loginUser")
	if loginUser == nil && ctx.Input.URL() != "/admin/login" && ctx.Input.URL() != "/admin/to-login" {
		ctx.Redirect(302, "/admin/login")
	}
}

/**
 * 这个函数主要是为了用户扩展用的，这个函数会在下面定义的这些 Method 方法之前执行，用户可以重写这个函数实现类似用户验证之类
 */
func (c *AdminBaseController) Prepare() {
	// admin-user-ctrl和user-index-ctrl都继承了base-ctrl，所以都会自动执行该方法
	// 因为前端用户界面不需要权限验证，管理后台才需要
	session := c.GetSession("loginUser")
	//session为空时不进行权限验证
	if session != nil {
		userPermission := session.(*UserPermission)
		c.Data["username"] = userPermission.User.UserName
		ctrl, runMethod := c.GetControllerAndAction() // 获取controller和method
		requestPermission := ctrl + ":" + runMethod
		fmt.Println(">>run-method:", ctrl+":"+runMethod)
		privileges := session.(*UserPermission).Privileges
		hasPermission := true
		//需要权限
		if NeedPermission[requestPermission] {
			for _, pri := range privileges {
				fmt.Println(pri)
				if pri != requestPermission {
					hasPermission = false
				} else {
					hasPermission = true
					break
				}
			}
			if !hasPermission {
				fmt.Println("权限不足")
				c.Data["json"] = ErrorMsg("权限不足")
				c.ServeJSON()
			}
		}
	}
}
