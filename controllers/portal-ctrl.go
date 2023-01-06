package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"fmt"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/service"
	"metal/util"
	"net/http"
	"reflect"
	"regexp"
	"strconv"
	"time"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/config"
	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"
)

type PortalController struct {
	beego.Controller
}

//用户如果没有进行注册，那么就会通过反射来执行对应的函数，如果注册了就会通过 interface 来进行执行函数
//官方文档说可以提高性能
// func (c *PortalController) URLMapping() {
// 	c.Mapping("Get", c.Get)
// 	c.Mapping("MyRoute", c.MyRoute)
// }

// 预处理，会在下面每个路由执行前执行，可当做前置中间件使用
func (c *PortalController) Prepare() {
	val, _ := beego.AppConfig.String("runmode")
	c.Data["env"] = val // 用户百度统计设置，测服环境不需要统计
	// 设置TKD信息
	c.Data["title"] = "月盾的网站，基于beego v2开发的web项目"
	c.Data["keywords"] = "golang,go-micro,beego v2博客,管理后台"
	c.Data["description"] = "golang,go-micro,beego v2博客,管理后台"
	ctr, method := c.GetControllerAndAction()
	logs.Debug("包， 结构体，请求方法:%s, %s, %s", reflect.TypeOf(PortalController{}).PkgPath(), ctr, method)
}

// 收尾处理，在路由执行完执行，已经渲染了数据，所以Finish里设置数据不会渲染到模板中
func (c *PortalController) Finish() {
	logs.Debug(">>>>>>>>>>Finish 执行完相应的 HTTP Method 方法之后执行的")
}

