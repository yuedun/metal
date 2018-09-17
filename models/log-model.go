package models

import (
	"github.com/astaxie/beego/orm"
	"time"
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
func (log *Log) GetLogs() ([]Log, error) {
	o := orm.NewOrm()
	var logs []Log
	//var userGroups []orm.Params//orm.Params是一个map类型
	num, err := o.Raw("select * from log order by id desc;").QueryRows(&logs)
	if nil != err && num > 0 {
		return nil, err
	}
	return logs, nil
}
