package api

import (
	"log"
	"metal/controllers"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/service"
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
	defer func() {
		if err := recover(); err != nil {
			c.Data["json"] = c.ErrorMsg(err.(string))
		}
		c.ServeJSON()
	}()
	title := c.GetString("title")
	if title == "" {
		log.Panic("title不能为空")
	}
	content := c.GetString("content")
	if content == "" {
		log.Panic("content不能为空")
	}
	category := c.GetString("category")
	keywords := c.GetString("keywords")

	article := new(Article)
	article.Title = title
	article.Content = content
	article.Category = category
	article.Keywords = keywords
	article.Status = 1
	article.CreatedAt = time.Now()
	article.UpdatedAt = time.Now()
	articleService := service.NewService()
	_, err := articleService.Save(article)

	categoryRec := &Category{Name: category}
	err2 := categoryRec.GetByName()
	if err2 == orm.ErrNoRows || err2 == orm.ErrMissPK {
		logs.Debug("【%s】分类记录不存在，去创建！", category)
		categoryRec.CreatedAt = time.Now()
		categoryRec.UpdatedAt = time.Now()
		categoryRec.Create()
	}
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(nil)
	}
	c.ServeJSON()
}

/**
 * 文章列表接口
 * /admin/page/articles
 */
func (c *ArticleAPIController) ArticlesList() {
	args := c.GetString("search") // 获取所有参数
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	article := new(Article)
	param := map[string]string{
		"title": args,
	}

	list, total, err := article.GetArticlesByCondition(param, start, perPage)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		data := map[string]any{
			"result": list,
			"total":  total,
		}
		c.Data["json"] = c.SuccessData(data)
	}
	c.ServeJSON()
}

/**
 * 修改文章接口
 * /admin/page/article/:id
 */
func (c *ArticleAPIController) ArticleEdit() {
	defer func() {
		if err := recover(); err != nil {
			c.Data["json"] = c.ErrorData(err.(error))
			c.ServeJSON()
		}
	}()
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
	_, err := article.Update()

	categoryRec := &Category{Name: category}
	err2 := categoryRec.GetByName()
	if err2 == orm.ErrNoRows || err2 == orm.ErrMissPK {
		logs.Debug("【%s】分类记录不存在，去创建！", category)
		categoryRec.CreatedAt = time.Now()
		categoryRec.UpdatedAt = time.Now()
		categoryRec.Create()
	}
	if err != nil {
		c.Data["json"] = c.ErrorData(err.(error))
		c.ServeJSON()
		return
	}
	c.Data["json"] = c.SuccessData(nil)
	c.ServeJSON()
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
