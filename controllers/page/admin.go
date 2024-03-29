package page

import (
	"metal/controllers"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"net/http"
	"runtime"

	"github.com/PuerkitoBio/goquery"
	"github.com/beego/beego/v2/core/logs"
	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/disk"
	"github.com/shirou/gopsutil/mem"
)

type AdminPageController struct {
	controllers.AdminBaseController
}

func (c *AdminPageController) Login() {
	c.Data["status"] = 0
	c.TplName = "admin/login.html"
}

func (c *AdminPageController) Register() {
	c.TplName = "admin/register.html"
}

func (c *AdminPageController) LoginOut() {
	c.DelSession("loginUser")
	c.Redirect("/admin/page/login", 302)
}

func (c *AdminPageController) Welcome() {
	c.TplName = "admin/index.html"
}

func (c *AdminPageController) UserAdd() {
	c.TplName = "admin/user-add.html"
}

func (c *AdminPageController) UserList() {
	c.Data["Title"] = "用户列表"
	c.TplName = "admin/user-list.html"
}

func (c *AdminPageController) LogList() {
	c.Data["Title"] = "日志列表"
	c.TplName = "admin/log-list.html"
}

func (c *AdminPageController) ArticleCreate() {
	category := &Category{}
	list, err := category.GetAllCategories()
	if err != nil {
		c.Data["categories"] = make(map[string]string)
	}
	logs.Debug("%+v", list)
	c.Data["categories"] = list
	c.TplName = "admin/article-add.html"
}

func (c *AdminPageController) ArticleList() {
	c.TplName = "admin/article-list.html"
}

func (c *AdminPageController) ArticleEdit() {
	article := new(Article)
	artId, _ := c.GetInt("id")
	article.Id = uint(artId)
	article.GetById()

	category := &Category{}
	list, err := category.GetAllCategories()
	if err != nil {
		c.Data["categories"] = make(map[string]string)
	}
	logs.Debug("%+v", list)
	c.Data["categories"] = list
	c.Data["article"] = article
	c.TplName = "admin/article-edit.html"
}

func (c *AdminPageController) PNameView() {
	c.TplName = "admin/pname.html"
}

func (c *AdminPageController) Messages() {
	article := new(Article)
	artId, _ := c.GetInt("id")
	article.Id = uint(artId)
	article.GetById()
	c.Data["article"] = article
	c.TplName = "admin/messages.html"
}

func (c *AdminPageController) JobCount() {
	c.Data["title"] = "报表"
	c.TplName = "admin/job-count.html"
}

func (c *AdminPageController) IconList() {
	c.TplName = "admin/icons.html"
}

func (c *AdminPageController) Picture() {
	url := c.GetString("url")
	if url != "" {
		//请求html数据
		res, err := http.Get(url)
		if err != nil {
			return
		}
		defer res.Body.Close()
		if res.StatusCode != 200 {
			return
		}
		logs.Info("请求成功")
		//转换数据为HTML对象模型
		doc, err := goquery.NewDocumentFromReader(res.Body)
		if err != nil {
			return
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

func (c *AdminPageController) PictureList() {
	c.TplName = "admin/picture-list.html"
}

const (
	B  = 1
	KB = 1024 * B
	MB = 1024 * KB
	GB = 1024 * MB
)

func (c *AdminPageController) SystemInfo() {
	osDic := make(map[string]interface{}, 0)
	osDic["goOs"] = runtime.GOOS
	osDic["arch"] = runtime.GOARCH
	osDic["mem"] = runtime.MemProfileRate
	osDic["compiler"] = runtime.Compiler
	osDic["version"] = runtime.Version()
	osDic["numGoroutine"] = runtime.NumGoroutine()

	dis, _ := disk.Usage("/")
	diskTotalGB := int(dis.Total) / GB
	diskFreeGB := int(dis.Free) / GB
	diskDic := make(map[string]interface{}, 0)
	diskDic["total"] = diskTotalGB
	diskDic["free"] = diskFreeGB

	mem, _ := mem.VirtualMemory()
	memUsedMB := int(mem.Used) / GB
	memTotalMB := int(mem.Total) / GB
	memFreeMB := int(mem.Free) / GB
	memUsedPercent := int(mem.UsedPercent)
	memDic := make(map[string]interface{}, 0)
	memDic["total"] = memTotalMB
	memDic["used"] = memUsedMB
	memDic["free"] = memFreeMB
	memDic["usage"] = memUsedPercent

	cpuDic := make(map[string]interface{}, 0)
	cpuDic["cpuNum"], _ = cpu.Counts(false)

	c.Data["os"] = osDic
	c.Data["mem"] = memDic
	c.Data["cpu"] = cpuDic
	c.Data["disk"] = diskDic

	c.TplName = "admin/system-info.html"
}

func (c *AdminPageController) RoleList() {
	c.TplName = "admin/role-list.html"
}

func (c *AdminPageController) CategoryList() {
	c.TplName = "admin/category-list.html"
}

func (c *AdminPageController) Movies() {
	c.TplName = "admin/movie-list.html"
}
