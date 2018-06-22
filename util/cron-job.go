package util

import (
	"github.com/astaxie/beego"
	"github.com/robfig/cron"
	"log"
)

type MyJob struct{}

func (job MyJob) Run() {
	log.Println("职位统计任务")
	GetJobs()
}
func CronStart() {
	c := cron.New()
	spec := beego.AppConfig.String("cron")
	c.AddFunc(spec, func() {
		log.Println("职位统计任务")
		GetJobs()
	})
	//c.AddJob(spec, MyJob{})
	c.Start()

	//select {}//作用是在main函数中阻塞不退出
}
