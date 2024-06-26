package api

import (
	"fmt"
	"metal/controllers"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/service"
	"metal/util"
	"net/http"
	"os"
	"strconv"
	"time"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/logs"

	beego "github.com/beego/beego/v2/server/web"
)

type AdminAPIController struct {
	controllers.AdminBaseController
}

func (c *AdminAPIController) GetLogs() {
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	var logModel = new(Log)
	list, total, err := logModel.GetLogList(start, perPage)
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

func (c *AdminAPIController) UploadImg() {
	var err error
	var code int
	var data any
	defer func(start time.Time) {
		var rsp controllers.Result
		rsp.Code = code
		rsp.Cost = time.Since(start).Milliseconds()
		rsp.Msg = http.StatusText(code)
		if err != nil {
			rsp.Msg = fmt.Sprintf("%s - %s", rsp.Msg, err.Error())
			logs.Error(rsp.Msg)
			c.Data["json"] = map[string]any{
				"success": 0,
				"message": err.Error(),
			}
		} else {
			c.Data["json"] = map[string]any{
				"success": 1,
				"message": "ok",
				"url":     data,
			}
		}
		c.ServeJSON()
	}(time.Now())
	file, h, err := c.GetFile("editormd-image-file")
	if err != nil {
		logs.Error("getfile err ", err)
		return
	}
	defer file.Close()
	_, err = os.Stat("tmp/upload")
	if err != nil {
		logs.Error("Stat err ", err)
		os.Mkdir("tmp/upload", os.ModePerm)
	}

	fileName := "tmp/upload/" + h.Filename
	err = c.SaveToFile("editormd-image-file", fileName)
	if err != nil {
		logs.Error("SaveToFile err ", err)
		return
	}
	//接收成功上传到七牛
	ret, err := util.UploadFile(fileName, h.Filename)
	if err != nil {
		logs.Error("UploadFile err ", err)
		return
	}
	//上传到七牛后删除本地文件
	if err := os.Remove(fileName); err != nil {
		logs.Error("Remove err ", err)
		return
	}
	url, _ := beego.AppConfig.String("qiniuUrl")
	data = url + ret.Key
}

func (c *AdminAPIController) MessageList() {
	args := c.GetString("search")
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	message := new(Message)
	var param = make(map[string]string)
	param["mobile"] = args
	param["username"] = args
	list, total, err := message.GetMessageList(param, start, perPage)
	if err != nil {
		c.ErrorMsg(err.Error())
	}
	data := map[string]any{
		"result": list,
		"total":  total,
	}
	c.Data["json"] = c.SuccessData(data)
	c.ServeJSON()
}

func (c *AdminAPIController) MessageUpdate() {
	article := new(Message)
	artId, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	article.Id = uint(artId)
	article.Status = 1
	article.UpdateStatus()
	c.Data["json"] = c.SuccessData("审核成功！")
	c.ServeJSON()
}

func (c *AdminAPIController) MessageDelete() {
	article := new(Message)
	artId, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	article.Id = uint(artId)
	article.Delete()
	c.Data["json"] = c.SuccessData("删除成功！")
	c.ServeJSON()
}

func (c *AdminAPIController) CountDataRecently() {
	startDate := c.GetString("startDate") + " 00:00:00"
	endDate := c.GetString("endDate") + " 23:59:59"

	logs.Info(startDate, endDate)
	jobCount := new(JobCount)
	list, err := jobCount.GetCountData(startDate, endDate)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(list)
	}
	c.ServeJSON()
}

func (c *AdminAPIController) CountDataAll() {
	jobCount := new(JobCount)
	list, err := jobCount.GetCountDataAll()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(list)
	}
	c.ServeJSON()
}

func (c *AdminAPIController) PictureAdd() {
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
	args := struct {
		PicUrl string `json:"picUrl"`
		Tag    string `json:"tag"`
	}{}
	c.Bind(&args)
	if err != nil {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
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
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(id)
	}
}

func (c *AdminAPIController) PictureList() {
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
	search := c.GetString("search") //搜索框
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	picture := new(Picture)
	list, total, err := picture.GetAllByCondition(search, start, perPage)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		data = map[string]any{
			"result": list,
			"total":  total,
		}
	}
}

func (c *AdminAPIController) PictureDelete() {
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
	picture := new(Picture)
	picId, _ := c.GetInt("picId")
	picture.Id = uint(picId)
	picture.Status = 0
	_, err = picture.Delete()
	if nil != err {
		logs.Error(err)
		return
	}
}

func (c *AdminAPIController) GetAllPermissions() {
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	list, err := permissionSrv.GetPermissionList()
	if nil != err {
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = list
	}
	c.ServeJSON()
}

func (c *AdminAPIController) AddUserRoles() {
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
	var userRoles struct {
		UserId uint   `json:"userId"`
		Roles  []uint `json:"roles"`
	}
	// json.Unmarshal(c.Ctx.Input.RequestBody, &userRole)
	c.Bind(&userRoles)
	logs.Debug(userRoles)
	if userRoles.UserId == 0 {
		logs.Warn("userId不能为空")
		err = fmt.Errorf("userId不能为空")
		return
	}
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	err = permissionSrv.UpdateUserRoles(userRoles.UserId, userRoles.Roles)
	if nil != err {
		logs.Error(err)
		code = http.StatusInternalServerError
		return
	}
}

