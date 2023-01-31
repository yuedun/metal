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

// GetAllCategories 获取所有分类列表
func (category *Category) GetAllCategories() (list []Category, err error) {
	o := orm.NewOrm()
	_, err = o.Raw("SELECT id, name FROM category;").QueryRows(&list)
	if err != nil {
		return nil, err
	}
	return list, nil
}

// 创建分类
func (category *Category) Create() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Insert(category)
	return id, err
}

// 通过id修改
func (category *Category) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(category) // 要修改的对象和需要修改的字段
	return id, err
}

// 通过名称查记录
func (category *Category) GetByName() error {
	o := orm.NewOrm()
	err := o.Read(category, "name") //需要指定要查询的字段
	return err
}
