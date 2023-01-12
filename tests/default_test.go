package test

import (
	"bytes"
	"encoding/base64"
	"encoding/gob"
	"fmt"
	"log"
	"math/rand"
	"metal/models"
	_ "metal/routers"
	"metal/util"
	"net/http"
	"net/http/httptest"
	"path/filepath"
	"runtime"
	"sync"
	"testing"
	"time"

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
