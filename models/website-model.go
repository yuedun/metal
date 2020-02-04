package models

import (
	"github.com/astaxie/beego/logs"
	"sync"
	"time"

	"github.com/astaxie/beego/orm"
)

type WebSite struct {
	BaseModel
	Name     string `json:"name"`
	Category string `json:"category"`
	Status   uint8  `json:"status"`
	Url      string `json:"url"`
}

func init() {
	orm.RegisterModel(new(WebSite))
}

func (model *WebSite) Save() (int64, error) {
	o := orm.NewOrm()
	model.Status = 1
	model.CreatedAt = time.Now()
	model.UpdatedAt = time.Now()
	return o.Insert(model)
}

func (model *WebSite) GetListByCondition(param map[string]string, pageIndex, pageSize int) (list []WebSite, total int64, returnError error) {
	o := orm.NewOrm()
	var condition = ""
	if param["status"] != "" {
		condition += " AND status IN (" + param["status"] + ")"
	}
	if param["title"] != "" {
		condition += " AND name LIKE '" + param["title"] + "%'"
	}
	list = []WebSite{} //初始化一个空的
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT * FROM website WHERE 1=1"
		sql += condition
		sql += " ORDER BY id DESC"
		sql += " LIMIT ?, ?;"
		_, err := o.Raw(sql, pageIndex, pageSize).QueryRows(&list)
		if err != nil {
			returnError = err
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM website WHERE status = 1"
		sql += condition
		err := o.Raw(sql).QueryRow(&total)
		if err != nil {
			returnError = err
		}
		logs.Info("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return list, total, returnError
}

func (model *WebSite) GetById() error {
	o := orm.NewOrm()
	err := o.Read(model, "id")
	return err
}

func (model *WebSite) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(model, "title", "content", "updated_at")
	return id, err
}
func (model *WebSite) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(model)
	return id, err
}

func (model *WebSite) GetCategory() ([]Article, error) {
	o := orm.NewOrm()
	titles := make([]Article, 1)
	_, err := o.Raw("SELECT id, title FROM website WHERE status = 1 ORDER BY id DESC;").QueryRows(&titles)
	return titles, err
}
