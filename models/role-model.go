package models

import (
	"sync"

	"github.com/astaxie/beego/orm"
)

type Role struct {
	BaseModel
	Description string `json:"description"`
	Groups      string `json:"groups"`
}

type UserGroups struct {
	Role_id     uint   `json:"roleId"`
	Description string `json:"description"`
	Checked     bool   `json:"checked"`
}

func init() {
	orm.RegisterModel(new(Role))
}

// GetRolesAndUserPermission 获取所有权限和单个用户拥有的权限
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

// GetRolesList 获取角色列表
func (role *Role) GetRolesList(search Role, offset, limit int) (allRoles []Role, count int64, err error) {
	o := orm.NewOrm()
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		count, err = o.QueryTable("role").Count()

	}()
	go func() {
		defer wg.Done()
		_, err = o.Raw("SELECT * FROM role LIMIT ?, ?;", offset, limit).QueryRows(&allRoles)
	}()
	wg.Wait()
	return
}

// 创建角色
func (role *Role) Create() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Insert(role) // 要修改的对象和需要修改的字段
	return id, err
}

// 通过id修改
func (role *Role) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(role, "description", "groups") // 要修改的对象和需要修改的字段
	return id, err
}
