package models

import "time"

type any = interface{}

type BaseModel struct {
	Id        uint
	CreatedAt time.Time
	UpdatedAt time.Time
}
