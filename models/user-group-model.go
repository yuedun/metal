package models

import (
	"github.com/astaxie/beego/orm"
)

type UserGroup struct {
	BaseModel
	UserId  int
	GroupId int
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(UserGroup))
	// 如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	// 反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

func (userGroup *UserGroup) GetUserGroupList() ([]UserGroup, error) {
	o := orm.NewOrm()
	var userGroups []UserGroup
	//var userGroups []orm.Params//orm.Params是一个map类型
	num, err := o.Raw("select * from user_group order by id desc;").QueryRows(&userGroups)
	if nil != err && num > 0 {
		return nil, err
	}
	return userGroups, nil
}

/**
 * 根据userid获取usergroup list
 */
func (userGroup *UserGroup) GetGroupByUserId(userId int) ([]UserGroup, error) {
	o := orm.NewOrm()
	var userGroups []UserGroup
	//var userGroups []orm.Params//orm.Params是一个map类型
	num, err := o.Raw("select * from user_group where user_id = ?;", userId).QueryRows(&userGroups)
	if nil != err && num > 0 {
		return nil, err
	}
	return userGroups, nil
}

// 用户添加权限
func (userGroup *UserGroup) Save() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	// 每次操作都需要新建一个Ormer变量，当然也可以全局设置
	// 需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(userGroup)
}
