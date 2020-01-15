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
	go util.RequestByAjax(c, "java", "上海")
	t.Log(<-c)
}

//格式化
func TestFmt(t *testing.T) {
	t.Log(fmt.Sprintf("https://www.lagou.com/jobs/list_%s?px=default&city=%s#filterBox", "golang", url.QueryEscape("shagnhai")))
}

// 获取七牛token
func TestGetToken(t *testing.T) {
	t.Log(">>>>>>getToken", util.GetToken())
}

//测试上传文件
func TestUpload(t *testing.T) {
	t.Log(">>>>>>uploadFile")
	//util.UploadFile()
}

//生成pdf文件
// https://godoc.org/github.com/jung-kurt/gofpdf
func TestPDF(t *testing.T) {

}
