package util

import (
	"crypto/md5"
	"fmt"
	"io"
)

/**
 * md5加密，未实现
 */
func GetMD5(password string) {
	h := md5.New()
	io.WriteString(h, "The fog is getting thicker!")
	fmt.Printf("%x", h.Sum(nil))
	return
}
