package main

import (
	"encoding/gob"
	"math/rand"
	"metal/controllers"
	_ "metal/routers"
	"metal/util"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/config"
	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"
)

var port string = "8080" //默认端口

func init() {
	rand.Seed(time.Now().Unix())
	dbUser, _ := config.String("mysqluser")
	dbPass, _ := config.String("mysqlpass")
	dbName, _ := config.String("mysqldb")
	dbURL, _ := config.String("mysqlurls")
	dbPort, _ := config.String("mysqlport")
	port, _ = config.String("httpport")
	runmode, _ := config.String("runmode")

	orm.RegisterDriver("mysql", orm.DRMySQL)
	// 参数1        数据库的别名，用来在ORM中切换数据库使用
	// 参数2        driverName
	// 参数3        对应的链接字符串
	// 参数4(可选)  设置最大空闲连接
	// 参数5(可选)  设置最大数据库连接 (go >= 1.2) username:password@tcp(127.0.0.1:3306)/db_name
	// set default database
	if err := orm.RegisterDataBase("default", "mysql", dbUser+":"+dbPass+"@tcp("+dbURL+":"+dbPort+")/"+dbName+"?charset=utf8&parseTime=true&loc=Asia%2FShanghai"); err != nil {
		panic(err)
	}
	if runmode == "dev" {
		orm.Debug = true // 控制台打印查询语句
	}
	// 自动建表
	// orm.RunSyncdb("default", false, true)
	// 设置为 UTC 时间(default：本地时区)
	orm.DefaultTimeLoc = time.UTC

	err := orm.RunSyncdb("default", false, true)
	if err != nil {
		panic(err)
	}
	/**
	 * 非 memory 的引擎，请自己在 main.go 的 init 里面注册需要保存的这些结构体，不然会引起应用重启之后出现无法解析的错误
	 * 如：gob: name not registered for interface: "*controllers.SessionObject"
	 */
	gob.Register(&controllers.UserPermission{})
	// session 开发环境下使用file存储，生产环境使用redis等数据库存储https://beego.me/docs/mvc/controller/session.md
	beego.BConfig.WebConfig.Session.SessionProvider = "file"
	beego.BConfig.WebConfig.Session.SessionProviderConfig = "./tmp"
	beego.BConfig.WebConfig.Session.SessionCookieLifeTime = 60 * 60 * 24 * 10 //cookie时长 10天 不会变
	beego.BConfig.WebConfig.Session.SessionGCMaxLifetime = 60 * 60 * 24 * 3   // session时长 3天 刷新会变

	// 日志：会保存手动输出的日志和系统异常日志
	// 如： logs.Error和panic
	logs.Async()

	//设置生产环境日志输出级别，此处设置输出 信息级别，不输出debug日志
	level, _ := beego.AppConfig.Int("logLevel")
	logs.SetLevel(level)
	// level 日志保存的时候的级别，默认是 Trace 级别，level值越高，记录的日志范围越广
	// filename 保存的文件名
	// maxlines 每个文件保存的最大行数，默认值 1000000
	// maxsize 每个文件保存的最大尺寸，默认值是 1 << 28, //256 MB
	// daily 是否按照每天 logrotate，默认是 true
	// maxdays 文件最多保存多少天，默认保存 7 天
	// rotate 是否开启 logrotate，默认是 true
	// perm 日志文件权限
	logs.SetLogger(logs.AdapterFile, `{"filename":"./logs/metal.log","level":6,"maxlines":0,"maxsize":0,"daily":true,"maxdays":30}`) //,"separate":["emergency", "alert", "critical", "error", "warning", "notice", "info"]
}

func main() {
	go util.CronStart() //启动定时任务
	//查看所有路由
	// tree := beego.PrintTree()
	// methods := tree["Data"].(beego.M)
	// for k, v := range methods {
	// 	fmt.Printf("%s => %v\n", k, v)
	// }
	beego.Run("localhost:" + port) //下面的代码不会执行，需要执行的代码放到上面
}
