package models

import "time"

type any = interface{}

//BaseModel 数据模型公共字段
type BaseModel struct {
	Id        uint      `json:"id"`
	CreatedAt time.Time `orm:"auto_now_add;type(datetime)" json:"created_at"`
	UpdatedAt time.Time `orm:"null" json:"updated_at"`
}
