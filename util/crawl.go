package util

import (
	"github.com/PuerkitoBio/goquery"
	"log"
	. "metal/models"
	"net/http"
	"strconv"
	"time"
)

func GetJokes() {
	// Request the HTML page.
	res, err := http.Get("https://www.lagou.com/jobs/list_nodejs?px=default&city=%E4%B8%8A%E6%B5%B7#filterBox")
	//res, err := http.Get("https://cnodejs.org")
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
	log.Println("职位数：", text)
	amount, _ := strconv.Atoi(text)
	jobCount := &JobCount{
		JobTitle:  "nodejs",
		Amount:    uint(amount),
		CreatedAt: time.Now(),
	}
	jobCount.Save()

	//cnodejs.org
	//doc.Find(".cell").Each(func(i int, s *goquery.Selection) {
	//	// For each item found, get the band and title
	//	band := s.Find("a.user_avatar.pull-left").Text()
	//	title := s.Find(".topic_title").Text()
	//	log.Printf("Review %d: %s - %s\n", i, band, title)
	//})
}
