package models

import (
	"github.com/astaxie/beego/orm"
	"time"
	"fmt"
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
	orm.RegisterModel(new(JobCount))
}

// 添加记录
func (jobCount *JobCount) Save() (int64, error) {
	o := orm.NewOrm()
	return o.Insert(jobCount)
}
// 获取记录列表
func (jobCount *JobCount) GetCountData() ([]JobCount, error) {
	o := orm.NewOrm()
	var jobCounts []JobCount
	num, err := o.Raw("SELECT * FROM job_count;").QueryRows(&jobCounts)
	fmt.Println("查询到", num, "条数据")
	return jobCounts, err
}
