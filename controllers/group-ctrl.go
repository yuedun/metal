package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"encoding/json"
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
// @router /user-role/get-all-user-role [get]
func (c *GroupController) GetAllUserGroup() {
	userGroup := new(Group)
	userGroups, err := userGroup.GetUserGroupList()
	if nil != err {
		c.Data["json"] = ErrorData(err)
	}
	c.Data["json"] = userGroups
	c.ServeJSON()
}

/**
用户添加权限
*/
// @router /user-role/add-user-role [post]
func (c *GroupController) AddUserGroup() {
	defer func() {
		if err := recover(); err != nil {
			c.Data["json"] = ErrorMsg(err.(string))
		}
		c.ServeJSON()
	}()
	args := Group{}
	json.Unmarshal(c.Ctx.Input.RequestBody, &args)
	userId := args.UserId
	if userId == 0 {
		log.Panic("userId不能为空")
	}
	roleId := args.RoleId
	if roleId == 0 {
		log.Panic("roleId不能为空")
	}
	var userGroup = new(Group)
	userGroup.UserId = userId
	userGroup.RoleId = roleId
	userGroup.CreatedAt = time.Now()
	userGroup.UpdatedAt = time.Now()

	_, err := userGroup.Save()
	if nil != err {
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(nil)
	}
}

// @Title aaa
// @router /user/:id [post,get]
func (c *GroupController) Aaa() {

}
