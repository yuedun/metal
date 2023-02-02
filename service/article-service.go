package service

import (
	. "metal/models"
	"sync"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/logs"
)

type IArticleService interface {
	Save(article Article) (int64, error)
	GetArticleList(param map[string]string, pageIndex, pageSize int) (articles []Article, total int64, returnError error)
	GetById() error
	Update() (int64, error)
	Delete() (int64, error)
	GetCategory() ([]Article, error)
}

type ArticleService struct {
	orm orm.Ormer
}

func NewArticleService(o orm.Ormer) IArticleService {
	return &ArticleService{
		orm: o,
	}
}

func (s *ArticleService) Save(article Article) (int64, error) {
	return s.orm.Insert(&article)
}

func (s *ArticleService) GetArticleList(param map[string]string, pageIndex, pageSize int) (list []Article, total int64, returnError error) {
	var condition = "WHERE 1"
	if param["title"] != "" {
		condition += " AND title LIKE '" + param["title"] + "%'"
	}
	if param["category"] != "" {
		condition += " AND category LIKE '%" + param["category"] + "%'"
	}
	if param["keywords"] != "" {
		condition += " AND keywords LIKE '%" + param["keywords"] + "%'"
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT * FROM article "
		sql += condition
		sql += " ORDER BY id DESC"
		sql += " LIMIT ?, ?;"
		_, err := s.orm.Raw(sql, pageIndex, pageSize).QueryRows(&list)
		if err != nil {
			returnError = err
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM article "
		sql += condition
		err := s.orm.Raw(sql).QueryRow(&total)
		if err != nil {
			returnError = err
		}
		logs.Debug("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return list, total, returnError
}

func (s *ArticleService) GetById() error {
	err := s.orm.Read(&Article{}, "id")
	return err
}

func (s *ArticleService) Update() (int64, error) {
	id, err := s.orm.Update((*Article)(nil), "title", "content", "category", "keywords", "updated_at")
	return id, err
}

func (s *ArticleService) Delete() (int64, error) {
	id, err := s.orm.Delete((*Article)(nil), "id")
	return id, err
}

func (s *ArticleService) GetCategory() ([]Article, error) {
	titles := make([]Article, 1)
	_, err := s.orm.Raw("SELECT id, title FROM article WHERE status = 1 ORDER BY id DESC;").QueryRows(&titles)
	return titles, err
}
