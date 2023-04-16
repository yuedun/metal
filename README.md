# 项目说明
![前台模板](https://hopefully-img.yuedun.wang/c1ba1907e36a3440dad489c99ca53f11?imageslim "前台模板")
![后台模板](https://hopefully-img.yuedun.wang/adminlte.png?imageslim "后台模板")

## go版本要求
本项目使用了`go 1.16`，`beego v2`, `bee v2`。
```sh
go get -u github.com/beego/beego/v2
go get -u github.com/beego/bee/v2
```
## 项目启动
复制`conf/app-sample.conf`文件并重命名为`app.conf`，数据库配置为必要配置。

`go get`安装所需依赖，默认的代理可能不能顺利安装，可设置国内代理  
linux:`go env -w GOPROXY=https://goproxy.cn,direct`  
windows:`$env:GOPROXY = "https://goproxy.cn"`

执行`bee run`如果未找到bee命令，在系统变量Path中追加%GOBIN%，作用是执行第三方命令，比如beego会在该目录下安装bee命令

```bash
> cd metal
> bee run
```

**注意**
1. 编译后的可执行文件和普通项目有点不一样，还需要依赖go运行坏境，所以还要在服务器上安装go。
2. 由于前后端是一体的，所以还需要前端文件，最好的方式是服务器上通过git拉项目，然后编译运行。

## 交叉编译
一般开发环境是windows或mac，但是服务器是linux，如果直接在服务器上拉取git代码进行编译可能会出现问题，比如开发时新引用了第三方包，国内的网络环境不便于使用第三方包，在服务器上可能get不到这些包。所以最好是在本地打包上传到服务器，那么就需要交叉编译（在window上打包为linux应用）
```shell
GOOS=linux GOARCH=amd64 go build
```
这个命令会生成一个linux可执行程序。然后上传到服务器即可。

## 测试
进入到有测试文件的目录执行`go test`可测试所有测试函数，如只需测试指定的函数。
`go test -v -run="Redis"`

## 项目结构说明
本项目使用了MVC结构。

## 权限设计
基于角色的访问控制方法（RBAC）,目前只是简单的使用用户和角色，每个角色可以有一个权限，也可以有多个权限，所以赋值角色即分配了权限。
比如：删除用户，既是角色，也是权限。

项目初始化：将issue.sql中的数据导入到数据库则可以使用管理员权限使用全部功能。

[图标库](https://iconpark.oceanengine.com/official)
[beego](https://beego.gocn.vip/beego/zh/developing/)
[七牛图片处理](https://developer.qiniu.com/dora/1279/basic-processing-images-imageview2)
[后台模板](https://adminlte.io/themes/AdminLTE/index2.html#)
[layer](https://layui.gitee.io/v2/demo/layer.html)