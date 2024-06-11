package models

import (
	"fmt"

	"github.com/beego/beego/v2/core/logs"

	"github.com/beego/beego/v2/client/orm"
)

// JobCount 添加tag标签
type JobCount struct {
	BaseModel
	JobTitle string `json:"job_title"`
	Amount   uint   `json:"amount"`
	Region   string `json:"region"`
}

func init() {
	orm.RegisterModel(new(JobCount))
}

// Save 添加记录
func (jobCount *JobCount) Save() (int64, error) {
	o := orm.NewOrm()
	return o.Insert(jobCount)
}

type JobData struct {
	CreatedAt string `json:"created_at"`
	Golang    string `json:"golang"`
	Nodejs    string `json:"nodejs"`
}

// GetCountData 获取记录列表，利用行专列将同一天数据一行展示
func (jobCount *JobCount) GetCountData(startDate, endDate string) ([]JobData, error) {
	o := orm.NewOrm()
	var jobCounts []JobData
	var sql = fmt.Sprintf(`SELECT 
		a.created_at, 
		MAX( CASE a.job_title WHEN 'golang' THEN a.amount ELSE 0 END ) 'golang', 
		MAX( CASE a.job_title WHEN 'nodejs' THEN a.amount ELSE 0 END ) 'nodejs' 
	FROM ( SELECT job_title, amount, DATE_FORMAT(created_at, '%%Y-%%m-%%d') AS created_at FROM job_count ) AS a `)
	if startDate != "" && endDate != "" {
		sql += fmt.Sprintf("WHERE a.created_at >= '%s' AND a.created_at <= '%s'", startDate, endDate)
	}
	sql += " GROUP BY a.created_at;"
	num, err := o.Raw(sql).QueryRows(&jobCounts)
	logs.Info("近一个月查询到", num, "条数据")
	return jobCounts, err
}

// GetCountDataAll 所有历史数据，按月平均值统计
func (jobCount *JobCount) GetCountDataAll() ([]JobData, error) {
	o := orm.NewOrm()
	var jobCounts []JobData
	var sql = `
		SELECT 
			a.created_at, 
			MAX( CASE a.job_title WHEN 'golang' THEN a.amount ELSE 0 END ) 'golang', 
			MAX( CASE a.job_title WHEN 'nodejs' THEN a.amount ELSE 0 END ) 'nodejs' FROM 
		( SELECT job_title, ROUND(AVG(amount)) AS amount, DATE_FORMAT(created_at, '%Y-%m') AS created_at FROM job_count GROUP BY job_title, YEAR (created_at), MONTH (created_at) ) AS a 
		GROUP BY a.created_at;`
	num, err := o.Raw(sql).QueryRows(&jobCounts)
	logs.Info("每月平均查询到", num, "条数据")
	return jobCounts, err
}

type JobDataLanguage struct {
	Count    int    //数量
	Region   string //地区
	Language string //语言
}

// 保存数据
func SaveJob(c JobDataLanguage) {
	jobCount := &JobCount{
		JobTitle: c.Language,
		Amount:   uint(c.Count),
		Region:   c.Region,
	}
	jobCount.Save()
	logs.Info("保存job成功", c.Language, c.Count)
}
