package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"encoding/json"
	"errors"
	. "metal/models"
	"strconv"
	"time"

	"github.com/astaxie/beego/logs"
)

// GroupController 用户权限管理
type GroupController struct {
	AdminBaseController
}

// AddUserRole 用户添加权限
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
func (c *GroupController) GetUserRoles() {
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
		userPremis.Role_id = uint(item.ID)
		userPremis.Description = item.Description
		for _, rid := range userRoles {
			if item.ID == rid {
				userPremis.Checked = true
				break
			}
		}
		userPermissions = append(userPermissions[:index], *userPremis)
	}
	c.Data["json"] = SuccessData(userPermissions)
	c.ServeJSON()
}
