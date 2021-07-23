package controllers

import (
	"metal/models"
	"reflect"

	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"

	"github.com/astaxie/beego/context"
)

type AdminBaseController struct {
	beego.Controller
}

/**
 * 给interface起个别名，这样是不是简短很多了
 */
type any = interface{}

// 自定义404错误页面
// 需要beego.Run之前注册beego.ErrorController(&controllers.ErrorController{})
// func (c *BaseController) Error404() {
//     c.Data["content"] = ">>>>>>>>>>"
//     c.TplName = "404.html"
// }

// 接口返回数据标准化
type Result struct {
	Code int         `json:"code"`
	Data interface{} `json:"data"`
	Msg  string      `json:"msg"`
}

// 返回错误信息，code是可选的自定义代码
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

func SuccessData(data any) Result {
	var r Result
	r.Code = 0
	r.Msg = "ok"
	r.Data = data
	return r
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
		if NeedPermission[requestPermission] {
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

// 此变量作用：
// 需要验证权限的接口，如果值为false或没有配置代表不需要验证权限
// 配置以后且值为true代表需要验证权限，并匹配数据库中用户是否存在对应权限
// 可使用该方式集中维护权限，也可以由各个controller各自在Prepare维护自己权限，缺点是每个controller都要写一遍Prepare

var NeedPermission = map[string]bool{
	"AdminController:ToLogin":              false,
	"AdminController:LoginOut":             false,
	"AdminController:ToRegister":           false,
	"AdminController:Register":             false,
	"AdminController:Welcome":              false,
	"AdminController:UserList":             true,
	"AdminController:UserListRoute":        true,
	"AdminController:UpdateUser":           true,
	"AdminController:DisableUser":          true,
	"AdminController:EnableUser":           true,
	"AdminController:DeleteUser":           true,
	"AdminController:ArticleEdit":          true,
	"AdminController:ArticleDelete":        true,
	"AdminController:CreateArticle":        false,
	"AdminController:ArticleEditRoute":     false,
	"AdminController:CreateArticleRoute":   false,
	"AdminController:ArticlesList":         false,
	"AdminController:ArticlesRoute":        false,
	"AdminController:GetLogs":              false,
	"AdminController:LogsRoute":            false,
	"AdminController:PNameView":            false,
	"AdminController:TemplatesRoute":       false,
	"AdminController:CreateTemplate":       false,
	"AdminController:TemplateView":         false,
	"AdminController:TemplateList":         false,
	"AdminController:UploadImg":            false,
	"JobCountController:JobCount":          false,
	"JobCountController:CountDataAll":      false,
	"JobCountController:CountDataRecently": false,
	"UserGroupController:GetUserRoles":     false,
	"UserGroupController:AddUserRole":      false,
	"UserGroupController:AddUserGroup":     false,
	"UserGroupController:GetAllUserGroup":  false,
	"UserGroupController:Roles":            true,
	"UserGroupController:UpdateRole":       true,
	"UserGroupController:CreateRole":       true,
}
