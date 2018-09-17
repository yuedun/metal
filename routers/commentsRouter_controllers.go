package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context/param"
)

func init() {

	beego.GlobalControllerRouter["metal/controllers:GroupController"] = append(beego.GlobalControllerRouter["metal/controllers:GroupController"],
		beego.ControllerComments{
			Method: "GetAllRole",
			Router: `/roles`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:GroupController"] = append(beego.GlobalControllerRouter["metal/controllers:GroupController"],
		beego.ControllerComments{
			Method: "Aaa",
			Router: `/user/:id`,
			AllowHTTPMethods: []string{"post","get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:GroupController"] = append(beego.GlobalControllerRouter["metal/controllers:GroupController"],
		beego.ControllerComments{
			Method: "AddUserRole",
			Router: `/user/groups`,
			AllowHTTPMethods: []string{"post"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:MainController"] = append(beego.GlobalControllerRouter["metal/controllers:MainController"],
		beego.ControllerComments{
			Method: "Get",
			Router: `/`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:MainController"] = append(beego.GlobalControllerRouter["metal/controllers:MainController"],
		beego.ControllerComments{
			Method: "About",
			Router: `/about`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:MainController"] = append(beego.GlobalControllerRouter["metal/controllers:MainController"],
		beego.ControllerComments{
			Method: "Category",
			Router: `/category`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:MainController"] = append(beego.GlobalControllerRouter["metal/controllers:MainController"],
		beego.ControllerComments{
			Method: "MyRoute",
			Router: `/test`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:MainController"] = append(beego.GlobalControllerRouter["metal/controllers:MainController"],
		beego.ControllerComments{
			Method: "AddUser",
			Router: `/user`,
			AllowHTTPMethods: []string{"post"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:UserController"] = append(beego.GlobalControllerRouter["metal/controllers:UserController"],
		beego.ControllerComments{
			Method: "GetLogsRoute",
			Router: `/get-logs-route`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:UserController"] = append(beego.GlobalControllerRouter["metal/controllers:UserController"],
		beego.ControllerComments{
			Method: "JobCount",
			Router: `/job-count`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:UserController"] = append(beego.GlobalControllerRouter["metal/controllers:UserController"],
		beego.ControllerComments{
			Method: "CountDataAll",
			Router: `/job-count/count-data-all`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:UserController"] = append(beego.GlobalControllerRouter["metal/controllers:UserController"],
		beego.ControllerComments{
			Method: "CountDataRecently",
			Router: `/job-count/count-data-recently`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:UserController"] = append(beego.GlobalControllerRouter["metal/controllers:UserController"],
		beego.ControllerComments{
			Method: "GetLogs",
			Router: `/logs`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:UserGroupController"] = append(beego.GlobalControllerRouter["metal/controllers:UserGroupController"],
		beego.ControllerComments{
			Method: "AddUserGroup",
			Router: `/user-group/add-user-group`,
			AllowHTTPMethods: []string{"post"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:UserGroupController"] = append(beego.GlobalControllerRouter["metal/controllers:UserGroupController"],
		beego.ControllerComments{
			Method: "GetAllUserGroup",
			Router: `/user-group/get-all-user-group`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["metal/controllers:UserGroupController"] = append(beego.GlobalControllerRouter["metal/controllers:UserGroupController"],
		beego.ControllerComments{
			Method: "Aaa",
			Router: `/user/:id`,
			AllowHTTPMethods: []string{"post","get"},
			MethodParams: param.Make(),
			Params: nil})

}
