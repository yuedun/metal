package models

import (
	"time"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/logs"
)

type Groups struct {
	BaseModel
	UserId uint `json:"user_id"`
	RoleId uint `json:"role_id"`
}

func init() {
	orm.RegisterModel(new(Groups))
}

func (group *Groups) GetUserGroupList() ([]Role, error) {
	o := orm.NewOrm()
	var roles []Role
	//var userGroups []orm.Params//orm.Params是一个map类型
	num, err := o.Raw("select * from role order by id desc;").QueryRows(&roles)
	if nil != err && num > 0 {
		return nil, err
	}
	return roles, nil
}

/**
 * 根据userid获取usergroup list
 */
func (group *Groups) GetGroupByUserId(userId uint) ([]Role, error) {
	o := orm.NewOrm()
	var userGroups []Role
	qb, _ := orm.NewQueryBuilder("mysql")
	qb.Select("role.groups").From("role").InnerJoin("`groups` as g").On("role.id = g.role_id").Where("g.user_id = ?")
	// 导出 SQL 语句
	sql := qb.String()
	// 执行 SQL 语句
	_, err := o.Raw(sql, userId).QueryRows(&userGroups)

	if nil != err {
		return nil, err
	}
	return userGroups, nil
}

// 用户添加权限
func (group *Groups) Save() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	// 每次操作都需要新建一个Ormer变量，当然也可以全局设置
	// 需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(group)
}

// 修改用户权限
func (group *Groups) UpdateUserRoles(userId uint, roleIds []uint) error {
	o := orm.NewOrm()
	to, err := o.Begin()
	if err != nil {
		logs.Error("start the transaction failed")
		return err
	}
	group.UserId = userId
	if _, err := to.Delete(group, "user_id"); err == nil {
		logs.Error(err)
	}

	for _, roleId := range roleIds {
		var userGroup = new(Groups)
		userGroup.UserId = userId
		userGroup.RoleId = roleId
		userGroup.CreatedAt = time.Now()
		userGroup.UpdatedAt = time.Now()
		_, err := to.Insert(userGroup)
		if nil != err {
			logs.Error(err)
			to.Rollback()
			return err
		}
	}

	err = to.Commit()

	return err
}
