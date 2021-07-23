package util

import "github.com/beego/beego/v2/core/logs"

func ErrCheck(err error) {
	if err != nil {
		logs.Info(err)
	}
}
