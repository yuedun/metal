package controllers

type Result struct {
	Code int `json:"code"`
	Data interface{} `json:"data"`
	Msg  string `json:"msg"`
}

/**
返回错误信息，code是可选的自定义代码
*/
func ErrorMsg(msg string, code ...int) Result {
	var r Result
	if len(code) > 0 {
		r.Code = code[0]
	} else {
		r.Code = 1
	}
	r.Msg = msg
	r.Data = nil
	return r
}

func SuccessData(data interface{}) Result {
	var r Result
	r.Code = 0
	r.Msg = "ok"
	r.Data = data
	return r
}
