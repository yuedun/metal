package util

import (
	"github.com/astaxie/beego"
	"github.com/robfig/cron"
	"log"
	"strconv"
)

type MyJob struct{}

func (job MyJob) Run() {
	log.Println("职位统计任务，单任务")
	GetJobs()
}
func CronStart() {
	runCron, err := strconv.ParseBool(beego.AppConfig.String("runCron"))
	if err == nil && runCron {
		c := cron.New()
		spec := beego.AppConfig.String("cron")
		c.AddFunc(spec, func() {
			log.Println("职位统计任务，多任务")
			GetJobs()
		})
		//c.AddJob(spec, MyJob{})
		c.Start()

		//select {}//作用是在main函数中阻塞不退出
	}
}
