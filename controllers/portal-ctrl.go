package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"github.com/astaxie/beego/logs"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"reflect"
	"regexp"
	"strconv"
	"time"

	"github.com/astaxie/beego"
	"github.com/microcosm-cc/bluemonday"
	"github.com/russross/blackfriday"
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
	val:= beego.AppConfig.String("runmode")
	this.Data["env"] = val
	ctr, meth := this.GetControllerAndAction()
	logs.Debug(">>>>>>>>>>Prepare:package:%s, method:%s, controller:%s, %s", reflect.TypeOf(PortalController{}).PkgPath(), this.Ctx.Request.Method, ctr, meth)
}

//收尾处理，在路由执行完执行，可当做后置中间件使用
func (this *PortalController) Finish() {
	logs.Debug(">>>>>>>>>>Finish", "env:", this.Data)
}

//首页
// @router / [get]
func (c *PortalController) Get() {
	pageNo, err := c.GetInt("pageNo")
	if err != nil {
		pageNo = 0
	}
	pageSize, err := c.GetInt("pageSize")
	if err != nil {
		pageSize = 5
	}
	skip := pageNo * pageSize
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
			htmlStr := md2html(art.Content)
			artList[index].Id = art.Id
			artList[index].Title = art.Title
			artList[index].Content = beego.Substr(re.ReplaceAllString(htmlStr, ""), 0, 300)
			artList[index].Img = string(reimg.Find([]byte(htmlStr)))
			artList[index].Status = art.Status
			artList[index].CreatedAt = art.CreatedAt
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
		article.Content = md2html(article.Content)
		c.Data["article"] = article
		c.TplName = "article.html"
	}
}

// @router /test [get]
func (c *PortalController) MyRoute() {
	c.Data["content"] = "这是一个自定义控制器"
	user := &User{}
	userList, err := user.GetAll()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = map[string]any{"msg": err}
		c.ServeJSON()
	}
	c.Data["userList"] = userList
	c.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要

}

// @router /user [post]
func (c *PortalController) AddUser() {
	username := c.GetString("username")
	password := c.GetString("password")

	var user = new(User)
	user.UserName = username
	user.Password = password
	user.CreatedAt = time.Now()
	user.UpdatedAt = time.Now()

	_, err := user.Save()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = map[string]any{"msg": err}
		c.ServeJSON()
	}
	userList, err := user.GetAll()
	c.Data["userList"] = userList
	c.TplName = "myroute.html" //其他数据相关的可以写到if块中，本行最好不要
}

// @route /getUserByName [get]
func (c *PortalController) GetUser() {
	username := c.Ctx.Input.Param(":username")
	user := &User{UserName: username}
	err := user.GetByName()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = map[string]any{"result": false, "msg": c.Ctx.Input.Params()}
	} else {
		c.Data["json"] = map[string]any{"result": true, "msg": user}
	}
	c.ServeJSON()
}

// @router /category [get]
func (c *PortalController) Category() {
	article := new(Article)
	titles, err := article.GetCategory()
	if err != nil {
		c.Data["titles"] = []string{}
	} else {
		c.Data["titles"] = titles
	}
	c.TplName = "category.html"
}

// @router /about [get]
func (c *PortalController) About() {
	c.TplName = "about.html"
}

// @router /vipkid [get]
func (c *PortalController) Vipkid() {
	c.TplName = "vipkid.html"
}

// markdown转html
func md2html(in string) string {
	input := []byte(in)
	unsafe := blackfriday.Run(input, blackfriday.WithExtensions(blackfriday.CommonExtensions)) //支持表格，代码
	htmlBytes := bluemonday.UGCPolicy().SanitizeBytes(unsafe)
	html := string(htmlBytes)
	return html
}
