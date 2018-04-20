package controllers

import (
	"fmt"
	"log"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
	"metal/models"
)

type BaseController struct {
	beego.Controller
}

/**
 * 给interface起个别名，这样是不是简短很多了
 */
type any = interface{}

type UserPermission struct {
	User models.User
	UserGroups []models.UserGroup
}
/**
 * 这个函数主要是为了用户扩展用的，这个函数会在下面定义的这些 Method 方法之前执行，用户可以重写这个函数实现类似用户验证之类
 */
func (c *BaseController) Prepare() {
	// admin-user-ctrl和user-index-ctrl都继承了base-ctrl，所以都会自动执行该方法，可以做一些校验，但不适合做权限校验
	// 因为前端用户界面不需要权限验证，管理后台才需要
	session := c.GetSession("loginUser")
	if session != nil {
		userPermission := session.(*UserPermission)
		c.Data["username"] = userPermission.User.UserName
	}
	fmt.Println(">>>>>>>>>>>>>Prepare前后端通用校验")
}

// 后台权限验证
var HasAdminPermission = func(ctx *context.Context) {
	fmt.Println(">>>>>>>>>>>>>admin auth权限验证")
	loginUser := ctx.Input.CruSession.Get("loginUser")
	fmt.Println(ctx.Input.URL())
	if loginUser == nil && ctx.Input.URL() != "/admin/login" && ctx.Input.URL() != "/admin/to-login" {
		fmt.Println("用户未登录")
		ctx.Redirect(302, "/admin/login")
	}
	if loginUser != nil {
		var routePermission = ctx.GetCookie("routePermission")
		var apiPermission = ctx.GetCookie("apiPermission")
		fmt.Println(">>>>routePermission", routePermission)
		fmt.Println(">>>>apiPermission", apiPermission)
		var userGroup = new(models.UserGroup)
		userGroupList, _ :=userGroup.GetGroupByUserId(loginUser.(*UserPermission).User.Id)
		hasPermission := false
		for _, p := range userGroupList {
			var group = new(models.Group)
			group.Id = p.GroupId
			err :=group.GetUserPermissions()
			if err !=nil {
				log.Print(err)
			}
			if group.Permissions == routePermission {
				hasPermission = true
			}
			if group.Permissions == apiPermission {
				hasPermission = true
			}
		}
		if routePermission !="" && !hasPermission {
			ctx.Abort(403, "权限不足")
		}
		if apiPermission !="" && !hasPermission {
			ctx.Output.JSON(ErrorMsg("权限不足"), true, false)
		}
	}

}

// 前端权限验证
var HasIndexPermission = func(ctx *context.Context) {
	fmt.Println(">>>>>>>>>>>>>index auth")
}

// 自定义404错误页面
// func (c *BaseController) Error404() {
//     c.Data["content"] = "page not found"
//     c.TplName = "404.html"
// }

// 接口返回数据标准化
type Result struct {
	Code int `json:"code"`
	Data interface{} `json:"data"`
	Msg  string `json:"msg"`
}

/**
返回错误信息，code是可选的自定义代码
*/
func ErrorMsg(msg string, code ...int) Result {
	var r Result
	if len(code) > 0 {
		r.Code = code[0]
	} else {
		r.Code = 1
	}
	r.Msg = msg
	r.Data = nil
	return r
}
/**
 * ErrorMsg和ErrorData作用一样，只不过是为了方便调用方不用手动msg.Error()，只需传error类型即可
 */
func ErrorData(msg error, code ...int) Result {
	var r Result
	if len(code) > 0 {
		r.Code = code[0]
	} else {
		r.Code = 1
	}
	r.Msg = msg.Error()
	r.Data = nil
	return r
}

func SuccessData(data interface{}) Result {
	var r Result
	r.Code = 0
	r.Msg = "ok"
	r.Data = data
	return r
}