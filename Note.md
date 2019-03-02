# 学习笔记

`go build`和`go install`命令的区别：
go build会在执行该命令的目录下生成可执行文件，go install会在bin目录下生成可执行文件

## 其他说明

### 目录结构
在clone源码之前，首先在本地创建一个作为`GOPATH`的目录，比如：`mygopro`，mygopro下创建src目录，最后才在src目录下克隆项目代码，这么做的原因是src目录只存放源码，而gopath目录目录下会在项目启动或其他命令执行以后生成pkg和bin两个文件夹，这两个文件夹是不需要提交到git上的，每次命令执行都会生成。特别说明一下，beego的目录规则不太符合以上规则，它会直接在项目根目录下生成可执行文件，而不是在gopath的bin目录下。
### 环境安装说明(系统变量和用户变量都可以)
* 系统变量中配置GOROOT=【GO的安装目录】
* 在系统变量中配置GOPATH=项目根目录（是指mygopro，而不是src下的项目）
* 在系统变量中配置GOBIN，命令行中执行`go install`会在GOPATH/bin目录下生成可执行文件
* 在系统变量Path中追加%GOBIN%，作用是执行第三方命令，比如beego会在该目录下安装bee命令

### 指针类型 &和\*说明：
```go
package main

import "fmt"

func main() {
   var a int= 20   /* 声明实际变量 */
   var ip *int        /* 声明指针变量 */

   ip = &a  /* 指针变量的存储地址 */

   fmt.Printf("a 变量的地址是: %x\n", &a  )

   /* 指针变量的存储地址 */
   fmt.Printf("ip 变量的存储地址: %x\n", ip )

   /* 使用指针访问值 */
   fmt.Printf("*ip 变量的值: %d\n", *ip )
}
```
>以上实例执行输出结果为：
a 变量的地址是: 20818a220
ip 变量的存储地址: 20818a220
\*ip 变量的值: 20

先简单说明一下，&是取一个变量的内存地址，\*会取得实际值，\*<变量名>=&<变量名>

### 再看一段代码

* 网络摘录
先放一段代码，人工运行一下，看看自己能做对几题？
```go
package main

import "fmt"

func main() {
    var a int = 1 
    var b *int = &a
    var c **int = &b
    var x int = *b
    fmt.Println("a = ",a)
    fmt.Println("&a = ",&a)
    fmt.Println("*&a = ",*&a)
    fmt.Println("b = ",b)
    fmt.Println("&b = ",&b)
    fmt.Println("*&b = ",*&b)
    fmt.Println("*b = ",*b)
    fmt.Println("c = ",c)
    fmt.Println("*c = ",*c)
    fmt.Println("&c = ",&c)
    fmt.Println("*&c = ",*&c)
    fmt.Println("**c = ",**c)
    fmt.Println("***&*&*&*&c = ",***&*&*&*&*&c)
    fmt.Println("x = ",x)
}
```

#### 解释

##### 理论

&符号的意思是对变量取地址，如：变量a的地址是&a
\*符号的意思是对指针取值，如:\*&a，就是a变量所在地址的值，当然也就是a的值了

##### 简单的解释

\*和 & 可以互相抵消,同时注意，\*&可以抵消掉，但&\*是不可以抵消的
a和\*&a是一样的，都是a的值，值为1 (因为\*&互相抵消掉了)
同理，a和\*&\*&\*&\*&a是一样的，都是1 (因为4个\*&互相抵消掉了)

##### 展开

因为有
```go
var b *int = &a
```
所以
a和\*&a和\*b是一样的，都是a的值，值为1 (把b当做&a看)

##### 再次展开

因为有
```go
var c **int = &b
```
所以
\*\*c和\*\*&b是一样的，把&约去后
会发现**c和\`b是一样的 (从这里也不难看出，c和b也是一样的) 又因为上面得到的&a和b是一样的 所以\*\*c和&a是一样的，再次把\*&约去后\*\*c和a`是一样的，都是1
不信你试试？
##### 公布结果
运行的结果内的地址值（0xc200开头的）可能会因不同机器运行而不同，你懂的
```text
$ go run main.go 
a     =     1
&a     =     0xc200000018
*&a     =     1
b     =     0xc200000018
&b     =     0xc200000020
*&b     =     0xc200000018
*b     =     1
c     =     0xc200000020
*c     =     0xc200000018
&c     =     0xc200000028
*&c     =     0xc200000020
**c     =     1
***&*&*&*&c     =     1
x     =     1
```
##### 两个符号抵消顺序
\*&可以在任何时间抵消掉，但&\*不可以被抵消的，因为顺序不对
```go
fmt.Println("*&a\t=\t",*&a)  //成功抵消掉，打印出1，即a的值
fmt.Println("&*a\t=\t",&*a)  //无法抵消，会报错
```
[原文地址](http://my.oschina.net/u/943306/blog/131269)
*ip 变量的值: 20
先简单说明一下，&是取一个变量的内存地址，*会取得实际值，*<变量名>=&<变量名>
## struct和interface的区别
struct定义数据结构，interface定义函数集合。
可以在struct上定义函数：
```go
type User struct {
  Name string
}
func (this *User) GetName(){
}
```
将GetName函数挂载到User上。interface是定义了一系列函数签名，没有具体实现，如果一个数据结构（struct）实现了这些函数，则实现了继承。

以下SQL在mysql5.7.5以上版本会报错：
```sql
SELECT job_title, ROUND(AVG(amount)) AS amount, DATE_FORMAT(CONCAT( YEAR (created_at), '-', MONTH (created_at), '-01'), '%Y-%m-%d') AS created_at FROM job_count WHERE job_title = 'golang' GROUP BY YEAR (created_at), MONTH (created_at);
```
```
- Error 1055: Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'issue.job_count.created_at' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
```
解决方法：

修改/etc/mysql/mysql.conf.d/mysqld.cnf
```
[mysqld]
sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
```

```shell
$ git checkout master
 is not a valid attribute name: .gitattributes:1
 is not a valid attribute name: .gitattributes:2
 is not a valid attribute name: .gitattributes:3
```
解决方案：
`*.css linguist-language = go`改成`*.css linguist-language=go`,去掉=号左右的空格