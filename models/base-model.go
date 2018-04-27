package models

import "time"

type any = interface{}

type BaseModel struct {
	Id          int
	CreatedAt   time.Time
	UpdatedAt   time.Time
}
