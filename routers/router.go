package routers

import (
	"metal/controllers"
	"metal/controllers/api"
	"metal/controllers/page"

	beego "github.com/beego/beego/v2/server/web"
)

func init() {
	//注解路由
	beego.Include(
		// 用户端
		&controllers.PortalController{},
	)

	//namespace中的路由推荐用NS开头的方法
	//admin管理后台路由配置
	ns := beego.NewNamespace("/admin",
		//根据实际经验，推荐使用直接注册的方式来管理路由，而不是注解路由。
		//原因：可以直接明了的看到所有路由，不再使用可以直接注释掉，方便搜索。而注解路由过于分散不易管理，且并不能减少代码量
		beego.NSBefore(controllers.HasAdminPermission), //权限校验
		beego.NSRouter("/", &page.AdminPageController{}, "get:Welcome"),
		beego.NSNamespace("/page",
			// beego.NSBefore(controllers.HasAdminPermission), //过滤器
			beego.NSRouter("/", &page.AdminPageController{}, "get:Welcome"),
			beego.NSRouter("/welcome", &page.AdminPageController{}, "get:Welcome"),
			beego.NSRouter("/login", &page.AdminPageController{}, "get:Login"),
			beego.NSRouter("/user-list", &page.AdminPageController{}, "get:UserList"),
			beego.NSRouter("/user-add", &page.AdminPageController{}, "get:UserAdd"),
			beego.NSRouter("/article-add", &page.AdminPageController{}, "get:CreateArticle"),
			beego.NSRouter("/article-list", &page.AdminPageController{}, "get:ArticleList"),
			beego.NSRouter("/article-edit", &page.AdminPageController{}, "get:ArticleEdit"),
			beego.NSRouter("/logs", &page.AdminPageController{}, "get:Logs"),
			beego.NSRouter("/pname/view", &page.AdminPageController{}, "get:PNameView"),
			beego.NSRouter("/picture", &page.AdminPageController{}, "get:Picture"),
			beego.NSRouter("/picture-list", &page.AdminPageController{}, "get:ListPicture"),
			beego.NSRouter("/icons", &page.AdminPageController{}, "get:IconList"),
			beego.NSRouter("/system-info", &page.AdminPageController{}, "get:SystemInfo"),
			beego.NSRouter("/job-count", &page.AdminPageController{}, "get:JobCount"),
			beego.NSRouter("/roles", &page.AdminPageController{}, "get:Roles"),
			beego.NSRouter("/messages", &page.AdminPageController{}, "get:Messages"),
			beego.NSRouter("/category-list", &page.AdminPageController{}, "get:CategoryList"),
		),
		beego.NSNamespace("/api",
			beego.NSBefore(controllers.HasAdminPermission), //过滤器
			beego.NSRouter("/to-login", &api.UserAPIController{}, "post:ToLogin"),
			beego.NSRouter("/login-out", &api.UserAPIController{}, "get:LoginOut"),
			beego.NSRouter("/user/disable/:id", &api.UserAPIController{}, "get:DisableUser"),
			beego.NSRouter("/user/enable/:id", &api.UserAPIController{}, "get:EnableUser"),
			beego.NSRouter("/user/delete", &api.UserAPIController{}, "delete,post:DeleteUser"),
			beego.NSRouter("/user/:id", &api.UserAPIController{}, "get:UserGet"),
			beego.NSRouter("/user", &api.UserAPIController{}, "post:CreateUser"),
			beego.NSRouter("/user", &api.UserAPIController{}, "put:UpdateUser"),
			beego.NSRouter("/users", &api.UserAPIController{}, "get:UserList"),
			beego.NSRouter("/article", &api.ArticleAPIController{}, "post:CreateArticle"),
			beego.NSRouter("/articles", &api.ArticleAPIController{}, "get:ArticlesList"),
			beego.NSRouter("/article/:id", &api.ArticleAPIController{}, "put:ArticleEdit"),
			beego.NSRouter("/article/:id", &api.ArticleAPIController{}, "delete:ArticleDelete"),
			beego.NSRouter("/logs", &api.AdminAPIController{}, "get:GetLogs"),
			beego.NSRouter("/upload-img", &api.AdminAPIController{}, "post:UploadImg"),
			beego.NSRouter("/pictures", &api.AdminAPIController{}, "post:AddPicture"),
			beego.NSRouter("/picture-list", &api.AdminAPIController{}, "get:ListPicture"),
			beego.NSRouter("/picture-delete", &api.AdminAPIController{}, "delete,post:DeletePicture"),
			beego.NSRouter("/user/add-roles", &api.AdminAPIController{}, "post:AddUserRoles"),
			beego.NSRouter("/user-roles/:userId", &api.AdminAPIController{}, "get:GetUserRoles"),
			beego.NSRouter("/roles/list", &api.AdminAPIController{}, "get:GetRolesList"),
			beego.NSRouter("/roles/create", &api.AdminAPIController{}, "post:CreateRole"),
			beego.NSRouter("/roles/update", &api.AdminAPIController{}, "put:UpdateRole"),
			beego.NSRouter("/job-count/count-data-recently", &api.AdminAPIController{}, "get:CountDataRecently"),
			beego.NSRouter("/job-count/count-data-all", &api.AdminAPIController{}, "get:CountDataAll"),
			beego.NSRouter("/message/list", &api.AdminAPIController{}, "get:MessageList"),
			beego.NSRouter("/message/update/:id", &api.AdminAPIController{}, "put:MessageUpdate"),
			beego.NSRouter("/categories", &api.AdminAPIController{}, "get:Categories"),
			beego.NSRouter("/categories", &api.AdminAPIController{}, "post:CreateCategories"),
			beego.NSRouter("/categories", &api.AdminAPIController{}, "put:UpdateCategories"),
		),
	)
	//注册namespace
	beego.AddNamespace(ns)
}
