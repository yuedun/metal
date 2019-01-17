package util

import (
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/astaxie/beego"
	"io/ioutil"
	"log"
	"net/http"
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
 * 生成密码
 */
func GeneratePassword(mobile string) string {
	b := []byte(mobile)
	p := b[7:]
	password := "hello" + string(p)
	return GetMD5(password)
}

// 淘宝api
// type IPBody struct {
// 	Code int
// 	Data struct {
// 		Ip         string
// 		Country    string
// 		Area       string
// 		Region     string
// 		City       string
// 		County     string
// 		Isp        string
// 		Country_id string
// 		area_id    string
// 		Region_id  string
// 		City_id    string
// 		County_id  string
// 		Isp_id     string
// 	}
// }
// 百度api
type IPBody struct {
	Address string
	Content struct {
		Address_detail struct {
			province string
			City string
            District string
            Dtreet string
            Atreet_number string
            City_code int
		}
		Address string
        Point struct {
            y float32
            x float32
        }
	}
	Status int
}

func GetIpGeography(ip string, objBody *IPBody) error {
	ipService := beego.AppConfig.String("ipService")
	res, err := http.Get(fmt.Sprintf(ipService, ip))
	if err != nil {
		beego.Error(err)
	}
	defer res.Body.Close()
	if res.StatusCode != 200 {
		beego.Error("请求地理位置错误: ", res.Status)
		return errors.New("请求地理位置错误：" + res.Status)
	} else {
		bodyByte, err := ioutil.ReadAll(res.Body)
		if err != nil {
			beego.Error("地理位置解析失败：", err)
		}
		json.Unmarshal(bodyByte, &objBody)
		return nil
	}
}
