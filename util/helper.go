package util

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
)

/**
 * md5加密
 */
func GetMD5(password string) string {
	Md5Inst := md5.New()
	Md5Inst.Write([]byte(password))
	Result := Md5Inst.Sum(nil)
	// 以下两种输出结果一样
	fmt.Printf(">>>>>>>%x\n\n", Result)
	fmt.Println(">>>>>>>", hex.EncodeToString(Result))
	return fmt.Sprintf("%x", Result)
}

/**
 * 生成秘密
 */
func GeneratePassword(mobile string) string {
	b := []byte(mobile)
	p := b[7:]
	password := "hello" + string(p)
	return  GetMD5(password)
}