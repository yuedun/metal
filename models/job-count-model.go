package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

/**
 * 模型与数据库字段多少不一定要匹配
 */
type JobCount struct {
	Id        uint      `json:"id"`
	CreatedAt time.Time `json:"created_at"`
	JobTitle  string    `json:"job_title"`
	Amount    uint      `json:"amount"`
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(JobCount))
	// 如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	// 反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

// 添加记录
func (jobCount *JobCount) Save() (int64, error) {
	o := orm.NewOrm()
	return o.Insert(jobCount)
}
