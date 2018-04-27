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
	User  models.User
	Group []models.Group
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
/*
func (c *AdminBaseController) Prepare() {
	// admin-user-ctrl和user-index-ctrl都继承了base-ctrl，所以都会自动执行该方法，可以做一些校验，但不适合做权限校验
	// 因为前端用户界面不需要权限验证，管理后台才需要
	session := c.GetSession("loginUser")
	if session != nil {
		userPermission := session.(*UserPermission)
		c.Data["username"] = userPermission.User.UserName
	}
	fmt.Println(">>>>>>>>>>>>>Prepare后端权限校验，第二级")
	ctrl, runMethod :=c.GetControllerAndAction()// 获取controller和method
	fmt.Println(">>run-method:", ctrl, runMethod)
	if session != nil {
		var userGroup = new(models.UserGroup)
		userGroupList, _ :=userGroup.GetGroupByUserId(session.(*UserPermission).User.Id)
		hasPermission := false
		for _, p := range userGroupList {
			var group = new(models.Group)
			group.Id = p.GroupId
			err :=group.GetUserPermissions()
			if err !=nil {
				log.Print(err)
			}
			fmt.Println("group.Permissions:", group.Permissions)
			if group.Permissions == ctrl+":"+runMethod {
				hasPermission = true//有权限
				break
			}
		}
		if !hasPermission {
			c.Data["json"] = ErrorMsg("权限不足")
			c.ServeJSON()
		}
	}
}
*/
