package models

import "time"

type BaseModel struct {
	Id          int
	CreatedAt   time.Time
	UpdatedAt   time.Time
}
