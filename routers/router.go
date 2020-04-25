package routers

import (
	"metal/controllers"

	"github.com/astaxie/beego"
)

func init() {
	//添加过滤器(这个正则还有问题，只能匹配到首页)
	beego.InsertFilter("/:*^(admin)", beego.BeforeRouter, controllers.HasIndexPermission, false)

	//注解路由
	beego.Include(
		&controllers.PortalController{},
	)

	//namespace中的路由推荐用NS开头的方法
	//admin管理后台路由配置
	ns := beego.NewNamespace("/admin",
		//根据实际经验，推荐使用直接注册的方式来管理路由，而不是注解路由。
		//原因：可以直接明了的看到所有路由，不再使用可以直接注释掉，方便搜索。而注解路由过于分散不易管理，且并不能减少代码量
		beego.NSBefore(controllers.HasAdminPermission), //权限校验
		beego.NSNamespace("/page",
			beego.NSBefore(controllers.HasAdminPermission), //过滤器
			beego.NSRouter("/", &controllers.AdminController{}, "get:Welcome"),
			beego.NSRouter("/welcome", &controllers.AdminController{}, "get:Welcome"),
			beego.NSRouter("/login", &controllers.AdminController{}, "get:Login"),
			beego.NSRouter("/user-list", &controllers.AdminController{}, "get:UserListRoute"),
			beego.NSRouter("/user-add", &controllers.AdminController{}, "get:UserAddRoute"),
			beego.NSRouter("/article-add", &controllers.AdminController{}, "get:CreateArticleRoute"),
			beego.NSRouter("/articles", &controllers.AdminController{}, "get:ArticlesRoute"),
			beego.NSRouter("/article-edit", &controllers.AdminController{}, "get:ArticleEditRoute"),
			beego.NSRouter("/logs", &controllers.AdminController{}, "get:LogsRoute"),
			beego.NSRouter("/picture", &controllers.PictureController{}, "get:Picture"),
			beego.NSRouter("/picture-list", &controllers.PictureController{}, "get:ListPictureRoute"),
			beego.NSRouter("/system-info", &controllers.SystemController{}, "get:SystemInfo"),
			beego.NSRouter("/icons", &controllers.PictureController{}, "get:IconList"),
			beego.NSRouter("/pname/view", &controllers.AdminController{}, "get:PNameView"),
			beego.NSRouter("/job-count", &controllers.JobCountController{}, "get:JobCount"),
		),
		beego.NSNamespace("/api",
			beego.NSBefore(controllers.HasAdminPermission), //过滤器
			beego.NSRouter("/to-login", &controllers.AdminController{}, "post:ToLogin"),
			beego.NSRouter("/login-out", &controllers.AdminController{}, "get:LoginOut"),
			beego.NSRouter("/user/delete", &controllers.AdminController{}, "delete,post:DeleteUser"),
			beego.NSRouter("/user/:id", &controllers.AdminController{}, "get:UserGet"),
			beego.NSRouter("/users", &controllers.AdminController{}, "get:UserList"),
			beego.NSRouter("/article", &controllers.AdminController{}, "post:CreateArticle"),
			beego.NSRouter("/articles", &controllers.AdminController{}, "get:ArticlesList"),
			beego.NSRouter("/article/:id", &controllers.AdminController{}, "put:ArticleEdit"),
			beego.NSRouter("/article/:id", &controllers.AdminController{}, "delete:ArticleDelete"),
			beego.NSRouter("/logs", &controllers.AdminController{}, "get:GetLogs"),
			beego.NSRouter("/upload-img", &controllers.AdminController{}, "post:UploadImg"),
			beego.NSRouter("/pictures", &controllers.PictureController{}, "post:AddPicture"),
			beego.NSRouter("/picture-list", &controllers.PictureController{}, "get:ListPicture"),
			beego.NSRouter("/picture-delete", &controllers.PictureController{}, "delete,post:DeletePicture"),
			beego.NSRouter("/user/groups", &controllers.GroupController{}, "post:AddUserRole"),
			beego.NSRouter("/user-roles/:userId", &controllers.GroupController{}, "get:GetUserRoles"),
			beego.NSRouter("/job-count/count-data-recently", &controllers.JobCountController{}, "get:CountDataRecently"),
			beego.NSRouter("/job-count/count-data-all", &controllers.JobCountController{}, "get:CountDataAll"),
		),
	)
	//注册namespace
	beego.AddNamespace(ns)
}
