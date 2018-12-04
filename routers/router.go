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
	// beego.Router("/test", &controllers.MainController{}, "*:MyRoute")
	//添加过滤器(这个正则还有问题，只能匹配到首页)
	beego.InsertFilter("/:*^(admin)", beego.BeforeRouter, controllers.HasIndexPermission, false)

	//注解路由，代替上面单个注册路由
	beego.Include(
		&controllers.MainController{},
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

		//根据实际经验，推荐使用直接注册的方式来管理路由，可以直接明了的看到所有路由，不再使用可以直接注释掉，方便搜索
		beego.NSBefore(controllers.HasAdminPermission), //过滤器
		beego.NSRouter("/", &controllers.UserController{}, "get:Welcome"),
		beego.NSRouter("/login", &controllers.UserController{}, "get:Login"),
		beego.NSRouter("/to-login", &controllers.UserController{}, "post:ToLogin"),
		beego.NSRouter("/login-out", &controllers.UserController{}, "get:LoginOut"),
		beego.NSRouter("/welcome", &controllers.UserController{}, "get:Welcome"),
		beego.NSRouter("/user-list", &controllers.UserController{}, "get:UserListRoute"),
		beego.NSRouter("/user-add", &controllers.UserController{}, "get:UserAddRoute"),
		beego.NSRouter("/user", &controllers.UserController{}),
		beego.NSRouter("/user/delete", &controllers.UserController{}, "delete,post:DeleteUser"),
		beego.NSRouter("/user/:id", &controllers.UserController{}, "get:UserGet"),
		beego.NSRouter("/users", &controllers.UserController{}, "get:UserList"),
		beego.NSRouter("/user-group", &controllers.UserGroupController{}),

		//也可以使用注解自动路由
		beego.NSInclude(
			&controllers.GroupController{},
			&controllers.UserController{},
			&controllers.JobCountController{},
		),
	)
	//注册namespace
	beego.AddNamespace(ns)
}
