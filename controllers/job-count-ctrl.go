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
func (c *UserController) CountData() {
	lang := c.GetString("language")
	log.Println(lang)
	jobCount := new(JobCount)
	jobCount.JobTitle = lang
	list, err := jobCount.GetCountData()
	if nil != err {
		log.Print(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(list)
	}
	c.ServeJSON()
}
