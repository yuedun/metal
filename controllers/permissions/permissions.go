package permissions

/**
 * 此变量作用：
 * 需要验证权限的接口，如果值为false或没有配置代表不需要需要验证
 * 配置以后且值为true代表需要验证权限，并匹配数据库中是否存在权限
 * 可使用该方式集中维护权限，也可以由各个controller各自在Prepare维护自己权限，缺点是每个controller都要写一遍Prepare
 */
var NeedPermission = map[string]bool{
	"AdminController:ToLogin":       false,
	"AdminController:LoginOut":      false,
	"AdminController:ToRegister":    false,
	"AdminController:Register":      false,
	"AdminController:Welcome":       false,
	"AdminController:UserList":      true,
	"AdminController:UserListRoute": true,
	"AdminController:PUT":           true,
	"AdminController:POST":          true,
	"AdminController:DeleteUser":    true,
	"AdminController:ArticleEdit":   true,
	"AdminController:ArticleDelete":   true,
}
