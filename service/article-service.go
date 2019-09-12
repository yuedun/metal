package service

import (
	"github.com/astaxie/beego/orm"
	. "metal/models"
)

type ArticleService interface {
	Save(article *Article)(int64, error)
	//GetArticlesByCondition(param map[string]string, pageIndex, pageSize int) (articles []Article, total int64, returnError error)
}

type articleService struct {

}

func NewService() ArticleService {
	return &articleService{}
}

func (a *articleService) Save(article *Article) (int64, error) {
	o := orm.NewOrm()
	return o.Insert(article)
}