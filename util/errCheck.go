package util

import "github.com/astaxie/beego/logs"

func ErrCheck(err error) {
	if err != nil {
		logs.Info(err)
	}
}
