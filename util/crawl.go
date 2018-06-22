package util

import (
	"fmt"
	"github.com/PuerkitoBio/goquery"
	"log"
	. "metal/models"
	"net/http"
	"net/url"
	"strconv"
	"time"
)

type JobData struct {
	c        chan int
	language string
	region   string
}

func GetJobs() {
	ch1, ch2 := make(chan int), make(chan int)
	go func() {
		requestUrl(ch1, "nodejs", "上海")
	}()
	go func() {
		requestUrl(ch2, "golang", "上海")
	}()
	for {
		select {
			case c1 := <-ch1:
				saveJob(c1, "nodejs", "上海")
			case c2 := <-ch2:
				saveJob(c2, "golang", "上海")
		}
	}
}

func requestUrl(c chan int, language, region string) {
	// Request the HTML page.
	res, err := http.Get(fmt.Sprintf("https://www.lagou.com/jobs/list_%s?px=default&city=%s#filterBox", language, url.QueryEscape(region)))
	if err != nil {
		log.Fatal(err)
	}
	defer res.Body.Close()
	if res.StatusCode != 200 {
		log.Fatalf("status code error: %d %s", res.StatusCode, res.Status)
	} else {
		log.Println("请求成功")
	}

	// Load the HTML document
	doc, err := goquery.NewDocumentFromReader(res.Body)
	if err != nil {
		log.Fatal(err)
	}

	// Find the review items
	text := doc.Find("#tab_pos>span").Text()
	log.Println(language+"职位数：", text)
	count, _ := strconv.Atoi(text)
	c <- count
}

func saveJob(c int, title, region string) {
	jobCount := &JobCount{
		JobTitle:  title,
		Amount:    uint(c),
		Region:    region,
		CreatedAt: time.Now(),
	}
	jobCount.Save()
	log.Println("保存")
}
