package service

import (
	. "metal/models"
	"sync"

	"github.com/beego/beego/v2/client/orm"
	"github.com/beego/beego/v2/core/logs"
)

type IPermissionService interface {
	GetPermissionList() ([]Permission, error)
	GetPermissionsByUserId(userId uint) ([]Role, error)
	UpdateUserRoles(userId uint, roleIds []uint) error
	GetRolesAndUserPermission(userId int) (allRoles []Role, userRoles []uint, returnErr error)
	GetRolesList(search Role, offset, limit int) (allRoles []Role, count int64, err error)
	CreateRole(role Role) (int64, error)
	UpdateRole(role Role) (int64, error)
	DeleteRole(id uint) (int64, error)
	GetUserGroupList() ([]UserRole, error)
	GetGroupByUserId(userId int) ([]UserRole, error)
}

type PermissionService struct {
	orm orm.Ormer
}

func NewPermissionService(o orm.Ormer) IPermissionService {
	return &PermissionService{
		orm: o,
	}
}

func (s *PermissionService) GetPermissionList() ([]Permission, error) {
	o := orm.NewOrm()
	var permis []Permission
	//var userPermission []orm.Params//orm.Params是一个map类型
	num, err := o.Raw("select * from permission order by id desc;").QueryRows(&permis)
	if nil != err && num > 0 {
		return nil, err
	}
	return permis, nil
}

/**
 * 根据userid获取usergroup list
 */
func (s *PermissionService) GetPermissionsByUserId(userId uint) ([]Role, error) {
	var userPermission []Role
	qb, _ := orm.NewQueryBuilder("mysql")
	qb.Select("role.permissions").From("role").InnerJoin("user_role as ur").On("role.id = ur.role_id").Where("ur.user_id = ?")
	// 导出 SQL 语句
	sql := qb.String()
	// 执行 SQL 语句
	_, err := s.orm.Raw(sql, userId).QueryRows(&userPermission)

	if nil != err {
		return nil, err
	}
	return userPermission, nil
}

// 添加权限
func (s *PermissionService) SavePermission(permission Permission) (int64, error) {
	return s.orm.Insert(permission)
}

// 修改用户角色
func (s *PermissionService) UpdateUserRoles(userId uint, roleIds []uint) error {
	to, err := s.orm.Begin()
	if err != nil {
		logs.Error("start the transaction failed")
		return err
	}
	userRole := UserRole{}
	userRole.UserId = userId
	if _, err = to.Delete(&userRole, "user_id"); err != nil {
		logs.Error(err)
		return err
	}

	for _, roleId := range roleIds {
		var userRole = new(UserRole)
		userRole.UserId = userId
		userRole.RoleId = roleId
		_, err := to.Insert(userRole)
		if nil != err {
			logs.Error(err)
			to.Rollback()
			return err
		}
	}
	err = to.Commit()
	return err
}

// GetRolesAndUserPermission 获取所有权限和单个用户拥有的权限
func (s *PermissionService) GetRolesAndUserPermission(userId int) (allRoles []Role, userRoles []uint, err error) {
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		_, err = s.orm.Raw("SELECT id, description FROM role ORDER BY id DESC;").QueryRows(&allRoles)
	}()
	go func() {
		defer wg.Done()
		_, err = s.orm.Raw("SELECT role_id FROM user_role WHERE user_id = ? ORDER BY id DESC;", userId).QueryRows(&userRoles)
	}()
	wg.Wait()
	return
}

// GetRolesList 获取角色列表
func (s *PermissionService) GetRolesList(search Role, offset, limit int) (allRoles []Role, count int64, err error) {
	o := s.orm
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		count, err = o.QueryTable("role").Count()

	}()
	go func() {
		defer wg.Done()
		_, err = o.Raw("SELECT * FROM role LIMIT ?, ?;", offset, limit).QueryRows(&allRoles)
	}()
	wg.Wait()
	return
}

// 创建角色
func (s *PermissionService) CreateRole(role Role) (int64, error) {
	id, err := s.orm.Insert(role) // 要修改的对象和需要修改的字段
	return id, err
}

// 通过id修改角色
func (s *PermissionService) UpdateRole(role Role) (int64, error) {
	id, err := s.orm.Update(&role, "description", "permissions") // 要修改的对象和需要修改的字段
	return id, err
}

// 通过id删除角色
func (s *PermissionService) DeleteRole(id uint) (int64, error) {
	num, err := s.orm.Delete(&Role{Id: id})
	return num, err
}

func (s *PermissionService) GetUserGroupList() ([]UserRole, error) {
	var userGroups []UserRole
	//var userGroups []orm.Params//orm.Params是一个map类型
	num, err := s.orm.Raw("select * from user_group order by id desc;").QueryRows(&userGroups)
	if nil != err && num > 0 {
		return nil, err
	}
	return userGroups, nil
}

/**
 * 根据userid获取usergroup list
 */
func (s *PermissionService) GetGroupByUserId(userId int) ([]UserRole, error) {
	var userGroups []UserRole
	//var userGroups []orm.Params//orm.Params是一个map类型
	num, err := s.orm.Raw("select * from user_group where user_id = ?;", userId).QueryRows(&userGroups)
	if nil != err && num > 0 {
		return nil, err
	}
	return userGroups, nil
}
