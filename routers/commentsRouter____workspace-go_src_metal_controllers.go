package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context/param"
)

func init() {

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "CreateArticle",
            Router: `/article`,
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "ArticleEditRoute",
            Router: `/article-edit-route/:id`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "CreateArticleRoute",
            Router: `/article-route`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "ArticleEdit",
            Router: `/article/:id`,
            AllowHTTPMethods: []string{"put"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "ArticleDelete",
            Router: `/article/:id`,
            AllowHTTPMethods: []string{"delete"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "ArticlesList",
            Router: `/articles`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "ArticlesRoute",
            Router: `/articles-route`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "GetLogs",
            Router: `/logs`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "LogsRoute",
            Router: `/logs-route`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "PNameView",
            Router: `/pname/view`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "TemplatesRoute",
            Router: `/template-route`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "CreateTemplate",
            Router: `/template/add`,
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "TemplateView",
            Router: `/template/view/:id`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "TemplateList",
            Router: `/templates`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:AdminController"] = append(beego.GlobalControllerRouter["metal/controllers:AdminController"],
        beego.ControllerComments{
            Method: "UploadImg",
            Router: `/uploadImg`,
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:GroupController"] = append(beego.GlobalControllerRouter["metal/controllers:GroupController"],
        beego.ControllerComments{
            Method: "GetUserRoles",
            Router: `/user-roles/:userId`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:GroupController"] = append(beego.GlobalControllerRouter["metal/controllers:GroupController"],
        beego.ControllerComments{
            Method: "AddUserRole",
            Router: `/user/groups`,
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:JobCountController"] = append(beego.GlobalControllerRouter["metal/controllers:JobCountController"],
        beego.ControllerComments{
            Method: "JobCount",
            Router: `/job-count`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:JobCountController"] = append(beego.GlobalControllerRouter["metal/controllers:JobCountController"],
        beego.ControllerComments{
            Method: "CountDataAll",
            Router: `/job-count/count-data-all`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:JobCountController"] = append(beego.GlobalControllerRouter["metal/controllers:JobCountController"],
        beego.ControllerComments{
            Method: "CountDataRecently",
            Router: `/job-count/count-data-recently`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Get",
            Router: `/`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "About",
            Router: `/about`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Article",
            Router: `/article/:id`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Category",
            Router: `/category`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "MyRoute",
            Router: `/test`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "AddUser",
            Router: `/user`,
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Vipkid",
            Router: `/vipkid`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:UserGroupController"] = append(beego.GlobalControllerRouter["metal/controllers:UserGroupController"],
        beego.ControllerComments{
            Method: "AddUserGroup",
            Router: `/user-group/add-user-group`,
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:UserGroupController"] = append(beego.GlobalControllerRouter["metal/controllers:UserGroupController"],
        beego.ControllerComments{
            Method: "GetAllUserGroup",
            Router: `/user-group/get-all-user-group`,
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

}
