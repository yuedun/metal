package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"encoding/json"
	"github.com/astaxie/beego/logs"
	"log"
	. "metal/models"
	"time"
)

type UserGroupController struct {
	BaseController
}

/**
 * 获取所有权限
 */
// @router /user-group/get-all-user-group [get]
func (c *UserGroupController) GetAllUserGroup() {
	userGroup := new(UserGroup)
	userGroups, err := userGroup.GetUserGroupList()
	if nil != err {
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = userGroups
	}
	c.ServeJSON()
}

/**
用户添加权限
*/
// @router /user-group/add-user-group [post]
func (c *UserGroupController) AddUserGroup() {
	defer func() {
		if err := recover(); err != nil {
			c.Data["json"] = ErrorMsg(err.(string))
		}
		c.ServeJSON()
	}()
	args := UserGroup{}
	json.Unmarshal(c.Ctx.Input.RequestBody, &args)
	userId := args.UserId
	if userId == 0 {
		log.Panic("userId不能为空")
	}
	groupId := args.GroupId
	if groupId == 0 {
		log.Panic("groupId不能为空")
	}
	var userGroup = new(UserGroup)
	userGroup.UserId = userId
	userGroup.GroupId = groupId
	userGroup.CreatedAt = time.Now()
	userGroup.UpdatedAt = time.Now()

	_, err := userGroup.Save()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(nil)
	}
}
