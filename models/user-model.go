package models

import (
	"fmt"
	"strconv"
	"sync"

	"github.com/astaxie/beego/orm"
)

type any = interface{}

//性别
var SexMap = map[int]string{0: "女", 1: "男"}

//状态
var StatusMap = map[int]string{0: "禁用", 1: "可用"}

/**
 * 模型与数据库字段多少不一定要匹配
 */
type User struct {
	BaseModel
	UserName    string
	Password    string
	Gender      int // 0女，1男
	Mobile      string
	Email       string
	Addr        string
	Description string
	Status      int // 0不可用，1可用
}
type UserVO struct {
	User
	Gender    string
	Status    string
	CreatedAt string
	UpdatedAt string
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
func (user *User) GetByName() error {
	o := orm.NewOrm()
	err := o.Read(user, "username")
	if err != nil {
		return err
	}
	return nil
}

// 通过手机号查找用户
func (user *User) GetByMobile() error {
	o := orm.NewOrm()
	err := o.Read(user, "mobile")
	if err != nil {
		return err
	}
	return nil
}

// 获取用户列表
func (user *User) GetAll() ([]User, error) {
	o := orm.NewOrm()
	var users []User
	num, err := o.Raw("SELECT * FROM user").QueryRows(&users)
	fmt.Println("查询到", num, "条数据")
	return users, err

}

// 获取用户列表
func (user *User) GetAllByCondition(cond map[string]string, start, perPage int) ([]User, int64, error) {
	o := orm.NewOrm()
	var users []User
	var total int64
	var newError error
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var param []string
		var sql = "SELECT * FROM user WHERE 1 "
		if cond["mobile"] != "" {
			sql += "and (mobile like '" + cond["username"] + "%' or user_name like '" + cond["username"] + "%' )"
		}
		sql += " LIMIT " + strconv.Itoa(start) + ", " + strconv.Itoa(perPage)
		_, err := o.Raw(sql, param).QueryRows(&users)
		if err != nil {
			newError = err
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM user WHERE 1 "
		if cond["mobile"] != "" {
			sql += "and (mobile like '" + cond["username"] + "%' or user_name like '" + cond["username"] + "%' )"
		}
		err2 := o.Raw(sql).QueryRow(&total)
		if err2 != nil {
			newError = err2
		}
		fmt.Println("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return users, total, newError
}

// 通过id修改用户
func (user *User) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(user, "username", "gender", "email", "mobile", "addr", "description", "updated_at") // 要修改的对象和需要修改的字段
	return id, err
}

// 通过id删除用户
func (user *User) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(user, "id") // 要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	} else {
		return id, nil
	}
}
