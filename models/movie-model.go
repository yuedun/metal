package models

import (
	"sync"

	"github.com/beego/beego/v2/core/logs"

	"github.com/beego/beego/v2/client/orm"
)

type Movie struct {
	BaseModel
	Name          string      `json:"name" orm:"size(50)"`
	URLs          []*MovieUrl `json:"urls" orm:"-"`
	Status        int         `json:"-"`
	StatusComment string      `json:"-"`
}
type MovieUrl struct {
	BaseModel
	MovieId       uint   `json:"-" orm:"column(movie_id)"`
	URL           string `json:"url" orm:"column(url)"`
	Status        int    `json:"status"` //0:正常，1:禁用，2:有异常
	StatusComment string `json:"statusCommnet"`
}

// 视图结构体
type MovieVO struct {
	Id     uint   `json:"id"`
	Name   string `json:"name"`
	Movies []MovieUrl
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

// 添加网站
func (mov *Movie) SaveUrls(urls []string) (int64, error) {
	//	var o Ormer
	o := orm.NewOrm()
	murls := []MovieUrl{}
	for _, v := range urls {
		murls = append(murls, MovieUrl{MovieId: mov.Id, URL: v})
	}
	return o.InsertMulti(len(murls), murls)
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

func (mov *Movie) GetMovieList(name, url string, start, perPage int) (list []Movie, total int64, err error) {
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
		var sql = "SELECT movie.id, movie.name FROM movie "
		sql += condition
		sql += " order by movie.created_at LIMIT ?, ?"
		_, err1 := o.Raw(sql, start, perPage).QueryRows(&list)
		if err1 != nil {
			err = err1
		}
		movieIds := []uint{}
		for _, v := range list {
			movieIds = append(movieIds, v.Id)
		}
		list2 := []MovieUrl{}
		qs := "select * from movie_url where movie_id IN ("
		for i, _ := range movieIds {
			if i > 0 {
				qs += ","
			}
			qs += "?"
		}
		qs += ")"
		if _, err1 := o.Raw(qs, movieIds).QueryRows(&list2); err != nil {
			err = err1
		}
		movieMap := make(map[uint][]*MovieUrl)
		for i := 0; i < len(list2); i++ {
			movieMap[list2[i].MovieId] = append(movieMap[list2[i].MovieId], &list2[i])
		}
		for idx, v := range list {
			list[idx].Id = v.Id
			list[idx].Name = v.Name
			if _, ok := movieMap[v.Id]; ok {
				list[idx].URLs = movieMap[v.Id]
			} else {
				list[idx].URLs = []*MovieUrl{}
			}
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
