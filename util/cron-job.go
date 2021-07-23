package util

import (
	"strconv"

	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"
	"github.com/robfig/cron"
)

type MyJob struct{}

func (job MyJob) Run() {
	logs.Info("职位统计任务，单任务")
	GetJobs()
}
func CronStart() {
	runCronStr, _ := beego.AppConfig.String("runCron")
	runCron, err := strconv.ParseBool(runCronStr)
	if err == nil && runCron {
		c := cron.New()
		cron, _ := beego.AppConfig.String("cron")
		spec := cron
		c.AddFunc(spec, func() {
			GetJobs()
			logs.Info("职位统计任务已执行！")
		})
		//c.AddJob(spec, MyJob{})
		c.Start()

		//select {}//作用是在main函数中阻塞不退出
	}
}
