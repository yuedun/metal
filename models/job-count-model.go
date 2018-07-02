package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
	"time"
)

/**
 * 添加tag标签
 */
type JobCount struct {
	Id        uint      `json:"id"`
	CreatedAt time.Time `json:"created_at"`
	JobTitle  string    `json:"job_title"`
	Amount    uint      `json:"amount"`
	Region    string    `json:"region"`
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
func (jobCount *JobCount) GetCountData(lang, startDate, endDate string) ([]JobCount, error) {
	o := orm.NewOrm()
	var jobCounts []JobCount
	var sql = fmt.Sprintf("SELECT job_title, amount,DATE_FORMAT(created_at,'%%Y-%%m-%%d') AS created_at FROM job_count WHERE job_title='%s'", lang)
	if startDate !="" && endDate !="" {
		sql += fmt.Sprintf("AND created_at >= '%s' AND created_at <= '%s'", startDate, endDate)
	}
	num, err := o.Raw(sql).QueryRows(&jobCounts)
	fmt.Println("查询到", num, "条数据")
	return jobCounts, err
}
func (jobCount *JobCount) GetCountDataAll() ([]JobCount, error) {
	o := orm.NewOrm()
	var jobCounts []JobCount
	var sql = fmt.Sprintf("SELECT job_title, amount,DATE_FORMAT(created_at,'%%Y-%%m-%%d') AS created_at FROM job_count WHERE job_title='%s'", jobCount.JobTitle)
	num, err := o.Raw(sql).QueryRows(&jobCounts)
	fmt.Println("查询到", num, "条数据")
	return jobCounts, err
}
