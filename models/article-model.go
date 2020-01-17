package models

import (
	"github.com/astaxie/beego/logs"
	"sync"
	"time"

	"github.com/astaxie/beego/orm"
)

type Article struct {
	BaseModel
	Title   string `json:"title"`
	Content string `json:"content"`
	Status  uint8  `json:"status"`
}
type ArticlePortal struct {
	Article
	Img string
}

func init() {
	orm.RegisterModel(new(Article))
}

func (model *Article) Save() (int64, error) {
	o := orm.NewOrm()
	model.Status = 1
	model.CreatedAt = time.Now()
	model.UpdatedAt = time.Now()
	return o.Insert(model)
}

func (model *Article) GetArticlesByCondition(param map[string]string, pageIndex, pageSize int) (articles []Article, total int64, returnError error) {
	o := orm.NewOrm()
	var condition = ""
	if param["status"] != "" {
		condition += " AND status IN (" + param["status"] + ")"
	}
	if param["title"] != "" {
		condition += " AND title LIKE '" + param["title"] + "%'"
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT * FROM article WHERE 1=1"
		sql += condition
		sql += " ORDER BY id DESC"
		sql += " LIMIT ?, ?;"
		_, err := o.Raw(sql, pageIndex, pageSize).QueryRows(&articles)
		if err != nil {
			returnError = err
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM article WHERE status = 1"
		sql += condition
		err := o.Raw(sql).QueryRow(&total)
		if err != nil {
			returnError = err
		}
		logs.Info("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return articles, total, returnError
}

func (model *Article) GetById() error {
	o := orm.NewOrm()
	err := o.Read(model, "id")
	return err
}

func (model *Article) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(model, "title", "content", "updated_at")
	return id, err
}
func (model *Article) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(model)
	return id, err
}

func (model *Article) GetCategory() ([]Article, error) {
	o := orm.NewOrm()
	titles := make([]Article, 1)
	_, err := o.Raw("SELECT id, title FROM article WHERE status = 1 ORDER BY id DESC;").QueryRows(&titles)
	return titles, err
}
