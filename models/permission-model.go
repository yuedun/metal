package models

import (
	"github.com/beego/beego/v2/client/orm"
)

// 权限表，某个增删改查接口名称
type Permission struct {
	Id          uint   `json:"id" orm:"pk;auto"`
	Description string `json:"description"` //权限说明
}

// 用户，角色关联关系，一对多
type UserRole struct {
	BaseModel
	UserId uint `orm:"index" json:"user_id"`
	RoleId uint `orm:"index" json:"role_id"`
}

// 角色表
type Role struct {
	Id          uint   `json:"id" orm:"pk;auto"`
	Description string `json:"description"`                  //角色说明
	Permissions string `json:"permissions" orm:"type(text)"` //角色拥有的多个权限
}

// 前端需要数据结构
type UserRoles struct {
	Role_id     uint   `json:"roleId"`
	Description string `json:"description"`
	Checked     bool   `json:"checked"`
}

func init() {
	orm.RegisterModel(new(Permission), new(Role), new(UserRole))
}
