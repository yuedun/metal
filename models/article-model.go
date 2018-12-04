package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
	"strconv"
	"sync"
	"time"
)

type Article struct {
	BaseModel
	Title   string `json:"title"`
	Content string `json:"content"`
	Status  uint8  `json:"status"`
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
func (article *Article) GetArticles() ([]Article, error) {
	o := orm.NewOrm()
	articles := make([]Article, 0, 50)
	num, err := o.Raw("select * from article WHERE status = 1 order by id desc;").QueryRows(&articles)
	if nil != err && num > 0 {
		return nil, err
	}
	return articles, nil
}

func (article *Article) GetArticlesByCondition(param map[string]string, start, perPage int) ([]Article, int64, error) {
	o := orm.NewOrm()
	var articles []Article
	var total int64
	var newError error
	var condition = ""
	if param["title"] != "" {
		condition += "and title like '" + param["title"] + "%'"
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT * FROM article WHERE status = 1 "
		sql += condition
		sql += "ORDER BY id DESC"
		sql += " LIMIT " + strconv.Itoa(start) + ", " + strconv.Itoa(perPage)
		_, err := o.Raw(sql).QueryRows(&articles)
		if err != nil {
			newError = err
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM article "
		sql += condition
		err := o.Raw(sql).QueryRow(&total)
		if err != nil {
			newError = err
		}
		fmt.Println("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return articles, total, newError
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
