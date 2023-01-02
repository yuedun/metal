package models

import "time"

// BaseModel 数据模型公共字段
type BaseModel struct {
	Id        uint      `json:"id" orm:"pk"`
	CreatedAt time.Time `json:"created_at" orm:"auto_now_add;type(datetime)"`
	UpdatedAt time.Time `json:"updated_at" orm:"auto_now;type(datetime)"`
}
