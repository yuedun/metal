package models

import (
	"sync"
	"time"

	"github.com/beego/beego/v2/client/orm"
)

type ArticleLog struct {
	BaseModel
	ArticleId uint   `orm:"index" json:"articleId"`
	Mark      string `json:"mark"`
}

func init() {
	orm.RegisterModel(new(ArticleLog))
}

func (log *ArticleLog) Save(artId uint, mark string) (int64, error) {
	o := orm.NewOrm()
	log.CreatedAt = time.Now()
	log.UpdatedAt = time.Now()
	log.ArticleId = artId
	log.Mark = mark
	return o.Insert(log)
}
func (log *ArticleLog) GetLogs(start, perPage int) (logs []Log, total int64, newError error) {
	o := orm.NewOrm()
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		num, err := o.Raw("select * from log order by id desc limit ?, ?;", start, perPage).QueryRows(&logs)
		if nil != err && num > 0 {
			newError = err
		}
	}()
	go func() {
		defer wg.Done()
		err := o.Raw("select count(*) from log;").QueryRow(&total)
		if nil != err {
			newError = err
		}
	}()
	wg.Wait()
	return logs, total, newError
}
