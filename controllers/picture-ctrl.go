package controllers

import (
	"log"
	"net/http"

	"github.com/PuerkitoBio/goquery"
)

type PictureController struct {
	AdminBaseController
}

/* icon列表 */
func (c *PictureController) IconList() {
	c.TplName = "admin/icons.html"
}

/* 图片检索 */
func (c *PictureController) Picture() {
	//请求html数据
	res, err := http.Get("https://blog.52itstyle.vip/archives/3808/")
	if err != nil {
		log.Fatal(err)
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
	text, _ := doc.Find("body").Html()
	log.Println(text)
	c.Data["htmlContent"] = text
	c.TplName = "admin/picture.html"
}
