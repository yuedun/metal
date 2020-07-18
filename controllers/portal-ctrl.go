package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/util"
	"reflect"
	"regexp"
	"strconv"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
)

type PortalController struct {
	BaseController
}

//用户如果没有进行注册，那么就会通过反射来执行对应的函数，如果注册了就会通过 interface 来进行执行函数
//官方文档说可以提高性能
// func (c *PortalController) URLMapping() {
// 	c.Mapping("Get", c.Get)
// 	c.Mapping("MyRoute", c.MyRoute)
// }

//预处理，会在下面每个路由执行前执行，可当做前置中间件使用
func (this *PortalController) Prepare() {
	val := beego.AppConfig.String("runmode")
	this.Data["env"] = val // 用户百度统计设置，测服环境不需要统计
	ctr, method := this.GetControllerAndAction()
	logs.Debug("包， 结构体，请求方法:%s, %s, %s", reflect.TypeOf(PortalController{}).PkgPath(), ctr, method)
}

//收尾处理，在路由执行完执行，可当做后置中间件使用
func (this *PortalController) Finish() {
	logs.Debug(">>>>>>>>>>Finish")
}

//首页
// @router / [get]
func (c *PortalController) Get() {
	pageNo, err := c.GetInt("pageNo")
	if err != nil {
		pageNo = 1
	}
	pageSize, err := c.GetInt("pageSize")
	if err != nil {
		pageSize = 5
	}
	skip := (pageNo - 1) * pageSize
	params := map[string]string{}
	params["status"] = "1"
	article := &Article{}
	articleList, total, err := article.GetArticlesByCondition(params, skip, pageSize)
	if nil != err {
		c.Data["articleList"] = []Article{}
		c.Data["total"] = 0
	} else {
		var artList = make([]ArticlePortal, len(articleList)) // 切片长度去实际数据长度
		for index, art := range articleList {
			re := regexp.MustCompile("\\<[\\S\\s]+?\\>")                //html标签
			reimg := regexp.MustCompile(`<img (\S*?)[^>]*>.*?|<.*? />`) //获取一张图片
			htmlStr := util.Md2html(art.Content)
			artList[index].Id = art.Id
			artList[index].Title = art.Title
			artList[index].Content = beego.Substr(re.ReplaceAllString(htmlStr, ""), 0, 300)
			artList[index].Img = string(reimg.Find([]byte(htmlStr)))
			artList[index].Status = art.Status
			artList[index].UpdatedAt = art.UpdatedAt.Format("2006-01-02 15:04")
		}
		c.Data["articleList"] = artList
		c.Data["total"] = total
		c.Data["pageNo"] = pageNo
		c.Data["pageSize"] = pageSize
	}
	logs.Info("访问ip:", c.Ctx.Input.Header("Remote_addr"))
	//默认tpl或html后缀
	c.TplName = "index.html"
}

// @router /article/:id [get]
func (c *PortalController) Article() {
	artId, err := strconv.Atoi(c.Ctx.Input.Param(":id"))
	if err != nil {
		c.Data["content"] = err
		c.TplName = "404.html"
	} else {
		article := &Article{}
		article.Id = uint(artId)
		err := article.GetById()
		if err != nil {
			logs.Error(err)
		}
		articlePortal := ArticlePortal{}
		articlePortal.Title = article.Title
		articlePortal.Content = util.Md2html(article.Content)
		articlePortal.UpdatedAt = article.UpdatedAt.Format("2006-01-02 15:04")
		c.Data["article"] = articlePortal
		c.TplName = "article.html"
	}
}

// @router /category [get]
func (c *PortalController) Category() {
	article := new(Article)
	titles, err := article.GetCategory()
	if err != nil {
		c.Data["titles"] = []string{}
	} else {
		c.Data["titles"] = titles
		c.Data["count"] = len(titles)
	}
	c.TplName = "category.html"
}

// @router /about [get]
func (c *PortalController) About() {
	c.TplName = "about.html"
}
