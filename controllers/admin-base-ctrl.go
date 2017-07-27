package controllers

import (
	"fmt"
	//	. "metal/models"

	"github.com/astaxie/beego"
)

type BaseController struct {
	beego.Controller
}

func (this *BaseController) Prepare() {
	fmt.Println(">>>>>>>>Prepare")
}
