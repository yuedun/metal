package routers

import (
	"metal/controllers"
	"metal/controllers/api"
	"metal/controllers/page"

	beego "github.com/beego/beego/v2/server/web"
)

func init() {
	beego.CtrlGet("/", (*controllers.PortalController).Get)                            //首页
	beego.CtrlGet("/article/:id", (*controllers.PortalController).Article)             //文章详情
	beego.CtrlGet("/catalog", (*controllers.PortalController).Catalog)                 //分类
	beego.CtrlGet("/categories/:category", (*controllers.PortalController).Categories) //分类下文章
	beego.CtrlGet("/tags/:tag", (*controllers.PortalController).Tags)                  //标签
	beego.CtrlGet("/about", (*controllers.PortalController).About)
	beego.CtrlGet("/message", (*controllers.PortalController).Message)            //留言列表
	beego.CtrlPost("/message", (*controllers.PortalController).CreateMessage)     //留言
	beego.CtrlPost("/registration", (*controllers.PortalController).Registration) //注册
	beego.CtrlGet("/verify", (*controllers.PortalController).Verify)              //验证

	//namespace中的路由推荐用NS开头的方法
	//admin管理后台路由配置
	ns := beego.NewNamespace("/admin",
		//根据实际经验，推荐使用直接注册的方式来管理路由，而不是注解路由。
		//原因：可以直接明了的看到所有路由，不再使用可以直接注释掉，方便搜索。而注解路由过于分散不易管理，且并不能减少代码量
		beego.NSBefore(controllers.HasAdminPermission), //权限校验
		beego.NSCtrlGet("/", (*page.AdminPageController).Welcome),
		beego.NSNamespace("/page",
			// beego.NSBefore(controllers.HasAdminPermission), //过滤器
			beego.NSCtrlGet("/", (*page.AdminPageController).Welcome),
			beego.NSCtrlGet("/welcome", (*page.AdminPageController).Welcome),
			beego.NSCtrlGet("/login", (*page.AdminPageController).Login),
			beego.NSCtrlGet("/register", (*page.AdminPageController).Register),
			beego.NSCtrlGet("/user-list", (*page.AdminPageController).UserList),
			beego.NSCtrlGet("/user-add", (*page.AdminPageController).UserAdd),
			beego.NSCtrlGet("/article-add", (*page.AdminPageController).ArticleCreate),
			beego.NSCtrlGet("/article-list", (*page.AdminPageController).ArticleList),
			beego.NSCtrlGet("/article-edit", (*page.AdminPageController).ArticleEdit),
			beego.NSCtrlGet("/logs", (*page.AdminPageController).LogList),
			beego.NSCtrlGet("/pname", (*page.AdminPageController).PNameView),
			beego.NSCtrlGet("/picture", (*page.AdminPageController).Picture),
			beego.NSCtrlGet("/picture-list", (*page.AdminPageController).PictureList),
			beego.NSCtrlGet("/icons", (*page.AdminPageController).IconList),
			beego.NSCtrlGet("/system-info", (*page.AdminPageController).SystemInfo),
			beego.NSCtrlGet("/job-count", (*page.AdminPageController).JobCount),
			beego.NSCtrlGet("/roles", (*page.AdminPageController).RoleList),
			beego.NSCtrlGet("/messages", (*page.AdminPageController).Messages),
			beego.NSCtrlGet("/category-list", (*page.AdminPageController).CategoryList),
			beego.NSCtrlGet("/movies", (*page.AdminPageController).Movies),
		),
		beego.NSNamespace("/api",
			// beego.NSBefore(controllers.HasAdminPermission), //过滤器
			beego.NSCtrlPost("/to-login", (*api.UserAPIController).ToLogin),
			beego.NSCtrlGet("/login-out", (*api.UserAPIController).LoginOut),
			beego.NSCtrlGet("/user/disable/:id", (*api.UserAPIController).DisableUser),
			beego.NSCtrlGet("/user/enable/:id", (*api.UserAPIController).EnableUser),
			beego.NSCtrlDelete("/user/delete", (*api.UserAPIController).DeleteUser),
			beego.NSCtrlGet("/user/:id", (*api.UserAPIController).UserGet),
			beego.NSCtrlPost("/user", (*api.UserAPIController).CreateUser),
			beego.NSCtrlPut("/user", (*api.UserAPIController).UpdateUser),
			beego.NSCtrlGet("/users", (*api.UserAPIController).UserList),
			beego.NSCtrlPost("/article", (*api.ArticleAPIController).ArticleCreate),
			beego.NSCtrlGet("/articles", (*api.ArticleAPIController).ArticleList),
			beego.NSCtrlPut("/article/:id", (*api.ArticleAPIController).ArticleEdit),
			beego.NSCtrlDelete("/article/:id", (*api.ArticleAPIController).ArticleDelete),
			beego.NSCtrlGet("/logs", (*api.AdminAPIController).GetLogs),
			beego.NSCtrlPost("/upload-img", (*api.AdminAPIController).UploadImg),
			beego.NSCtrlPost("/pictures", (*api.AdminAPIController).PictureAdd),
			beego.NSCtrlGet("/picture-list", (*api.AdminAPIController).PictureList),
			beego.NSCtrlDelete("/picture-delete", (*api.AdminAPIController).PictureDelete),
			beego.NSCtrlPost("/user/add-roles", (*api.AdminAPIController).AddUserRoles),
			beego.NSCtrlGet("/user-roles/:userId", (*api.AdminAPIController).GetUserRoles),
			beego.NSCtrlGet("/roles/list", (*api.AdminAPIController).GetRolesList),
			beego.NSCtrlPost("/roles/create", (*api.AdminAPIController).RoleCreate),
			beego.NSCtrlPut("/roles/update", (*api.AdminAPIController).RoleUpdate),
			beego.NSCtrlDelete("/roles/delete/:id", (*api.AdminAPIController).RoleDelete),
			beego.NSCtrlGet("/job-count/count-data-recently", (*api.AdminAPIController).CountDataRecently),
			beego.NSCtrlGet("/job-count/count-data-all", (*api.AdminAPIController).CountDataAll),
			beego.NSCtrlGet("/message/list", (*api.AdminAPIController).MessageList),
			beego.NSCtrlPut("/message/update/:id", (*api.AdminAPIController).MessageUpdate),
			beego.NSCtrlDelete("/message/delete/:id", (*api.AdminAPIController).MessageDelete),
			beego.NSCtrlGet("/categories", (*api.AdminAPIController).Categories),
			beego.NSCtrlPost("/categories", (*api.AdminAPIController).CategoriesCreate),
			beego.NSCtrlPut("/categories", (*api.AdminAPIController).CategoriesUpdate),
			beego.NSCtrlPost("/movie/add", (*api.AdminAPIController).MovieAdd),
			beego.NSCtrlPut("/movie/update", (*api.AdminAPIController).MovieUpdate),
			beego.NSCtrlDelete("/movie/delete/:id", (*api.AdminAPIController).MovieDelete),
			beego.NSCtrlGet("/movie-list", (*api.AdminAPIController).MovieList),
			beego.NSCtrlGet("/movie/:id", (*api.AdminAPIController).MovieInfo),
		),
	)
	//注册namespace
	beego.AddNamespace(ns)
}
