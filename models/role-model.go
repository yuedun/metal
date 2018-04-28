package models

import "github.com/astaxie/beego/orm"

type Role struct {
	BaseModel
	Name   string
	Groups string
}

func init() {
	orm.RegisterModel(new(Role))
}

func (role *Role) GetUserPermissions() error {
	o := orm.NewOrm()
	return o.Read(role, "id")
}
