package models

import (
	"fmt"
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

func (article *Article) Save() (int64, error) {
	o := orm.NewOrm()
	article.Status = 1
	article.CreatedAt = time.Now()
	article.UpdatedAt = time.Now()
	return o.Insert(article)
}

func (article *Article) GetArticlesByCondition(param map[string]string, pageIndex, pageSize int) (articles []Article, total int64, returnError error) {
	o := orm.NewOrm()
	var condition = ""
	if param["title"] != "" {
		condition += " AND title LIKE '" + param["title"] + "%'"
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT * FROM article WHERE status = 1"
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
		fmt.Println("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return articles, total, returnError
}

func (article *Article) GetById() error {
	o := orm.NewOrm()
	err := o.Read(article, "id")
	return err
}

func (article *Article) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(article, "title", "content", "updated_at")
	return id, err
}
func (article *Article) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(article)
	return id, err
}

func (article *Article) GetCategory() ([]Article, error) {
	o := orm.NewOrm()
	titles := make([]Article, 1)
	_, err := o.Raw("SELECT id, title FROM article WHERE status = 1 ORDER BY id DESC;").QueryRows(&titles)
	return titles, err
}
