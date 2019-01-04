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

