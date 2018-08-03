package test

import (
	"fmt"
	"metal/util"
	"net/url"

	"testing"
)

/**
  测试代码写法：格式：Test*()(t *testing.T)，可以使用t.Log()输出日志，要测试单个方法使用go test -v -run="TestOne|TestMd5"
*/
func TestMd5(t *testing.T) {
	var p = util.GetMD5("ceshi")
	t.Log(p)
}

/**
 * 根据手机号生成密码
 */
func TestOne(t *testing.T) {
	t.Log(">>>>>>testone", util.GeneratePassword("18701897513"))
}

/**
 * 爬虫测试
 */
func TestCrawl(t *testing.T) {
	//util.GetJobs()
	var c = make(chan int)
	util.RequestByAjax(c, "java", "上海")
}

//格式化
func TestFmt(t *testing.T) {
	t.Log(fmt.Sprintf("https://www.lagou.com/jobs/list_%s?px=default&city=%s#filterBox", "golang", url.QueryEscape("shagnhai")))
}
