package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
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
	}
	c.Data["json"] = userGroups
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
	userId, erru := c.GetInt("userId")
	if nil != erru {
		log.Panic(erru)
	}
	groupId, err2 := c.GetInt("groupId")
	if nil != err2 {
		log.Panic(err2)
	}
	var userGroup = new(UserGroup)
	userGroup.UserId = userId
	userGroup.GroupId = groupId
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
