package models

import "github.com/astaxie/beego/orm"

type Role struct {
	BaseModel
	Description string
	Groups      string
}

func init() {
	orm.RegisterModel(new(Role))
}

func (role *Role) GetUserPermissions() error {
	o := orm.NewOrm()
	return o.Read(role, "id")
}

func (role *Role) GetAllRole() ([]Role, error) {
	o := orm.NewOrm()
	var roles []Role
	//var userGroups []orm.Params//orm.Params是一个map类型
	num, err := o.Raw("select id, description from role order by id desc;").QueryRows(&roles)
	if nil != err && num > 0 {
		return nil, err
	}
	return roles, nil
}