// 首页
func (c *PortalController) Get() {
	pageNo, err := c.GetInt("pageNo")
	if err != nil {
		pageNo = 1
	}
	pageSize, err := c.GetInt("pageSize")
	if err != nil {
		pageSize = 10
	}
	skip := (pageNo - 1) * pageSize
	params := map[string]string{}
	article := Article{}
	articleList, total, err := article.GetArticlesByCondition(params, skip, pageSize)
	if nil != err {
		c.Data["articleList"] = []Article{}
		c.Data["total"] = 0
	} else {
		var artList = make([]ArticlePortal, len(articleList)) // 切片长度去实际数据长度
		for index, art := range articleList {
			re := regexp.MustCompile(`\\<[\\S\\s]+?\\>`)                //html标签
			reimg := regexp.MustCompile(`<img (\S*?)[^>]*>.*?|<.*? />`) //获取一张图片
			htmlStr := util.Md2html(art.Content)
			artList[index].Id = art.Id
			artList[index].Title = art.Title
			artList[index].Content = beego.Substr(re.ReplaceAllString(htmlStr, ""), 0, 300)
			artList[index].Img = string(reimg.Find([]byte(htmlStr)))
			artList[index].Status = art.Status
			artList[index].Category = art.Category
			count, _ := article.GetArticleViewCount(art.Id)
			artList[index].ViewCount = count
			artList[index].UpdatedAt = art.UpdatedAt.Format("2006-01-02")
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

func (c *PortalController) Article() {
	artId, err := strconv.Atoi(c.Ctx.Input.Param(":id"))
	if err != nil {
		c.Data["content"] = err
		c.TplName = "404.html"
	} else {
		article := &Article{}
		article.Id = uint(artId)
		articlePortal, err := article.ArticleDetail()

		artLog := &ArticleLog{}
		artLog.Save(article.Id, "") //记录访问日志
		if err != nil {
			logs.Error(err)
		}
		articlePortal.Title = article.Title
		articlePortal.Keywords = article.Keywords
		articlePortal.Content = util.Md2html(article.Content)
		articlePortal.Category = article.Category
		articlePortal.UpdatedAt = article.UpdatedAt.Format("2006-01-02 15:04")
		c.Data["article"] = articlePortal
		c.Data["zero"] = uint(0)
		c.TplName = "article.html"
	}
}

func (c *PortalController) Categories() {
	category := c.Ctx.Input.Param(":category")
	params := map[string]string{}
	params["category"] = category
	article := new(Article)
	articleList, _, err := article.GetArticlesByCondition(params, 0, 100)
	if err != nil {
		c.Data["titles"] = []string{}
	} else {
		var artList = make([]ArticlePortal, len(articleList)) // 切片长度去实际数据长度
		for index, art := range articleList {
			artList[index].Id = art.Id
			artList[index].Title = art.Title
			artList[index].Category = art.Category
			artList[index].CreatedAt = art.CreatedAt.Format("2006-01-02 15:04")
			artList[index].UpdatedAt = art.UpdatedAt.Format("2006-01-02 15:04")
		}
		c.Data["category"] = category
		c.Data["titles"] = artList
	}
	c.TplName = "categories-tags.html"
}

func (c *PortalController) Tags() {
	tag := c.Ctx.Input.Param(":tag")
	params := map[string]string{}
	params["keywords"] = tag
	article := new(Article)
	articleList, _, err := article.GetArticlesByCondition(params, 0, 100)
	if err != nil {
		c.Data["titles"] = []string{}
	} else {
		var artList = make([]ArticlePortal, len(articleList)) // 切片长度去实际数据长度
		for index, art := range articleList {
			artList[index].Id = art.Id
			artList[index].Title = art.Title
			artList[index].Category = art.Category
			artList[index].CreatedAt = art.CreatedAt.Format("2006-01-02 15:04")
			artList[index].UpdatedAt = art.UpdatedAt.Format("2006-01-02 15:04")
		}
		c.Data["category"] = tag
		c.Data["titles"] = artList
	}
	c.TplName = "categories-tags.html"
}

func (c *PortalController) Catalog() {
	article := new(Article)
	titles, err := article.GetCatalog()
	if err != nil {
		c.Data["titles"] = []string{}
	} else {
		c.Data["titles"] = titles
		c.Data["count"] = len(titles)
	}
	c.TplName = "catalog.html"
}

func (c *PortalController) About() {
	c.TplName = "about.html"
}

func (c *PortalController) Message() {
	message := new(Message)
	cond := map[string]string{}
	cond["status"] = "1"
	list, total, err := message.GetAllByCondition(cond, 0, 10)
	if err != nil {
		c.Data["messageList"] = list
		c.Data["total"] = total
	}
	c.Data["messageList"] = list
	c.Data["total"] = total
	// c.Data["pageNo"] = pageNo
	// c.Data["pageSize"] = pageSize
	c.TplName = "message.html"
}

func (c *PortalController) CreateMessage() {
	nickName := c.GetString("nickName")
	email := c.GetString("email")
	content := c.GetString("content")
	if nickName == "" || email == "" || content == "" {
		c.Data["json"] = Result{
			Code: 1,
			Msg:  "留言失败！",
		}
	}
	message := Message{}
	message.NickName = nickName
	message.Email = email
	message.Content = content
	message.Status = 0 //待审核
	message.CreatedAt = time.Now()
	message.UpdatedAt = time.Now()
	_, err := message.Save()
	if err != nil {
		c.Data["json"] = Result{
			Code: 1,
			Msg:  "留言失败！",
		}
	}
	c.Data["json"] = Result{
		Msg: "留言成功",
	}
	c.ServeJSON()
}

func (c *PortalController) Registration() {
	var err error
	var code int
	defer func(start time.Time) {
		var rsp Result
		rsp.Code = code
		rsp.Cost = time.Since(start).Milliseconds()
		rsp.Msg = http.StatusText(code)
		if err != nil {
			rsp.Msg = fmt.Sprintf("%s - %s", rsp.Msg, err.Error())
			logs.Error(rsp.Msg)
			c.Data["json"] = map[string]any{
				"code": code,
				"msg":  err.Error(),
			}
		} else {
			c.Data["json"] = map[string]any{
				"code": 0,
				"msg":  "ok",
			}
		}
		c.ServeJSON()
	}(time.Now())
	req := struct {
		Username   string `json:"username"`
		Password   string `json:"password"`
		RePassword int    `json:"repassword"`
		Email      string `json:"email"`
	}{}
	c.BindJSON(&req)

	if req.Email == "" {
		code = http.StatusBadRequest
		err = fmt.Errorf("手机号不能为空！")
		return
	}
	if req.Username == "" {
		code = http.StatusBadRequest
		err = fmt.Errorf("名称不能为空！")
		return
	}
	salt, err := config.String("salt")
	if err != nil {
		logs.Error("not found salt")
		code = http.StatusInternalServerError
		err = fmt.Errorf("not found salt")
		return
	}
	logs.Debug("salt", salt)
	password := util.GetMD5(req.Password, salt)
	var user = new(User)
	user.Username = req.Username
	user.Gender = 1
	user.Email = req.Email
	user.Password = password
	user.Status = Unverified

	//TODO 事务注册
	if _, err = user.Save(); err != nil {
		code = http.StatusInternalServerError
		return
	}
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	err = permissionSrv.UpdateUserRoles(user.Id, []uint{3})
	if nil != err {
		code = http.StatusInternalServerError
		return
	}
	link := fmt.Sprintf("%s/user/verfify?token=%s", "https://www.hopefly.top", "token")
	content := fmt.Sprintf("【hopefly.top】点击链接验证邮箱。<a href='%s'>点击验证</a>或复制链接浏览器打开：%s", link, link)
	err = util.SendEmail("注册验证", content, []string{user.Email})
	if nil != err {
		code = http.StatusInternalServerError
		return
	}
	c.ServeJSON()
}
