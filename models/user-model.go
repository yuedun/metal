package models

import (
	"fmt"
	"strconv"
	"sync"

	"github.com/beego/beego/v2/core/logs"

	"github.com/beego/beego/v2/client/orm"
)

// 性别
var SexMap = map[int]string{0: "女", 1: "男"}

type USERSTATUS int

const (
	UserStatusForbid     USERSTATUS = 0 //禁用
	UserStatusOk         USERSTATUS = 1 //正常
	UserStatusUnverified USERSTATUS = 2 //未验证，注册未验证手机或邮箱
)

/**
 * 模型与数据库字段多少不一定要匹配
 */
type User struct {
	BaseModel
	Username    string     `json:"username" orm:"size(20)"`
	Password    string     `json:"password"`
	Gender      int        `json:"gender" orm:"default(1);description(0女，1男)"` // 0女，1男
	Mobile      string     `json:"mobile"`
	Email       string     `json:"email" orm:"size(30);unique"`
	Addr        string     `json:"addr"  orm:"size(50)"`
	Description string     `json:"description"`
	Status      USERSTATUS `json:"status" orm:"default(1);description(0不可用，1可用)"` // 0不可用，1可用
	Token       string     `json:"-" orm:"type(text)"`
}
type UserVO struct {
	User
	Gender    string `json:"gender"`
	CreatedAt string `json:"created_at"`
	UpdatedAt string `json:"updated_at"`
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(User))
	// 如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	// 反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

// 添加用户
func (user *User) Save() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	// 每次操作都需要新建一个Ormer变量，当然也可以全局设置
	// 需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(user)
}

// 通过id查找用户
func (user *User) GetById() (*User, error) {
	o := orm.NewOrm()
	err := o.Read(user, "id")
	return user, err
}

// 通过用户名查找用户
func (user *User) GetByCondition() error {
	o := orm.NewOrm()
	sql := "SELECT id, mobile, username, password, gender, email, addr, status, description, created_at, updated_at FROM user where 1 "
	if user.Id != 0 {
		sql += fmt.Sprintf(" and id = %d", user.Id)
	}
	if user.Email != "" {
		sql += fmt.Sprintf(" and email = '%s'", user.Email)
	}
	if user.Mobile != "" {
		sql += fmt.Sprintf(" and mobile = '%s'", user.Mobile)
	}
	if user.Username != "" {
		sql += fmt.Sprintf(" and username = '%s'", user.Username)
	}
	sql += " LIMIT 1;"
	err := o.Raw(sql).QueryRow(&user)
	if err != nil {
		return err
	}
	return nil
}

// 通过手机号查找用户
func (user *User) GetByMobile() error {
	o := orm.NewOrm()
	err := o.Raw("SELECT id, mobile, username, password, gender, email, addr, status, description, created_at, updated_at FROM user where mobile = ? OR email = ? LIMIT 1;", user.Mobile, user.Mobile).QueryRow(&user)
	if err != nil {
		return err
	}
	return nil
}

// 获取用户列表
func (user *User) GetAll() ([]User, error) {
	o := orm.NewOrm()
	var users []User
	num, err := o.Raw("SELECT id, mobile, username, password, gender, email, addr, status, description, created_at, updated_at FROM user ORDER BY id DESC;").QueryRows(&users)
	logs.Info("查询到", num, "条数据")
	return users, err
}

// 获取用户列表
func (user *User) GetUserList(cond map[string]string, start, perPage int) (users []User, total int64, newError error) {
	o := orm.NewOrm()
	var condition = " WHERE 1 "
	if cond["username"] != "" {
		condition += "and username like '" + cond["username"] + "%'"
	}
	if cond["mobile"] != "" {
		condition += "and mobile like '" + cond["mobile"] + "%'"
	}
	if cond["email"] != "" {
		condition += "and email like '" + cond["email"] + "%'"
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT id, mobile, username, password, gender, email, addr, status, description, created_at, updated_at FROM `user` "
		sql += condition
		sql += " LIMIT ?, ?"
		_, err := o.Raw(sql, strconv.Itoa(start), strconv.Itoa(perPage)).QueryRows(&users)
		if err != nil {
			newError = err
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(1) FROM user "
		sql += condition
		err := o.Raw(sql).QueryRow(&total)
		if err != nil {
			newError = err
		}
		logs.Debug("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return users, total, newError
}

// 通过id修改用户
func (user *User) Update(col ...string) (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(user, col...) // 要修改的对象和需要修改的字段
	return id, err
}

// 修改用户状态
func (user *User) UpdateStatus() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(user, "status") // 要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	}
	return id, nil
}

// 通过id删除用户
func (user *User) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(user, "status") // 要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	}
	return id, nil
}
