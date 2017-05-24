package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"fmt"
	. "metal/models"
	"time"

	"github.com/astaxie/beego"
)

type AdminController struct {
	beego.Controller
}

func (this *AdminController) Get() {
	fmt.Println()
	this.TplName = "admin/index.html"
}
func (this *AdminController) Login() {
	this.TplName = "admin/login.html"
}
func (this *AdminController) Welcome() {
	this.TplName = "admin/welcome.html"
}

func (this *UserController) UserList() {
	user := new(Users)
	userList, err := user.FindAllUser()
	for _, u := range userList {
		date, _ := time.Parse("2006-01-02 15:04:05", u.CreatedAt) //这样的日期格式化也真是够奇葩的
		u.CreatedAt = date.Format("2006-01-02 15:04:05")
		fmt.Println(">>>>>>>>>>>>>", u.CreatedAt)
	}
	if nil != err {
		this.Data["json"] = map[string]interface{}{"msg": err}
		this.ServeJSON()
	}
	this.Data["userList"] = userList
	this.Data["total"] = len(userList)
	this.TplName = "admin/user-list.html"
}
func (this *UserController) UserAddUI() {
	this.TplName = "admin/user-add.html"
}
