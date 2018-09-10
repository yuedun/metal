package util

import (
	"encoding/json"
	"fmt"
	"github.com/PuerkitoBio/goquery"
	"io/ioutil"
	"log"
	. "metal/models"
	"net/http"
	"net/url"
	"strconv"
	"strings"
	"time"
)

type JobData struct {
	c        chan int
	language string
	region   string
}

type resBody struct {
	Content struct {
		PositionResult struct {
			TotalCount int
			ResultSize int
			Result     []struct {
				PositionName string
			}
		}
	}
}

// 并行获取
func GetJobs() {
	ch1, ch2 := make(chan int), make(chan int)
	go RequestByAjax(ch1, "nodejs", "上海")
	go RequestByAjax(ch2, "golang", "上海")
	for {
		select {
		case c1 := <-ch1:
			saveJob(c1, "nodejs", "上海")
		case c2 := <-ch2:
			saveJob(c2, "golang", "上海")
		}
	}
}

// 获取HTML页面中需要的数据
func requestUrl(c chan int, language, region string) {
	//请求html数据
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
	//转换数据为HTML对象模型
	doc, err := goquery.NewDocumentFromReader(res.Body)
	if err != nil {
		log.Fatal(err)
	}
	//查找元素
	text := doc.Find("#tab_pos>span").Text()
	log.Println(language+"职位数：", text)
	count, _ := strconv.Atoi(text)
	c <- count
}

/**
 * 通过ajax post获取数据
 */
func RequestByAjax(c chan int, language, region string) {
	client := &http.Client{}
	var r http.Request
	r.ParseForm()
	r.Form.Add("first", "true")
	r.Form.Add("pn", "1")
	r.Form.Add("kd", language)
	bodystr := strings.TrimSpace(r.Form.Encode())
	req, err := http.NewRequest(http.MethodPost,
		fmt.Sprintf("https://www.lagou.com/jobs/positionAjax.json?px=default&city=%s&needAddtionalResult=false", url.QueryEscape(region)),
		strings.NewReader(bodystr))
	if err != nil {
		log.Fatal(err)
	}
	req.Header.Set("Referer", "https://www.lagou.com/jobs/list_nodejs")
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	resp, err := client.Do(req)
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatal(err)
	}

	var resBody resBody
	err2 := json.Unmarshal(body, &resBody)
	if err2 != nil {
		log.Fatal(err)
	}
	count := resBody.Content.PositionResult.TotalCount
	c <- count
}

// 保存数据
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
