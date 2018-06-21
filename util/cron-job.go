package util

import (
	"github.com/robfig/cron"
	"log"
)

type MyJob struct{}

func (job MyJob) Run() {
	log.Println("职位统计任务")
	GetJokes()
}
func CronStart() {
	c := cron.New()
	spec := "0 0 12 * * ?"
	c.AddFunc(spec, func() {
		log.Println("职位统计任务")
		GetJokes()
	})
	//c.AddJob(spec, MyJob{})
	c.Start()

	//select {}//作用是在main函数中阻塞不退出
}
