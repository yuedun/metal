package main

import (
	"fmt"
	_ "metal/routers"
	"time"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

func init() {
	dbuser := beego.AppConfig.String("mysqluser")
	dbpass := beego.AppConfig.String("mysqlpass")
	dbname := beego.AppConfig.String("mysqldb")
	orm.RegisterDriver("mysql", orm.DRMySQL)
	maxIdle := 5
	maxConn := 5
	// 参数1        数据库的别名，用来在ORM中切换数据库使用
	// 参数2        driverName
	// 参数3        对应的链接字符串
	// 参数4(可选)  设置最大空闲连接
	// 参数5(可选)  设置最大数据库连接 (go >= 1.2)
	orm.RegisterDataBase("default", "mysql", dbuser+":"+dbpass+"@/"+dbname+"?charset=utf8", maxIdle, maxConn)
	orm.Debug = true //控制台打印查询语句
	// 自动建表
	// orm.RunSyncdb("default", false, true)
	// 设置为 UTC 时间
	orm.DefaultTimeLoc = time.UTC
}

func main() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>\n\n浏览器访问：http://127.0.0.1:8081\n\n>>>>>>>>>>>>>>>>>>>>>>>")
	beego.Run()
}
