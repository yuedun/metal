package controllers

import (
	"metal/models"
	"reflect"

	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"

	"github.com/beego/beego/v2/server/web/context"
)

type AdminBaseController struct {
	beego.Controller
}

// 自定义404错误页面
// 需要beego.Run之前注册beego.ErrorController(&controllers.ErrorController{})
// func (c *BaseController) Error404() {
//     c.Data["content"] = ">>>>>>>>>>"
//     c.TplName = "404.html"
// }

// 接口返回数据标准化
type Result struct {
	Code int         `json:"code"`
	Cost int64       `json:"cost"`
	Data interface{} `json:"data"`
	Msg  string      `json:"msg"`
}

// 返回错误信息，code是可选的自定义代码
func (h *AdminBaseController) ErrorMsg(msg string, code ...int) Result {
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
func (h *AdminBaseController) ErrorData(msg error, code ...int) Result {
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

func (h *AdminBaseController) SuccessData(data any) Result {
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
	loginUser := ctx.Input.Session("loginUser")
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
		logs.Info("ctrl:method =", ctrl+":"+runMethod)
		privileges := userPermission.Privileges // 获取用户拥有的权限
		hasPermission := false
		//检查需要权限的路由和接口用户是否拥有
		p, ok := NeedPermission[requestPermission]
		logs.Debug(">>>>>>>", p, ok)
		if ok {
			hasPermission = false
			//需要验证权限
			if p {
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
					c.Data["json"] = c.ErrorMsg("权限不足")
					c.ServeJSON()
				}
			}
		} else {
			logs.Info("未设置权限")
			c.Data["json"] = c.ErrorMsg("未设置权限")
			c.ServeJSON()
		}
	}
}

// 此变量作用：
// 需要验证权限的接口，如果值为false或没有配置代表不需要验证权限
// 配置以后且值为true代表需要验证权限，并匹配数据库中用户是否存在对应权限
// 可使用该方式集中维护权限，也可以由各个controller各自在Prepare维护自己权限，缺点是每个controller都要写一遍Prepare
var NeedPermission = map[string]bool{
	//页面权限
	"AdminPageController:Welcome":            false,
	"AdminPageController:UserListRoute":      true,
	"AdminPageController:ArticleEditRoute":   false,
	"AdminPageController:CreateArticleRoute": false,
	"AdminPageController:ArticlesRoute":      true,
	"AdminPageController:LogsRoute":          true,
	"AdminPageController:TemplatesRoute":     true,
	"AdminPageController:Roles":              false,
	"AdminPageController:UserList":           false,
	"AdminPageController:PNameView":          true,

	//接口权限
	"AdminAPIController:ToLogin":           false,
	"UserAPIController:LoginOut":           false,
	"AdminAPIController:ToRegister":        false,
	"AdminAPIController:Register":          false,
	"UserAPIController:UserList":           true,
	"AdminAPIController:GetUserRoles":      true,
	"AdminAPIController:AddUserRoles":      true,
	"AdminAPIController:UpdateUser":        true,
	"AdminAPIController:DisableUser":       true,
	"AdminAPIController:EnableUser":        true,
	"AdminAPIController:DeleteUser":        true,
	"AdminAPIController:GetRolesList":      true,
	"AdminAPIController:UpdateRole":        true,
	"AdminAPIController:ArticleEdit":       true,
	"AdminAPIController:ArticleDelete":     true,
	"AdminAPIController:CreateArticle":     true,
	"AdminAPIController:ArticlesList":      true,
	"AdminAPIController:GetLogs":           true,
	"AdminAPIController:CreateTemplate":    true,
	"AdminAPIController:TemplateView":      true,
	"AdminAPIController:TemplateList":      true,
	"AdminAPIController:UploadImg":         true,
	"JobCountController:JobCount":          true,
	"JobCountController:CountDataAll":      true,
	"JobCountController:CountDataRecently": true,
	"UserGroupController:GetUserRoles":     true,
	"UserGroupController:AddUserRole":      true,
	"UserGroupController:AddUserGroup":     true,
	"UserGroupController:GetAllUserGroup":  true,
	"UserGroupController:Roles":            true,
	"UserGroupController:UpdateRole":       true,
	"UserGroupController:CreateRole":       true,
}
