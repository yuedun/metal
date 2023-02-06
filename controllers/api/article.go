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
func (c *ArticleAPIController) ArticleCreate() {
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
		code = http.StatusBadRequest
		return
	}
	content := c.GetString("content")
	if content == "" {
		logs.Warn("content不能为空")
		err = fmt.Errorf("content不能为空")
		code = http.StatusBadRequest
		return
	}
	category := c.GetString("category")
	keywords := c.GetString("keywords")
	status, _ := c.GetInt("status")

	article := Article{}
	article.Title = title
	article.Content = content
	article.Category = category
	article.Keywords = keywords
	article.Status = uint8(status)
	article.CreatedAt = time.Now()
	article.UpdatedAt = time.Now()
	articleService := service.NewArticleService(orm.NewOrm())
	_, err = articleService.Save(article)
	if err != nil {
		logs.Warn("创建文章失败")
		err = fmt.Errorf("创建文章失败")
		code = http.StatusInternalServerError
		return
	}
	categoryRec := &Category{Name: category}
	err = categoryRec.GetByName()
	if err == orm.ErrNoRows || err == orm.ErrMissPK {
		logs.Debug("【%s】分类记录不存在，去创建！", category)
		categoryRec.Create()
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
	if title == "" {
		logs.Warn("title不能为空")
		err = fmt.Errorf("title不能为空")
		code = http.StatusBadRequest
		return
	}
	content := c.GetString("content")
	if content == "" {
		logs.Warn("content不能为空")
		err = fmt.Errorf("content不能为空")
		code = http.StatusBadRequest
		return
	}
	category := c.GetString("category")
	keywords := c.GetString("keywords")
	article.Id = uint(artId)
	article.Title = title
	article.Content = content
	article.Category = category
	article.Keywords = keywords
	_, err = article.Update([]string{"title", "content", "category", "keywords", "updated_at"})
	if err != nil {
		logs.Warn("更新文章失败")
		err = fmt.Errorf("更新文章失败")
		code = http.StatusInternalServerError
		return
	}
	categoryRec := &Category{Name: category}
	err = categoryRec.GetByName()
	if err == orm.ErrNoRows || err == orm.ErrMissPK {
		logs.Debug(err)
		logs.Debug("【%s】分类记录不存在，去创建！", category)
		categoryRec.Create()
		return
	}
}

/**
 * 文章列表接口
 * /admin/page/articles
 */
func (c *ArticleAPIController) ArticleList() {
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
	category := c.GetString("category")
	keywords := c.GetString("keywords")
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	article := new(Article)
	param := map[string]string{
		"title":    title,
		"category": category,
		"keywords": keywords,
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
