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

//注解路由
// @router /admin/user-group [get]
func (c *UserGroupController) Get() {

	//默认tpl或html后缀
	c.TplName = "index.html"
}

// @router /admin/user-group [post]
func (c *UserGroupController) Post() {
	userId := c.GetString("userId")
	groupId := c.GetString("groupId")

	var userGroup = new(UserGroup)
	userGroup.UserId = userId
	userGroup.GroupId = groupId
	userGroup.CreatedAt = time.Now()
	userGroup.UpdatedAt = time.Now()

	_, err := userGroup.Save()
	if nil != err {
		log.Print(err)
		c.Data["json"] = ErrorMsg(err)
	}
	c.ServeJSON()
}
