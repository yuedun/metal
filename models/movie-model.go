package models

import (
	"strconv"
	"strings"
	"sync"

	"github.com/beego/beego/v2/core/logs"

	"github.com/beego/beego/v2/client/orm"
)

type Movie struct {
	BaseModel
	Name          string `json:"name" orm:"size(50)"`
	URL           string `json:"url" orm:"column(url)"`
	Status        int    `json:"status"` //0:正常，1:禁用，2:有异常
	StatusComment string `json:"statusCommnet"`
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(Movie))
	// 如果使用 orm.QuerySeter 进行高级查询的话，这个是必须的。
	// 反之，如果只使用 Raw 查询和 map struct，是无需这一步的。
}

// 添加网站
func (mov *Movie) Save() (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	// 每次操作都需要新建一个Ormer变量，当然也可以全局设置
	// 需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Insert(mov)
}

// 获取单个网站
func (mov *Movie) MovieInfo() error {
	//	var o Ormer
	o := orm.NewOrm()
	// 每次操作都需要新建一个Ormer变量，当然也可以全局设置
	// 需要 切换数据库 和 事务处理 的话，不要使用全局保存的 Ormer 对象。
	return o.Read(mov)
}

func (mov *Movie) GetMovieList(cond string, start, perPage int) (list []Movie, total int64, err error) {
	o := orm.NewOrm()
	var condition = " WHERE 1 = 1 "
	if cond != "" {
		condition += "and name like '%" + cond + "%' "
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT * FROM movie "
		sql += condition
		sql += " order by status LIMIT ?, ?"
		_, err1 := o.Raw(sql, strconv.Itoa(start), strconv.Itoa(perPage)).QueryRows(&list)
		if err1 != nil {
			err = err1
		}
		for idx, v := range list {
			urls := strings.Split(v.URL, ",")
			list[idx].URL = urls[0]
		}
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM movie "
		sql += condition
		err1 := o.Raw(sql).QueryRow(&total)
		if err1 != nil {
			err = err1
		}
		logs.Debug("mysql row affected nums: ", total)
	}()
	wg.Wait()
	return list, total, err
}

// 通过id修改
func (mov *Movie) Update(cols []string) (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(mov, cols...) // 要修改的对象和需要修改的字段
	return id, err
}

// 通过id删除
func (mov *Movie) Delete() (int64, error) {
	o := orm.NewOrm()
	id, err := o.Delete(mov) // 要修改的对象和需要修改的字段
	if err != nil {
		return id, err
	} else {
		return id, nil
	}
}

func (mov *Movie) AllMovie() (list []Movie, err error) {
	o := orm.NewOrm()
	var sql = "SELECT * FROM movie;"
	_, err = o.Raw(sql).QueryRows(&list)
	if err != nil {
		return nil, err
	}
	return list, nil
}
