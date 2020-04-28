package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	. "metal/models"

	"github.com/astaxie/beego/logs"
)

type JobCountController struct {
	AdminBaseController
}

//JobCount 工作数量统计
func (c *JobCountController) JobCount() {
	c.Data["title"] = "报表"
	c.TplName = "admin/job-count.html"
}

//CountDataRecently 近一个月数据
func (c *JobCountController) CountDataRecently() {
	startDate := c.GetString("startDate") + " 00:00:00"
	endDate := c.GetString("endDate") + " 23:59:59"

	logs.Info(startDate, endDate)
	jobCount := new(JobCount)
	list, err := jobCount.GetCountData(startDate, endDate)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(list)
	}
	c.ServeJSON()
}

//CountDataAll 所有历史数据，按月平均值统计
func (c *JobCountController) CountDataAll() {
	jobCount := new(JobCount)
	list, err := jobCount.GetCountDataAll()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(list)
	}
	c.ServeJSON()
}
