package util

import (
	"encoding/json"
	"fmt"
	"github.com/astaxie/beego/httplib"
	"github.com/astaxie/beego/logs"
	"io/ioutil"
	"log"
	. "metal/models"
	"net/http"
	"net/url"
	"strconv"
	"time"

	"github.com/PuerkitoBio/goquery"
)

// PC端结构体
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
	State  int
	Status int
}

// WAP端结构体
type wapResBody struct {
	Content struct {
		Data struct {
			Page struct {
				TotalCount string `json:"totalCount"`
			} `json:"page"`
			Custom struct {
				PositionName string `json:"positionName"`
			} `json:"custom"`
		}
	} `json:"content"`
	State   int    `json:"state"`
	Message string `json:"message"`
}

type JobData struct {
	Count    int    //数量
	Region   string //地区
	Language string //语言
}

// 并行获取
func GetJobs() {
	ch1, ch2 := make(chan JobData), make(chan JobData)
	go RequestByAjax3(ch1, "上海", "nodejs")
	go RequestByAjax3(ch2, "上海", "golang")
	i := 0 // 用于跳出for循环
	for {
		select {
		case c1 := <-ch1:
			if c1.Count != 0 {
				saveJob(c1)
			}
			i++
			if i == 2 {
				fmt.Println("break now")
				goto ForEnd
			}
		case c2 := <-ch2:
			if c2.Count != 0 {
				saveJob(c2)
			}
			i++
			if i == 2 {
				fmt.Println("break now")
				goto ForEnd
			}
		}
	}
ForEnd:
	logs.Info("for loop end")
}

// 获取HTML页面中需要的数据
func requestUrl(c chan JobData, language, region string) {
	//请求html数据
	res, err := http.Get(fmt.Sprintf("https://www.lagou.com/jobs/list_%s?px=default&city=%s#filterBox", language, url.QueryEscape(region)))
	if err != nil {
		logs.Error(err)
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
	c <- JobData{
		Count:    count,
		Region:   region,
		Language: language,
	}
}

/**
 * 通过ajax post获取数据
 */
func RequestByAjax(c chan JobData, language, region string) {
	client := &http.Client{}
	// 使用wap端接口
	req, err := http.NewRequest(http.MethodGet,
		fmt.Sprintf("https://m.lagou.com/search.json?city=上海&positionName=%s&pageNo=1&pageSize=1", language),
		nil)
	if err != nil {
		log.Fatal(err)
	}

	req.Header.Set("Referer", "https://m.lagou.com/search.html")
	req.Header.Set("Content-Type", "application/json;charset=UTF-8")
	req.Header.Set("Accept", "application/json")
	req.Header.Set("Accept-Encoding", "gzip, deflate, br")
	req.Header.Set("Accept-Language", "zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7")
	req.Header.Set("Cache-Control", "no-cache")
	req.Header.Set("REQUEST_ID", "b5b4d3f3-ebcf-4a72-8f6a-27f02d870dd1")
	req.Header.Set("Connection", "keep-alive")
	req.Header.Set("Cookie", "_ga=GA1.2.868381298.1568425609; user_trace_token=20190914094652-86535ba6-d691-11e9-91c2-525400f775ce; LGUID=20190914094652-86535ea3-d691-11e9-91c2-525400f775ce; LG_LOGIN_USER_ID=331375a513278b48052a1b5822f918477bb64f55e874649e; LG_HAS_LOGIN=1; _gid=GA1.2.413117961.1579144546; Hm_lvt_4233e74dff0ae5bd0a3d81c6ccf756e6=1579144546; _ga=GA1.3.868381298.1568425609; Hm_lvt_2f04b07136aeba81b3a364fd73385ff4=1579144546; X_HTTP_TOKEN=d19f45b7e2f1b8bd7554419751f18b54668ac30637; Hm_lpvt_4233e74dff0ae5bd0a3d81c6ccf756e6=1579154658; _gat=1; Hm_lpvt_2f04b07136aeba81b3a364fd73385ff4=1579154658; LGSID=20200116140419-088f7663-3826-11ea-b2e7-525400f775ce; PRE_UTM=; PRE_HOST=; PRE_SITE=https%3A%2F%2Fm.lagou.com%2F; PRE_LAND=https%3A%2F%2Fm.lagou.com%2Fsearch.html; LGRID=20200116140419-088f7798-3826-11ea-b2e7-525400f775ce; JSESSIONID=ABAAAECAAHHAAFD563185970B3FFDB2396C908BB34D64C0")
	req.Header.Set("Host", "m.lagou.com")
	req.Header.Set("Pragma", "no-cache")
	req.Header.Set("User-Agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1")
	req.Header.Set("X-Requested-With", "XMLHttpRequest")
	resp, err := client.Do(req)
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		logs.Error("读取body失败：", err)
	}

	var resBody wapResBody
	//var resBody interface{}
	err2 := json.Unmarshal(body, &resBody)
	if err2 != nil {
		logs.Error("解析body失败:", err2)
	}
	if resBody.State != 1 {
		logs.Error("获取"+language+"数据为空!", fmt.Sprint("%+v", resBody))
	}
	countStr := resBody.Content.Data.Page.TotalCount
	count, _ := strconv.Atoi(countStr)
	c <- JobData{
		Count:    count,
		Region:   region,
		Language: language,
	}
}

