package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context/param"
)

func init() {

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
            Method: "Category",
            Router: "/category",
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

    beego.GlobalControllerRouter["metal/controllers:UserGroupController"] = append(beego.GlobalControllerRouter["metal/controllers:UserGroupController"],
        beego.ControllerComments{
            Method: "AddUserGroup",
            Router: "/user-group/add-user-group",
            AllowHTTPMethods: []string{"post"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

    beego.GlobalControllerRouter["metal/controllers:UserGroupController"] = append(beego.GlobalControllerRouter["metal/controllers:UserGroupController"],
        beego.ControllerComments{
            Method: "GetAllUserGroup",
            Router: "/user-group/get-all-user-group",
            AllowHTTPMethods: []string{"get"},
            MethodParams: param.Make(),
            Filters: nil,
            Params: nil})

}
