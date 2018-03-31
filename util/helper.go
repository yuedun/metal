package util

import (
	"crypto/md5"
	"fmt"
)

/**
 * md5加密
 */
func GetMD5(password string) string {
	Md5Inst := md5.New()
	Md5Inst.Write([]byte(password))
	Result := Md5Inst.Sum([]byte(""))
	fmt.Sprintf(">>>>>>>%x\n\n", Result)
	return fmt.Sprintf("%x", Result)
}
