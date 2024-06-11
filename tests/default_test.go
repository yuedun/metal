package test

import (
	"bytes"
	"encoding/base64"
	"encoding/gob"
	"fmt"
	"html"
	"log"
	"math/rand"
	"metal/models"
	_ "metal/routers"
	"metal/util"
	"net/http"
	"net/http/httptest"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"sync"
	"testing"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"
	_ "github.com/go-sql-driver/mysql"
	. "github.com/smartystreets/goconvey/convey"
)

func init() {
	rand.Seed(time.Now().Unix())
	_, file, _, _ := runtime.Caller(0)
	apppath, _ := filepath.Abs(filepath.Dir(filepath.Join(file, ".."+string(filepath.Separator))))
	logs.Debug("apppath", apppath)
	beego.TestBeegoInit(apppath)
}

func TestMain(m *testing.M) {
	dbUser, _ := beego.AppConfig.String("mysqluser") //获取不到
	dbPass, _ := beego.AppConfig.String("mysqlpass")
	dbName, _ := beego.AppConfig.String("mysqldb")
	dbURL, _ := beego.AppConfig.String("mysqlurls")
	dbPort, _ := beego.AppConfig.String("mysqlport")
	orm.RegisterDriver("mysql", orm.DRMySQL)

	fmt.Println(dbUser + ":" + dbPass + "@tcp(" + dbURL + ":" + dbPort + ")/" + dbName + "?charset=utf8&parseTime=true&loc=Asia%2FShanghai")
	orm.RegisterDataBase("default", "mysql", dbUser+":"+dbPass+"@tcp("+dbURL+":"+dbPort+")/"+dbName+"?charset=utf8&parseTime=true&loc=Asia%2FShanghai")
	orm.Debug = true // 控制台打印查询语句
	// 自动建表
	// orm.RunSyncdb("default", false, true)
	// 设置为 UTC 时间(default：本地时区)
	orm.DefaultTimeLoc = time.UTC
	logs.Debug("TestMain")
	m.Run()
}

// TestBeego is a sample to run an endpoint test
func TestBeego(t *testing.T) {
	r, _ := http.NewRequest("GET", "/", nil)
	w := httptest.NewRecorder()
	beego.BeeApp.Handlers.ServeHTTP(w, r)

	// beego.Trace("testing", "TestBeego", "Code[%d]\n%s", w.Code, w.Body.String())

	Convey("Subject: Test Station Endpoint\n", t, func() {
		Convey("Status Code Should Be 200", func() {
			So(w.Code, ShouldEqual, 200)
		})
		Convey("The Result Should Not Be Empty", func() {
			So(w.Body.Len(), ShouldBeGreaterThan, 0)
		})
	})
}

func TestMd5(t *testing.T) {
	util.GeneratePassword("13100000001", "")
}

func TestGobEncode(t *testing.T) {
	u := models.User{}
	buf := new(bytes.Buffer)
	//gob编码
	enc := gob.NewEncoder(buf)
	if err := enc.Encode(u); err != nil {
		fmt.Println(err)
	}
	t.Logf("%v\n", buf.Bytes())
	encoded := base64.StdEncoding.EncodeToString(buf.Bytes())
	t.Log(encoded)

	dec := gob.NewDecoder(buf)
	if err := dec.Decode(&u); err != nil {
		fmt.Println(err)
	}
	t.Logf("%+v", u)

}

func TestEmail(t *testing.T) {
	util.SendEmail("测试邮件", "测试内容", []string{""})
}

// 并发数控制
func TestGoroutin(t *testing.T) {
	var wg sync.WaitGroup
	// 限制最大并发数为10
	limitGoroutine := make(chan int, 10)
	wg.Add(100)
	for i := 0; i < 100; i++ {
		// 每启动一个协程，就往channel里写入一位数
		limitGoroutine <- 0 //放这也行
		go func(i int) {
			// limitGoroutine <- 0
			// 并发请求获取信息
			// 存入数据库
			defer func() {
				wg.Done()
				// 协程执行完退出时，就从channel里读一位数
				<-limitGoroutine
			}()
			sl := time.Duration(util.GetRandomWithAll(1, 10)) * time.Second
			time.Sleep(sl)
			log.Println(i, sl)
		}(i)
	}
	wg.Wait()
}

func TestRedis(t *testing.T) {
	util.ExampleNewClient()
}

func TestHtmlToText(t *testing.T) {
	t.Log(html.EscapeString("To estimate the relative BCKDH activity in adipose tissue versus liver, we determined the enzymatic activity of BCKDH in WAT <a href=http://bestcialis20mg.com/>cialis online no prescription</a>"))
}

func TestRequestByAjax3(t *testing.T) {
	ch1 := make(chan models.JobDataLanguage)
	go util.RequestByAjax3(ch1, "上海", "nodejs")
	t.Log(">>>>ch1", <-ch1)
}

func TestJWTCreate(t *testing.T) {
	token, err := util.GetJwtToken("secret-key", 100000, util.AuthClaim{Username: "hello", Email: "hello@example.com"})
	t.Log(err)
	t.Log(token)
}
func TestJWTParse(t *testing.T) {
	token := "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MCwidXNlcm5hbWUiOiJoZWxsbyIsImVtYWlsIjoiaGVsbG9AZXhhbXBsZS5jb20iLCJleHAiOjE2OTMyMDYzMjksIm5iZiI6MTY5MzEwNjMyOSwiaWF0IjoxNjkzMTA2MzI5fQ.WhzEyF_nlWmxE5WPzZ5JiQdjgnbJH1sB1Ez8HYg-yv4"
	claim, err := util.ParseToken(token, "secret-key")
	t.Log(err)
	t.Logf("%+v", claim)
}

func TestMysql(t *testing.T) {
	bts, err := os.ReadFile("./mysql.html")
	if err != nil {
		t.Error(err)
	}
	doc, err := goquery.NewDocumentFromReader(strings.NewReader(string(bts)))
	if err != nil {
		t.Error(err)
	}
	doc.Find(".section").Each(func(i int, s *goquery.Selection) {
		idx := s.Find(".index").Text()
		idx = strings.TrimSpace(idx)
		title := s.Find(".title-text").Text()
		title = strings.TrimSpace(title)
		// fmt.Printf("%s:%s\n", strings.TrimSpace(idx), strings.TrimSpace(title))
		err := os.Rename(fmt.Sprintf("/Users/huopanpan/Desktop/MySQL/%sMySQL 是怎样运行的：从根儿上理解 MySQL - 小孩子4919 - 掘金小册.pdf", idx), fmt.Sprintf("/Users/huopanpan/Desktop/MySQL/%s.pdf", idx+title))
		if err != nil {
			t.Log("改名错误：", err)
		}
	})
}
func TestMovie(t *testing.T) {
	o := orm.NewOrm()
	list := []models.Movie{}
	o.Raw("select * from movie").QueryRows(&list)
	// for _, v := range list {
	// urls := strings.Split(v.URL, ",")
	// for _, v2 := range urls {
	// 	murl := models.MovieUrl{
	// 		Movie:         &models.Movie{BaseModel: models.BaseModel{Id: v.Id}},
	// 		URL:           v2,
	// 		Status:        v.Status,
	// 		StatusComment: v.StatusComment,
	// 		BaseModel: models.BaseModel{
	// 			CreatedAt: v.CreatedAt,
	// 			UpdatedAt: v.UpdatedAt,
	// 		},
	// 	}
	// 	o.Insert(&murl)
	// }
	// }
}
