package controllers

import (
	"fmt"
	"metal/models"

	"github.com/astaxie/beego/context"
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
	fmt.Println(">>>>>>>>>>>>>第一级验证是否登录")
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
	// admin-user-ctrl和user-index-ctrl都继承了base-ctrl，所以都会自动执行该方法
	// 因为前端用户界面不需要权限验证，管理后台才需要
	session := c.GetSession("loginUser")
	//session为空时不进行权限验证
	if session != nil {
		userPermission := session.(*UserPermission)
		c.Data["username"] = userPermission.User.UserName
		fmt.Println(">>>>>>>>>>>>>Prepare第二级验证是否拥有接口权限")
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
				c.Data["json"] = ErrorMsg("权限不足")
				c.ServeJSON()
			}
		}
	}
}

/**
 * 此变量作用：
 * 需要验证权限的接口，如果值为false或没有配置代表不需要需要验证
 * 配置以后且值为true代表需要验证权限，并匹配数据库中是否存在权限
 */
var NeedPermission = map[string]bool{
	"UserController:ToLogin":       false,
	"UserController:LoginOut":      false,
	"UserController:Welcome":       false,
	"UserController:UserList":      true,
	"UserController:UserListRoute": true,
}
