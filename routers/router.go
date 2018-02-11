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
	// beego.Router("/", &controllers.MainController{})
	// beego.Router("/category", &controllers.CategoryController{})
	// beego.Router("/about", &controllers.AboutController{})
	// beego.Router("/user", &controllers.UserController{})
	// beego.Router("/user/?:username", &controllers.UserController{}, "get:GetUser")

	//添加过滤器，目前未实现只过滤用户端不过滤管理端
	// beego.InsertFilter("/:*^(?!admin)", beego.BeforeRouter, controllers.HasIndexPermission)
	//注解路由，代替上面单个注册路由
	beego.Include(
		&controllers.MainController{},
	)

	//namespace中的路由推荐用NS开头的方法
	//admin管理后台路由配置
	ns := beego.NewNamespace("/admin",
		beego.NSBefore(controllers.HasAdminPermission), //过滤器
		beego.NSRouter("/", &controllers.UserController{}, "get:Welcome"),
		beego.NSRouter("/login", &controllers.UserController{}, "get:Login"),
		beego.NSRouter("/to-login", &controllers.UserController{}, "post:ToLogin"),
		beego.NSRouter("/welcome", &controllers.UserController{}, "get:Welcome"),
		beego.NSRouter("/user-list", &controllers.UserController{}, "get:UserListRoute"),
		beego.NSRouter("/user-add", &controllers.UserController{}, "get:UserAddRoute"),
		beego.NSRouter("/user", &controllers.UserController{}),
		beego.NSRouter("/user/delete", &controllers.UserController{}, "delete,post:DeleteUser"),
		beego.NSRouter("/user/:id", &controllers.UserController{}, "get:UserGet"),
	)
	//注册namespace
	beego.AddNamespace(ns)
}
