package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"encoding/json"
	"github.com/astaxie/beego/logs"
	"log"
	. "metal/models"
	"strconv"
	"time"
)

type GroupController struct {
	AdminBaseController
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

/**
 * 获取用户权限
 */
// @router /user-roles/:userId [get]
func (c *GroupController) GetUserRoles() {
	userId := c.Ctx.Input.Param(":userId")
	uid, _ := strconv.Atoi(userId)
	role := new(Role)
	allRoles, userRoles, err := role.GetRolesAndUserPermission(uid)
	if nil != err {
		c.Data["json"] = ErrorData(err)
	}
	userPermissions := make([]UserPermisson, 0, 20)
	for index, item := range allRoles {
		userPremis := new(UserPermisson)
		userPremis.Role_id = uint(item.Id)
		userPremis.Description = item.Description
		for _, rid := range userRoles {
			if item.Id == rid {
				userPremis.Checked = true
				break
			}
		}
		userPermissions = append(userPermissions[:index], *userPremis)
	}

	c.Data["json"] = SuccessData(userPermissions)
	c.ServeJSON()
}
