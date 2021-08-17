package models

import (
	"sync"

	"github.com/beego/beego/v2/client/orm"
)

type Category struct {
	BaseModel
	Name string `json:"name"`
}

func init() {
	orm.RegisterModel(new(Category))
}

// GetCategorysList 获取角色列表
func (category *Category) GetCategoryList(search Category, offset, limit int) (allCategorys []Category, count int64, err error) {
	o := orm.NewOrm()
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		count, err = o.QueryTable("category").Count()

	}()
	go func() {
		defer wg.Done()
		_, err = o.Raw("SELECT * FROM category LIMIT ?, ?;", offset, limit).QueryRows(&allCategorys)
	}()
	wg.Wait()
	return
}

// 创建角色
func (category *Category) Create() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Insert(category) // 要修改的对象和需要修改的字段
	return id, err
}

// 通过id修改
func (category *Category) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(category, "description", "groups") // 要修改的对象和需要修改的字段
	return id, err
}
