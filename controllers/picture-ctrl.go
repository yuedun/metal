package controllers

import (
	"encoding/json"
	"log"
	"net/http"
	"time"

	"github.com/astaxie/beego/logs"

	. "metal/models"

	"github.com/PuerkitoBio/goquery"
)

type PictureController struct {
	AdminBaseController
}

// IconList 列表
func (c *PictureController) IconList() {
	c.TplName = "admin/icons.html"
}

// Picture 图片检索
func (c *PictureController) Picture() {
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
func (c *PictureController) ListPictureRoute() {
	c.TplName = "admin/picture-list.html"
}

//ListPicture 图片列表
func (c *PictureController) ListPicture() {
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
func (c *PictureController) DeletePicture() {
	defer func() {
		c.ServeJSON()
	}()
	picture := new(Picture)
	picId, _ := c.GetInt("picId")
	logs.Info(">>>>", picId)
	picture.ID = uint(picId)
	picture.Status = 0
	_, err := picture.Delete()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = ErrorData(err)
	} else {
		c.Data["json"] = SuccessData(nil)
	}
}
