package routers

import (
	"metal/controllers"

	"github.com/astaxie/beego"
)

func init() {
	/**
	 * 用户端页面路由配置
	 * 下面第一个路由有三个参数，指定路由/myroute访问的是MyRoute控制器
	 */
	// beego.Router("/test", &controllers.PortalController{}, "*:MyRoute")
	//添加过滤器(这个正则还有问题，只能匹配到首页)
	beego.InsertFilter("/:*^(admin)", beego.BeforeRouter, controllers.HasIndexPermission, false)

	//注解路由，代替上面单个注册路由
	beego.Include(
		&controllers.PortalController{},
	)

	//namespace中的路由推荐用NS开头的方法
	//admin管理后台路由配置
	ns := beego.NewNamespace("/admin",
		//支持满足条件的就执行该 namespace, 不满足就不执行 condition
		//beego.NSCond(func(ctx *context.Context) bool {
		//	if ctx.Input.Domain() == "api.beego.me" {
		//		return true
		//	}
		//	return false
		//}),

		//根据实际经验，推荐使用直接注册的方式来管理路由，而不是注解路由。
		//原因：可以直接明了的看到所有路由，不再使用可以直接注释掉，方便搜索。而注解路由过于分散不易管理，且不能减少代码量
		beego.NSBefore(controllers.HasAdminPermission), //过滤器
		beego.NSRouter("/", &controllers.AdminController{}, "get:Welcome"),
		beego.NSRouter("/login", &controllers.AdminController{}, "get:Login"),
		beego.NSRouter("/to-login", &controllers.AdminController{}, "post:ToLogin"),
		beego.NSRouter("/login-out", &controllers.AdminController{}, "get:LoginOut"),
		beego.NSRouter("/welcome", &controllers.AdminController{}, "get:Welcome"),
		beego.NSRouter("/user-list", &controllers.AdminController{}, "get:UserListRoute"),
		beego.NSRouter("/user-add", &controllers.AdminController{}, "get:UserAddRoute"),
		beego.NSRouter("/user", &controllers.AdminController{}),
		beego.NSRouter("/user/delete", &controllers.AdminController{}, "delete,post:DeleteUser"),
		beego.NSRouter("/user/:id", &controllers.AdminController{}, "get:UserGet"),
		beego.NSRouter("/users", &controllers.AdminController{}, "get:UserList"),
		beego.NSRouter("/user-group", &controllers.UserGroupController{}),
		beego.NSRouter("/icons", &controllers.PictureController{}, "get:IconList"),
		beego.NSRouter("/picture", &controllers.PictureController{}, "get:Picture"),

		//也可以使用注解自动路由
		beego.NSInclude(
			&controllers.GroupController{},
			&controllers.AdminController{},
			&controllers.JobCountController{},
		),
	)
	//注册namespace
	beego.AddNamespace(ns)
}
