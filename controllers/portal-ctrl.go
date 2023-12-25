package controllers

//包名并非必须和文件夹名相同，但是按照惯例最后一个路径名和包名一致
import (
	"encoding/base64"
	"fmt"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/service"
	"metal/util"
	"net/http"
	"reflect"
	"strconv"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/config"
	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"
)

type PortalController struct {
	beego.Controller
}

// 预处理，会在下面每个路由执行前执行，可当做前置中间件使用
func (c *PortalController) Prepare() {
	val, _ := beego.AppConfig.String("runmode")
	c.Data["env"] = val // 用户百度统计设置，测服环境不需要统计
	// 设置TKD信息
	c.Data["title"] = "月盾的网站，基于beego开发的web项目"
	c.Data["keywords"] = "golang,beego,博客,管理后台"
	c.Data["description"] = "golang,beego,博客,管理后台"
	ctr, method := c.GetControllerAndAction()
	logs.Debug("包:%s, 结构体:请求方法:%s:%s", reflect.TypeOf(PortalController{}).PkgPath(), ctr, method)
	logs.Info("IP:%s URL:%s", c.Ctx.Input.Header("Remote_addr"), c.Ctx.Request.URL)
}

// 收尾处理，在路由执行完执行，已经渲染了数据，所以Finish里设置数据不会渲染到模板中
func (c *PortalController) Finish() {
	logs.Debug(">>>>>>>>>>Finish 执行完相应的 HTTP Method 方法之后执行的")
}

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
			// re := regexp.MustCompile(`\\<[\\S\\s]+?\\>`)                //html标签
			// reimg := regexp.MustCompile(`<img (\S*?)[^>]*>.*?|<.*? />`) //获取一张图片
			htmlStr := util.Md2html(art.Content)
			doc, err := goquery.NewDocumentFromReader(strings.NewReader(htmlStr))
			if err != nil {
				continue
			}
			//查找元素
			text := doc.Text()
			img, _ := doc.Find("img").Attr("src")
			artList[index].Id = art.Id
			artList[index].Title = art.Title
			artList[index].Content = beego.Substr(text, 0, 300)
			artList[index].Img = img
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
	//默认tpl或html后缀
	c.TplName = "index.html"
}

func (c *PortalController) Article() {
	artId, err := strconv.Atoi(c.Ctx.Input.Param(":id"))
	if err != nil {
		c.Abort("404")
	}
	article := &Article{}
	article.Id = uint(artId)
	article.Status = 1
	articlePortal, err := article.ArticleDetail()
	if err != nil {
		logs.Error(err)
		c.Abort("404")
	}
	runmode, _ := config.String("runmode")
	if runmode == "prod" {
		artLog := &ArticleLog{
			ArticleId: article.Id,
			Mark:      c.Ctx.Input.Header("Remote_addr"),
		}
		_, err = artLog.Save() //记录访问日志
		if err != nil {
			logs.Error(err)
		}
	}
	articlePortal.Title = article.Title
	articlePortal.Keywords = article.Keywords
	articlePortal.Description = article.Description
	articlePortal.Content = util.Md2html(article.Content)
	articlePortal.Category = article.Category
	articlePortal.UpdatedAt = article.UpdatedAt.Format("2006-01-02 15:04")
	c.Data["article"] = articlePortal
	c.Data["zero"] = uint(0)
	logs.Info("博客详情:", article.Title)
	c.TplName = "article.html"
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
	list, total, err := message.GetMessageList(cond, 0, 10)
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
	defer func() {
		c.ServeJSON()
	}()
	nickName := c.GetString("nickName")
	email := c.GetString("email")
	content := c.GetString("content")
	if nickName == "" || email == "" || content == "" {
		c.Data["json"] = Result{
			Code: 1,
			Msg:  "留言失败！",
		}
		return
	}
	message := Message{}
	message.NickName = nickName
	message.Email = email
	message.Content = content
	message.Status = 0 //待审核
	_, err := message.Save()
	if err != nil {
		c.Data["json"] = Result{
			Code: 1,
			Msg:  "留言失败！",
		}
		return
	}
	c.Data["json"] = Result{
		Msg: "留言成功",
	}
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
			c.Data["json"] = rsp
		} else {
			c.Data["json"] = rsp
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
	user.Status = UserStatusUnverified

	//TODO 事务注册
	if _, err = user.Save(); err != nil {
		code = http.StatusInternalServerError
		return
	}
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	err = permissionSrv.UpdateUserRoles(user.Id, []uint{2}) //未验证邮箱前是游客权限
	if nil != err {
		code = http.StatusInternalServerError
		return
	}
	domain, err := config.String("domain")
	if err != nil {
		code = http.StatusInternalServerError
		return
	}
	token := base64.StdEncoding.EncodeToString([]byte(fmt.Sprintf("%s:%d", user.Email, user.Id)))
	link := fmt.Sprintf("%s/verify?token=%s", domain, token)
	content := fmt.Sprintf("【hopefly.top】点击链接验证邮箱。<a href='%s'>点击验证</a>或复制链接浏览器打开：%s", link, link)
	err = util.SendEmail("注册验证", content, []string{user.Email})
	if nil != err {
		code = http.StatusInternalServerError
		return
	}
}

func (c *PortalController) Verify() {
	token := c.GetString("token")
	bts, err := base64.StdEncoding.DecodeString(token)
	if err != nil {
		logs.Info("token解码失败", err)
		c.Abort("500")
	}
	token = string(bts)
	tokenArr := strings.Split(token, ":")
	email, uid := tokenArr[0], tokenArr[1]
	userId, err := strconv.Atoi(uid)
	if err != nil {
		logs.Info("uid转类型失败", err)
		c.Abort("500")
	}
	logs.Debug(">>>>>>>", email, uid)
	if email == "" || uid == "" {
		logs.Info("email或uid为空", err)
		c.Abort("500")
	}
	user := User{}
	user.Id = uint(userId)
	user.Email = email
	if err = user.GetByCondition(); err != nil {
		c.Abort("500")
	}
	user.Status = UserStatusOk
	if _, err = user.UpdateStatus(); err != nil {
		c.Abort("500")
	}
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	err = permissionSrv.UpdateUserRoles(user.Id, []uint{3}) //验证邮箱后是注册用户权限
	if nil != err {
		c.Abort("500")
	}
	c.Data["status"] = UserStatusOk

	c.TplName = "admin/login.html"
}
