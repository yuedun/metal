package controllers

import (
	"encoding/json"
	"github.com/astaxie/beego/logs"
	"log"
	"net/http"
	"strconv"
	"time"

	. "metal/models"

	"github.com/PuerkitoBio/goquery"
)

type WebSiteController struct {
	AdminBaseController
}

// 网页组件列表
//@router /widget/list [get]
func (c *WebSiteController) WidgetList() {
	c.TplName = "admin/widget-list.html"
}

// Picture 图片检索
func (c *WebSiteController) Picture() {
	url := c.GetString("url")
	if url != "" {
		//请求html数据
		res, err := http.Get(url)
		if err != nil {
			log.Fatal(err)
		}
		defer res.Body.Close()
		if res.StatusCode != 200 {
			log.Fatalf("status code error: %d %s", res.StatusCode, res.Status)
		} else {
			logs.Info("请求成功")
		}
		//转换数据为HTML对象模型
		doc, err := goquery.NewDocumentFromReader(res.Body)
		if err != nil {
			log.Fatal(err)
		}
		//查找元素
		text, _ := doc.Find("body").Html()
		c.Data["url"] = url
		c.Data["htmlContent"] = text
	} else {
		c.Data["htmlContent"] = ""
	}
	c.TplName = "admin/picture.html"
}

// AddPicture 保存图片
func (c *WebSiteController) AddPicture() {
	defer func() {
		c.ServeJSON()
	}()
	args := struct {
		PicUrl string
		Tag    string
	}{}
	body := c.Ctx.Input.RequestBody //接收raw body内容
	err := json.Unmarshal(body, &args)
	if err != nil {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
		return
	}
	picUrl := args.PicUrl
	tag := args.Tag
	logs.Info(">>>>>>>>", args)
	var picture = new(Picture)
	picture.PicUrl = picUrl
	picture.Tag = tag
	picture.Status = 1
	picture.CreatedAt = time.Now()
	picture.UpdatedAt = time.Now()

	id, err := picture.Save()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(id)
	}
}

// ListPictureRoute 图片列表路由
func (c *WebSiteController) ListPictureRoute() {
	c.TplName = "admin/picture-list.html"
}

//ListPicture 图片列表
func (c *WebSiteController) ListPicture() {
	defer func() {
		c.ServeJSON()
	}()
	search := c.GetString("search") //搜索框
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	picture := new(Picture)
	list, total, err := picture.GetAllByCondition(search, start, perPage)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		data := map[string]any{
			"result": list,
			"total":  total,
		}
		c.Data["json"] = SuccessData(data)
	}
}

//DeletePicture 删除图片
func (c *WebSiteController) DeletePicture() {
	defer func() {
		c.ServeJSON()
	}()
	picture := new(Picture)
	picId, _ := c.GetInt("picId")
	logs.Info(">>>>", picId)
	picture.Id = uint(picId)
	picture.Status = 0
	_, err := picture.Delete()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(nil)
	}
}

// 模板网站
//@router /website-route [get]
func (c *AdminController) TemplatesRoute() {
	c.TplName = "admin/website-list.html"
}

//@router /website/add [post]
func (c *AdminController) CreateTemplate() {
	name := c.GetString("name")
	category := c.GetString("category")
	url := c.GetString("url")
	website := new(WebSite)
	website.Name = name
	website.Category = category
	website.Url = url
	website.Save()
	c.Data["json"] = SuccessData(nil)
	c.ServeJSON()
}

//@router /website [get]
func (c *AdminController) TemplateList() {
	args := c.GetString("search") // 获取所有参数
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	website := new(WebSite)
	param := map[string]string{
		"status": "1,0",
		"name":   args,
	}

	list, total, err := website.GetListByCondition(param, start, perPage)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		data := map[string]any{
			"result": list,
			"total":  total,
		}
		c.Data["json"] = SuccessData(data)
	}
	c.ServeJSON()
}

//@router /website/view/:id [get]
func (c *AdminController) TemplateView() {
	tid := c.Ctx.Input.Param(":id")
	id, _ := strconv.Atoi(tid)
	website := new(WebSite)
	website.Id = uint(id)
	err := website.GetById()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Redirect("/"+website.Url, 302)
	}
}
