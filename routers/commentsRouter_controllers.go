package routers

import (
	beego "github.com/beego/beego/v2/server/web"
	"github.com/beego/beego/v2/server/web/context/param"
)

func init() {

    beego.GlobalControllerRouter["metal/controllers/api:AdminAPIController"] = append(beego.GlobalControllerRouter["metal/controllers/api:AdminAPIController"],
        beego.ControllerComments{
            Method: "AddUserGroup",
            Router: "/user-group/add-user-group",
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers/api:AdminAPIController"] = append(beego.GlobalControllerRouter["metal/controllers/api:AdminAPIController"],
        beego.ControllerComments{
            Method: "GetAllUserGroup",
            Router: "/user-group/get-all-user-group",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Get",
            Router: "/",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "About",
            Router: "/about",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Article",
            Router: "/article/:id",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Catalog",
            Router: "/catalog",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Categories",
            Router: "/categories/:category",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Message",
            Router: "/message",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "CreateMessage",
            Router: "/message",
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:PortalController"] = append(beego.GlobalControllerRouter["metal/controllers:PortalController"],
        beego.ControllerComments{
            Method: "Tags",
            Router: "/tags/:tag",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

}
