package util

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
	"github.com/robfig/cron"
	"strconv"
)

type MyJob struct{}

func (job MyJob) Run() {
	logs.Info("职位统计任务，单任务")
	GetJobs()
}
func CronStart() {
	runCron, err := strconv.ParseBool(beego.AppConfig.String("runCron"))
	if err == nil && runCron {
		c := cron.New()
		spec := beego.AppConfig.String("cron")
		c.AddFunc(spec, func() {
			GetJobs()
			beego.Info("职位统计任务已执行！")
		})
		//c.AddJob(spec, MyJob{})
		c.Start()

		//select {}//作用是在main函数中阻塞不退出
	}
}
