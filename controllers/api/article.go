package api

import (
	"fmt"
	"metal/controllers"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/service"
	"net/http"
	"strconv"
	"time"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/logs"
)

type ArticleAPIController struct {
	controllers.AdminBaseController
}

/**
 * 创建文章接口
 */
func (c *ArticleAPIController) CreateArticle() {
	var err error
	var code int
	var data interface{}
	defer func(start time.Time) {
		var rsp controllers.Result
		rsp.Code = code
		rsp.Cost = time.Since(start).Milliseconds()
		rsp.Msg = http.StatusText(code)
		if err != nil {
			rsp.Msg = fmt.Sprintf("%s - %s", rsp.Msg, err.Error())
			logs.Error(rsp.Msg)
			c.Data["json"] = c.ErrorData(err, code)
		} else {
			c.Data["json"] = c.SuccessData(data)
		}
		c.ServeJSON()
	}(time.Now())
	title := c.GetString("title")
	if title == "" {
		logs.Warn("title不能为空")
		err = fmt.Errorf("title不能为空")
		return
	}
	content := c.GetString("content")
	if content == "" {
		logs.Warn("content不能为空")
		err = fmt.Errorf("content不能为空")
		return
	}
	category := c.GetString("category")
	keywords := c.GetString("keywords")

	article := Article{}
	article.Title = title
	article.Content = content
	article.Category = category
	article.Keywords = keywords
	article.Status = 1
	article.CreatedAt = time.Now()
	article.UpdatedAt = time.Now()
	articleService := service.NewArticleService(orm.NewOrm())
	_, err = articleService.Save(article)

	categoryRec := &Category{Name: category}
	err2 := categoryRec.GetByName()
	if err2 == orm.ErrNoRows || err2 == orm.ErrMissPK {
		logs.Debug("【%s】分类记录不存在，去创建！", category)
		categoryRec.CreatedAt = time.Now()
		categoryRec.UpdatedAt = time.Now()
		categoryRec.Create()
	}
	if nil != err {
		return
	}
}

/**
 * 文章列表接口
 * /admin/page/articles
 */
func (c *ArticleAPIController) ArticlesList() {
	var err error
	var code int
	var data interface{}
	defer func(start time.Time) {
		var rsp controllers.Result
		rsp.Code = code
		rsp.Cost = time.Since(start).Milliseconds()
		rsp.Msg = http.StatusText(code)
		if err != nil {
			rsp.Msg = fmt.Sprintf("%s - %s", rsp.Msg, err.Error())
			logs.Error(rsp.Msg)
			c.Data["json"] = c.ErrorData(err, code)
		} else {
			c.Data["json"] = c.SuccessData(data)
		}
		c.ServeJSON()
	}(time.Now())
	args := c.GetString("search") // 获取所有参数
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	article := new(Article)
	param := map[string]string{
		"title": args,
	}

	list, total, err := article.GetArticlesList(param, start, perPage)
	if nil != err {
		code = http.StatusInternalServerError
		return
	} else {
		data = map[string]any{
			"result": list,
			"total":  total,
		}
	}
}

/**
 * 修改文章接口
 * /admin/page/article/:id
 */
func (c *ArticleAPIController) ArticleEdit() {
	var err error
	var code int
	var data interface{}
	defer func(start time.Time) {
		var rsp controllers.Result
		rsp.Code = code
		rsp.Cost = time.Since(start).Milliseconds()
		rsp.Msg = http.StatusText(code)
		if err != nil {
			rsp.Msg = fmt.Sprintf("%s - %s", rsp.Msg, err.Error())
			logs.Error(rsp.Msg)
			c.Data["json"] = c.ErrorData(err, code)
		} else {
			c.Data["json"] = c.SuccessData(data)
		}
		c.ServeJSON()
	}(time.Now())
	article := new(Article)
	artId, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	title := c.GetString("title")
	content := c.GetString("content")
	category := c.GetString("category")
	keywords := c.GetString("keywords")
	article.Id = uint(artId)
	article.Title = title
	article.Content = content
	article.Category = category
	article.Keywords = keywords
	article.UpdatedAt = time.Now()
	_, err = article.Update()
	if err != nil {
		return
	}
	categoryRec := &Category{Name: category}
	err = categoryRec.GetByName()
	if err == orm.ErrNoRows || err == orm.ErrMissPK {
		logs.Debug("【%s】分类记录不存在，去创建！", category)
		categoryRec.CreatedAt = time.Now()
		categoryRec.UpdatedAt = time.Now()
		categoryRec.Create()
		return
	}
}

/**
 * 删除文章接口
 * /admin/page/articles
 */
func (c *ArticleAPIController) ArticleDelete() {
	article := new(Article)
	artId, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	article.Id = uint(artId)
	article.Delete()
	c.Data["json"] = c.SuccessData(nil)
	c.ServeJSON()
}
