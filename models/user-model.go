package models

import (
	"fmt"
	"time"

	"github.com/astaxie/beego/orm"
)

/**
 * 模型与数据库字段多少不一定要匹配
 */
type Users struct {
	Id          int
	Username    string
	Password    string
	Gender      string
	Mobile      string
	Email       string
	Addr        string
	Description string
	CreatedAt   time.Time
	UpdatedAt   time.Time
	Status      int
}
type UserPOJO struct {
	Users
	CreatedAt string
	UpdatedAt string
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(Users))
	//如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	//反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

// 添加用户
func (user *Users) AddUser() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	o.Using("default")
	//每次操作都需要新建一个Ormer变量，当然也可以全局设置
	//需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(user)
}

// 通过id查找用户
func (user *Users) FindUserById() (*Users, error) {
	o := orm.NewOrm()
	o.Using("default")
	err := o.Read(user, "id")
	return user, err
}

// 通过用户名查找用户
func (user *Users) FindUser() (*Users, error) {
	o := orm.NewOrm()
	o.Using("default")
	err := o.Read(user, "username")
	return user, err
}

//获取用户列表
func (user *Users) FindAllUser() ([]Users, error) {
	o := orm.NewOrm()
	o.Using("default")
	var users []Users
	num, err := o.Raw("SELECT * FROM users").QueryRows(&users)
	fmt.Println("查询到", num, "条数据")
	return users, err

}

// 通过id修改用户
func (user *Users) UpdateUser() (int64, error) {
	o := orm.NewOrm()
	o.Using("default")
	id, err := o.Update(user, "username", "email") //要修改的对象和需要修改的字段
	return id, err
}

// 通过id删除用户
func (user *Users) DeleteUser() (int64, error) {
	o := orm.NewOrm()
	o.Using("default")
	id, err := o.Delete(user, "id") //要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	} else {
		return id, nil
	}
}
