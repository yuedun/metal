package test

import (
	"metal/models"
	"testing"

	_ "github.com/go-sql-driver/mysql"
)

/*
*

	测试代码写法：格式：Test*()(t *testing.T)，可以使用t.Log()输出日志，要测试单个方法使用go test -v -run="TestOne|TestMd5"
*/
func TestCatalog(t *testing.T) {
	article := models.Article{}
	list, _ := article.GetCatalog()
	t.Log(list)
}
