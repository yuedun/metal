package models

import (
	"strconv"
	"sync"

	"github.com/beego/beego/v2/core/logs"

	"github.com/beego/beego/v2/client/orm"
)

// type Movie struct {
// 	BaseModel
// 	Name          string `json:"name" orm:"size(50)"`
// 	URL           string `json:"urls" orm:"column(url)"`
// 	Status        int    `json:"status"` //0:正常，1:禁用，2:有异常
// 	StatusComment string `json:"statusCommnet"`
// }

type Movie struct {
	BaseModel
	Name          string      `json:"name" orm:"size(50)"`
	URLs          []*MovieUrl `json:"urls" orm:"reverse(many)"`
	Status        int         `json:"status"` //0:正常，1:禁用，2:有异常
	StatusComment string      `json:"statusCommnet"`
}
type MovieUrl struct {
	BaseModel
	Movie         *Movie `orm:"rel(fk)"` // RelForeignKey relation
	URL           string `json:"url" orm:"column(url)"`
	Status        int    `json:"status"` //0:正常，1:禁用，2:有异常
	StatusComment string `json:"statusCommnet"`
}

type MovieView struct {
	BaseModel
	Name          string `json:"name" orm:"size(50)"`
	URL           string `json:"url" orm:"column(url)"`
	Status        int    `json:"status"` //0:正常，1:禁用，2:有异常
	StatusComment string `json:"statusCommnet"`
}

func init() {
	// 需要在init中注册定义的model
	orm.RegisterModel(new(Movie), new(MovieUrl))
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
	o.Read(mov)
	o.Raw("select * from movie_url where movie_id = ?", mov.Id).QueryRows(&mov.URLs)
	mov.URLs = mov.URLs
	return nil
}

func (mov *Movie) GetMovieList(name, url string, start, perPage int) (list []MovieView, total int64, err error) {
	o := orm.NewOrm()
	var condition = " WHERE 1 = 1 "
	if name != "" {
		condition += "and name like '%" + name + "%' "
	}
	if url != "" {
		condition += "and url like '%" + url + "%' "
	}
	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		defer wg.Done()
		var sql = "SELECT movie_url.id, movie.name, movie_url.url, movie_url.status, movie_url.status_comment, movie_url.created_at,movie_url.updated_at FROM movie left join movie_url on movie.id = movie_url.movie_id "
		sql += condition
		sql += " order by movie_url.status, movie.created_at LIMIT ?, ?"
		_, err1 := o.Raw(sql, strconv.Itoa(start), strconv.Itoa(perPage)).QueryRows(&list)
		if err1 != nil {
			err = err1
		}
		// for idx, v := range list {
		// 	o.Raw("select * from movie_url where movie_id = ?", v.Id).QueryRows(&v.URLs)
		// 	list[idx].URLs = v.URLs
		// }
	}()
	go func() {
		defer wg.Done()
		var sql = "SELECT COUNT(0) FROM movie left join movie_url on movie.id = movie_url.movie_id "
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

func (mov *MovieUrl) Update(cols []string) (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(mov, cols...) // 要修改的对象和需要修改的字段
	return id, err
}

func (mov *MovieUrl) FindById() error {
	o := orm.NewOrm()
	return o.Read(mov)
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
	for idx, v := range list {
		o.Raw("select * from movie_url where movie_id = ?", v.Id).QueryRows(&v.URLs)
		list[idx].URLs = v.URLs
	}
	return list, nil
}
