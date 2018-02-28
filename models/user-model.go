package models

import (
	"fmt"
	"strconv"
	"time"

	"github.com/astaxie/beego/orm"
)

type any = interface{}

/**
 * 模型与数据库字段多少不一定要匹配
 */
type User struct {
	Id          int
	Username    string
	Password    string
	Gender      int //0女，1男
	Mobile      string
	Email       string
	Addr        string
	Description string
	CreatedAt   time.Time
	UpdatedAt   time.Time
	Status      int //0不可用，1可用
}
type UserVO struct {
	User
	Gender    string
	CreatedAt string
	UpdatedAt string
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(User))
	//如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	//反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

// 添加用户
func (user *User) Save() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	//每次操作都需要新建一个Ormer变量，当然也可以全局设置
	//需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(user)
}

// 通过id查找用户
func (user *User) GetById() (*User, error) {
	o := orm.NewOrm()
	err := o.Read(user, "id")
	return user, err
}

// 通过用户名查找用户
func (user *User) GetByName() (*User, error) {
	o := orm.NewOrm()
	err := o.Read(user, "username")
	return user, err
}

//获取用户列表
func (user *User) GetAll() ([]User, error) {
	o := orm.NewOrm()
	var users []User
	num, err := o.Raw("SELECT * FROM user").QueryRows(&users)
	fmt.Println("查询到", num, "条数据")
	return users, err

}
//获取用户列表
func (user *User) GetAllByCondition(cond map[string]any, start, perPage int) ([]User, int64, error) {
	o := orm.NewOrm()
	var users []User
	var sql = "SELECT * FROM user LIMIT " + strconv.Itoa(start) + ", " + strconv.Itoa(perPage)
	_, err := o.Raw(sql).QueryRows(&users)
	if err!=nil {
		return nil, 0, err
	}
	var total int64
	err2 := o.Raw("SELECT COUNT(*) FROM user").QueryRow(&total)
	if err2 != nil {
		return nil, 0, err
	}
	fmt.Println("mysql row affected nums: ", total)
	return users, total, err

}

// 通过id修改用户
func (user *User) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(user, "username", "gender", "email", "mobile", "addr", "description", "updated_at") //要修改的对象和需要修改的字段
	return id, err
}

// 通过id删除用户
func (user *User) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(user, "id") //要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	} else {
		return id, nil
	}
}
