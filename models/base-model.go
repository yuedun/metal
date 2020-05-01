package models

import "time"

type any = interface{}

//BaseModel 数据模型公共字段
type BaseModel struct {
	Id        uint      `json:"id"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}
