package api

import (
	"encoding/json"
	"fmt"
	"metal/controllers"
	. "metal/models" // 点操作符导入的包可以省略包名直接使用公有属性和方法
	"metal/util"
	"net/http"
	"os"
	"strconv"
	"time"

	"github.com/beego/beego/v2/core/logs"

	beego "github.com/beego/beego/v2/server/web"
)

type AdminAPIController struct {
	controllers.AdminBaseController
}

/**
 * 日志列表接口
 */
func (c *AdminAPIController) GetLogs() {
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	var logModel = new(Log)
	list, total, err := logModel.GetLogs(start, perPage)
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
 * 上传图片
 * /admin/page/upload-img
 */
func (c *AdminAPIController) UploadImg() {
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
	file, h, err := c.GetFile("editormd-image-file")
	if err != nil {
		logs.Error("getfile err ", err)
		code = http.StatusBadRequest
		return
	}
	defer file.Close()
	_, err = os.Stat("tmp/upload")
	if err != nil {
		os.Mkdir("tmp/upload", os.ModePerm)
	}

	fileName := "tmp/upload/" + h.Filename
	err = c.SaveToFile("editormd-image-file", fileName)
	if err != nil {
		data = map[string]any{
			"success": 0,
			"message": err.Error(),
		}
		return
	}
	//接收成功上传到七牛
	ret, err := util.UploadFile(fileName, h.Filename)
	if err != nil {
		data = map[string]any{
			"success": 0,
			"message": err,
			"url":     fileName,
		}
		return
	}
	//上传到七牛后删除本地文件
	localFile, err := os.Open(fileName)
	if err != nil {
		logs.Error(err.Error())
		code = http.StatusInternalServerError
		return
	}
	defer localFile.Close()
	if err := localFile.Close(); err != nil {
		logs.Error(err)
		code = http.StatusInternalServerError
		return
	}
	os.Remove(fileName)
	url, _ := beego.AppConfig.String("qiniuUrl")
	c.Data["json"] = map[string]any{
		"success": 1,
		"message": "ok",
		"url":     url + ret.Key,
	}
}

/**
 * 留言查看，审核
 * /admin/api/message/list
 */
func (c *AdminAPIController) MessageList() {
	args := c.GetString("search")
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	message := new(Message)
	var param = make(map[string]string)
	param["mobile"] = args
	param["username"] = args
	list, total, err := message.GetAllByCondition(param, start, perPage)
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

/**
 * 留言审核通过
 * /admin/api/message/update
 */
func (c *AdminAPIController) MessageUpdate() {
	article := new(Message)
	artId, _ := strconv.Atoi(c.Ctx.Input.Param(":id"))
	article.Id = uint(artId)
	article.Status = 1
	article.UpdateStatus()
	c.Data["json"] = c.SuccessData("审核成功！")
	c.ServeJSON()
}

// CountDataRecently 近一个月数据
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

// CountDataAll 所有历史数据，按月平均值统计
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

// AddPicture 保存图片
func (c *AdminAPIController) AddPicture() {
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

// ListPicture 图片列表
func (c *AdminAPIController) ListPicture() {
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
		c.Data["json"] = c.ErrorData(err)
	} else {
		data := map[string]any{
			"result": list,
			"total":  total,
		}
		c.Data["json"] = c.SuccessData(data)
	}
}

// DeletePicture 删除图片
func (c *AdminAPIController) DeletePicture() {
	defer func() {
		c.ServeJSON()
	}()
	picture := new(Picture)
	picId, _ := c.GetInt("picId")
	logs.Info(">>>>", picId)
	picture.Id = uint(picId)
	picture.Status = 0
	_, err := picture.Delete()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = c.SuccessData(nil)
	}
}

/**
 * 获取所有权限
 */
// @router /user-group/get-all-user-group [get]
func (c *AdminAPIController) GetAllUserGroup() {
	userGroup := new(UserGroup)
	list, err := userGroup.GetUserGroupList()
	if nil != err {
		c.Data["json"] = c.ErrorData(err)
	} else {
		c.Data["json"] = list
	}
	c.ServeJSON()
}

/**
用户添加权限
*/
// @router /user-group/add-user-group [post]
func (c *AdminAPIController) AddUserGroup() {
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
	args := UserGroup{}
	json.Unmarshal(c.Ctx.Input.RequestBody, &args)
	userId := args.UserId
	if userId == 0 {
		logs.Warn("userId不能为空")
		err = fmt.Errorf("userId不能为空")
		return
	}
	groupId := args.GroupId
	if groupId == 0 {
		logs.Warn("groupId不能为空")
		err = fmt.Errorf("groupId不能为空")
		return
	}
	userGroup := UserGroup{}
	userGroup.UserId = userId
	userGroup.GroupId = groupId
	userGroup.CreatedAt = time.Now()
	userGroup.UpdatedAt = time.Now()

	_, err = userGroup.Save()
	if nil != err {
		logs.Error(err)
		code = http.StatusBadRequest
		return
	}
}

// AddUserRole 用户添加权限
func (c *AdminAPIController) AddUserRole() {
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
	var args struct {
		UserId uint
		Roles  []uint
	}
	err = json.Unmarshal(c.Ctx.Input.RequestBody, &args)
	if err != nil {
		return
	}
	logs.Info("参数：", args)
	userId := args.UserId
	if userId == 0 {
		logs.Warn("userId不能为空")
		err = fmt.Errorf("userId不能为空")
		return
	}
	roleIds := args.Roles
	if len(roleIds) == 0 {
		logs.Warn("roleId不能为空")
		err = fmt.Errorf("roleId不能为空")
		return
	}
	userGroup := Groups{}
	err = userGroup.UpdateUserRoles(userId, roleIds)
	if err != nil {
		return
	}
}

// GetUserRoles 获取用户权限
func (c *AdminAPIController) GetUserRoles() {
	userId := c.Ctx.Input.Param(":userId")
	uid, _ := strconv.Atoi(userId)
	role := new(Role)
	allRoles, userRoles, err := role.GetRolesAndUserPermission(uid)
	logs.Debug("allRoles:", allRoles)
	logs.Debug("userRoles:", userRoles)
	if nil != err {
		c.Data["json"] = c.ErrorData(err)
	}
	userPermissions := make([]UserGroups, 0, 20)
	for index, item := range allRoles {
		userPremis := new(UserGroups)
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
	// args := c.GetString("search") //搜索框
	start, _ := c.GetInt("start")
	perPage, _ := c.GetInt("perPage")
	role := new(Role)

	list, total, err := role.GetRolesList(*role, start, perPage)
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

func (c *AdminAPIController) CreateRole() {
	roleName := c.GetString("roleName")
	groups := c.GetString("permissions")
	role := Role{
		Description: roleName,
		Groups:      groups,
	}
	role.CreatedAt = time.Now()
	role.UpdatedAt = time.Now()
	_, err := role.Create()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(role)
	c.ServeJSON()
}

func (c *AdminAPIController) UpdateRole() {
	// args := c.GetString("search") //搜索框
	roleId := c.GetString("roleId")
	ridint, _ := strconv.Atoi(roleId)
	rid := uint(ridint)
	roleName := c.GetString("roleName")
	groups := c.GetString("permissions")
	role := Role{
		Description: roleName,
		Groups:      groups,
	}
	role.Id = rid
	_, err := role.Update()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(role)
	c.ServeJSON()
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

// 创建分类
func (c *AdminAPIController) CreateCategories() {
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

// 修改分类
func (c *AdminAPIController) UpdateCategories() {
	id, _ := c.GetInt("id")
	name := c.GetString("name")
	category := new(Category)
	category.Id = uint(id)
	category.Name = name

	category.CreatedAt = time.Now()
	category.UpdatedAt = time.Now()
	_, err := category.Update()
	if nil != err {
		logs.Error(err)
		c.Data["json"] = c.ErrorData(err)
	}
	c.Data["json"] = c.SuccessData(category)
	c.ServeJSON()
}
