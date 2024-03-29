package util

import (
	"crypto/tls"
	"fmt"
	"metal/models"
	"net/http"
	"strings"
	"time"

	"github.com/beego/beego/v2/core/config"
	"github.com/beego/beego/v2/core/logs"
	"github.com/robfig/cron/v3"
)

func CronStart() {
	c := cron.New()
	runCron, err := config.Bool("runCron")
	if err == nil && runCron {
		cron, _ := config.String("cron")
		id, err := c.AddFunc(cron, func() { //"0/1 * * * *"
			logs.Debug("任务开始")
			GetJobs()
			logs.Info("职位统计任务已执行！")
		})
		logs.Debug(id, err)

	}
	runCron2, err := config.Bool("runCron2")
	if err == nil && runCron2 {
		cron2, _ := config.String("cron2")
		id, err := c.AddFunc(cron2, func() { //"0/1 * * * *"
			logs.Debug("任务开始2")
			movie := &models.Movie{}
			list, err := movie.AllMovie()
			if err != nil {
				logs.Error(err)
			}
			for _, v := range list {
				urls := strings.Split(v.URL, ",")
				logs.Debug(v.Id, urls)
				u, status, statusComments := v, 0, []string{}
				for _, url := range urls {
					trans := &http.Transport{
						DisableKeepAlives: true,
						TLSClientConfig:   &tls.Config{InsecureSkipVerify: true},
					}
					var cli = &http.Client{
						Timeout:   time.Second * 300,
						Transport: trans,
					}
					req, err := http.NewRequest(http.MethodGet, url, nil)
					if err != nil {
						logs.Error(err)
						status = 2
						statusComments = append(statusComments, fmt.Sprintf("%s %s", url, err.Error()))
						break
					}
					resp, err := cli.Do(req)
					if err != nil {
						logs.Error(err)
						status = 2
						statusComments = append(statusComments, fmt.Sprintf("%s %s", url, err.Error()))
						break
					}
					defer resp.Body.Close()
					if resp.StatusCode != 200 && resp.StatusCode != 512 && resp.StatusCode != 403 {
						logs.Error(url, resp.Status)
						status = 2
						statusComments = append(statusComments, fmt.Sprintf("%s %s", url, resp.Status))
					}
				}
				if status == 2 {
					u.Status = status
					u.StatusComment = strings.Join(statusComments, ",")
				} else {
					u.Status = 0
					u.StatusComment = ""
				}
				u.Update([]string{"status", "status_comment"})
			}
		})
		logs.Debug(id, err)
	}
	c.Start()
}
