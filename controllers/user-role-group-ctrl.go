package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"encoding/json"
	"errors"
	"log"
	. "metal/models"
	"strconv"
	"time"

	"github.com/astaxie/beego/logs"
)

// UserGroupController 用户角色权限管理
type UserGroupController struct {
	AdminBaseController
}

func (c *UserGroupController) Roles() {
	c.TplName = "admin/roles.html"
}

/**
 * 获取所有权限
 */
// @router /user-group/get-all-user-group [get]
func (c *UserGroupController) GetAllUserGroup() {
	userGroup := new(UserGroup)
	list, err := userGroup.GetUserGroupList()
	if nil != err {
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = list
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

// AddUserRole 用户添加权限
func (c *UserGroupController) AddUserRole() {
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
	err := json.Unmarshal(c.Ctx.Input.RequestBody, &args)
	if err != nil {
		panic(err)
	}
	logs.Info("参数：", args)
	userId := args.UserId
	if userId == 0 {
		panic(errors.New("userId不能为空"))
	}
	roleIds := args.Roles
	if len(roleIds) == 0 {
		panic(errors.New("roleId不能为空"))
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

// GetUserRoles 获取用户权限
func (c *UserGroupController) GetUserRoles() {
	userId := c.Ctx.Input.Param(":userId")
	uid, _ := strconv.Atoi(userId)
	role := new(Role)
	allRoles, userRoles, err := role.GetRolesAndUserPermission(uid)
	logs.Debug("allRoles:", allRoles)
	logs.Debug("userRoles:", userRoles)
	if nil != err {
		c.Data["json"] = ErrorData(err)
	}
	userPermissions := make([]UserGroups, 0, 20)
	for index, item := range allRoles {
		userPremis := new(UserGroups)
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
