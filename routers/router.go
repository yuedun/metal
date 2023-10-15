package routers

import (
	"metal/controllers"
	"metal/controllers/api"
	"metal/controllers/page"

	beego "github.com/beego/beego/v2/server/web"
)

func init() {
	beego.ErrorController(&controllers.ErrorController{}) //自定义错误页面

	beego.CtrlGet("/", (*controllers.PortalController).Get)                            //首页
	beego.CtrlGet("/article/:id", (*controllers.PortalController).Article)             //文章详情
	beego.CtrlGet("/catalog", (*controllers.PortalController).Catalog)                 //分类
	beego.CtrlGet("/categories/:category", (*controllers.PortalController).Categories) //分类下文章
	beego.CtrlGet("/tags/:tag", (*controllers.PortalController).Tags)                  //标签
	beego.CtrlGet("/about", (*controllers.PortalController).About)
	beego.CtrlGet("/message", (*controllers.PortalController).Message)            //留言列表
	beego.CtrlPost("/message", (*controllers.PortalController).CreateMessage)     //留言
	beego.CtrlPost("/registration", (*controllers.PortalController).Registration) //注册
	beego.CtrlGet("/verify", (*controllers.PortalController).Verify)              //验证账号

	//namespace中的路由推荐用NS开头的方法
	//admin管理后台路由配置
	ns := beego.NewNamespace("/admin",
		//根据实际经验，推荐使用直接注册的方式来管理路由，而不是注解路由。
		//原因：可以直接明了的看到所有路由，不再使用可以直接注释掉，方便搜索。而注解路由过于分散不易管理，且并不能减少代码量
		beego.NSBefore(controllers.HasAdminPermission), //权限校验
		beego.NSCtrlGet("/", (*page.AdminPageController).Welcome),
		beego.NSNamespace("/page",
			beego.NSCtrlGet("/", (*page.AdminPageController).Welcome),
			beego.NSCtrlGet("/welcome", (*page.AdminPageController).Welcome),
			beego.NSCtrlGet("/login", (*page.AdminPageController).Login),
			beego.NSCtrlGet("/register", (*page.AdminPageController).Register),          //注册路由
			beego.NSCtrlGet("/user-list", (*page.AdminPageController).UserList),         //用户列表路由
			beego.NSCtrlGet("/user-add", (*page.AdminPageController).UserAdd),           //添加用户
			beego.NSCtrlGet("/article-add", (*page.AdminPageController).ArticleCreate),  //创建文章路由
			beego.NSCtrlGet("/article-list", (*page.AdminPageController).ArticleList),   //文章列表路由
			beego.NSCtrlGet("/article-edit", (*page.AdminPageController).ArticleEdit),   //编辑文章路由
			beego.NSCtrlGet("/logs", (*page.AdminPageController).LogList),               //日志列表路由
			beego.NSCtrlGet("/pname", (*page.AdminPageController).PNameView),            //通讯录
			beego.NSCtrlGet("/picture", (*page.AdminPageController).Picture),            //Picture 图片检索
			beego.NSCtrlGet("/picture-list", (*page.AdminPageController).PictureList),   //ListPicture 图片列表路由
			beego.NSCtrlGet("/icons", (*page.AdminPageController).IconList),             //IconList 列表
			beego.NSCtrlGet("/system-info", (*page.AdminPageController).SystemInfo),     //系统信息
			beego.NSCtrlGet("/job-count", (*page.AdminPageController).JobCount),         //JobCount 工作数量统计
			beego.NSCtrlGet("/roles", (*page.AdminPageController).RoleList),             //角色列表路由
			beego.NSCtrlGet("/messages", (*page.AdminPageController).Messages),          //留言查看，审核 页面
			beego.NSCtrlGet("/category-list", (*page.AdminPageController).CategoryList), //文章分类
			beego.NSCtrlGet("/movies", (*page.AdminPageController).Movies),              //免费电影管理
		),
		beego.NSNamespace("/api",
			beego.NSCtrlPost("/to-login", (*api.UserAPIController).ToLogin),                                //登录接口
			beego.NSCtrlGet("/login-out", (*api.UserAPIController).LoginOut),                               //登出
			beego.NSCtrlPut("/user/:id/status", (*api.UserAPIController).UserUpdateStatus),                 //修改用户状态
			beego.NSCtrlDelete("/user/delete", (*api.UserAPIController).UserDelete),                        //删除用户
			beego.NSCtrlGet("/user/:id", (*api.UserAPIController).UserGet),                                 //获取单个用户
			beego.NSCtrlPost("/user", (*api.UserAPIController).UserCreate),                                 //新建用户
			beego.NSCtrlPut("/user", (*api.UserAPIController).UpdateUser),                                  //修改用户
			beego.NSCtrlGet("/users", (*api.UserAPIController).UserList),                                   //用户列表接口
			beego.NSCtrlPost("/article", (*api.ArticleAPIController).ArticleCreate),                        //创建文章接口
			beego.NSCtrlGet("/articles", (*api.ArticleAPIController).ArticleList),                          //文章列表接口
			beego.NSCtrlPut("/article/:id", (*api.ArticleAPIController).ArticleEdit),                       //修改文章接口
			beego.NSCtrlDelete("/article/:id", (*api.ArticleAPIController).ArticleDelete),                  //删除文章接口
			beego.NSCtrlGet("/logs", (*api.AdminAPIController).GetLogs),                                    //日志列表接口
			beego.NSCtrlPost("/upload-img", (*api.AdminAPIController).UploadImg),                           //上传图片
			beego.NSCtrlPost("/pictures", (*api.AdminAPIController).PictureAdd),                            //AddPicture 保存图片
			beego.NSCtrlGet("/picture-list", (*api.AdminAPIController).PictureList),                        //ListPicture 图片列表
			beego.NSCtrlDelete("/picture-delete", (*api.AdminAPIController).PictureDelete),                 //DeletePicture 删除图片
			beego.NSCtrlPost("/user/add-roles", (*api.AdminAPIController).AddUserRoles),                    //用户添加权限
			beego.NSCtrlGet("/user-roles/:userId", (*api.AdminAPIController).GetUserRoles),                 //获取用户权限
			beego.NSCtrlGet("/roles/list", (*api.AdminAPIController).GetRolesList),                         //获取角色列表
			beego.NSCtrlPost("/roles/create", (*api.AdminAPIController).RoleCreate),                        //创建角色
			beego.NSCtrlPut("/roles/update", (*api.AdminAPIController).RoleUpdate),                         //修改角色
			beego.NSCtrlDelete("/roles/delete/:id", (*api.AdminAPIController).RoleDelete),                  //删除角色
			beego.NSCtrlGet("/job-count/count-data-recently", (*api.AdminAPIController).CountDataRecently), //CountDataRecently 近一个月数据
			beego.NSCtrlGet("/job-count/count-data-all", (*api.AdminAPIController).CountDataAll),           //CountDataAll 所有历史数据，按月平均值统计
			beego.NSCtrlGet("/message/list", (*api.AdminAPIController).MessageList),                        //留言查看，审核
			beego.NSCtrlPut("/message/update/:id", (*api.AdminAPIController).MessageUpdate),                //留言审核通过
			beego.NSCtrlDelete("/message/delete/:id", (*api.AdminAPIController).MessageDelete),             //删除留言
			beego.NSCtrlGet("/categories", (*api.AdminAPIController).Categories),                           //文章分类列表
			beego.NSCtrlPost("/categories", (*api.AdminAPIController).CategoriesCreate),                    //创建分类
			beego.NSCtrlPut("/categories", (*api.AdminAPIController).CategoriesUpdate),                     //修改分类
			beego.NSCtrlPost("/movie/add", (*api.AdminAPIController).MovieAdd),                             //创建电影网站
			beego.NSCtrlPut("/movie/update", (*api.AdminAPIController).MovieUpdate),                        //修改电影网站
			beego.NSCtrlDelete("/movie/delete/:id", (*api.AdminAPIController).MovieDelete),                 //删除电影网站
			beego.NSCtrlGet("/movie-list", (*api.AdminAPIController).MovieList),                            //电影网站列表
			beego.NSCtrlGet("/movie/:id", (*api.AdminAPIController).MovieInfo),                             //电影网站详情
		),
	)
	//注册namespace
	beego.AddNamespace(ns)
}