//获取页面cookie
func GetCookies(url string) []string {
	req1 := httplib.Get(url)
	req1.Header("User-Agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1")
	resp, err := req1.Response()
	if err != nil {
		logs.Error("请求页面错误", err.Error())
	}
	logs.Info("%+v", resp.Header["Set-Cookie"])
	for key, val := range resp.Header["Set-Cookie"] {
		logs.Debug(key, "-:", val)
	}
	return resp.Header["Set-Cookie"]
}

// 先访问页面获取cookie，再将cookie值放入请求header中
func RequestByAjax3(c chan JobData, region, language string) {
	cookies := GetCookies("https://m.lagou.com/search.html")
	//-------------------------------------
	req := httplib.Get(fmt.Sprintf("https://m.lagou.com/search.json?city=%s&positionName=%s&pageNo=1&pageSize=1", url.QueryEscape(region), language))
	req.Header("Referer", "https://m.lagou.com/search.html")
	var stringCookies string
	for _, val := range cookies {
		stringCookies += val
	}
	req.Header("Cookie", stringCookies)
	//req.Header("Cookie", "JSESSIONID=ABAAAECAAHHAAFD8DC17DEB3DE2DF3C5FCAE8C3D4423759; user_trace_token=20200117101405-234d1d57-b8c1-4d66-956e-c49f35f28f75; _ga=GA1.3.2130396867.1579227245; _ga=GA1.2.2130396867.1579227245; _gid=GA1.2.1665214724.1579227245; LGSID=20200117101406-09c6fa83-38cf-11ea-b2e7-525400f775ce; PRE_UTM=; PRE_HOST=; PRE_SITE=; PRE_LAND=https%3A%2F%2Fm.lagou.com%2Fsearch.html; LGUID=20200117101406-09c6fc06-38cf-11ea-b2e7-525400f775ce; Hm_lvt_2f04b07136aeba81b3a364fd73385ff4=1579144546,1579227231; Hm_lvt_4233e74dff0ae5bd0a3d81c6ccf756e6=1579144546,1579227231; X_MIDDLE_TOKEN=0d6113694aa5cbc462c4848316855d56; _gat=1; LGRID=20200117103523-0355dbff-38d2-11ea-af1d-5254005c3644; Hm_lpvt_4233e74dff0ae5bd0a3d81c6ccf756e6=1579228523; X_HTTP_TOKEN=8e6e6bd15763030e425822975149ec77fc62d73ec7; Hm_lpvt_2f04b07136aeba81b3a364fd73385ff4=1579228523")
	req.Header("Host", "m.lagou.com")
	req.Header("User-Agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1")
	var resBody wapResBody
	req.ToJSON(&resBody)
	logs.Debug(">>>>>>%+v", resBody)
	if resBody.State != 1 {
		logs.Error("获取"+language+"数据为空!", fmt.Sprint("%+v", resBody))
	}
	countStr := resBody.Content.Data.Page.TotalCount
	count, _ := strconv.Atoi(countStr)
	c <- JobData{
		Count:    count,
		Region:   region,
		Language: language,
	}
}

// 保存数据
func saveJob(c JobData) {
	jobCount := &JobCount{
		JobTitle:  c.Language,
		Amount:    uint(c.Count),
		Region:    c.Region,
		CreatedAt: time.Now(),
	}
	jobCount.Save()
	logs.Info("保存job成功", c.Language, c.Count)
}
