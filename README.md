# 项目说明
![后台模板](http://hopefully-img.yuedun.wang/adminlte.png)

## 项目启动

- 该项目包含数据库文件，请自行创建`issue`数据库，执行`issue.sql`数据脚本导入数据。
- 复制`conf/app-sample.conf`文件并重命名为`app.conf`

`go get`安装所需依赖

`go get -u github.com/beego/bee`安装beego命令行工具

执行`bee run`如果未找到bee命令，在系统变量Path中追加%GOBIN%，作用是执行第三方命令，比如beego会在该目录下安装bee命令

`go build`和`go install`命令的区别：
go build会在执行该命令的目录下生成可执行文件，go install会在bin目录下生成可执行文件

```bash
> cd %GOPATH%/src
> cd metal
> bee run
```
**生产环境启动**
> ./run

## 守护进程
单纯的启动以后，程序的稳定性很差，任何一个错误都会导致进程退出。所以需要守护进程来保证程序退出后自动重启，beego官网有提供一些方法[https://beego.me/docs/deploy/](https://beego.me/docs/deploy/)，但在此我提供另一种方式，nodejs开发者应该很熟悉了，就是大名鼎鼎的**pm2**，没想到pm2也可以作为golang的守护进程。如果已经安装了pm2可以直接使用。

首次启动服务：
> pm2 start metal

`run-by-pm2.sh`是编写好的脚本文件，用于重启服务，具体过程是代码更新后编译>杀进程>pm2自动重启。因为pm2监听到进程退出后会自动重启，所以此处不需要手动重启。
> ./run-by-pm2.sh

启动方法和nodejs一样简单。如果没有安装过pm2那建议还是使用**Supervisord**，毕竟安装nodejs也是个技术活。

## 交叉编译
一般开发环境是windows或mac，但是服务器是linux，如果直接在服务器上拉取git代码进行编译可能会出现问题，比如开发时新引用了第三方包，国内的网络环境不便于使用第三方包，在服务器上可能get不到这些包。所以最好是在本地打包上传到服务器，那么就需要交叉编译（在window上打包为linux应用）
```shell
GOOS=linux GOARCH=amd64 go build
```
这个命令会生成一个linux可执行程序。然后上传到服务器即可。