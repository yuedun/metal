package test

import (
	"fmt"
	"metal/models"
	"testing"
	"time"

	beego "github.com/beego/beego/v2/server/web"

	"github.com/beego/beego/v2/client/orm"
	_ "github.com/go-sql-driver/mysql"
)

func TestMain(t *testing.M) {
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
}

/**
  测试代码写法：格式：Test*()(t *testing.T)，可以使用t.Log()输出日志，要测试单个方法使用go test -v -run="TestOne|TestMd5"
*/
func TestCatalog(t *testing.T) {
	article := models.Article{}
	list, _ := article.GetCatalog()
	t.Log(list)
}
