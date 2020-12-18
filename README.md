# 项目说明
![后台模板](http://hopefully-img.yuedun.wang/adminlte.png)

## go版本要求
本项目使用了`go 1.15`，`beego v1.12.3`。

## 项目启动

- 该项目包含数据库文件，请自行创建`issue`数据库，执行`issue.sql`数据脚本导入数据。
- 复制`conf/app-sample.conf`文件并重命名为`app.conf`

`go get`安装所需依赖，默认的代理可能不能顺利安装，可设置国内代理
linux:`go env -w GOPROXY=https://goproxy.cn,direct`
windows:`$env:GOPROXY = "https://goproxy.cn"`

`go get -u github.com/beego/bee`安装beego命令行工具

执行`bee run`如果未找到bee命令，在系统变量Path中追加%GOBIN%，作用是执行第三方命令，比如beego会在该目录下安装bee命令

```bash
> cd %GOPATH%/src
> cd metal
> bee run
```
**生产环境启动**
> ./run.sh
脚本内容需要自身需求编写，我的发布流程并不一定适合你。
## 守护进程
单纯的启动以后，程序的稳定性很差，任何一个错误都会导致进程退出。所以需要守护进程来保证程序退出后自动重启，beego官网有提供一些方法[https://beego.me/docs/deploy/](https://beego.me/docs/deploy/)，但在此我提供另一种方式，nodejs开发者应该很熟悉了，就是大名鼎鼎的**pm2**，如果已经安装了pm2可以直接使用。

首次启动服务：
> pm2 start metal

`run-by-pm2.sh`是编写好的脚本文件，用于删除服务器可执行文件，上传新应用文件，修改执行权限，重启pm2服务。
> ./run-by-pm2.sh

启动方法和nodejs一样简单。如果没有安装过pm2那建议还是使用**Supervisord**，毕竟安装nodejs也是个技术活。

## 交叉编译
一般开发环境是windows或mac，但是服务器是linux，如果直接在服务器上拉取git代码进行编译可能会出现问题，比如开发时新引用了第三方包，国内的网络环境不便于使用第三方包，在服务器上可能get不到这些包。所以最好是在本地打包上传到服务器，那么就需要交叉编译（在window上打包为linux应用）
```shell
GOOS=linux GOARCH=amd64 go build
```
这个命令会生成一个linux可执行程序。然后上传到服务器即可。
其实在windows环境下进行交叉编译生成linux可执行程序后就可以不用`run`和`run-by-pm2`两个脚本了，因为交叉编译后的可执行文件直接上传到服务器就可以使用了，不需要在服务器上编译，也不需要安装golang和依赖。
需要的只是重启一下服务即可。

## 测试
进入到有测试文件的目录执行`go test`可测试所有测试函数，如只需测试指定的函数`go test -v -run="Redis"`

## 项目结构说明
由于本项目较简单，所以对项目目录结构没有严格要求，尤其是没有service层，而是将一些逻辑放到了model里，当初主要是觉得go的model层不像java，一个model文件中有大量的getter,setter方法，导致每个model变的很大，
所以java喜欢对每种文件做分类。而go的model相对来说就很简单了，只是一个简单的struct，单独作为一层会显得多余，就决定把一些函数放到model中，可以直接通过model调用相关函数。go和java还是有很大的区别，如果还是用老的一套会显得繁琐和鸡肋。

## 权限设计
基于角色的访问控制方法（RBAC）,目前只是简单的使用用户和角色，每个角色可以有一个权限，也可以有多个权限，所以赋值角色即分配了权限。
比如：删除用户，既是角色，也是权限。