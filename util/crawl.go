package util

import (
	"encoding/json"
	"fmt"
	"github.com/astaxie/beego"
	"io/ioutil"
	"log"
	. "metal/models"
	"net/http"
	"net/url"
	"strconv"
	"time"

	"github.com/PuerkitoBio/goquery"
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
			if c1 != 0 {
				saveJob(c1, "nodejs", "上海")
			}
		case c2 := <-ch2:
			if c2 != 0 {
				saveJob(c2, "golang", "上海")
			}
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
	// var r http.Request
	// r.ParseForm()
	// r.Form.Add("first", "true")
	// r.Form.Add("pn", "1")
	// r.Form.Add("kd", language)
	// bodystr := strings.TrimSpace(r.Form.Encode())
	// req, err := http.NewRequest(http.MethodGet,
	// 	fmt.Sprintf("https://m.lagou.com/search.json?city=%E4%B8%8A%E6%B5%B7&positionName=%s&pageNo=1&pageSize=15", url.QueryEscape(region)),
	// 	strings.NewReader(bodystr))
	// if err != nil {
	// 	log.Fatal(err)
	// }

	// 使用wap端接口
	req, err := http.NewRequest(http.MethodGet,
		"http://m.lagou.com/search.json?city=%E4%B8%8A%E6%B5%B7&positionName=golang&pageNo=1&pageSize=1",
		nil)
	if err != nil {
		log.Fatal(err)
	}

	req.Header.Add("Referer", "https://m.lagou.com/search.html")
	// req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	// req.Header.Set("Accept", "application/json")
	// req.Header.Set("Accept-Encoding", "gzip, deflate, br")
	// req.Header.Set("Accept-Language", "zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7")
	// req.Header.Set("Cache-Control", "no-cache")
	// req.Header.Set("Connection", "keep-alive")
	// req.Header.Set("Cookie", "user_trace_token=20180709113435-26a58e65-cffe-4852-a3f1-f5d86404990d; _ga=GA1.2.1018714389.1531107507; LGUID=20180709113850-9823fc8a-8329-11e8-993c-5254005c3644; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22167d52069b0282-0a9bc48ac709f9-454c092b-2073600-167d52069b1722%22%2C%22%24device_id%22%3A%22167d52069b0282-0a9bc48ac709f9-454c092b-2073600-167d52069b1722%22%2C%22props%22%3A%7B%22%24latest_traffic_source_type%22%3A%22%E7%9B%B4%E6%8E%A5%E6%B5%81%E9%87%8F%22%2C%22%24latest_referrer%22%3A%22%22%2C%22%24latest_referrer_host%22%3A%22%22%2C%22%24latest_search_keyword%22%3A%22%E6%9C%AA%E5%8F%96%E5%88%B0%E5%80%BC_%E7%9B%B4%E6%8E%A5%E6%89%93%E5%BC%80%22%7D%7D; index_location_city=%E4%B8%8A%E6%B5%B7; JSESSIONID=ABAAABAAAGCABCCF89C2DBE74B8B2A9E5B43C7A60E58E42; Hm_lvt_4233e74dff0ae5bd0a3d81c6ccf756e6=1545468931,1546587701; _ga=GA1.3.1018714389.1531107507; _gid=GA1.2.2124006721.1547196851; LGSID=20190111165411-76c71326-157e-11e9-b300-5254005c3644; PRE_UTM=; PRE_HOST=; PRE_SITE=; PRE_LAND=https%3A%2F%2Fm.lagou.com%2F; Hm_lpvt_4233e74dff0ae5bd0a3d81c6ccf756e6=1547196904; LGRID=20190111165504-965cf77c-157e-11e9-998e-525400f775ce")
	// req.Header.Set("Host", "m.lagou.com")
	// req.Header.Set("Pragma", "no-cache")
	// req.Header.Set("User-Agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1")
	// req.Header.Set("X-Requested-With", "XMLHttpRequest")
	resp, err := client.Do(req)
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		beego.Error("读取body失败：", err)
	}

	// var resBody = new(resBody)
	var resBody interface{}
	err2 := json.Unmarshal(body, &resBody)
	if err2 != nil {
		beego.Error("解析body失败:", err2)
	}
	log.Println(resBody)
	// if resBody.Content.PositionResult.TotalCount == 0 {
	// 	beego.Error("获取" + language + "数据为空!")
	// }
	// count := resBody.Content.PositionResult.TotalCount
	c <- 0
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
	beego.Info("保存job成功")
}
