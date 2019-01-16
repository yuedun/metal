package util

import (
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
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

type IPBody struct {
	Code int
	Data struct {
		Ip         string
		Country    string
		Area       string
		Region     string
		City       string
		County     string
		Isp        string
		Country_id string
		area_id    string
		Region_id  string
		City_id    string
		County_id  string
		Isp_id     string
	}
}

func GetIpGeography(ip string, objBody *IPBody) {
	ipService := beego.AppConfig.String("ipService")
	res, err := http.Get(fmt.Sprintf(ipService, ip))
	if err != nil {
		log.Fatal(err)
	}
	defer res.Body.Close()
	if res.StatusCode != 200 {
		log.Fatalf("status code error: %d %s", res.StatusCode, res.Status)
	} else {
		log.Println("请求成功")
		bodyByte, err := ioutil.ReadAll(res.Body)
		if err != nil {
			log.Fatal(err)
		}
		json.Unmarshal(bodyByte, &objBody)
	}
}
