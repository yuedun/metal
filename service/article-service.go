package service

import (
	. "metal/models"
	"sync"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/logs"
)

type ArticleService interface {
	Save(article Article) (int64, error)
	GetArticlesByCondition(param map[string]string, pageIndex, pageSize int) (articles []Article, total int64, returnError error)
	GetById() error
	Update() (int64, error)
	Delete() (int64, error)
	GetCategory() ([]Article, error)
}

type articleService struct {
}

func NewService() ArticleService {
	return &articleService{}
}

func (a *articleService) Save(article Article) (int64, error) {
	o := orm.NewOrm()
	return o.Insert(&article)
}

func (a *articleService) GetArticlesByCondition(param map[string]string, pageIndex, pageSize int) (articles []Article, total int64, returnError error) {
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
		logs.Info("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return articles, total, returnError
}

func (article *articleService) GetById() error {
	o := orm.NewOrm()
	err := o.Read(article, "id")
	return err
}

func (article *articleService) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(article, "title", "content", "updated_at")
	return id, err
}
func (article *articleService) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(article)
	return id, err
}

func (article *articleService) GetCategory() ([]Article, error) {
	o := orm.NewOrm()
	titles := make([]Article, 1)
	_, err := o.Raw("SELECT id, title FROM article WHERE status = 1 ORDER BY id DESC;").QueryRows(&titles)
	return titles, err
}
