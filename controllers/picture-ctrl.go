package controllers

import (
	"encoding/json"
	"log"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"net/http"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"
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
	c.Data["htmlContent"] = text
	c.TplName = "admin/picture.html"
}

/* 保存图片 */
func (c *PictureController) AddPicture() {
	args := map[string]string{}
	body := c.Ctx.Input.RequestBody //接收raw body内容
	json.Unmarshal(body, &args)
	picUrl := args["picUrl"]
	tag := args["tag"] // 只能接收url后面的参数，不能接收body中的参数
	beego.Info(">>>>>>>>", args)
	var picture = new(Picture)
	picture.PicUrl = picUrl
	picture.Tag = tag
	picture.CreatedAt = time.Now()
	picture.UpdatedAt = time.Now()

	id, err := picture.Save()
	if nil != err {
		beego.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(id)
	}
	c.ServeJSON()
}
