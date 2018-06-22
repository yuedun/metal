package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"encoding/json"
	"github.com/astaxie/beego/logs"
	"log"
	. "metal/models"
	"time"
)

type GroupController struct {
	AdminBaseController
}

/**
 * 获取所有权限
 */
// @router /roles [get]
func (c *GroupController) GetAllRole() {
	role := new(Role)
	roles, err := role.GetAllRole()
	if nil != err {
		c.Data["json"] = ErrorData(err)
	}
	c.Data["json"] = SuccessData(roles)
	c.ServeJSON()
}

/**
用户添加权限
*/
// @router /user/groups [post]
func (c *GroupController) AddUserRole() {
	defer func() {
		if err := recover(); err != nil {
			c.Data["json"] = ErrorData(err.(error))
		}
		c.ServeJSON()
	}()
	var args struct {
		UserId uint
		Roles  []uint
	}
	json.Unmarshal(c.Ctx.Input.RequestBody, &args)
	log.Print("*********%v", args)
	userId := args.UserId
	if userId == 0 {
		log.Panic("userId不能为空")
	}
	roleIds := args.Roles
	if len(roleIds) == 0 {
		log.Panic("roleId不能为空")
	}
	for _, roleId := range roleIds {
		var userGroup = new(Groups)
		userGroup.UserId = userId
		userGroup.RoleId = roleId
		userGroup.CreatedAt = time.Now()
		userGroup.UpdatedAt = time.Now()
		_, err := userGroup.Save()
		if nil != err {
			logs.Error(err)
			panic(err)
		}
	}
	c.Data["json"] = SuccessData(nil)
}

// @Title aaa
// @router /user/:id [post,get]
func (c *GroupController) Aaa() {

}
