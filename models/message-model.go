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
type Message struct {
	BaseModel
	NickName string `json:"nick_name" orm:"size(20)"`
	Email    string `json:"email" orm:"size(30)"`
	Content  string `json:"content" orm:"size(200)"`
	Status   int    `json:"status" orm:"default(0);description(0待审核，1通过，2不通过)"` // 0待审核，1通过，2不通过
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(Message))
	// 如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	// 反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

// 添加用户
func (msg *Message) Save() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	// 每次操作都需要新建一个Ormer变量，当然也可以全局设置
	// 需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(msg)
}

// 通过id查找用户
func (msg *Message) GetById() (*Message, error) {
	o := orm.NewOrm()
	err := o.Read(msg, "id")
	return msg, err
}

// 获取用户列表
func (msg *Message) GetAll() ([]Message, error) {
	o := orm.NewOrm()
	var list []Message
	num, err := o.Raw("SELECT * FROM msg").QueryRows(&list)
	logs.Info("查询到", num, "条数据")
	return list, err

}

// 获取用户列表
func (msg *Message) GetAllByCondition(cond map[string]string, start, perPage int) (list []Message, total int64, newError error) {
	o := orm.NewOrm()
	var condition = " WHERE 1 "
	if cond["status"] != "" {
		condition += "and status = " + cond["status"]
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT * FROM message "
		sql += condition
		sql += " ORDER BY id DESC LIMIT ?, ?"
		_, err := o.Raw(sql, strconv.Itoa(start), strconv.Itoa(perPage)).QueryRows(&list)
		if err != nil {
			newError = err
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM message "
		sql += condition
		err := o.Raw(sql).QueryRow(&total)
		if err != nil {
			newError = err
		}
		logs.Info("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return list, total, newError
}

// 通过id修改用户
func (msg *Message) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(msg, "username", "gender", "email", "mobile", "addr", "description", "updated_at") // 要修改的对象和需要修改的字段
	return id, err
}

// 修改用户状态
func (msg *Message) UpdateStatus() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(msg, "status") // 要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	}
	return id, nil
}

// 通过id删除用户
func (msg *Message) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(msg) // 要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	}
	return id, nil
}
