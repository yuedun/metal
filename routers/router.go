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
	beego.Router("/test", &controllers.MainController{}, "*:MyRoute")
	beego.Router("/", &controllers.MainController{})
	beego.Router("/category", &controllers.CategoryController{})
	beego.Router("/about", &controllers.AboutController{})
	beego.Router("/user", &controllers.UserController{})
	beego.Router("/user/?:username", &controllers.UserController{}, "get:GetUser")

	//admin管理后台路由配置
	ns := beego.NewNamespace("/admin",
		beego.NSRouter("/", &controllers.AdminController{}),
		beego.NSRouter("/login", &controllers.AdminController{}, "get:Login"),
		beego.NSRouter("/welcome", &controllers.AdminController{}, "get:Welcome"),
		beego.NSRouter("/user-list", &controllers.UserController{}, "get:UserList"),
		beego.NSRouter("/user-add-ui", &controllers.UserController{}, "get:UserAddUI"),
		beego.NSRouter("/user", &controllers.UserController{}),
	)
	//注册namespace
	beego.AddNamespace(ns)
}
