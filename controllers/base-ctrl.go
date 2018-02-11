package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
)

type BaseController struct {
	beego.Controller
}

/**
 * 给interface起个别名，这样是不是简短很多了
 */
type any = interface{}

/**
 * 这个函数主要是为了用户扩展用的，这个函数会在下面定义的这些 Method 方法之前执行，用户可以重写这个函数实现类似用户验证之类
 */
func (this *BaseController) Prepare() {
	fmt.Println(">>>>>>>>Prepare")
}

//权限验证
var HasAdminPermission = func(ctx *context.Context) {
	fmt.Println(">>>>>>>>>>>>>admin auth")
}