package main

import (
	"encoding/gob"
	"fmt"
	"metal/controllers"
	_ "metal/routers"
	"time"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

var port string

func init() {
	dbUser := beego.AppConfig.String("mysqluser")
	dbPass := beego.AppConfig.String("mysqlpass")
	dbName := beego.AppConfig.String("mysqldb")
	dbUrl := beego.AppConfig.String("mysqlurls")
	dbPort := beego.AppConfig.String("mysqlport")
	port = beego.AppConfig.String("httpport")
	orm.RegisterDriver("mysql", orm.DRMySQL)
	maxIdle := 5
	maxConn := 5
	// 参数1        数据库的别名，用来在ORM中切换数据库使用
	// 参数2        driverName
	// 参数3        对应的链接字符串
	// 参数4(可选)  设置最大空闲连接
	// 参数5(可选)  设置最大数据库连接 (go >= 1.2) username:password@tcp(127.0.0.1:3306)/db_name
	orm.RegisterDataBase(
		"default",
		"mysql",
		dbUser+":"+dbPass+"@tcp("+dbUrl+":"+dbPort+")/"+dbName+"?charset=utf8&parseTime=true&loc=Asia%2FShanghai",
		maxIdle,
		maxConn)
	orm.Debug = true // 控制台打印查询语句
	// 自动建表
	// orm.RunSyncdb("default", false, true)
	// 设置为 UTC 时间(default：本地时区)
	orm.DefaultTimeLoc = time.UTC

	/**
	 * 非 memory 的引擎，请自己在 main.go 的 init 里面注册需要保存的这些结构体，不然会引起应用重启之后出现无法解析的错误
	 * 如：gob: name not registered for interface: "*controllers.SessionObject"
	 */
	gob.Register(&controllers.UserPermission{})
	// session 开发环境下使用file存储，生产环境使用redis等数据库存储
	beego.BConfig.WebConfig.Session.SessionProvider = "file"
	beego.BConfig.WebConfig.Session.SessionProviderConfig = "./tmp"
	// 日志：会保存手动输出的日志和系统异常日志
	// 如： logs.Error和panic
	logs.Async()
	logs.SetLogger(logs.AdapterFile, `{"filename":"./tmp/error.log","level":4,"maxlines":0,"maxsize":0,"daily":true,"maxdays":10}`)
}

func main() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n浏览器访问：http://localhost:" + port + "\n\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	beego.Run()
}
