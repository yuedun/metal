package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"log"
	. "metal/models"
)

type JobCountController struct {
	BaseController
}

/**
 * 工作数量统计
 */

// @router /job-count [get]
func (c *UserController) JobCount() {
	c.Data["title"] = "报表"
	c.TplName = "admin/job-count.html"
}

// @router /job-count/count-data [get]
func (c *UserController) CountDataRecently() {
	lang := c.GetString("language")
	startDate := c.GetString("startDate")
	endDate := c.GetString("endDate")

	log.Println(lang, startDate, endDate)
	jobCount := new(JobCount)
	list, err := jobCount.GetCountData(lang, startDate, endDate)
	if nil != err {
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(list)
	}
	c.ServeJSON()
}
