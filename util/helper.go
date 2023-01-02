package util

import (
	"bytes"
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"time"

	"github.com/beego/beego/v2/core/config"
	"github.com/beego/beego/v2/core/logs"
	"github.com/gomarkdown/markdown"
	"github.com/microcosm-cc/bluemonday"
	blackfriday "github.com/russross/blackfriday/v2"
)

/**
 * md5加密
 */
func GetMD5(password string) string {
	Md5Inst := md5.New()
	Md5Inst.Write([]byte(password))
	salt, err := config.String("salt")
	if err != nil {
		logs.Error("not found salt")
	}
	logs.Debug("salt", salt)
	Result := Md5Inst.Sum([]byte(salt))
	// 以下两种输出结果一样
	logs.Debug("格式化>>>>>>>%x\n", Result)
	logs.Debug("hex解码>>>>>>>", hex.EncodeToString(Result), "\n")
	return fmt.Sprintf("%x", Result)
}

/**
 * 生成密码
 */
func GeneratePassword(mobile string) string {
	b := []byte(mobile)
	p := b[7:]
	password := "metal" + string(p)
	return GetMD5(password)
}

// 淘宝api
//
//	type IPBody struct {
//		Code int
//		Data struct {
//			Ip         string
//			Country    string
//			Area       string
//			Region     string
//			City       string
//			County     string
//			Isp        string
//			Country_id string
//			area_id    string
//			Region_id  string
//			City_id    string
//			County_id  string
//			Isp_id     string
//		}
//	}
//
// 百度api
type IPBody struct {
	Address string
	Content struct {
		Address_detail struct {
			province      string
			City          string
			District      string
			Dtreet        string
			Atreet_number string
			City_code     int
		}
		Address string
		Point   struct {
			y float32
			x float32
		}
	}
	Status int
}

func GetIpGeography(ip string, objBody *IPBody) error {
	ipstr, _ := config.String("ipService")
	ipService := ipstr
	res, err := http.Get(fmt.Sprintf(ipService, ip))
	if err != nil {
		logs.Error(err)
	}
	defer res.Body.Close()
	if res.StatusCode != 200 {
		logs.Error("请求地理位置错误: ", res.Status)
		return errors.New("请求地理位置错误：" + res.Status)
	} else {
		bodyByte, err := io.ReadAll(res.Body)
		if err != nil {
			logs.Error("地理位置解析失败：", err)
		}
		json.Unmarshal(bodyByte, &objBody)
		return nil
	}
}

// markdown转html
func Md2html(in string) string {
	input := []byte(in)
	unsafe := blackfriday.Run(input, blackfriday.WithExtensions(blackfriday.CommonExtensions)) //支持表格，代码
	// htmlBytes := bluemonday.UGCPolicy().SanitizeBytes(unsafe)// 会class="language-xx"过滤掉
	html := string(unsafe)
	return html
}

// markdown转html v2
func Md2htmlV2(in string) string {
	input := []byte(in)
	unsafe := markdown.ToHTML(input, nil, nil)
	htmlBytes := bluemonday.UGCPolicy().SanitizeBytes(unsafe)
	html := string(htmlBytes)
	return html
}

func HttpGet(url string, s interface{}) (int, []byte, error) {
	logs.Info(url)
	buf := new(bytes.Buffer)
	if err := json.NewEncoder(buf).Encode(s); err != nil {
		return 0, nil, err
	}
	var cli = &http.Client{
		Timeout: time.Second * 300,
	}
	req, _ := http.NewRequest(http.MethodGet, url, buf)
	resp, err := cli.Do(req)
	if err != nil {
		return 0, nil, err
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return 0, nil, err
	}

	return resp.StatusCode, body, nil
}

func HttpPost(url string, s interface{}) (int, []byte, error) {
	buf := new(bytes.Buffer)
	if err := json.NewEncoder(buf).Encode(s); err != nil {
		return 0, nil, err
	}
	var cli = &http.Client{
		Timeout: time.Second * 300,
	}
	req, _ := http.NewRequest(http.MethodPost, url, buf)
	req.Header.Set("Content-Type", "application/json")
	resp, err := cli.Do(req)
	if err != nil {
		return 0, nil, err
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return 0, nil, err
	}

	return resp.StatusCode, body, nil
}
