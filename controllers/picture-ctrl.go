package controllers

import (
	"encoding/json"
	"log"
	"net/http"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"
	. "metal/models"
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
	url:=c.GetString("url")
	if url!=""{
		//请求html数据
		res, err := http.Get(url)
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
		c.Data["url"]=url
		c.Data["htmlContent"] = text
	} else {
		c.Data["htmlContent"]=""
	}
	c.TplName = "admin/picture.html"
}

/* 保存图片 */
func (c *PictureController) AddPicture() {
	defer func() {
		c.ServeJSON()
	}()
	args := struct {
		PicUrl string
		Tag    string
	}{}
	body := c.Ctx.Input.RequestBody //接收raw body内容
	err := json.Unmarshal(body, &args)
	if err!=nil {
		beego.Error(err)
		c.Data["json"] = ErrorData(err)
		return
	}
	picUrl := args.PicUrl
	tag:=args.Tag
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
}
/* 图片列表路由 */
func (c *PictureController) ListPictureRoute() {
	c.TplName = "admin/picture-list.html"
}
/* 图片列表 */
func (c *PictureController) ListPicture() {
	defer func() {
		c.ServeJSON()
	}()
	picture:=new(Picture)
	picList, total, err := picture.GetAllByCondition(nil, 1, 10)
	if nil != err {
		beego.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		data:=map[string]any{
			"result":picList,
			"totle":total,
		}
		c.Data["json"] = SuccessData(data)
	}
}
