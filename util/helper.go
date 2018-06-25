package util

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"log"
)

/**
 * md5加密
 */
func GetMD5(password string) string {
	Md5Inst := md5.New()
	Md5Inst.Write([]byte(password))
	Result := Md5Inst.Sum(nil)
	// 以下两种输出结果一样
	log.Printf("格式化>>>>>>>%x\n", Result)
	log.Print("hex解码>>>>>>>", hex.EncodeToString(Result), "\n")
	return fmt.Sprintf("%x", Result)
}

/**
 * 生成秘密
 */
func GeneratePassword(mobile string) string {
	b := []byte(mobile)
	p := b[7:]
	password := "hello" + string(p)
	return GetMD5(password)
}
