package permissions

// 此变量作用：
// 需要验证权限的接口，如果值为false或没有配置代表不需要验证权限
// 配置以后且值为true代表需要验证权限，并匹配数据库中用户是否存在对应权限
// 可使用该方式集中维护权限，也可以由各个controller各自在Prepare维护自己权限，缺点是每个controller都要写一遍Prepare

var NeedPermission = map[string]bool{
	"AdminController:ToLogin":              false,
	"AdminController:LoginOut":             false,
	"AdminController:ToRegister":           false,
	"AdminController:Register":             false,
	"AdminController:Welcome":              false,
	"AdminController:UserList":             true,
	"AdminController:UserListRoute":        true,
	"AdminController:UpdateUser":           true,
	"AdminController:DisableUser":          true,
	"AdminController:EnableUser":           true,
	"AdminController:DeleteUser":           true,
	"AdminController:ArticleEdit":          true,
	"AdminController:ArticleDelete":        true,
	"AdminController:CreateArticle":        false,
	"AdminController:ArticleEditRoute":     false,
	"AdminController:CreateArticleRoute":   false,
	"AdminController:ArticlesList":         false,
	"AdminController:ArticlesRoute":        false,
	"AdminController:GetLogs":              false,
	"AdminController:LogsRoute":            false,
	"AdminController:PNameView":            false,
	"AdminController:TemplatesRoute":       false,
	"AdminController:CreateTemplate":       false,
	"AdminController:TemplateView":         false,
	"AdminController:TemplateList":         false,
	"AdminController:UploadImg":            false,
	"JobCountController:JobCount":          false,
	"JobCountController:CountDataAll":      false,
	"JobCountController:CountDataRecently": false,
	"UserGroupController:GetUserRoles":     false,
	"UserGroupController:AddUserRole":      false,
	"UserGroupController:AddUserGroup":     false,
	"UserGroupController:GetAllUserGroup":  false,
	"UserGroupController:Roles":            true,
	"UserGroupController:UpdateRole":       true,
	"UserGroupController:CreateRole":       true,
}
