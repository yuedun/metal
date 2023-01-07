package models

import (
	"strconv"
	"sync"
	"time"

	"github.com/beego/beego/v2/core/logs"

	"github.com/beego/beego/v2/client/orm"
)

type Article struct {
	BaseModel
	Title    string `json:"title"`
	Keywords string `json:"keywords"`
	Content  string `json:"content" org:"type(text)"`
	Category string `json:"category"` //分类
	Status   uint8  `json:"status"`
}

// func (a Article) MarshalJSON() ([]byte, error) {
// 	type TT Article
// 	return json.Marshal(struct {
// 		TT
// 		CreatedAt string
// 		UpdatedAt string
// 	}{
// 		TT(a),
// 		a.CreatedAt.Format("2006-01-02 15:04"),
// 		a.CreatedAt.Format("2006-01-02 15:04"),
// 	})
// }

type ArticlePortal struct {
	Article
	ViewCount int    //浏览量
	Img       string //缩略图
	CreatedAt string
	UpdatedAt string
	Previous  Article
	Next      Article
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
	if param["title"] != "" {
		condition += " AND title LIKE '" + param["title"] + "%'"
	}
	if param["category"] != "" {
		condition += " AND category = '" + param["category"] + "'"
	}
	if param["keywords"] != "" {
		condition += " AND keywords LIKE '%" + param["keywords"] + "%'"
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
		logs.Debug("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return articles, total, returnError
}

func (model *Article) GetById() error {
	o := orm.NewOrm()
	err := o.Read(model)
	return err
}

func (model *Article) Update() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(model, "title", "content", "category", "keywords", "updated_at")
	return id, err
}
func (model *Article) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(model)
	return id, err
}

// 目录
func (model *Article) GetCatalog() ([]ArticlePortal, error) {
	o := orm.NewOrm()
	titles := make([]ArticlePortal, 1)
	_, err := o.Raw("SELECT id, title, DATE_FORMAT(created_at,'%Y-%m-%d') as created_at, DATE_FORMAT(updated_at,'%Y-%m-%d') as updated_at FROM article WHERE status = 1 ORDER BY id DESC;").QueryRows(&titles)
	return titles, err
}

// 查询所有分类
func (model *Article) GetCategories() ([]string, error) {
	o := orm.NewOrm()
	titles := make([]string, 1)
	_, err := o.Raw("SELECT category FROM article GROUP BY category;").QueryRows(&titles)
	return titles, err
}

// 查询所有标签
func (model *Article) GetKeywords() ([]ArticlePortal, error) {
	o := orm.NewOrm()
	titles := make([]ArticlePortal, 1)
	_, err := o.Raw("SELECT keywords FROM article GROUP BY keywords;").QueryRows(&titles)
	return titles, err
}

// 文章详情
func (model *Article) ArticleDetail() (ArticlePortal, error) {
	o := orm.NewOrm()
	err := o.Read(model)
	articlePortal := ArticlePortal{}
	strID := strconv.Itoa(int(model.Id))
	o.Raw("SELECT count(1) FROM article_log WHERE article_id = ?", model.Id).QueryRow(&articlePortal.ViewCount)
	o.Raw("SELECT id, title FROM article WHERE id < " + strID + " ORDER BY id DESC LIMIT 1;").QueryRow(&articlePortal.Previous)
	o.Raw("SELECT id, title FROM article WHERE id > " + strID + " ORDER BY id ASC LIMIT 1;").QueryRow(&articlePortal.Next)
	return articlePortal, err
}

func (model *Article) GetArticleViewCount(id uint) (int, error) {
	o := orm.NewOrm()
	count := 0
	err := o.Raw("SELECT count(1) FROM article_log WHERE article_id = ?", id).QueryRow(&count)
	if err != nil {
		return 0, err
	}
	return count, nil
}
