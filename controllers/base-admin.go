package controllers

import (
	"metal/controllers/permissions"
	"metal/models"
	"reflect"

	"github.com/astaxie/beego/logs"

	"github.com/astaxie/beego/context"
)

type AdminBaseController struct {
	BaseController // 提供一些公共函数
}

type UserPermission struct {
	User       models.User
	Privileges []string //权限
}

// 后台校验是否登录，未登录请求跳转到登录页
var HasAdminPermission = func(ctx *context.Context) {
	loginUser := ctx.Input.CruSession.Get("loginUser")
	if loginUser == nil && ctx.Input.URL() != "/admin/page/login" && ctx.Input.URL() != "/admin/api/to-login" {
		ctx.Redirect(302, "/admin/page/login")
	}
}

/**
 *这个函数会在每个Method方法之前执行，用户可以重写这个函数实现类似用户验证之类
 */
func (c *AdminBaseController) Prepare() {
	// 凡是继承了AdminBaseController的controller都会自动执行该方法进行权限校验
	// 因为前端用户界面不需要权限验证，管理后台才需要
	session := c.GetSession("loginUser")
	//session为空时不进行权限验证
	if session != nil {
		userPermission := session.(*UserPermission)
		c.Data["username"] = userPermission.User.UserName
		ctrl, runMethod := c.GetControllerAndAction() // 获取controller和method
		requestPermission := ctrl + ":" + runMethod
		logs.Info(reflect.Indirect(reflect.ValueOf(c.AppController)).Type().PkgPath()) //获取包名
		logs.Info("ctrl:method=", ctrl+":"+runMethod)
		privileges := userPermission.Privileges // 获取用户拥有的权限
		hasPermission := true
		//检查需要权限的路由和接口用户是否拥有
		if permissions.NeedPermission[requestPermission] {
			hasPermission = false
			for _, pri := range privileges {
				if pri != requestPermission {
					hasPermission = false
				} else {
					hasPermission = true
					break
				}
			}
			if !hasPermission {
				logs.Info("权限不足")
				c.Data["json"] = ErrorMsg("权限不足")
				c.ServeJSON()
			}
		}
	}
}
