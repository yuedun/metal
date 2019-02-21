package controllers

import (
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

// 前端权限验证
var HasIndexPermission = func(ctx *context.Context) {
	// TODO 做一些验证
}

// 自定义404错误页面
// 需要beego.Run之前注册beego.ErrorController(&controllers.ErrorController{})
// func (c *BaseController) Error404() {
//     c.Data["content"] = ">>>>>>>>>>"
//     c.TplName = "404.html"
// }

// 接口返回数据标准化
type Result struct {
	Code int         `json:"code"`
	Data interface{} `json:"data"`
	Msg  string      `json:"msg"`
}

/**
返回错误信息，code是可选的自定义代码
*/
func ErrorMsg(msg string, code ...int) Result {
	var r Result
	if len(code) > 0 {
		r.Code = code[0]
	} else {
		r.Code = 1
	}
	r.Msg = msg
	r.Data = nil
	return r
}

/**
 * ErrorMsg和ErrorData作用一样，只不过是为了方便调用方不用手动msg.Error()，只需传error类型即可
 */
func ErrorData(msg error, code ...int) Result {
	var r Result
	if len(code) > 0 {
		r.Code = code[0]
	} else {
		r.Code = 1
	}
	r.Msg = msg.Error()
	r.Data = nil
	return r
}

func SuccessData(data interface{}) Result {
	var r Result
	r.Code = 0
	r.Msg = "ok"
	r.Data = data
	return r
}
