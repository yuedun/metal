package models

import "github.com/astaxie/beego/orm"

type Group struct {
	BaseModel
	Name string
	Permissions string
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(Group))
	// 如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	// 反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

// 添加权限名
func (group *Group) Save() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	// 每次操作都需要新建一个Ormer变量，当然也可以全局设置
	// 需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(group)
}