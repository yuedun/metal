package models

import (
	"github.com/astaxie/beego/orm"
	"sync"
)

type Role struct {
	BaseModel
	Description string `json:"description"`
	Groups      string `json:"groups"`
}

type UserPermisson struct {
	Role_id     uint   `json:"roleId"`
	Description string `json:"description"`
	Checked     bool   `json:"checked"`
}

func init() {
	orm.RegisterModel(new(Role))
}

/**
 * 获取所有权限和单个用户拥有的权限
 */
func (role *Role) GetRolesAndUserPermission(userId int) (allRoles []Role, userRoles []uint, returnErr error) {
	o := orm.NewOrm()
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		_, err := o.Raw("SELECT id, description FROM role ORDER BY id DESC;").QueryRows(&allRoles)
		if nil != err {
			returnErr = err
		}
	}()
	go func() {
		defer wg.Done()
		_, err := o.Raw("SELECT role_id FROM groups WHERE user_id = ? ORDER BY id DESC;", userId).QueryRows(&userRoles)
		if nil != err {
			returnErr = err
		}
	}()
	wg.Wait()
	return
}
