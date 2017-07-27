package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"fmt"
	//	. "metal/models"
	//	"time"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
)

//权限验证
var HasAdminPermission = func(ctx *context.Context) {
	fmt.Println(">>>>>>>>>>>>>admin auth")
}

type AdminController struct {
	beego.Controller
}

func (this *AdminController) Get() {
	fmt.Print("index")
	this.TplName = "admin/index.html"
}
func (this *AdminController) Login() {
	this.TplName = "admin/login.html"
}
func (this *AdminController) Welcome() {
	this.TplName = "admin/welcome.html"
}
