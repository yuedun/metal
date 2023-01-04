package models

import (
	"sync"
	"time"

	"github.com/beego/beego/v2/client/orm"
)

type Log struct {
	BaseModel
	Mark string `json:"mark"`
}

func init() {
	orm.RegisterModel(new(Log))
}

func (log *Log) Save(mark string) (int64, error) {
	o := orm.NewOrm()
	log.CreatedAt = time.Now()
	log.UpdatedAt = time.Now()
	log.Mark = mark
	return o.Insert(log)
}
func (log *Log) GetLogList(start, perPage int) (logs []Log, total int64, returnError error) {
	o := orm.NewOrm()
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		num, err := o.Raw("select * from log order by id desc limit ?, ?;", start, perPage).QueryRows(&logs)
		if nil != err && num > 0 {
			returnError = err
		}
	}()
	go func() {
		defer wg.Done()
		err := o.Raw("select count(*) from log;").QueryRow(&total)
		if nil != err {
			returnError = err
		}
	}()
	wg.Wait()
	return logs, total, returnError
}
