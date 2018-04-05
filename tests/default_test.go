package test

import (
	"metal/util"

	"testing"
)

/**
  测试代码写法：格式：Test*()(t *testing.T)，可以使用t.Log()输出日志，要测试单个方法使用go test -v -run="TestOne|TestMd5"
 */
func TestMd5(t *testing.T){
	var p = util.GetMD5("ceshi")
	t.Log(p)
}

func TestOne(t *testing.T)  {

	t.Log(">>>>>>testone", util.GeneratePassword("18701897513"))
}