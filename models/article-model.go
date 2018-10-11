package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type Article struct {
	BaseModel
	Title   string `json:"title"`
	Content string `json:"content"`
}

func init() {
	orm.RegisterModel(new(Article))
}

func (article *Article) Save() (int64, error) {
	o := orm.NewOrm()
	article.CreatedAt = time.Now()
	article.UpdatedAt = time.Now()
	return o.Insert(article)
}
func (article *Article) GetArticles() ([]Article, error) {
	o := orm.NewOrm()
	articles := make([]Article, 0, 50)
	num, err := o.Raw("select * from article order by id desc;").QueryRows(&articles)
	if nil != err && num > 0 {
		return nil, err
	}
	return articles, nil
}
