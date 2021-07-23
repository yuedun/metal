package models

import (
	"strconv"
	"sync"

	"github.com/beego/beego/v2/core/logs"

	"github.com/beego/beego/v2/client/orm"
)

/**
 * 模型与数据库字段多少不一定要匹配
 */
type Picture struct {
	BaseModel
	PicUrl string `json:"pic_url"`
	Tag    string `json:"tag"`
	Status int    `json:"status"`
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(Picture))
	// 如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	// 反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

// 添加用户
func (pic *Picture) Save() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	// 每次操作都需要新建一个Ormer变量，当然也可以全局设置
	// 需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(pic)
}

// 获取用户列表
func (pic *Picture) GetAllByCondition(cond string, start, perPage int) (pics []Picture, total int64, newError error) {
	o := orm.NewOrm()
	var condition = " WHERE status = 1 "
	if cond != "" {
		condition += "and tag like '%" + cond + "%' "
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT * FROM picture "
		sql += condition
		sql += " LIMIT ?, ?"
		_, err := o.Raw(sql, strconv.Itoa(start), strconv.Itoa(perPage)).QueryRows(&pics)
		if err != nil {
			newError = err
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM picture "
		sql += condition
		err := o.Raw(sql).QueryRow(&total)
		if err != nil {
			newError = err
		}
		logs.Info("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return pics, total, newError
}

// 通过id修改用户
func (pic *Picture) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(pic, "username", "gender", "email", "mobile", "addr", "description", "updated_at") // 要修改的对象和需要修改的字段
	return id, err
}

// 通过id删除用户
func (pic *Picture) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(pic, "status") // 要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	} else {
		return id, nil
	}
}