func (c *AdminAPIController) GetUserRoles() {
	userId := c.Ctx.Input.Param(":userId")
	uid, _ := strconv.Atoi(userId)
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	allRoles, userRoles, err := permissionSrv.GetRolesAndUserPermission(uid)
	// logs.Debug("allRoles:", allRoles)
	logs.Debug("userRoles>>>>>>:", userRoles)
	if nil != err {
		c.Data["json"] = c.ErrorData(err)
	}
	userPermissions := make([]UserRoles, 0, 20)
	for index, item := range allRoles {
		userPremis := new(UserRoles)
		userPremis.Role_id = uint(item.Id)
		userPremis.Description = item.Description
		for _, rid := range userRoles {
			if item.Id == rid {
				userPremis.Checked = true
				break
			}
		}
		userPermissions = append(userPermissions[:index], *userPremis)
	}
	c.Data["json"] = c.SuccessData(userPermissions)
	c.ServeJSON()
}

func (c *AdminAPIController) GetRolesList() {
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
	args := c.GetString("search") //搜索框
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	role := Role{
		Description: args,
	}
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	list, total, err1 := permissionSrv.GetRolesList(role, start, perPage)
	if nil != err1 {
		logs.Error(err)
		err = err1
		code = http.StatusInternalServerError
		return
	}
	data = map[string]any{
		"result": list,
		"total":  total,
	}
}

func (c *AdminAPIController) RoleCreate() {
	roleName := c.GetString("roleName")
	permissions := c.GetString("permissions")
	role := Role{
		Description: roleName,
		Permissions: permissions,
	}
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	_, err := permissionSrv.CreateRole(role)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(role)
	c.ServeJSON()
}

func (c *AdminAPIController) RoleUpdate() {
	roleId := c.GetString("roleId")
	ridint, _ := strconv.Atoi(roleId)
	rid := uint(ridint)
	roleName := c.GetString("roleName")
	permissions := c.GetString("permissions")
	role := Role{
		Description: roleName,
		Permissions: permissions,
	}
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	role.Id = rid
	_, err := permissionSrv.UpdateRole(role)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(role)
	c.ServeJSON()
}

func (c *AdminAPIController) RoleDelete() {
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
	roleId, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	permissionSrv := service.NewPermissionService(orm.NewOrm())
	_, err = permissionSrv.DeleteRole(uint(roleId))
	if nil != err {
		logs.Error(err)
		code = http.StatusInternalServerError
		return
	}
}

func (c *AdminAPIController) Categories() {
	// args := c.GetString("search") //搜索框
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	category := Category{}

	list, total, err := category.GetCategoryList(category, start, perPage)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	data := map[string]any{
		"result": list,
		"total":  total,
	}
	c.Data["json"] = c.SuccessData(data)

	c.ServeJSON()
}

func (c *AdminAPIController) CategoriesCreate() {
	name := c.GetString("name")
	category := Category{
		Name: name,
	}
	category.CreatedAt = time.Now()
	category.UpdatedAt = time.Now()
	_, err := category.Create()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(category)
	c.ServeJSON()
}

func (c *AdminAPIController) CategoriesUpdate() {
	id, _ := c.GetInt("id")
	name := c.GetString("name")
	category := new(Category)
	category.Id = uint(id)
	category.Name = name
	_, err := category.Update([]string{"name"})
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(category)
	c.ServeJSON()
}

func (c *AdminAPIController) MovieList() {
	// args := c.GetString("search") //搜索框
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	mname := c.GetString("name")
	url := c.GetString("url")
	movie := Movie{}

	list, total, err := movie.GetMovieList(mname, url, start, perPage)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	data := map[string]any{
		"result": list,
		"total":  total,
	}
	c.Data["json"] = c.SuccessData(data)

	c.ServeJSON()
}

func (c *AdminAPIController) MovieInfo() {
	id, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	movie := Movie{}
	movie.Id = uint(id)
	err := movie.MovieInfo()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(movie)
	c.ServeJSON()
}

func (c *AdminAPIController) MovieAdd() {
	name := c.GetString("name")
	urls := c.GetStrings("urls[]")
	logs.Debug(name, urls)
	movie := Movie{
		Name: name,
	}
	_, err := movie.Save()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	_, err = movie.SaveUrls(urls)
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(nil)
	c.ServeJSON()
}

func (c *AdminAPIController) MovieUpdate() {
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
	id, _ := c.GetInt("id")
	name := c.GetString("name")
	url := c.GetString("url")
	url2 := c.GetString("url2")
	url3 := c.GetString("url3")
	if url2 != "" {
		url = url + "," + url2
	}
	if url3 != "" {
		url = url + "," + url3
	}

	movurl := MovieUrl{}
	movurl.Id = uint(id)
	err = movurl.FindById()
	if nil != err {
		logs.Error(err)
		return
	}
	movurl.URL = url
	_, err = movurl.Update([]string{"url"})
	if nil != err {
		logs.Error(err)
		return
	}
	movie := new(Movie)
	movie.Id = movurl.MovieId
	movie.Name = name
	_, err = movie.Update([]string{"name"})
	if nil != err {
		logs.Error(err)
		return
	}
}

func (c *AdminAPIController) MovieDelete() {
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
	id, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	movie := Movie{}
	movie.Id = uint(id)
	// movie.Status = 1
	_, err = movie.Delete()
	if nil != err {
		logs.Error(err)
		code = http.StatusInternalServerError
		return
	}
}
