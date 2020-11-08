/*
Navicat MySQL Data Transfer

Source Server         : alimysql
Source Server Version : 50723
Source Host           : 112.74.171.94:3306
Source Database       : issue

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2020-07-30 10:43:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `keywords` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', 'Go语言优势', '', '', '### 一、部署简单。\nGo 编译生成的是一个静态可执行文件，除了 glibc 外没有其他外部依赖。这让部署变得异常方便：目标机器上只需要一个基础的系统和必要的管理、\n监控工具，完全不需要操心应用所需的各种包、库的依赖关系，大大减轻了维护的负担。这和 Python 有着巨大的区别。由于历史的原因，\nPython 的部署工具生态相当混乱【比如 setuptools, distutils, pip, buildout 的不同适用场合以及兼容性问题】。官方 PyPI 源又经常出问题，\n需要搭建私有镜像，而维护这个镜像又要花费不少时间和精力。\n### 二、并发性好。\nGoroutine 和 channel 使得编写高并发的服务端软件变得相当容易，很多情况下完全不需要考虑锁机制以及由此带来的各种问题。单个 Go 应用也能有效的利用多个 CPU 核，并行执行的性能好。这和 Python 也是天壤之比。多线程和多进程的服务端程序编写起来并不简单，而且由于全局锁 GIL 的原因，多线程的 Python 程序并不能有效利用多核，只能用多进程的方式部署；如果用标准库里的 multiprocessing 包又会对监控和管理造成不少的挑战【我们用的 supervisor 管理进程，对 fork 支持不好】。部署 Python 应用的时候通常是每个 CPU 核部署一个应用，这会造成不少资源的浪费，比如假设某个 Python 应用启动后需要占用 100MB 内存，而服务器有 32 个 CPU 核，那么留一个核给系统、运行 31 个应用副本就要浪费 3GB 的内存资源。\n### 三、良好的语言设计。\n从学术的角度讲 Go 语言其实非常平庸，不支持许多高级的语言特性；但从工程的角度讲，Go 的设计是非常优秀的：规范足够简单灵活，有其他语言基础的程序员都能迅速上手。更重要的是 Go 自带完善的工具链，大大提高了团队协作的一致性。比如 gofmt 自动排版 Go 代码，很大程度上杜绝了不同人写的代码排版风格不一致的问题。把编辑器配置成在编辑存档的时候自动运行 gofmt，这样在编写代码的时候可以随意摆放位置，存档的时候自动变成正确排版的代码。此外还有 gofix, govet 等非常有用的工具。\n### 四、执行性能好。\n虽然不如 C 和 Java，但通常比原生 Python 应用还是高一个数量级的，适合编写一些瓶颈业务。内存占用也非常省。', '1', '2018-10-24 11:42:33', '2020-07-21 18:05:16');
INSERT INTO `article` VALUES ('2', '各平台mysql重启', '', '', 'linux平台及windows平台mysql重启方法\n\n　　Linux下重启MySQL的正确方法：\n\n　　1、通过rpm包安装的MySQL\n\n　　service mysqld restart\n\n　　2、从源码包安装的MySQL\n\n　　// linux关闭MySQL的命令\n\n　　$mysql_dir/bin/mysqladmin -uroot -p shutdown\n\n　　// linux启动MySQL的命令\n\n　　$mysql_dir/bin/mysqld_safe &\n\n　　其中mysql_dir为MySQL的安装目录，mysqladmin和mysqld_safe位于MySQL安装目录的bin目录下，很容易找到的。\n\n　　3、以上方法都无效的时候，可以通过强行命令：“killall mysql”来关闭MySQL，但是不建议用这样的方式，因为这种野蛮的方法会强行终止MySQL数据库服务，有可能导致表损坏\n\n　　步骤或方法:RedHat Linux (Fedora Core/Cent OS)\n\n　　1.启动：/etc/init.d/mysqld start\n\n　　2.停止：/etc/init.d/mysqld stop\n\n　　3.重启：/etc/init.d/mysqld restart\n\n　　Debian / Ubuntu Linux\n\n　　1.启动：/etc/init.d/mysql start\n\n　　2.停止：/etc/init.d/mysql stop\n\n　　3.重启：/etc/init.d/mysql restart\n\n　　Windows\n\n　　1.点击“开始”->“运行”(快捷键Win+R)。\n\n　　2.启动：输入 net stop mysql\n\n　　3.停止：输入 net start mysql\n\n　　提示* Redhat Linux 也支持service command，启动：# service mysqld start 停止：# service mysqld stop 重启：# service mysqld restart\n\n　　* Windows下不能直接重启(restart)，只能先停止，再启动。\n\n　　MySQL启动，停止，重启方法：\n\n　　一、启动方式\n\n　　1、使用 service 启动：service mysqld start\n\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld start\n\n　　3、使用 safe_mysqld 启动：safe_mysqld&\n\n　　二、停止\n\n　　1、使用 service 启动：service mysqld stop\n\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld stop\n\n　　3、mysqladmin shutdown\n\n　　三、重启\n\n　　1、使用 service 启动：service mysqld restart\n\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld restart', '1', '2018-10-11 16:47:02', '2020-01-17 20:06:04');
INSERT INTO `article` VALUES ('6', '说道说道前后端分离 ', '', '', '\n要说前端界的发展速度，那真是快！\n\n2012年那时候接触过extjs，用于企业级后台开发还真不错，有好看的UI界面，组件丰富，基本能满足各类需求。但此时，HTML5正在蓬勃发展，尤其是乔布斯宣布苹果设备不支持flash后HTML5发展更是迅猛。并且angularjs这类MVVM框架被大多数所知，reactjs,vuejs如雨后春笋般生长。\n\n2014年使用了一段时间angularjs，感觉学习难度有点大，2015年使用vue1.0做了一个项目后我逢人就说angular，vue有多好用，推荐他们放弃jquery使用vue。不到2年时间再看看前端界，vue，react等框架已经是前端开发标配，如果你说公司项目还在使用jquery会被人笑话，对于前端新人MVVM框架是必学，jquery反而不会重视。\n\n这就导致一个结果：“手里拿着锤子，看什么都是钉子”，因为有锤子的关系，遇到任何问题，都会先想如何用锤子解决。久而久之，陷入了一种思维定式。任何工具带来便利的同时，也带来了局限性。而这往往是用锤子的人很难看到的。就拿一个需要SEO的网站来说，该选择哪种技术好？如果只会vue，不熟悉jquery的人来说肯定是选择vue，就算vue不太适合做这类网站，也会拿出ssr来强行做事。殊不知需要SEO的网站使用静态文件是最合适的。大多数人认为前后端分离是使用vue，react，angular，使用jquery的不叫前后端分离，这完全是搞混了概念，实际上后端的controller层也属于视图层，也可以归属于前端。\n\n现在去网上一搜，问一下身边的人怎么看待前后端分离的，大多数人秉持着支持的态度，认为前后端分离好处多多，列举几条：\n\n- 专业的人做专业的事\n- 前后并行开发，效率高\n- 前端工程化，组件化\n- 解耦\n- 降低了开发学习难度\n\n![](http://hopefully-img.yuedun.wang/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20180805104325.jpg)\n\n等等……\n\n大家说的都说到点上了，这也是前后端分离能发展起来的驱动力。但是道理说的都挺好，如果不结合实际情况的话就是大炮打蚊子，不但达不到理想的效果还浪费资源。而且前后端分离带来的负面情况也不可忽视：\n\n- 增加了沟通成本，一些前后端都可以做又都不想做的事或许只能由权利大的来决定。\n- 一般前端开发速度会比后端快，在接口没开发好时前端只能闲等着。也有反过来的情况。前后端分离也意味着任务关联性减弱，可能不是同时开发，需要一方催着一方来完成。\n- 跨域问题导致联调困难，前端只能等待接口开发上了服务器才能调试。\n- 职责分离后确认职责也困难，一个问题出现到底是谁的问题？谁解决？\n- 一个需求需要前后端开发同时参与理解需求，有理解偏差问题。\n- 小公司多一个人多一份支出。\n\n那么到底该不该进行前后端分离，如何进行技术选型？这需要根据一些实际情况来决定，大体判断准则有以下几点：\n\n- 后台系统采用前后端分离比较合适。\n- 需要SEO引流的就不要强行前后端分离了，react，vue的服务端渲染也很勉强，徒增开发难度而已。\n- 数据交互比较多的使用前后端分离，操作数据比jquery方便。\n- 页面本身特别简单，只负责简单数据展示，要求打开速度，直接服务端渲染即可。这种页面本身就是单页面，如果还要使用框架就是多此一举，增加页面负担，增加开发调试难度。\n- 开发资源充足最好前后端分离，开发资源不足时不分离，一人包揽前后台端反而更快。\n\n最后，前后端分离是一个趋势，但不是必须。更准确的说法应该叫做“前后端分工”，毕竟在5年前这些活都是一个开发来做的，因为技术复杂性提升，前端不想只是切图，后端不想学变化太快的前端就出现了分离。你可以想象测试的工作，现在的测试大多还是测业务，但是也出现了一个自动化测试的职位，因为测试不想天天鼠标点呀点的测，想搞点高深的东西，而开发又特别烦写单元测试代码，这就又出现分离。再者，数据库也是一样，所以出现了DBA这个角色。谁知哪一天又会合起来呢！\n', '1', '2019-03-01 14:21:34', '2020-07-22 13:42:28');
INSERT INTO `article` VALUES ('7', '使用pm2作为golang的守护进程', '', '', '开发过nodejs的人对于pm2再熟悉不过了，而pm2不止可以作为nodejs的守护进程，\n\n同样可以用在golang上，使用方法同样很简单：\n\n> pm2 start bin\n\n直接启动go二进制文件即可。\n\n[https://pm2.keymetrics.io/docs/usage/pm2-doc-single-page/](https://pm2.keymetrics.io/docs/usage/pm2-doc-single-page/#start-an-app)', '1', '2019-01-16 17:18:42', '2020-07-21 14:43:01');
INSERT INTO `article` VALUES ('9', 'go语言开发grpc——安装grpc', '', '', '### 一、安装gRPC\n> $ go get -u google.golang.org/grpc\n\n```sehll\npackage google.golang.org/grpc: unrecognized import path \"google.golang.org/grpc\" (https fetch: Get https://google.golang.org/grpc?go-get=1: dial tcp 216.239.37.1:443: connectex: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.)\n```\ngrpc的源码库迁移到了github上，所以需要手动下载了。[grpc-go](https://github.com/grpc/grpc-go)\n正常情况下按照以下方式就可安装完成\n```shell\ngit clone https://github.com/grpc/grpc-go.git $GOPATH/src/google.golang.org/grpc`\n\ngit clone https://github.com/golang/net.git $GOPATH/src/golang.org/x/net`\n\ngit clone https://github.com/golang/text.git $GOPATH/src/golang.org/x/text\n\ngo get -u github.com/golang/protobuf/{proto,protoc-gen-go}\n\ngit clone https://github.com/google/go-genproto.git $GOPATH/src/google.golang.org/genproto\n\ncd $GOPATH/src/\n\ngo install google.golang.org/grpc\n```\n但是在某些情况可能连`git clone`都不行。就像下面这样的：\n```\n$  git clone https://github.com/google/go-genproto.git $GOPATH/src/google.golang.org/genproto\nCloning into \'E:\\go-work/src/google.golang.org/genproto\'...\nfatal: unable to access \'https://github.com/google/go-genproto.git/\': OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to github.com:443\n```\n这种情况自带梯子可以，如果没有梯子不能通过`git clone`的话就download吧！\n```\n$ git clone https://github.com/grpc/grpc-go.git grpc\n\nCloning into \'grpc\'...\nfatal: unable to access \'https://github.com/grpc/grpc-go.git/\': OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to github.com:443\n```\n虽然grpc源码迁到了github上，但是包名并未随着修改，使用的还是**google.golang.org**，所以需要在src目录下新建google.golang.org目录，并把下载的grpc-go-master.zip解压到google.golang.org目录下，重命名为**grpc**\ngrpc包依赖[genproto](https://github.com/google/go-genproto)，下载解压后放在grpc同级目录，报名重命名为**genproto**\n`git clone https://github.com/golang/net.git $GOPATH/src/golang.org/x/net`\n\n`git clone https://github.com/golang/text.git $GOPATH/src/golang.org/x/text`\n\n### 二、安装protoc编译器\n从[protobuf](https://github.com/google/protobuf/releases)下载对应平台的编译器： protoc-&lt;version&gt;-&lt;platform&gt;.zip\n比如我下载文件名为：**protoc-3.7.0-rc-2-win64.zip**，解压后的目录为：\n```\nE:.\n│  readme.txt\n│\n├─bin\n│      protoc.exe\n│\n└─include\n    └─google\n        └─protobuf\n            │  any.proto\n            │  api.proto\n            │  descriptor.proto\n            │  duration.proto\n            │  empty.proto\n            │  field_mask.proto\n            │  source_context.proto\n            │  struct.proto\n            │  timestamp.proto\n            │  type.proto\n            │  wrappers.proto\n            │\n            └─compiler\n                    plugin.proto\n```\n复制protoc.exe文件到GOPATH的bin目录下。这时就可以执行**protoc**命令了\n```\n$ protoc.exe -h\nUsage: E:\\go-work\\bin\\protoc.exe [OPTION] PROTO_FILES\nParse PROTO_FILES and generate output based on the options given:\n  -IPATH, --proto_path=PATH   Specify the directory in which to search for imports.  May be specified multiple times;\n```\n但是还需要安装**protoc-gen-go**插件，可以产生go相关代码， 除上述序列化和反序列化代码之外， 还增加了一些通信公共库。\n`$ go get -u github.com/golang/protobuf/protoc-gen-go`\n还是不能正常下载的话，那就老办法，手动下载[>protoc-gen-go]https://github.com/golang/protobuf)\n解压后将**protoc-gen-go**目录复制到src/github.com/目录下。\n`$ cd protoc-gen-go`\n`$ go install`\n会在$GOPATH/bin目录下生成protoc-gen-go文件。\n到此，go语言开发grpc所需的工具已经安装完成。\n', '1', '2019-02-15 18:00:55', '2020-07-22 13:37:14');
INSERT INTO `article` VALUES ('11', '网站接入代码高亮', '', '', '### highlight.js\n使用bower安装的起了一半作用，有背景色，具体代码没有高亮，手动下载的可以', '1', '2019-02-20 12:19:06', '2019-02-20 12:19:07');
INSERT INTO `article` VALUES ('13', 'go如何进行交叉编译', '', '', '# golang交叉编译\n## 问题\ngolang如何在一个平台编译另外一个平台可以执行的文件。比如在mac上编译Windows和linux可以执行的文件。那么我们的问题就设定成：如何在mac上编译64位linux的可执行文件。\n### 解决方案\ngolang的交叉编译要保证golang版本在1.5以上，本解决方案实例代码1.9版本执行的。\n我们想要编译的文件hello.go\nhello.go\n```go\npackage main\n\nimport \"fmt\"\n\nfunc main() {\n    fmt.Printf(\"hello, world\\n\")\n}\n```\n在mac上编译64位linux的命令编译命令\nbash:\n```shell\nGOOS=linux GOARCH=amd64 go build hello.go\n```\n上面这段代码直接在命令控制台里面运行就可以生成64位linux的可执行程序。\n参数解析\n这里用到了两个变量：\n\nGOOS：目标操作系统\nGOARCH：目标操作系统的架构\n\nOS|ARCH|OS version\n--|----|---------\nlinux|386 / amd64 / arm|>= Linux 2.6\ndarwin|386 / amd64|OS X (Snow Leopard + Lion)\nfreebsd|386 / amd64|>= FreeBSD 7\nwindows|386 / amd64|>= Windows 2000\n\n编译其他平台的时候根据上面表格参数执行编译就可以了。\n扩展阅读\n在网络上的诸多教程中可能会看到下面的编译命令\n```shell\nCGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build hello.go\n```\n其中CGO_ENABLED=0的意思是使用C语言版本的GO编译器，参数配置为0的时候就关闭C语言版本的编译器了。自从golang1.5以后go就使用go语言编译器进行编译了。在golang1.9当中没有使用CGO_ENABLED参数发现依然可以正常编译。当然使用了也可以正常编译。比如把CGO_ENABLED参数设置成1，即在编译的过程当中使用CGO编译器，我发现依然是可以正常编译的。\n实际上如果在go当中使用了C的库，比如import \"C\"默认使用go build的时候就会启动CGO编译器，当然我们可以使用CGO_ENABLED=0来控制go build是否使用CGO编译器。\n以上若有错误欢迎指正。\n\n作者：ppmoon\n链接：https://www.jianshu.com/p/4b345a9e768e\n來源：简书\n简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。', '1', '2019-02-20 10:07:34', '2019-02-20 10:07:34');
INSERT INTO `article` VALUES ('14', '服务发现：Zookeeper vs etcd vs Consul', '', '', '【编者的话】本文对比了Zookeeper、etcd和Consul三种服务发现工具，探讨了最佳的服务发现解决方案，仅供参考。\n\n如果使用预定义的端口，服务越多，发生冲突的可能性越大，毕竟，不可能有两个服务监听同一个端口。管理一个拥挤的比方说被几百个服务所使用的所有端口的列表，本身就是一个挑战，添加到该列表后，这些服务需要的数据库和数量会日益增多。因此我们应该部署无需指定端口的服务，并且让Docker为我们分配一个随机的端口。唯一的问题是我们需要发现端口号，并且让别人知道。\n\n![](https://i1.wp.com/technologyconversations.com/wp-content/uploads/2015/09/single-node-docker1.png)\n\n当我们开始在一个分布式系统上部署服务到其中一台服务器上时，事情会变得更加复杂，我们可以选择预先定义哪台服务器运行哪个服务的方式，但这会导致很多问题。我们应该尽我们所能尽量利用服务器资源，但是如果预先定义每个服务的部署位置，那么要实现尽量利用服务器资源是几乎不可能的。另一个问题是服务的自动伸缩将会非常困难，更不用说自动恢复了，比方说服务器故障。另一方面，如果我们将服务部署到某台只有最少数量的容器在运行的服务器上，我们需要添加IP地址到数据列表中，这些数据需要可以被发现并存储在某处。\n\n![](https://i2.wp.com/technologyconversations.com/wp-content/uploads/2015/09/multi-node-docker1.png)\n\n当我们需要存储和发现一些与正在工作的服务相关的信息时，还有很多其他的例子。\n\n为了能够定位服务，我们需要至少接下来的两个有用的步骤。\n服务注册——该步骤存储的信息至少包括正在运行的服务的主机和端口信息\n服务发现——该步骤允许其他用户可以发现在服务注册阶段存储的信息。\n\n\n除了上述的步骤，我们还需要考虑其他方面。如果一个服务停止工作并部署/注册了一个新的服务实例，那么该服务是否应该注销呢？当有相同服务的多个副本时咋办？我们该如何做负载均衡呢？如果一个服务器宕机了咋办？所有这些问题都与注册和发现阶段紧密关联。现在，我们限定只在服务发现的范围里（常见的名字，围绕上述步骤）以及用于服务发现任务的工具，它们中的大多数采用了高可用的分布式键/值存储。\n### 服务发现工具\n服务发现工具的主要目标是用来服务查找和相互对话，为此该工具需要知道每个服务，这不是一个新概念，在Docker之前就已经存在很多类似的工具了，然而，容器带给了这些工具一个全新水平的需求。\n\n服务发现背后的基本思想是对于服务的每一个新实例（或应用程序），能够识别当前环境和存储相关信息。存储的注册表信息本身通常采用键/值对的格式，由于服务发现经常用于分布式系统，所以要求这些信息可伸缩、支持容错和分布式集群中的所有节点。这种存储的主要用途是给所有感兴趣的各方提供最起码诸如服务IP地址和端口这样的信息，用于它们之间的相互通讯，这些数据还经常扩展到其它类型的信息服务发现工具倾向于提供某种形式的API，用于服务自身的注册以及服务信息的查找。\n\n比方说我们有两个服务，一个是提供方，另一个是第一个服务的消费者，一旦部署了服务提供方，就需要在服务发现注册表中存储其信息。接着，当消费者试图访问服务提供者时，它首先查询服务注册表，使用获取到的IP地址和端口来调用服务提供者。为了与注册表中的服务提供方的具体实现解耦，我们常常采用某种代理服务。这样消费者总是向固定IP地址的代理请求信息，代理再依次使用服务发现来查找服务提供方信息并重定向请求，在本文中我们稍后通过反向代理来实现。现在重要的是要理解基于三种角色（服务消费者、提供者和代理）的服务发现流程。\n\n服务发现工具要查找的是数据，至少我们应该能够找出服务在哪里？服务是否健康和可用？配置是什么样的？既然我们正在多台服务器上构建一个分布式系统，那么该工具需要足够健壮，保证其中一个节点的宕机不会危及数据，同时，每个节点应该有完全相同的数据副本，进一步地，我们希望能够以任何顺序启动服务、杀死服务或者替换服务的新版本，我们还应该能够重新配置服务并且查看到数据相应的变化。\n\n让我们看一下一些常用的选项来完成我们上面设定的目标。\n### 手动配置\n大多数服务仍然是需要手动管理的，我们预先决定在何处部署服务、如何配置和希望不管什么原因，服务都将继续正常工作，直到天荒地老。这样的目标不是可以轻易达到的。部署第二个服务实例意味着我们需要启动全程的手动处理，我们需要引入一台新的服务器，或者找出哪一台服务器资源利用率较低，然后创建一个新的配置集并启动服务。情况或许会变得越来越复杂，比方说，硬件故障导致的手动管理下的反应时间变得很慢。可见性是另外一个痛点，我们知道什么是静态配置，毕竟是我们预先准备好的，然而，大多数的服务有很多动态生成的信息，这些信息不是轻易可见的，也没有一个单独的地方供我们在需要时参考这些数据。\n\n反应时间会不可避免的变慢，鉴于存在许多需要手动处理的移动组件，故障恢复和监控也会变得非常难以管理。\n\n尽管在过去或者当服务/服务器数量很少的时候有借口不做这项工作，随着服务发现工具的出现，这个借口已经不存在了。\n### Zookeeper\nZookeeper是这种类型的项目中历史最悠久的之一，它起源于Hadoop，帮助在Hadoop集群中维护各种组件。它非常成熟、可靠，被许多大公司（YouTube、eBay、雅虎等）使用。其数据存储的格式类似于文件系统，如果运行在一个服务器集群中，Zookeper将跨所有节点共享配置状态，每个集群选举一个领袖，客户端可以连接到任何一台服务器获取数据。\n\nZookeeper的主要优势是其成熟、健壮以及丰富的特性，然而，它也有自己的缺点，其中采用Java开发以及复杂性是罪魁祸首。尽管Java在许多方面非常伟大，然后对于这种类型的工作还是太沉重了，Zookeeper使用Java以及相当数量的依赖使其对于资源竞争非常饥渴。因为上述的这些问题，Zookeeper变得非常复杂，维护它需要比我们期望从这种类型的应用程序中获得的收益更多的知识。这部分地是由于丰富的特性反而将其从优势转变为累赘。应用程序的特性功能越多，就会有越大的可能性不需要这些特性，因此，我们最终将会为这些不需要的特性付出复杂度方面的代价。\n\nZookeeper为其他项目相当大的改进铺平了道路，“大数据玩家“在使用它，因为没有更好的选择。今天，Zookeeper已经老态龙钟了，我们有了更好的选择。\n### etcd\netcd是一个采用HTTP协议的健/值对存储系统，它是一个分布式和功能层次配置系统，可用于构建服务发现系统。其很容易部署、安装和使用，提供了可靠的数据持久化特性。它是安全的并且文档也十分齐全。\n\netcd比Zookeeper是比更好的选择，因为它很简单，然而，它需要搭配一些第三方工具才可以提供服务发现功能。\n\n![etcd.png](https://i2.wp.com/technologyconversations.com/wp-content/uploads/2015/09/etcd1.png)\n\n现在，我们有一个地方来存储服务相关信息，我们还需要一个工具可以自动发送信息给etcd。但在这之后，为什么我们还需要手动把数据发送给etcd呢？即使我们希望手动将信息发送给etcd，我们通常情况下也不会知道是什么信息。记住这一点，服务可能会被部署到一台运行最少数量容器的服务器上，并且随机分配一个端口。理想情况下，这个工具应该监视所有节点上的Docker容器，并且每当有新容器运行或者现有的一个容器停止的时候更新etcd，其中的一个可以帮助我们达成目标的工具就是Registrator。\n### Registrator\nRegistrator通过检查容器在线或者停止运行状态自动注册和去注册服务，它目前支持etcd、Consul和SkyDNS 2。\n\nRegistrator与etcd是一个简单但是功能强大的组合，可以运行很多先进的技术。每当我们打开一个容器，所有数据将被存储在etcd并传播到集群中的所有节点。我们将决定什么信息是我们的。\n\n![etcd-registrator.png](https://i1.wp.com/technologyconversations.com/wp-content/uploads/2015/09/etcd-registrator2.png)\n\n上述的拼图游戏还缺少一块，我们需要一种方法来创建配置文件，与数据都存储在etcd，通过运行一些命令来创建这些配置文件。\n### Confd\nConfd是一个轻量级的配置管理工具，常见的用法是通过使用存储在etcd、consul和其他一些数据登记处的数据保持配置文件的最新状态，它也可以用来在配置文件改变时重新加载应用程序。换句话说，我们可以用存储在etcd（或者其他注册中心）的信息来重新配置所有服务。\n\n![etcd-registrator-confd.png](https://i0.wp.com/technologyconversations.com/wp-content/uploads/2015/09/etcd-registrator-confd2.png)\n\n对于etcd、Registrator和Confd组合的最后的思考\n当etcd、Registrator和Confd结合时，可以获得一个简单而强大的方法来自动化操作我们所有的服务发现和需要的配置。这个组合还展示了“小”工具正确组合的有效性，这三个小东西可以如我们所愿正好完成我们需要达到的目标，若范围稍微小一些，我们将无法完成我们面前的目标，而另一方面如果他们设计时考虑到更大的范围，我们将引入不必要的复杂性和服务器资源开销。\n\n在我们做出最后的判决之前，让我们看看另一个有相同目标的工具组合，毕竟，我们不应该满足于一些没有可替代方案的选择。\n### Consul\nConsul是强一致性的数据存储，使用gossip形成动态集群。它提供分级键/值存储方式，不仅可以存储数据，而且可以用于注册器件事各种任务，从发送数据改变通知到运行健康检查和自定义命令，具体如何取决于它们的输出。\n\n与Zookeeper和etcd不一样，Consul内嵌实现了服务发现系统，所以这样就不需要构建自己的系统或使用第三方系统。这一发现系统除了上述提到的特性之外，还包括节点健康检查和运行在其上的服务。\n\nZookeeper和etcd只提供原始的键/值队存储，要求应用程序开发人员构建他们自己的系统提供服务发现功能。而Consul提供了一个内置的服务发现的框架。客户只需要注册服务并通过DNS或HTTP接口执行服务发现。其他两个工具需要一个亲手制作的解决方案或借助于第三方工具。\n\nConsul为多种数据中心提供了开箱即用的原生支持，其中的gossip系统不仅可以工作在同一集群内部的各个节点，而且还可以跨数据中心工作。\n\n![consul1.png](https://i2.wp.com/technologyconversations.com/wp-content/uploads/2015/09/consul2.png)\n\nConsul还有另一个不错的区别于其他工具的功能，它不仅可以用来发现已部署的服务以及其驻留的节点信息，还通过HTTP请求、TTLs（time-to-live）和自定义命令提供了易于扩展的健康检查特性。\n### Registrator\nRegistrator有两个Consul协议，其中consulkv协议产生类似于etcd协议的结果。\n\n除了通常的IP和端口存储在etcd或consulkv协议中之外，Registrator consul协议存储了更多的信息，我们可以得到服务运行节点的信息，以及服务ID和名称。我们也可以借助于一些额外的环境变量按照一定的标记存储额外的信息。\n\n![consul-registrator1.png](https://i2.wp.com/technologyconversations.com/wp-content/uploads/2015/09/consul-registrator2.png)\n\n### Consul-template\nconfd可以像和etce搭配一样用于Consul，不过Consul有自己的模板服务，其更适配Consul。\n\n通过从Consul获得的信息，Consul-template是一个非常方便的创建文件的途径，还有一个额外的好处就是在文件更新后可以运行任意命令，正如confd，Consul-template也可以使用 Go模板格式。\n\n![consul-registrator-consul-template1.png](https://i2.wp.com/technologyconversations.com/wp-content/uploads/2015/09/consul-registrator-consul-template2.png)\n\n### Consul健康检查、Web界面和数据中心\n监控集群节点和服务的健康状态与测试和部署它们一样的重要。虽然我们应该向着拥有从来没有故障的稳定的环境努力，但我们也应该承认，随时会有意想不到的故障发生，时刻准备着采取相应的措施。例如我们可以监控内存使用情况，如果达到一定的阈值，那么迁移一些服务到集群中的另外一个节点，这将是在发生“灾难”前执行的一个预防措施。另一方面，并不是所有潜在的故障都可以被及时检测到并采取措施。单个服务可能会齿白，一个完整的节点也可能由于硬件故障而停止工作。在这种情况下我们应该准备尽快行动，例如一个节点替换为一个新的并迁移失败的服务。Consul有一个简单的、优雅的但功能强大的方式进行健康检查，当健康阀值达到一定数目时，帮助用户定义应该执行的操作。\n\n如果用户Google搜索“etcd ui”或者“etec dashboard”时，用户可能看到只有几个可用的解决方案，可能会问为什么我们还没有介绍给用户，这个原因很简单，etcd只是键/值对存储，仅此而已。通过一个UI呈现数据没有太多的用处，因为我们可以很容易地通过etcdctl获得这些数据。这并不意味着etcd UI是无用的，但鉴于其有限的使用范围，它不会产生多大影响。\n\nConsu不仅仅是一个简单的键/值对存储，正如我们已经看到的，除了存储简单的键/值对，它还有一个服务的概念以及所属的数据。它还可以执行健康检查，因此成为一个好的候选dashboard，在上面可以看到我们的节点的状态和运行的服务。最后，它支持了多数据中心的概念。所有这些特性的结合让我们从不同的角度看到引入dashboard的必要性。\n\n通过Consul Web界面，用户可以查看所有的服务和节点、监控健康检查状态以及通过切换数据中心读取设置键/值对数据。\n\n![consul-nodes.png](https://i0.wp.com/technologyconversations.com/wp-content/uploads/2015/09/consul-nodes.png)\n\n### 对于Consul、Registrator、Template、健康检查和Web UI的最终思考\nConsul以及上述我们一起探讨的工具在很多情况下提供了比etcd更好的解决方案。这是从内心深处为了服务架构和发现而设计的方案，简单而强大。它提供了一个完整的同时不失简洁的解决方案，在许多情况下，这是最佳的服务发现以及满足健康检查需求的工具。\n结论\n所有这些工具都是基于相似的原则和架构，它们在节点上运行，需要仲裁来运行，并且都是强一致性的，都提供某种形式的键/值对存储。\n\nZookeeper是其中最老态龙钟的一个，使用年限显示出了其复杂性、资源利用和尽力达成的目标，它是为了与我们评估的其他工具所处的不同时代而设计的（即使它不是老得太多）。\n\netcd、Registrator和Confd是一个非常简单但非常强大的组合，可以解决大部分问题，如果不是全部满足服务发现需要的话。它还展示了我们可以通过组合非常简单和特定的工具来获得强大的服务发现能力，它们中的每一个都执行一个非常具体的任务，通过精心设计的API进行通讯，具备相对自治工作的能力，从架构和功能途径方面都是微服务方式。\n\nConsul的不同之处在于无需第三方工具就可以原生支持多数据中心和健康检查，这并不意味着使用第三方工具不好。实际上，在这篇博客里我们通过选择那些表现更佳同时不会引入不必要的功能的的工具，尽力组合不同的工具。使用正确的工具可以获得最好的结果。如果工具引入了工作不需要的特性，那么工作效率反而会下降，另一方面，如果工具没有提供工作所需要的特性也是没有用的。Consul很好地权衡了权重，用尽量少的东西很好的达成了目标。\n\nConsul使用gossip来传播集群信息的方式，使其比etcd更易于搭建，特别是对于大的数据中心。将存储数据作为服务的能力使其比etcd仅仅只有健/值对存储的特性更加完整、更有用（即使Consul也有该选项）。虽然我们可以在etcd中通过插入多个键来达成相同的目标，Consul的服务实现了一个更紧凑的结果，通常只需要一次查询就可以获得与服务相关的所有数据。除此之外，Registrator很好地实现了Consul的两个协议，使其合二为一，特别是添加Consul-template到了拼图中。Consul的Web UI更是锦上添花般地提供了服务和健康检查的可视化途径。\n\n我不能说Consul是一个明确的赢家，而是与etcd相比其有一个轻微的优势。服务发现作为一个概念，以及作为工具都很新，我们可以期待在这一领域会有许多的变化。秉承开放的心态，大家可以对本文的建议持保留态度，尝试不同的工具然后做出自己的结论。\n\n原文链接：Service Discovery: Zookeeper vs etcd vs Consul（翻译：胡震）\n原文链接： https://studygolang.com/articles/4837\n', '1', '2019-07-23 14:00:22', '2019-07-23 14:11:46');
INSERT INTO `article` VALUES ('15', 'go get设置代理', '', '', '直接使用`go get`安装依赖总是失败，除了翻墙还可以通过设置代理的方式。\nbash环境执行：\n```shell\n$ export GOPROXY=https://goproxy.io\n```\n\n这样就可以顺利`go get`了。\n![](http://hopefully-img.yuedun.wang/background1.png)', '1', '2019-05-19 23:12:00', '2019-05-19 23:12:01');
INSERT INTO `article` VALUES ('19', 'markdown语法支持', '', '', '## 3333333333333333\n\n> **34543**5\n\n![](http://hopefully-img.yuedun.wang/b43793304e9aa6d3e57f897dbe4633710d695b38506e-AoREwF_fw658.jpg)\n\n| 一个普通标题 | 一个普通标题 | 一个普通标题 |\n| ------ | ------ | ------ |\n| 短文本 | 中等文本 | 稍微长一点的文本 |\n| 稍微长一点的文本 | 短文本 | 中等文本 |\n\nName    | Age\n--------|------\nBob     | 27\nAlice   | 23', '1', '2019-08-16 09:46:33', '2019-10-11 17:03:47');
INSERT INTO `article` VALUES ('20', 'golang项目目录结构', '', '', 'go语言和其他语言有一些区别，它是以包为单位来划分访问权限，和Java的访问粒度不一样，这注定了他们不会有相同的代码组织方式。\n\n这里推荐的项目目录组织方式是按职责划分，就是不同功能使用不同的目录。\n采用这种结构的原因是，目前流行的开发模式是微服务架构，但是一般项目的发展过程都是由小到大再到拆分的过程，如果项目初始就使用微服务的架构开发的话估计还没等项目开发完公司就完蛋了。\n所以最开始还是单体架构才是正确的方式，不过为了以后方便拆分，可以对项目目录进行合理的划分。\n从路由入口看：\n```go\nfunc RouterRegister(router *gin.Engine) {\n	//user路由注册\n    	userRouter := router.Group(\"/user\")\n    	{\n    		userRouter.GET(\"/index\", user.Index)\n    		userRouter.GET(\"/users/:id\", middleware.Auth(), user.GetUserInfo)\n    		userRouter.GET(\"/users-by-sql/:id\", user.GetUserInfoBySql)\n    		userRouter.POST(\"/\", user.CreateUser)\n    		userRouter.PUT(\"/update/:id\", user.UpdateUser)\n    		userRouter.DELETE(\"/del/:id\", user.DeleteUser)\n    	}\n    	//post路由注册\n    	postRouter := router.Group(\"/post\")\n    	{\n    		postRouter.GET(\"/\", post.Index)\n    		postRouter.GET(\"/posts/:id\", middleware.Auth(), post.GetPostInfo)\n    		postRouter.GET(\"/posts-by-sql/:id\", post.GetPostInfoBySql)\n    		postRouter.POST(\"/\", post.CreatePost)\n    		postRouter.PUT(\"/:id\", post.UpdatePost)\n    		postRouter.DELETE(\"/:id\", post.DeletePost)\n    	}\n}\n```\n本项目只是一个示例项目，模块较少，只开设了两个模块，`user`和`post`，注册路由的时候就可以按照不同的职责来分组注册，`pkg`目录下放置的就是不同职责的模块。\n将来需要对服务进行拆分的时候只需要将`pkg`目录下的模块分离出去即可形成独立的服务，对依赖的的修改也较少。如果使用的MVC架构的话，要对不同职责的服务进行拆分则很困难，需要对每一层中对应的文件都拿出来重新组织。\n\n', '1', '2019-09-30 16:48:17', '2020-02-03 10:24:34');
INSERT INTO `article` VALUES ('21', '测试一下写东西怎么样', '', '', '测试一下写东西怎么样\n![](http://hopefully-img.yuedun.wang/屏幕快照 2019-10-22 05.57.49.png)\n哈哈哈哈哈', '1', '2019-10-04 11:10:33', '2019-12-20 04:13:05');
INSERT INTO `article` VALUES ('22', '真的假的', '', '', '哈哈，真的假的![](http://hopefully-img.yuedun.wang/屏幕快照 2019-10-22 05.57.49.png)', '1', '2019-12-20 04:16:31', '2019-12-20 04:16:31');
INSERT INTO `article` VALUES ('23', '时隔半年，工作数量爬虫再次运行', '', '', '[![](http://hopefully-img.yuedun.wang/104432cjc7c8tx7xxqqkgq.jpg)](http://hopefully-img.yuedun.wang/104432cjc7c8tx7xxqqkgq.jpg)\n\n之前做过拉钩数据爬取，但是没运行几个月，就似乎不能正常爬数据了，调试结果显示“您操作太频繁,请稍后再访问”，应该是被阻止了。偶然的使用nodejs爬了下数据，居然能爬到，就继续用go试了下，结果发现应该是cookie过期导致的，使用最新的cookie可以爬到。因为以前是写死的，肯定是过期了。那就在每次爬数据前重新获取cookie来防止过期好了。顺便修改请求客户端为beego httplib来简化代码。希望这次不会被拉黑。', '1', '2020-01-17 19:56:00', '2020-01-17 19:58:25');
INSERT INTO `article` VALUES ('24', '123123123', '', '', '123123123123', '1', '2020-01-18 17:41:31', '2020-01-18 17:41:31');
INSERT INTO `article` VALUES ('25', '88888', '', '', '5555555![](http://hopefully-img.yuedun.wang/cook.png)', '1', '2020-01-21 14:57:51', '2020-01-21 14:57:51');
INSERT INTO `article` VALUES ('26', 'go-micro搭建golang微服务', '', '', '# micro-service\ngo语言微服务[https://github.com/yuedun/micro-service](https://github.com/yuedun/micro-service)\n\n## Getting Started\n\n- [教程](https://micro.mu/docs/go-helloworld.html)\n- [用户服务](https://github.com/micro-in-cn/tutorials/tree/master/microservice-in-micro/part1)\n\n## 依赖\n\ngrpc v1.25.1，\nv1.27.1会有类型这样的错误`undefined: resolver.BuildOption`,`undefined: resolver.ResolveNowOption`\n\n## Usage\n生成*.pb.go代码\n```shell\n$ protoc --proto_path=. --micro_out=. --go_out=. proto/user/user.proto\n```\n启动服务和测试\n```shell\ngo run main.go\n```\n```shell\ngo run client/main.go\n```\n\n### 开启api服务\n```shell\ngo run main.go\n```\n```shell\ngo run api/api.go\n```\n```shell\nmicro api --handler=api\n```\n```shell\ncurl \"http://localhost:8080/user/say/hello?name=huohuo\"\n```\n返回\n{\"id\":\"123\",\"password\":\"dslhgfoif40u9b9\",\"username\":\"huohuo\"}\n\n### api层说明：\nAPI模块，它的身份其实就是一个网关或者代理层，它的能力就是让一个单一的入口可以去访问微服务。API工作在我们的软件服务架构的边缘。\n\n## 服务注册服务\nv2.0版本默认使用的服务注册发现是**mdns**。\nMicro内置了mDNS组播系统，这是一种零依赖的服务注册发现机制，它是区别于有注册中心的替代方案。\n通过在启动指令中传入--registry=mdns 或者在环境变量中设置MICRO_REGISTRY=mdns。\n其实也可以不传，早期版本的go-micro默认注册中心是consul，现在换成了mdns\nmDNS（多播DNS）是一种局域网内使用的DNS机制，他的大致原理如下：当有新的节点加入局域网的时候，如果打开了mDNS，就主动向局域网其他所有节点广播，自己提供的服务（域名是什么、ip地址是什么、端口号是什么）, 这样我们任何一个节点都知道局域网提供了什么服务。\n所以生产环境需要其他中间件，如**consul**，**etcd**。\n\n## 使用etcd作为服务发现中间件\ngo-micro v2弃用了**consul**，推荐使用的是**etcd**。\n使用方法：\n```shell\ngo run main.go --registry=etcd\n```\n```shell\ngo run api/api.go --registry=etcd\n```\n```shell\nmicro --registry=etcd api --handler=api\n```\n在启动的时候加上`--registry=etcd`参数即可，启动日志如下：\n```cassandraql\n2020-03-14 16:17:07 Starting [service] go.micro.srv.user\n2020-03-14 16:17:07 Server [grpc] Listening on [::]:10507\n2020-03-14 16:17:07 Registry [etcd] Registering node: go.micro.srv.user-332fd9a8-f241-4c20-bf93-ee832b487261\n```\n`Registry [mdns]`变成了`Registry [etcd]`。\n### 启动三个etcd实例：\n```shell\n.\\etcd.exe --name etcd01 ^\n--data-dir .\\data\\etcd01 ^\n--advertise-client-urls http://127.0.0.1:2379 ^\n--listen-client-urls http://127.0.0.1:2379 ^\n--listen-peer-urls http://127.0.0.1:2380 ^\n--initial-advertise-peer-urls http://127.0.0.1:2380 ^\n--initial-cluster-token etcd-cluster-1 ^\n--initial-cluster etcd01=http://127.0.0.1:2380,etcd02=http://127.0.0.1:2381,etcd03=http://127.0.0.1:2382 ^\n--initial-cluster-state new\n\npause\n```\n```shell\n.\\etcd.exe --name etcd02 ^\n--data-dir .\\data\\etcd02 ^\n--advertise-client-urls http://127.0.0.1:3379 ^\n--listen-client-urls http://127.0.0.1:3379 ^\n--listen-peer-urls http://127.0.0.1:2381 ^\n--initial-advertise-peer-urls http://127.0.0.1:2381 ^\n--initial-cluster-token etcd-cluster-1 ^\n--initial-cluster etcd01=http://127.0.0.1:2380,etcd02=http://127.0.0.1:2381,etcd03=http://127.0.0.1:2382 ^\n--initial-cluster-state new\n\npause\n```\n```shell\n.\\etcd.exe --name etcd03 ^\n--data-dir .\\data\\etcd03 ^\n--advertise-client-urls http://127.0.0.1:4379 ^\n--listen-client-urls http://127.0.0.1:4379 ^\n--listen-peer-urls http://127.0.0.1:2382 ^\n--initial-advertise-peer-urls http://127.0.0.1:2382 ^\n--initial-cluster-token etcd-cluster-1 ^\n--initial-cluster etcd01=http://127.0.0.1:2380,etcd02=http://127.0.0.1:2381,etcd03=http://127.0.0.1:2382 ^\n--initial-cluster-state new\n\npause\n```\n查看etcd节点状态\n```shell\n./etcdctl.exe --write-out=table --endpoints=http://127.0.0.1:2379,http://127.0.0.1:3379,http://127.0.0.1:4379 endpoint status\n```\n```shell\n+-----------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+\n|       ENDPOINT        |        ID        | VERSION | DB SIZE | IS LEADER | IS LEARNER | RAFT TERM | RAFT INDEX | RAFT APPLIED INDEX | ERRORS |\n+-----------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+\n| http://127.0.0.1:2379 | bf9071f4639c75cc |   3.4.4 |  115 kB |      true |      false |        13 |         99 |                 99 |        |\n| http://127.0.0.1:3379 | e7b968b9fb1bc003 |   3.4.4 |  115 kB |     false |      false |        13 |         99 |                 99 |        |\n| http://127.0.0.1:4379 | 19ac17627e3e396f |   3.4.4 |  106 kB |     false |      false |        13 |         99 |                 99 |        |\n+-----------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+\n\n```\n启动两个新的服务并注册到etcd中\n```shell\n go run main.go --registry=etcd --registry_address=http://127.0.0.1:3379\n```\n```shell\n go run main.go --registry=etcd --registry_address=http://127.0.0.1:4379\n```\n多次请求http://localhost:8080/user/say/hello?name=huohuo\n会在三个服务轮询接收请求\n![](./etcd.jpg)\n停止某个服务并不会中断服务，以此实现了服务注册发现。', '1', '2020-03-16 14:21:26', '2020-07-21 17:30:33');
INSERT INTO `article` VALUES ('27', '祝大家五一快乐', '', '', '五一长假，出行安全，吃喝玩乐，走亲访友，阖家欢乐', '1', '2020-05-01 10:49:13', '2020-05-01 10:49:13');
INSERT INTO `article` VALUES ('28', 'dfsaf', '', '', 'fdsafdasfds', '1', '2020-05-03 21:45:04', '2020-05-03 21:45:04');
INSERT INTO `article` VALUES ('29', '1111', '', '', '11111', '1', '2020-05-19 14:28:18', '2020-05-19 14:28:18');
INSERT INTO `article` VALUES ('30', '棒棒哒！', '', '', '预祝周末愉快\nGo Go Go, 学起来！！！\nFrom Elsa', '1', '2020-05-29 10:23:34', '2020-07-18 17:07:11');
INSERT INTO `article` VALUES ('31', '213', '', '', '12312312', '1', '2020-06-13 17:18:06', '2020-06-13 17:18:06');
INSERT INTO `article` VALUES ('32', 'hello', '', '', '！', '1', '2020-07-05 01:47:11', '2020-07-05 01:47:11');
INSERT INTO `article` VALUES ('33', '更新UI', '', '', '本次更新UI，使得整体看起来更大气，同时在移动端布局更合理。\n\n本站基于golang语言，beego框架开发。项目同时包含了用户界面和管理后台，无需部署两个服务，同时提供了数据库结构，可直接拿来使用。 本项目对个人用户友好，前端使用了最原始的html，js，css开发无需搭建繁琐的开发环境，不追求高大上（假大空）的技术，返璞归真，让个人网站更易建立。', '1', '2020-07-18 12:12:03', '2020-07-18 12:12:03');
INSERT INTO `article` VALUES ('34', '友情告知', '', '', '亲爱的朋友们，很高兴您访问本站。\n\n但是，很不幸的告诉您，您可能无法从本站看到有用的文章。本站目前只是作为一个供广大网友学习golang的项目，网站中暂不会发表重要文章，因为本站直接提供了登录后台的账号和入口，会有网友们测试发表的内容，看看就行，不要当真。也希望大家不要胡乱发表内容。', '1', '2020-07-19 15:56:44', '2020-07-21 17:27:33');
INSERT INTO `article` VALUES ('35', '权限控制设计', '权限设计', '架构', '权限往往是一个极其复杂的问题，但也可简单表述为这样的逻辑表达式：判断“Who对What(Which)进行How的操作”的逻辑表达式是否为真。针对不同的应用，需要根据项目的实际情况和具体架构，在维护性、灵活性、完整性等N多个方案之间比较权衡，选择符合的方案。\n\n**目标：**\n直观，因为系统最终会由最终用户来维护，权限分配的直观和容易理解，显得比较重要，系统不辞劳苦的实现了组的继承，除了功能的必须，更主要的就是因为它足够直观。\n\n简单，包括概念数量上的简单和意义上的简单还有功能上的简单。想用一个权限系统解决所有的权限问题是不现实的。设计中将常常变化的“定制”特点比较强的部分判断为业务逻辑，而将常常相同的“通用”特点比较强的部分判断为权限逻辑就是基于这样的思路。\n\n扩展，采用可继承在扩展上的困难。的Group概念在支持权限以组方式定义的同时有效避免了重定义时\n\n**现状：**\n对于在企业环境中的访问控制方法，一般有三种：\n\n1.自主型访问控制方法。目前在我国的大多数的信息系统中的访问控制模块中基本是借助于自主型访问控制方法中的访问控制列表(ACLs)。\n\n2.强制型访问控制方法。用于多层次安全级别的军事应用。\n\n3.基于角色的访问控制方法（RBAC）。是目前公认的解决大型企业的统一资源访问控制的有效方法。\n其显著的两大特征是：1.减小授权管理的复杂性，降低管理开销。2.灵活地支持企业的安全策略，并对企业的变化有很大的伸缩性。\n\n**名词：**\n粗粒度：表示类别级，即仅考虑对象的类别(the type of object)，不考虑对象的某个特定实例。比如，用户管理中，创建、删除，对所有的用户都一视同仁，并不区分操作的具体对象实例。\n\n细粒度：表示实例级，即需要考虑具体对象的实例(the instance of object)，当然，细粒度是在考虑粗粒度的对象类别之后才再考虑特定实例。比如，合同管理中，列表、删除，需要区分该合同实例是否为当前用户所创建。\n\n**原则：**\n权限逻辑配合业务逻辑。即权限系统以为业务逻辑提供服务为目标。相当多细粒度的权限问题因其极其独特而不具通用意义，它们也能被理解为是“业务逻辑”的一部分。比如，要求：“合同资源只能被它的创建者删除，与创建者同组的用户可以修改，所有的用户能够浏览”。这既可以认为是一个细粒度的权限问题，也可以认为是一个业务逻辑问题。在这里它是业务逻辑问题，在整个权限系统的架构设计之中不予过多考虑。当然，权限系统的架构也必须要能支持这样的控制判断。或者说，系统提供足够多但不是完全的控制能力。即，设计原则归结为：“系统只提供粗粒度的权限，细粒度的权限被认为是业务逻辑的职责”。\n\n需要再次强调的是，这里表述的权限系统仅是一个“不完全”的权限系统，即，它不提供所有关于权限的问题的解决方法。它提供一个基础，并解决那些具有“共性”的(或者说粗粒度的)部分。在这个基础之上，根据“业务逻辑”的独特权限需求，编码实现剩余部分(或者说细粒度的)部分，才算完整。回到权限的问题公式，通用的设计仅解决了Who+What+How 的问题，其他的权限问题留给业务逻辑解决。\n\n**概念：**\n\n- Who：权限的拥用者或主体（Principal、User、Group、Role、Actor等等）\n- What：权限针对的对象或资源（Resource、Class）。\n- How：具体的权限（Privilege, 正向授权与负向授权）。\n- Role：是角色，拥有一定数量的权限。\n- Operator：操作。表明对What的How 操作。\n\n**说明：**\nUser：与 Role 相关，用户仅仅是纯粹的用户，权限是被分离出去了的。User是不能与 Privilege 直接相关的，User 要拥有对某种资源的权限，必须通过Role去关联。解决 Who 的问题。\n\nResource：就是系统的资源，比如部门新闻，文档等各种可以被提供给用户访问的对象。资源可以反向包含自身，即树状结构，每一个资源节点可以与若干指定权限类别相关可定义是否将其权限应用于子节点。\n\nPrivilege：是Resource Related的权限。就是指，这个权限是绑定在特定的资源实例上的。比如说部门新闻的发布权限，叫做\"部门新闻发布权限\"。\n这就表明，该Privilege是一个发布权限，而且是针对部门新闻这种资源的一种发布权限。Privilege是由Creator在做开发时就确定的。权限，包括系统定义权限和用户自定义权限用户自定义权限之间可以指定排斥和包含关系(如：读取，修改，管理三个权限，管理 权限 包含 前两种权限)。Privilege 如\"删除\" 是一个抽象的名词，当它不与任何具体的 Object 或 Resource 绑定在一起时是没有任何意义的。拿新闻发布来说，发布是一种权限，但是只说发布它是毫无意义的。因为不知道发布可以操作的对象是什么。只有当发布与新闻结合在一起时，才会产生真正的 Privilege。这就是 Privilege Instance。权限系统根据需求的不同可以延伸生很多不同的版本。\n\nRole：是粗粒度和细粒度(业务逻辑)的接口，一个基于粗粒度控制的权限框架软件，对外的接口应该是Role，具体业务实现可以直接继承或拓展丰富Role的内容，Role不是如同User或Group的具体实体，它是接口概念，抽象的通称。\n\nGroup：用户组，权限分配的单位与载体。权限不考虑分配给特定的用户。组可以包括组(以实现权限的继承)。组可以包含用户，组内用户继承组的权限。Group要实现继承。即在创建时必须要指定该Group的Parent是什么Group。在粗粒度控制上，可以认为，只要某用户直接或者间接的属于某个Group那么它就具备这个Group的所有操作许可。细粒度控制上，在业务逻辑的判断中，User仅应关注其直接属于的Group，用来判断是否“同组” 。Group是可继承的，对于一个分级的权限实现，某个Group通过“继承”就已经直接获得了其父Group所拥有的所有“权限集合”，对这个Group而言，需要与权限建立直接关联的，仅是它比起其父Group需要“扩展”的那部分权限。子组继承父组的所有权限，规则来得更简单，同时意味着管理更容易。为了更进一步实现权限的继承，最直接的就是在Group上引入“父子关系”。\n\nUser与Group是多对多的关系。即一个User可以属于多个Group之中，一个Group可以包括多个User。子Group与父Group是多对一的关系。Operator某种意义上类似于Resource + Privilege概念，但这里的Resource仅包括Resource Type不表示Resource Instance。Group 可以直接映射组织结构，Role 可以直接映射组织结构中的业务角色，比较直观，而且也足够灵活。Role对系统的贡献实质上就是提供了一个比较粗颗粒的分配单位。\nGroup与Operator是多对多的关系。各概念的关系图示如下：\n\n**解释：**\nOperator的定义包括了Resource Type和Method概念。即，What和How的概念。之所以将What和How绑定在一起作为一个Operator概念而不是分开建模再建立关联，这是因为很多的How对于某What才有意义。比如，发布操作对新闻对象才有意义，对用户对象则没有意义。\n\nHow本身的意义也有所不同，具体来说，对于每一个What可以定义N种操作。比如，对于合同这类对象，可以定义创建操作、提交操作、检查冲突操作等。可以认为，How概念对应于每一个商业方法。其中，与具体用户身份相关的操作既可以定义在操作的业务逻辑之中，也可以定义在操作级别。比如，创建者的浏览视图与普通用户的浏览视图要求内容不同。既可以在外部定义两个操作方法，也可以在一个操作方法的内部根据具体逻辑进行处理。具体应用哪一种方式应依据实际情况进行处理。\n\n这样的架构，应能在易于理解和管理的情况下，满足绝大部分粗粒度权限控制的功能需要。但是除了粗粒度权限，系统中必然还会包括无数对具体Instance的细粒度权限。这些问题，被留给业务逻辑来解决，这样的考虑基于以下两点：\n一方面，细粒度的权限判断必须要在资源上建模权限分配的支持信息才可能得以实现。比如，如果要求创建者和普通用户看到不同的信息内容，那么，资源本身应该有其创建者的信息。另一方面，细粒度的权限常常具有相当大的业务逻辑相关性。对不同的业务逻辑，常常意味着完全不同的权限判定原则和策略。相比之下，粗粒度的权限更具通用性，将其实现为一个架构，更有重用价值；而将细粒度的权限判断实现为一个架构级别的东西就显得繁琐，而且不是那么的有必要，用定制的代码来实现就更简洁，更灵活。\n\n所以细粒度控制应该在底层解决，Resource在实例化的时候，必需指定Owner和GroupPrivilege在对Resource进行操作时也必然会确定约束类型：究竟是OwnerOK还是GroupOK还是AllOK。Group应和Role严格分离User和Group是多对多的关系，Group只用于对用户分类，不包含任何Role的意义；Role只授予User，而不是Group。如果用户需要还没有的多种Privilege的组合，必须新增Role。Privilege必须能够访问Resource，同时带User参数，这样权限控制就完备了。\n\n**思想：**\n权限系统的核心由以下三部分构成：1.创造权限，2.分配权限，3.使用权限，然后，系统各部分的主要参与者对照如下：1.创造权限 - Creator创造，2.分配权限 - Administrator 分配，3.使用权限 - User：\n\n1. Creator 创造 Privilege， Creator 在设计和实现系统时会划分，一个子系统或称为模块，应该有哪些权限。这里完成的是 Privilege 与 Resource 的对象声明，并没有真正将 Privilege 与具体Resource 实例联系在一起，形成Operator。\n\n2. Administrator 指定 Privilege 与 Resource Instance 的关联。在这一步， 权限真正与资源实例联系到了一起， 产生了Operator（Privilege Instance）。Administrator利用Operator这个基本元素，来创造他理想中的权限模型。如，创建角色，创建用户组，给用户组分配用户，将用户组与角色关联等等...这些操作都是由 Administrator 来完成的。\n\n3. User 使用 Administrator 分配给的权限去使用各个子系统。Administrator 是用户，在他的心目中有一个比较适合他管理和维护的权限模型。于是，程序员只要回答一个问题，就是什么权限可以访问什么资源，也就是前面说的 Operator。程序员提供 Operator 就意味着给系统穿上了盔甲。Administrator 就可以按照他的意愿来建立他所希望的权限框架可以自行增加，删除，管理Resource和Privilege之间关系。可以自行设定用户User和角色Role的对应关系。(如果将 Creator看作是 Basic 的发明者， Administrator 就是 Basic 的使用者，他可以做一些脚本式的编程) Operator是这个系统中最关键的部分，它是一个纽带，一个系在Programmer，Administrator，User之间的纽带。\n\n用一个功能模块来举例子。\n## 一．建立角色功能并做分配：\n1．如果现在要做一个员工管理的模块(即Resources)，这个模块有三个功能，分别是：增加，修改，删除。给这三个功能各自分配一个ID，这个ID叫做功能代号：\nEmp_addEmp，Emp_deleteEmp，Emp_updateEmp。\n\n2．建立一个角色(Role)，把上面的功能代码加到这个角色拥有的权限中，并保存到数据库中。角色包括系统管理员，测试人员等。\n\n3．建立一个员工的账号，并把一种或几种角色赋给这个员工。比如说这个员工既可以是公司管理人员，也可以是测试人员等。这样他登录到系统中将会只看到他拥有权限的那些模块。\n\n## 二．把身份信息加到Session中。\n登录时，先到数据库中查找是否存在这个员工，如果存在，再根据员工的sn查找员工的权限信息，把员工所有的权限信息都入到一个Hashmap中，比如就把上面的Emp_addEmp等放到这个Hashmap中。然后把Hashmap保存在一个UserInfoBean中。最后把这个UserInfoBean放到Session中，这样在整个程序的运行过程中，系统随时都可以取得这个用户的身份信息。\n\n## 三．根据用户的权限做出不同的显示。\n\n可以对比当前员工的权限和给这个菜单分配的“功能ID”判断当前用户是否有打开这个菜单的权限。例如：如果保存员工权限的Hashmap中没有这三个ID的任何一个，那这个菜单就不会显示，如果员工的Hashmap中有任何一个ID，那这个菜单都会显示。\n\n对于一个新闻系统(Resouce)，假设它有这样的功能(Privilege)：查看，发布，删除，修改；假设对于删除，有\"新闻系统管理者只能删除一月前发布的，而超级管理员可删除所有的这样的限制，这属于业务逻辑(Business logic)，而不属于用户权限范围。也就是说权限负责有没有删除的Permission，至于能删除哪些内容应该根据UserRole or UserGroup来决定(当然给UserRole or UserGroup分配权限时就应该包含上面两条业务逻辑)。\n\n一个用户可以拥有多种角色，但同一时刻用户只能用一种角色进入系统。角色的划分方法可以根据实际情况划分，按部门或机构进行划分的，至于角色拥有多少权限，这就看系统管理员赋给他多少的权限了。用户—角色—权限的关键是角色。用户登录时是以用户和角色两种属性进行登录的（因为一个用户可以拥有多种角色，但同一时刻只能扮演一种角色），根据角色得到用户的权限，登录后进行初始化。这其中的技巧是同一时刻某一用户只能用一种角色进行登录。\n针对不同的“角色”动态的建立不同的组，每个项目建立一个单独的Group，对于新的项目，建立新的 Group 即可。在权限判断部分，应在商业方法上予以控制。比如：不同用户的“操作能力”是不同的(粗粒度的控制应能满足要求)，不同用户的“可视区域”是不同的(体现在对被操作的对象的权限数据，是否允许当前用户访问，这需要对业务数据建模的时候考虑权限控制需要)。\n\n**扩展性：**\n有了用户/权限管理的基本框架，Who(User/Group)的概念是不会经常需要扩展的。变化的可能是系统中引入新的 What (新的Resource类型)或者新的How(新的操作方式)。那在三个基本概念中，仅在Permission上进行扩展是不够的。这样的设计中Permission实质上解决了How 的问题，即表示了“怎样”的操作。那么这个“怎样”是在哪一个层次上的定义呢？将Permission定义在“商业方法”级别比较合适。比如，发布、购买、取消。每一个商业方法可以意味着用户进行的一个“动作”。定义在商业逻辑的层次上，一方面保证了数据访问代码的“纯洁性”，另一方面在功能上也是“足够”的。也就是说，对更低层次，能自由的访问数据，对更高层次，也能比较精细的控制权限。\n\n确定了Permission定义的合适层次，更进一步，能够发现Permission实际上还隐含了What的概念。也就是说，对于What的How操作才会是一个完整的Operator。比如，“发布”操作，隐含了“信息”的“发布”概念，而对于“商品”而言发布操作是没有意义的。同样的，“购买”操作，隐含了“商品”的“购买”概念。这里的绑定还体现在大量通用的同名的操作上，比如，需要区分“商品的删除”与“信息的删除”这两个同名为“删除”的不同操作。\n\n提供权限系统的扩展能力是在Operator (Resource + Permission)的概念上进行扩展。Proxy 模式是一个非常合适的实现方式。实现大致如下：在业务逻辑层(EJB Session Facade [Stateful SessionBean]中)，取得该商业方法的Methodname，再根据Classname和 Methodname 检索Operator 数据，然后依据这个Operator信息和Stateful中保存的User信息判断当前用户是否具备该方法的操作权限。\n\n应用在 EJB 模式下，可以定义一个很明确的 Business层次，而一个Business 可能意味着不同的视图，当多个视图都对应于一个业务逻辑的时候，比如，Swing Client以及 Jsp Client 访问的是同一个 EJB 实现的 Business。在 Business 层上应用权限较能提供集中的控制能力。实际上，如果权限系统提供了查询能力，那么会发现，在视图层次已经可以不去理解权限，它只需要根据查询结果控制界面就可以了。\n\n**灵活性：**\nGroup和Role，只是一种辅助实现的手段，不是必需的。如果系统的Role很多，逐个授权违背了“简单，方便”的目的，那就引入Group，将权限相同的Role组成一个Group进行集中授权。Role也一样，是某一类Operator的集合，是为了简化针对多个Operator的操作。\n\nRole把具体的用户和组从权限中解放出来。一个用户可以承担不同的角色，从而实现授权的灵活性。当然，Group也可以实现类似的功能。但实际业务中，Group划分多以行政组织结构或业务功能划分；如果为了权限管理强行将一个用户加入不同的组，会导致管理的复杂性。\n\nDomain的应用。为了授权更灵活，可以将Where或者Scope抽象出来，称之为Domain，真正的授权是在Domain的范围内进行，具体的Resource将分属于不同的Domain。比如：一个新闻机构有国内与国外两大分支，两大分支内又都有不同的资源（体育类、生活类、时事政治类）。假如所有国内新闻的权限规则都是一样的，所有国外新闻的权限规则也相同。则可以建立两个域，分别授权，然后只要将各类新闻与不同的域关联，受域上的权限控制，从而使之简化。\n\n权限系统还应该考虑将功能性的授权与资源性的授权分开。很多系统都只有对系统中的数据（资源）的维护有权限控制，但没有对系统功能的权限控制。\n\n权限系统最好是可以分层管理而不是集中管理。大多客户希望不同的部门能且仅能管理其部门内部的事务，而不是什么都需要一个集中的Administrator或Administrators组来管理。虽然你可以将不同部门的人都加入Administrators组，但他们的权限过大，可以管理整个系统资源而不是该部门资源。\n\n正向授权与负向授权：正向授权在开始时假定主体没有任何权限，然后根据需要授予权限，适合于权限要求严格的系统。负向授权在开始时假定主体有所有权限，然后将某些特殊权限收回。\n权限计算策略：系统中User，Group，Role都可以授权，权限可以有正负向之分，在计算用户的净权限时定义一套策略。\n\n系统中应该有一个集中管理权限的AccessService，负责权限的维护（业务管理员、安全管理模块）与使用（最终用户、各功能模块），该AccessService在实现时要同时考虑一般权限与特殊权限。虽然在具体实现上可以有很多，比如用Proxy模式，但应该使这些Proxy依赖于AccessService。各模块功能中调用AccessService来检查是否有相应的权限。所以说，权限管理不是安全管理模块自己一个人的事情，而是与系统各功能模块都有关系。每个功能模块的开发人员都应该熟悉安全管理模块，当然，也要从业务上熟悉本模块的安全规则。\n\n**技术实现：**\n\n1．表单式认证，这是常用的，但用户到达一个不被授权访问的资源时，Web容器就发出一个html页面，要求输入用户名和密码。\n\n2．一个基于Servlet Sign in/Sign out来集中处理所有的Request，缺点是必须由应用程序自己来处理。\n3．用Filter防止用户访问一些未被授权的资源，Filter会截取所有Request/Response，然后放置一个验证通过的标识在用户的Session中，然后Filter每次依靠这个标识来决定是否放行Response。\n\n**这个模式分为：**\n\nGatekeeper ：采取Filter或统一Servlet的方式。\n\nAuthenticator： 在Web中使用JAAS自己来实现。\n\n用户资格存储LDAP或数据库：\n\n1. Gatekeeper拦截检查每个到达受保护的资源。首先检查这个用户是否有已经创建好的Login Session，如果没有，Gatekeeper 检查是否有一个全局的和Authenticator相关的session？\n\n2. 如果没有全局的session，这个用户被导向到Authenticator的Sign-on 页面，要求提供用户名和密码。\n3. Authenticator接受用户名和密码，通过用户的资格系统验证用户。\n\n4. 如果验证成功，Authenticator将创建一个全局Login session，并且导向Gatekeeper来为这个用户在他的web应用中创建一个Login Session。\n\n5. Authenticator和Gatekeepers联合分享Cookie，或者使用Tokens在Query字符里。', '1', '2020-07-29 18:11:37', '2020-07-30 10:28:21');

-- ----------------------------
-- Table structure for `assistance`
-- ----------------------------
DROP TABLE IF EXISTS `assistance`;
CREATE TABLE `assistance` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `urgency_level` int(11) NOT NULL DEFAULT '1',
  `state` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `images` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_helper` int(11) DEFAULT '0',
  `second_helper` int(11) DEFAULT '0',
  `user_mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of assistance
-- ----------------------------
INSERT INTO `assistance` VALUES ('1', '1', '从页面显示效果来看，被 <b> 和 <strong> 包围的文字将会被加粗，而被 <i> 和 <em> 包围的文字将以斜体的形式呈现。那大家可能就会疑惑了，既然效果一样，那为什么还要重复定义标签呢？这就要从 HTML5 的一个最大的特性 -- 语义化来谈了。\n\n作者：编译青春\n链接：https://www.zhihu.com/question/19551271/answer/146298923\n来源：知乎\n著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。', null, null, '1', '0', '2017-10-21 04:06:00', '2017-10-21 04:06:00', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('2', '1', '不得不说，<b> 和 <i> 创建之初就是简单地表示粗体和斜体样式，但现在是 HTML5 的天下。语义化是 HTML5 最大的特性之一，而所有被 HTML5 保留的标签都带有其特有的语义，<b> 和 <i> 也不例外，它们分别被重新赋予了语义。相比较而言，标签的样式反而变得无足轻重，所以上面所讲的两组标签，虽然样式上表现极其相似，但其实语义上各有侧重。\n\n作者：编译青春\n链接：https://www.zhihu.com/question/19551271/answer/146298923\n来源', null, null, '1', '0', '2017-10-21 04:14:30', '2017-10-21 04:14:30', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('6', '1', 'XSS攻击全称跨站脚本攻击，是为不和层叠样式表(Cascading Style Sheets, CSS)的缩写混淆， 故将跨站脚本攻击缩写为XSS，XSS是一种在web应用中的计算机安全漏洞，它允许恶意web用户将代码植入到 提供给其它用户使用的页面中。从而达到攻击的目的。如，盗取用户Cookie、破坏页面结构、重定向到其它网站等。 XSS攻击案例： 新浪微博遭受XX攻击', null, 'http://localhost:3002/', '1', '0', '2017-11-18 08:32:58', '2017-11-18 08:32:58', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('7', '1', 'XSS攻击全称跨站脚本攻击，是为不和层叠样式表(Cascading Style Sheets, CSS)的缩写混淆， 故将跨站脚本攻击缩写为XSS，XSS是一种在web应用中的计算机安全漏洞，它允许恶意web用户将代码植入到 提供给其它用户使用的页面中。从而达到攻击的目的。如，盗取用户Cookie、破坏页面结构、重定向到其它网站等。 XSS攻击案例： 新浪微博遭受XX攻击', null, 'http://localhost:3002/', '1', '0', '2017-11-18 08:33:26', '2017-11-18 08:33:26', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('8', '1', 'http://soft.yesky.com/security/156/30179156.shtml 人人网遭受XSS攻击： http://www.freebuf.com/articles/6295.html 简单的测试方法： 所有提交数据的地方都有可能存在XSS，', null, 'http://localhost:3002/', '1', '0', '2017-11-18 08:34:15', '2017-11-18 08:34:15', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('9', '1', 'http://soft.yesky.com/security/156/30179156.shtml 人人网遭受XSS攻击： http://www.freebuf.com/articles/6295.html 简单的测试方法： 所有提交数据的地方都有可能存在XSS，', null, 'http://localhost:3002/', '1', '0', '2017-11-18 08:39:30', '2017-11-18 08:39:30', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('10', '1', '诱导或等待用户去点击链接，才能触发XSS代码，达到劫持访问、获取cookies的目的。一般容易出现在搜索页面。 例如：https://m.wuage.com/search/self-shop?memberId=4lv8ll4g&keywords=x%22alert(1)%22&psa=M3.s10.0.j4 （此漏洞已经修复，请勿再测，造成访问压力。） 图片描述 ', null, 'http://localhost:3002/', '1', '0', '2017-11-18 08:52:44', '2017-11-18 08:52:44', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('11', '1', '库或者文件中，成为某个url正常的页面的一部分，所有访问这个页面的所有用户都是受害者，看似正常的url，则其页面已经包含了xss代码，持久型XSS更具有隐蔽性，带来的危害也更大 例如：在页面中不容注意的地方加一段js脚本（如下），当页面被打开时，页面会加载这段脚本，加系统登录', null, 'http://localhost:3002/platform/assistance-list', '1', '0', '2017-11-19 06:28:57', '2017-11-19 06:28:57', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('12', '1', 'script节点的语句，载入来自第三方域的含有 具体恶意代码的脚本。具体的恶意代码，常见的行为是读取cookie，构造例如一个img标签，将其src属性指向 恶意第三方网站，将cookie的内容作为参数附在src的url上，这样黑客就能在其网', null, 'http://localhost:3002/platform/assistance-list', '1', '0', '2017-11-19 06:31:23', '2017-11-19 06:31:23', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('13', '1', 'XSS攻击： http://www.freebuf.com/articles/6295.html 简单的测试方法： 所有提交数据的地方都有可能存在XSS，可以用最简单脚本进行测试： XSS攻击类型 反射型： 黑客构造一个包含XSS代码的URL（服务器中没', null, 'http://localhost:3002/', '1', '0', '2017-11-19 10:15:26', '2017-11-19 10:15:26', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('14', '1', '此漏洞已经修复，请勿再测，造成访问压力。） 图片描述 持久型： 如果黑客可以将脚本代码通过发布内容（如发论坛、博文、写留言等）的方式发布后，存储在服务端的数据库或者文件中，成为某个url正常的页面的一部分，所有访问这个页面的所有用户都是受害者，看似正常的url，则其页面已经包含了xss代码，持久型XSS更具有隐蔽性，带来的危', null, 'http://localhost:3002/platform/assistance-list', '1', '0', '2017-11-19 10:17:02', '2017-11-19 10:17:02', null, '0', '0', null);
INSERT INTO `assistance` VALUES ('15', '1', 'dom xss并不复杂，他也属于反射型xss的一种(，domxss取决于输出位置，并不取决于输出环境， 因此domxss既有可能是反射型的，也有可能是存储型的)，简单去理解就是因为他输出点在DOM，所以', null, 'http://localhost:3002/platform/assistance-list', '1', '0', '2018-03-03 15:58:10', '2018-03-03 15:58:10', null, '1', '0', null);

-- ----------------------------
-- Table structure for `assistance_people`
-- ----------------------------
DROP TABLE IF EXISTS `assistance_people`;
CREATE TABLE `assistance_people` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `superior` int(11) DEFAULT NULL,
  `features` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of assistance_people
-- ----------------------------

-- ----------------------------
-- Table structure for `features`
-- ----------------------------
DROP TABLE IF EXISTS `features`;
CREATE TABLE `features` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `feature_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of features
-- ----------------------------
INSERT INTO `features` VALUES ('1', '教学工作站', '2017-11-18 15:28:10', '2017-11-18 15:28:13');
INSERT INTO `features` VALUES ('2', '销售工作站', '2017-11-18 15:28:25', '2017-11-18 15:28:30');
INSERT INTO `features` VALUES ('3', '市场工作站', '2017-11-18 15:28:42', '2017-11-18 15:28:45');
INSERT INTO `features` VALUES ('4', '数据管理', '2017-11-18 15:28:54', '2017-11-18 15:28:57');
INSERT INTO `features` VALUES ('5', '管理中心', '2017-11-18 15:29:08', '2017-11-18 15:29:11');
INSERT INTO `features` VALUES ('6', '用户管理', '2017-11-18 15:29:19', '2017-11-18 15:29:22');
INSERT INTO `features` VALUES ('7', '财务工作站', '2017-11-18 15:31:06', '2017-11-18 15:31:09');

-- ----------------------------
-- Table structure for `groups`
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_group` (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO `groups` VALUES ('6', '2', '3', '2018-04-28 17:35:30', '2018-04-28 17:35:32');
INSERT INTO `groups` VALUES ('7', '2', '1', '2018-04-28 13:16:33', '2018-04-28 13:16:36');
INSERT INTO `groups` VALUES ('8', '2', '2', '2018-06-11 13:10:12', '2018-06-11 13:10:15');
INSERT INTO `groups` VALUES ('9', '2', '4', '2018-06-11 13:10:25', '2018-06-11 13:10:28');
INSERT INTO `groups` VALUES ('10', '2', '5', '2018-06-11 13:10:38', '2018-06-11 13:10:40');
INSERT INTO `groups` VALUES ('11', '2', '6', '2018-06-11 13:10:50', '2018-06-11 13:10:55');
INSERT INTO `groups` VALUES ('12', '2', '7', '2019-02-15 15:25:02', '2019-02-15 15:25:02');
INSERT INTO `groups` VALUES ('15', '2', '8', '2019-02-16 14:21:49', '2019-02-16 14:21:49');
INSERT INTO `groups` VALUES ('16', '1', '1', '2019-05-08 14:58:10', '2019-05-08 14:58:10');
INSERT INTO `groups` VALUES ('17', '25', '2', '2019-05-08 14:58:37', '2019-05-08 14:58:37');
INSERT INTO `groups` VALUES ('20', '23', '6', '2019-05-19 23:10:19', '2019-05-19 23:10:19');
INSERT INTO `groups` VALUES ('21', '13', '7', '2019-06-28 14:40:07', '2019-06-28 14:40:07');
INSERT INTO `groups` VALUES ('22', '13', '6', '2019-06-28 14:40:07', '2019-06-28 14:40:07');
INSERT INTO `groups` VALUES ('23', '14', '8', '2019-07-28 19:22:27', '2019-07-28 19:22:27');
INSERT INTO `groups` VALUES ('24', '14', '7', '2019-07-28 19:22:27', '2019-07-28 19:22:27');
INSERT INTO `groups` VALUES ('25', '14', '6', '2019-07-28 19:22:27', '2019-07-28 19:22:27');
INSERT INTO `groups` VALUES ('26', '1', '8', '2019-08-16 10:08:42', '2019-08-16 10:08:42');
INSERT INTO `groups` VALUES ('27', '1', '7', '2019-08-16 10:08:42', '2019-08-16 10:08:42');
INSERT INTO `groups` VALUES ('29', '5', '8', '2019-08-16 10:08:59', '2019-08-16 10:08:59');
INSERT INTO `groups` VALUES ('30', '5', '3', '2019-08-16 10:08:59', '2019-08-16 10:08:59');
INSERT INTO `groups` VALUES ('33', '8', '8', '2019-08-16 10:11:18', '2019-08-16 10:11:18');
INSERT INTO `groups` VALUES ('34', '8', '3', '2019-08-16 10:11:18', '2019-08-16 10:11:18');
INSERT INTO `groups` VALUES ('36', '28', '8', '2019-09-03 14:50:28', '2019-09-03 14:50:28');
INSERT INTO `groups` VALUES ('43', '13', '8', '2019-09-17 10:40:41', '2019-09-17 10:40:41');

-- ----------------------------
-- Table structure for `helper_feature_relation`
-- ----------------------------
DROP TABLE IF EXISTS `helper_feature_relation`;
CREATE TABLE `helper_feature_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `helper_id` int(11) DEFAULT NULL,
  `feature_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of helper_feature_relation
-- ----------------------------

-- ----------------------------
-- Table structure for `helpers`
-- ----------------------------
DROP TABLE IF EXISTS `helpers`;
CREATE TABLE `helpers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `superior` int(11) DEFAULT NULL,
  `features` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of helpers
-- ----------------------------
INSERT INTO `helpers` VALUES ('1', '张三', '18734587454', 'zhangsan@qq.com', null, '教学工作站,销售工作站', '2017-10-24 23:11:10', '2017-10-24 23:11:14');
INSERT INTO `helpers` VALUES ('2', '李四', '12222222222', '12222222222@163.com', null, '财务工作站,用户管理', '2017-11-18 15:30:06', '2017-11-18 15:30:09');

-- ----------------------------
-- Table structure for `job_count`
-- ----------------------------
DROP TABLE IF EXISTS `job_count`;
CREATE TABLE `job_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_title` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '职位名称，开发语言',
  `region` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '上海' COMMENT '地区',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '职位数',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_title` (`job_title`),
  KEY `idx_region` (`region`)
) ENGINE=InnoDB AUTO_INCREMENT=757 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of job_count
-- ----------------------------
INSERT INTO `job_count` VALUES ('1', 'nodejs', '上海', '120', '2018-03-13 11:30:21');
INSERT INTO `job_count` VALUES ('2', 'golang', '上海', '90', '2018-03-13 11:30:44');
INSERT INTO `job_count` VALUES ('3', 'nodejs', '上海', '130', '2018-03-25 11:31:14');
INSERT INTO `job_count` VALUES ('4', 'golang', '上海', '110', '2018-03-25 11:31:43');
INSERT INTO `job_count` VALUES ('5', 'nodejs', '上海', '141', '2018-03-30 11:32:14');
INSERT INTO `job_count` VALUES ('6', 'golang', '上海', '117', '2018-03-30 11:32:40');
INSERT INTO `job_count` VALUES ('7', 'nodejs', '上海', '138', '2018-04-02 11:33:21');
INSERT INTO `job_count` VALUES ('8', 'golang', '上海', '116', '2018-04-02 11:33:44');
INSERT INTO `job_count` VALUES ('9', 'nodejs', '上海', '147', '2018-04-05 11:34:57');
INSERT INTO `job_count` VALUES ('10', 'golang', '上海', '128', '2018-04-05 11:35:17');
INSERT INTO `job_count` VALUES ('11', 'nodejs', '上海', '141', '2018-04-10 11:35:45');
INSERT INTO `job_count` VALUES ('12', 'golang', '上海', '130', '2018-04-10 11:36:04');
INSERT INTO `job_count` VALUES ('13', 'nodejs', '上海', '139', '2018-04-14 11:36:23');
INSERT INTO `job_count` VALUES ('14', 'golang', '上海', '133', '2018-04-14 11:36:40');
INSERT INTO `job_count` VALUES ('15', 'nodejs', '上海', '153', '2018-04-23 11:37:23');
INSERT INTO `job_count` VALUES ('16', 'golang', '上海', '143', '2018-04-23 11:37:44');
INSERT INTO `job_count` VALUES ('17', 'nodejs', '上海', '155', '2018-04-27 11:38:02');
INSERT INTO `job_count` VALUES ('18', 'golang', '上海', '144', '2018-04-27 11:38:26');
INSERT INTO `job_count` VALUES ('19', 'nodejs', '上海', '148', '2018-05-26 11:38:53');
INSERT INTO `job_count` VALUES ('20', 'golang', '上海', '165', '2018-05-26 11:39:24');
INSERT INTO `job_count` VALUES ('21', 'golang', '上海', '163', '2018-06-21 12:00:01');
INSERT INTO `job_count` VALUES ('22', 'nodejs', '上海', '135', '2018-06-21 12:00:01');
INSERT INTO `job_count` VALUES ('23', 'golang', '上海', '164', '2018-06-22 12:00:01');
INSERT INTO `job_count` VALUES ('24', 'nodejs', '上海', '137', '2018-06-22 12:00:01');
INSERT INTO `job_count` VALUES ('25', 'golang', '上海', '164', '2018-06-23 12:00:01');
INSERT INTO `job_count` VALUES ('26', 'nodejs', '上海', '138', '2018-06-23 12:00:01');
INSERT INTO `job_count` VALUES ('27', 'nodejs', '上海', '139', '2018-06-24 12:00:01');
INSERT INTO `job_count` VALUES ('28', 'golang', '上海', '164', '2018-06-24 12:00:01');
INSERT INTO `job_count` VALUES ('29', 'golang', '上海', '160', '2018-06-25 12:00:01');
INSERT INTO `job_count` VALUES ('30', 'nodejs', '上海', '138', '2018-06-25 12:00:01');
INSERT INTO `job_count` VALUES ('31', 'golang', '上海', '163', '2018-06-26 12:00:01');
INSERT INTO `job_count` VALUES ('32', 'nodejs', '上海', '138', '2018-06-26 12:00:01');
INSERT INTO `job_count` VALUES ('33', 'nodejs', '上海', '137', '2018-06-27 12:00:01');
INSERT INTO `job_count` VALUES ('34', 'golang', '上海', '163', '2018-06-27 12:00:01');
INSERT INTO `job_count` VALUES ('35', 'golang', '上海', '163', '2018-06-28 12:00:01');
INSERT INTO `job_count` VALUES ('36', 'nodejs', '上海', '135', '2018-06-28 12:00:01');
INSERT INTO `job_count` VALUES ('37', 'golang', '上海', '163', '2018-06-29 12:00:01');
INSERT INTO `job_count` VALUES ('38', 'nodejs', '上海', '138', '2018-06-29 12:00:01');
INSERT INTO `job_count` VALUES ('39', 'nodejs', '上海', '133', '2018-06-30 12:00:01');
INSERT INTO `job_count` VALUES ('40', 'golang', '上海', '166', '2018-06-30 12:00:01');
INSERT INTO `job_count` VALUES ('41', 'nodejs', '上海', '130', '2018-07-01 12:00:01');
INSERT INTO `job_count` VALUES ('42', 'golang', '上海', '166', '2018-07-01 12:00:01');
INSERT INTO `job_count` VALUES ('43', 'nodejs', '上海', '124', '2018-07-02 12:00:01');
INSERT INTO `job_count` VALUES ('44', 'golang', '上海', '164', '2018-07-02 12:00:01');
INSERT INTO `job_count` VALUES ('45', 'nodejs', '上海', '130', '2018-07-03 12:00:01');
INSERT INTO `job_count` VALUES ('46', 'golang', '上海', '167', '2018-07-03 12:00:01');
INSERT INTO `job_count` VALUES ('47', 'nodejs', '上海', '133', '2018-07-04 12:00:01');
INSERT INTO `job_count` VALUES ('48', 'golang', '上海', '168', '2018-07-04 12:00:01');
INSERT INTO `job_count` VALUES ('49', 'nodejs', '上海', '135', '2018-07-05 12:00:01');
INSERT INTO `job_count` VALUES ('50', 'golang', '上海', '169', '2018-07-05 12:00:01');
INSERT INTO `job_count` VALUES ('51', 'nodejs', '上海', '134', '2018-07-07 12:00:01');
INSERT INTO `job_count` VALUES ('52', 'golang', '上海', '173', '2018-07-07 12:00:01');
INSERT INTO `job_count` VALUES ('53', 'golang', '上海', '173', '2018-07-08 12:00:01');
INSERT INTO `job_count` VALUES ('54', 'nodejs', '上海', '133', '2018-07-08 12:00:01');
INSERT INTO `job_count` VALUES ('55', 'nodejs', '上海', '126', '2018-07-09 12:00:01');
INSERT INTO `job_count` VALUES ('56', 'golang', '上海', '168', '2018-07-09 12:00:01');
INSERT INTO `job_count` VALUES ('57', 'nodejs', '上海', '125', '2018-07-10 12:00:01');
INSERT INTO `job_count` VALUES ('58', 'golang', '上海', '172', '2018-07-10 12:00:01');
INSERT INTO `job_count` VALUES ('59', 'golang', '上海', '174', '2018-07-11 12:00:01');
INSERT INTO `job_count` VALUES ('60', 'nodejs', '上海', '129', '2018-07-11 12:00:01');
INSERT INTO `job_count` VALUES ('61', 'nodejs', '上海', '123', '2018-07-12 12:00:01');
INSERT INTO `job_count` VALUES ('62', 'golang', '上海', '175', '2018-07-12 12:00:01');
INSERT INTO `job_count` VALUES ('63', 'golang', '上海', '177', '2018-07-13 12:00:01');
INSERT INTO `job_count` VALUES ('64', 'nodejs', '上海', '121', '2018-07-13 12:00:01');
INSERT INTO `job_count` VALUES ('65', 'golang', '上海', '176', '2018-07-14 12:00:01');
INSERT INTO `job_count` VALUES ('66', 'nodejs', '上海', '121', '2018-07-14 12:00:01');
INSERT INTO `job_count` VALUES ('67', 'nodejs', '上海', '118', '2018-07-15 12:00:01');
INSERT INTO `job_count` VALUES ('68', 'golang', '上海', '174', '2018-07-15 12:00:01');
INSERT INTO `job_count` VALUES ('69', 'golang', '上海', '173', '2018-07-16 12:00:01');
INSERT INTO `job_count` VALUES ('70', 'nodejs', '上海', '121', '2018-07-16 12:00:01');
INSERT INTO `job_count` VALUES ('71', 'golang', '上海', '173', '2018-07-17 12:00:01');
INSERT INTO `job_count` VALUES ('72', 'nodejs', '上海', '120', '2018-07-17 12:00:01');
INSERT INTO `job_count` VALUES ('73', 'golang', '上海', '175', '2018-07-18 12:00:01');
INSERT INTO `job_count` VALUES ('74', 'nodejs', '上海', '121', '2018-07-18 12:00:01');
INSERT INTO `job_count` VALUES ('75', 'nodejs', '上海', '126', '2018-07-19 12:00:01');
INSERT INTO `job_count` VALUES ('76', 'golang', '上海', '176', '2018-07-19 12:00:01');
INSERT INTO `job_count` VALUES ('77', 'golang', '上海', '178', '2018-07-20 12:00:02');
INSERT INTO `job_count` VALUES ('78', 'nodejs', '上海', '123', '2018-07-20 12:00:02');
INSERT INTO `job_count` VALUES ('79', 'golang', '上海', '178', '2018-07-21 12:00:01');
INSERT INTO `job_count` VALUES ('80', 'nodejs', '上海', '124', '2018-07-21 12:00:01');
INSERT INTO `job_count` VALUES ('81', 'nodejs', '上海', '125', '2018-07-22 12:00:01');
INSERT INTO `job_count` VALUES ('82', 'golang', '上海', '179', '2018-07-22 12:00:01');
INSERT INTO `job_count` VALUES ('83', 'nodejs', '上海', '126', '2018-07-23 12:00:01');
INSERT INTO `job_count` VALUES ('84', 'golang', '上海', '179', '2018-07-23 12:00:02');
INSERT INTO `job_count` VALUES ('85', 'golang', '上海', '179', '2018-07-24 12:00:01');
INSERT INTO `job_count` VALUES ('86', 'nodejs', '上海', '128', '2018-07-24 12:00:01');
INSERT INTO `job_count` VALUES ('87', 'golang', '上海', '181', '2018-07-25 12:00:01');
INSERT INTO `job_count` VALUES ('88', 'nodejs', '上海', '124', '2018-07-25 12:00:01');
INSERT INTO `job_count` VALUES ('89', 'golang', '上海', '181', '2018-07-26 12:00:01');
INSERT INTO `job_count` VALUES ('90', 'nodejs', '上海', '124', '2018-07-26 12:00:01');
INSERT INTO `job_count` VALUES ('91', 'golang', '上海', '181', '2018-07-27 12:00:01');
INSERT INTO `job_count` VALUES ('92', 'nodejs', '上海', '124', '2018-07-27 12:00:01');
INSERT INTO `job_count` VALUES ('93', 'golang', '上海', '184', '2018-07-28 12:00:01');
INSERT INTO `job_count` VALUES ('94', 'nodejs', '上海', '125', '2018-07-28 12:00:01');
INSERT INTO `job_count` VALUES ('95', 'golang', '上海', '184', '2018-07-29 12:00:01');
INSERT INTO `job_count` VALUES ('96', 'nodejs', '上海', '125', '2018-07-29 12:00:01');
INSERT INTO `job_count` VALUES ('97', 'nodejs', '上海', '126', '2018-07-30 12:00:01');
INSERT INTO `job_count` VALUES ('98', 'golang', '上海', '187', '2018-07-30 12:00:01');
INSERT INTO `job_count` VALUES ('99', 'nodejs', '上海', '127', '2018-07-31 12:00:01');
INSERT INTO `job_count` VALUES ('100', 'golang', '上海', '191', '2018-07-31 12:00:01');
INSERT INTO `job_count` VALUES ('117', 'nodejs', '上海', '1271', '2018-08-11 12:01:24');
INSERT INTO `job_count` VALUES ('118', 'golang', '上海', '1308', '2018-08-11 12:01:24');
INSERT INTO `job_count` VALUES ('119', 'nodejs', '上海', '1229', '2018-09-02 12:01:24');
INSERT INTO `job_count` VALUES ('120', 'golang', '上海', '1269', '2018-09-02 12:01:24');
INSERT INTO `job_count` VALUES ('121', 'golang', '上海', '1263', '2018-09-09 12:00:01');
INSERT INTO `job_count` VALUES ('122', 'nodejs', '上海', '1201', '2018-09-09 12:00:01');
INSERT INTO `job_count` VALUES ('123', 'nodejs', '上海', '1199', '2018-09-10 12:00:01');
INSERT INTO `job_count` VALUES ('124', 'golang', '上海', '1256', '2018-09-10 12:00:01');
INSERT INTO `job_count` VALUES ('125', 'nodejs', '上海', '1206', '2018-09-11 12:00:01');
INSERT INTO `job_count` VALUES ('126', 'golang', '上海', '1265', '2018-09-11 12:00:01');
INSERT INTO `job_count` VALUES ('127', 'nodejs', '上海', '1227', '2018-09-12 12:00:01');
INSERT INTO `job_count` VALUES ('128', 'golang', '上海', '1290', '2018-09-12 12:00:01');
INSERT INTO `job_count` VALUES ('129', 'golang', '上海', '1282', '2018-09-13 12:00:01');
INSERT INTO `job_count` VALUES ('130', 'nodejs', '上海', '1213', '2018-09-13 12:00:01');
INSERT INTO `job_count` VALUES ('131', 'nodejs', '上海', '1212', '2018-09-14 12:00:01');
INSERT INTO `job_count` VALUES ('132', 'golang', '上海', '1280', '2018-09-14 12:00:02');
INSERT INTO `job_count` VALUES ('133', 'golang', '上海', '1274', '2018-09-15 12:00:01');
INSERT INTO `job_count` VALUES ('134', 'nodejs', '上海', '1199', '2018-09-15 12:00:01');
INSERT INTO `job_count` VALUES ('135', 'golang', '上海', '1271', '2018-09-16 12:00:01');
INSERT INTO `job_count` VALUES ('136', 'nodejs', '上海', '1196', '2018-09-16 12:00:01');
INSERT INTO `job_count` VALUES ('137', 'golang', '上海', '1269', '2018-09-17 12:00:01');
INSERT INTO `job_count` VALUES ('138', 'nodejs', '上海', '1188', '2018-09-17 12:00:01');
INSERT INTO `job_count` VALUES ('139', 'nodejs', '上海', '1199', '2018-09-18 12:00:01');
INSERT INTO `job_count` VALUES ('140', 'golang', '上海', '1282', '2018-09-18 12:00:02');
INSERT INTO `job_count` VALUES ('141', 'nodejs', '上海', '1209', '2018-09-19 12:00:01');
INSERT INTO `job_count` VALUES ('142', 'golang', '上海', '1290', '2018-09-19 12:00:01');
INSERT INTO `job_count` VALUES ('143', 'golang', '上海', '1279', '2018-09-20 12:00:01');
INSERT INTO `job_count` VALUES ('144', 'nodejs', '上海', '1207', '2018-09-20 12:00:01');
INSERT INTO `job_count` VALUES ('145', 'nodejs', '上海', '1195', '2018-09-21 12:00:02');
INSERT INTO `job_count` VALUES ('146', 'golang', '上海', '1258', '2018-09-21 12:00:02');
INSERT INTO `job_count` VALUES ('147', 'golang', '上海', '1261', '2018-09-22 12:00:01');
INSERT INTO `job_count` VALUES ('148', 'nodejs', '上海', '1205', '2018-09-22 12:00:01');
INSERT INTO `job_count` VALUES ('149', 'golang', '上海', '1252', '2018-09-23 12:00:01');
INSERT INTO `job_count` VALUES ('150', 'nodejs', '上海', '1188', '2018-09-23 12:00:01');
INSERT INTO `job_count` VALUES ('151', 'nodejs', '上海', '1179', '2018-09-24 12:00:01');
INSERT INTO `job_count` VALUES ('152', 'golang', '上海', '1249', '2018-09-24 12:00:01');
INSERT INTO `job_count` VALUES ('153', 'golang', '上海', '1250', '2018-09-25 12:00:01');
INSERT INTO `job_count` VALUES ('154', 'nodejs', '上海', '1183', '2018-09-25 12:00:01');
INSERT INTO `job_count` VALUES ('155', 'golang', '上海', '1248', '2018-09-26 12:00:01');
INSERT INTO `job_count` VALUES ('156', 'nodejs', '上海', '1192', '2018-09-26 12:00:01');
INSERT INTO `job_count` VALUES ('157', 'golang', '上海', '1246', '2018-09-27 12:00:01');
INSERT INTO `job_count` VALUES ('158', 'nodejs', '上海', '1190', '2018-09-27 12:00:01');
INSERT INTO `job_count` VALUES ('159', 'golang', '上海', '1242', '2018-09-28 12:00:01');
INSERT INTO `job_count` VALUES ('160', 'nodejs', '上海', '1191', '2018-09-28 12:00:01');
INSERT INTO `job_count` VALUES ('161', 'nodejs', '上海', '1186', '2018-09-29 12:00:01');
INSERT INTO `job_count` VALUES ('162', 'golang', '上海', '1246', '2018-09-29 12:00:01');
INSERT INTO `job_count` VALUES ('163', 'golang', '上海', '1240', '2018-09-30 12:00:01');
INSERT INTO `job_count` VALUES ('164', 'nodejs', '上海', '1170', '2018-09-30 12:00:01');
INSERT INTO `job_count` VALUES ('165', 'nodejs', '上海', '1158', '2018-10-01 12:00:01');
INSERT INTO `job_count` VALUES ('166', 'golang', '上海', '1236', '2018-10-01 12:00:01');
INSERT INTO `job_count` VALUES ('167', 'nodejs', '上海', '1154', '2018-10-02 12:00:01');
INSERT INTO `job_count` VALUES ('168', 'golang', '上海', '1236', '2018-10-02 12:00:01');
INSERT INTO `job_count` VALUES ('169', 'golang', '上海', '1239', '2018-10-03 12:00:01');
INSERT INTO `job_count` VALUES ('170', 'nodejs', '上海', '1152', '2018-10-03 12:00:01');
INSERT INTO `job_count` VALUES ('171', 'golang', '上海', '1216', '2018-10-04 12:00:01');
INSERT INTO `job_count` VALUES ('172', 'nodejs', '上海', '1135', '2018-10-04 12:00:01');
INSERT INTO `job_count` VALUES ('173', 'nodejs', '上海', '1123', '2018-10-05 12:00:01');
INSERT INTO `job_count` VALUES ('174', 'golang', '上海', '1194', '2018-10-05 12:00:01');
INSERT INTO `job_count` VALUES ('175', 'nodejs', '上海', '1111', '2018-10-06 12:00:01');
INSERT INTO `job_count` VALUES ('176', 'golang', '上海', '1180', '2018-10-06 12:00:01');
INSERT INTO `job_count` VALUES ('177', 'golang', '上海', '1173', '2018-10-07 12:00:01');
INSERT INTO `job_count` VALUES ('178', 'nodejs', '上海', '1102', '2018-10-07 12:00:02');
INSERT INTO `job_count` VALUES ('179', 'golang', '上海', '1170', '2018-10-08 12:00:01');
INSERT INTO `job_count` VALUES ('180', 'nodejs', '上海', '1096', '2018-10-08 12:00:02');
INSERT INTO `job_count` VALUES ('181', 'nodejs', '上海', '1109', '2018-10-09 12:00:01');
INSERT INTO `job_count` VALUES ('182', 'golang', '上海', '1181', '2018-10-09 12:00:01');
INSERT INTO `job_count` VALUES ('183', 'nodejs', '上海', '1125', '2018-10-10 12:00:01');
INSERT INTO `job_count` VALUES ('184', 'golang', '上海', '1201', '2018-10-10 12:00:01');
INSERT INTO `job_count` VALUES ('185', 'nodejs', '上海', '1126', '2018-10-11 12:00:00');
INSERT INTO `job_count` VALUES ('186', 'golang', '上海', '1127', '2018-10-11 12:00:00');
INSERT INTO `job_count` VALUES ('187', 'nodejs', '上海', '1120', '2018-10-12 12:00:01');
INSERT INTO `job_count` VALUES ('188', 'golang', '上海', '1189', '2018-10-12 12:00:01');
INSERT INTO `job_count` VALUES ('189', 'nodejs', '上海', '1111', '2018-10-13 12:00:01');
INSERT INTO `job_count` VALUES ('190', 'golang', '上海', '1180', '2018-10-13 12:00:02');
INSERT INTO `job_count` VALUES ('191', 'golang', '上海', '1163', '2018-10-14 12:00:01');
INSERT INTO `job_count` VALUES ('192', 'nodejs', '上海', '1103', '2018-10-14 12:00:01');
INSERT INTO `job_count` VALUES ('193', 'golang', '上海', '1154', '2018-10-15 12:00:01');
INSERT INTO `job_count` VALUES ('194', 'nodejs', '上海', '1101', '2018-10-15 12:00:01');
INSERT INTO `job_count` VALUES ('195', 'golang', '上海', '1170', '2018-10-16 12:00:01');
INSERT INTO `job_count` VALUES ('196', 'nodejs', '上海', '1099', '2018-10-16 12:00:01');
INSERT INTO `job_count` VALUES ('197', 'nodejs', '上海', '1099', '2018-10-17 12:00:01');
INSERT INTO `job_count` VALUES ('198', 'golang', '上海', '1170', '2018-10-17 12:00:01');
INSERT INTO `job_count` VALUES ('199', 'golang', '上海', '1167', '2018-10-18 12:00:01');
INSERT INTO `job_count` VALUES ('200', 'nodejs', '上海', '1085', '2018-10-18 12:00:01');
INSERT INTO `job_count` VALUES ('201', 'golang', '上海', '1171', '2018-10-19 12:00:02');
INSERT INTO `job_count` VALUES ('202', 'nodejs', '上海', '1075', '2018-10-19 12:00:02');
INSERT INTO `job_count` VALUES ('203', 'golang', '上海', '1155', '2018-10-20 12:00:01');
INSERT INTO `job_count` VALUES ('204', 'nodejs', '上海', '1076', '2018-10-20 12:00:01');
INSERT INTO `job_count` VALUES ('205', 'golang', '上海', '1144', '2018-10-21 12:00:02');
INSERT INTO `job_count` VALUES ('206', 'nodejs', '上海', '1063', '2018-10-21 12:00:02');
INSERT INTO `job_count` VALUES ('207', 'nodejs', '上海', '1064', '2018-10-22 12:00:01');
INSERT INTO `job_count` VALUES ('208', 'golang', '上海', '1139', '2018-10-22 12:00:01');
INSERT INTO `job_count` VALUES ('209', 'nodejs', '上海', '1085', '2018-10-23 12:00:02');
INSERT INTO `job_count` VALUES ('210', 'golang', '上海', '1147', '2018-10-23 12:00:02');
INSERT INTO `job_count` VALUES ('211', 'golang', '上海', '1155', '2018-10-24 12:00:01');
INSERT INTO `job_count` VALUES ('212', 'nodejs', '上海', '1100', '2018-10-24 12:00:01');
INSERT INTO `job_count` VALUES ('213', 'nodejs', '上海', '1104', '2018-10-25 12:00:02');
INSERT INTO `job_count` VALUES ('214', 'golang', '上海', '1163', '2018-10-25 12:00:02');
INSERT INTO `job_count` VALUES ('215', 'nodejs', '上海', '1099', '2018-10-26 12:00:01');
INSERT INTO `job_count` VALUES ('216', 'golang', '上海', '1167', '2018-10-26 12:00:01');
INSERT INTO `job_count` VALUES ('217', 'golang', '上海', '1159', '2018-10-27 12:00:01');
INSERT INTO `job_count` VALUES ('218', 'nodejs', '上海', '1088', '2018-10-27 12:00:02');
INSERT INTO `job_count` VALUES ('219', 'golang', '上海', '1148', '2018-10-28 12:00:01');
INSERT INTO `job_count` VALUES ('220', 'nodejs', '上海', '1072', '2018-10-28 12:00:01');
INSERT INTO `job_count` VALUES ('221', 'golang', '上海', '1132', '2018-10-29 12:00:01');
INSERT INTO `job_count` VALUES ('222', 'nodejs', '上海', '1063', '2018-10-29 12:00:01');
INSERT INTO `job_count` VALUES ('223', 'golang', '上海', '1133', '2018-10-30 12:00:01');
INSERT INTO `job_count` VALUES ('224', 'nodejs', '上海', '1062', '2018-10-30 12:00:01');
INSERT INTO `job_count` VALUES ('225', 'golang', '上海', '1146', '2018-10-31 12:00:01');
INSERT INTO `job_count` VALUES ('226', 'nodejs', '上海', '1055', '2018-10-31 12:00:01');
INSERT INTO `job_count` VALUES ('227', 'golang', '上海', '1158', '2018-11-01 12:00:01');
INSERT INTO `job_count` VALUES ('228', 'nodejs', '上海', '1066', '2018-11-01 12:00:01');
INSERT INTO `job_count` VALUES ('229', 'golang', '上海', '1162', '2018-11-02 12:00:00');
INSERT INTO `job_count` VALUES ('230', 'nodejs', '上海', '1066', '2018-11-02 12:00:01');
INSERT INTO `job_count` VALUES ('231', 'nodejs', '上海', '1071', '2018-11-03 12:00:00');
INSERT INTO `job_count` VALUES ('232', 'golang', '上海', '1166', '2018-11-03 12:00:02');
INSERT INTO `job_count` VALUES ('233', 'golang', '上海', '1168', '2018-11-04 12:00:00');
INSERT INTO `job_count` VALUES ('234', 'nodejs', '上海', '1072', '2018-11-04 12:00:01');
INSERT INTO `job_count` VALUES ('235', 'nodejs', '上海', '1075', '2018-11-05 12:00:00');
INSERT INTO `job_count` VALUES ('236', 'golang', '上海', '1167', '2018-11-05 12:00:01');
INSERT INTO `job_count` VALUES ('237', 'nodejs', '上海', '1066', '2018-11-06 12:00:01');
INSERT INTO `job_count` VALUES ('238', 'golang', '上海', '1151', '2018-11-06 12:00:01');
INSERT INTO `job_count` VALUES ('239', 'nodejs', '上海', '1061', '2018-11-07 12:00:01');
INSERT INTO `job_count` VALUES ('240', 'golang', '上海', '1154', '2018-11-07 12:00:01');
INSERT INTO `job_count` VALUES ('241', 'golang', '上海', '1120', '2018-11-13 12:00:01');
INSERT INTO `job_count` VALUES ('242', 'nodejs', '上海', '1051', '2018-11-13 12:00:01');
INSERT INTO `job_count` VALUES ('243', 'golang', '上海', '1140', '2018-11-14 12:00:00');
INSERT INTO `job_count` VALUES ('244', 'nodejs', '上海', '1069', '2018-11-14 12:00:01');
INSERT INTO `job_count` VALUES ('245', 'golang', '上海', '1139', '2018-11-15 12:00:01');
INSERT INTO `job_count` VALUES ('246', 'nodejs', '上海', '1054', '2018-11-15 12:00:01');
INSERT INTO `job_count` VALUES ('247', 'nodejs', '上海', '1049', '2018-11-16 12:00:01');
INSERT INTO `job_count` VALUES ('248', 'golang', '上海', '1135', '2018-11-16 12:00:01');
INSERT INTO `job_count` VALUES ('249', 'golang', '上海', '1144', '2018-11-17 12:00:01');
INSERT INTO `job_count` VALUES ('250', 'nodejs', '上海', '1045', '2018-11-17 12:00:01');
INSERT INTO `job_count` VALUES ('251', 'golang', '上海', '1130', '2018-11-18 12:00:01');
INSERT INTO `job_count` VALUES ('252', 'nodejs', '上海', '1040', '2018-11-18 12:00:01');
INSERT INTO `job_count` VALUES ('253', 'nodejs', '上海', '1036', '2018-11-19 12:00:01');
INSERT INTO `job_count` VALUES ('254', 'golang', '上海', '1134', '2018-11-19 12:00:01');
INSERT INTO `job_count` VALUES ('255', 'golang', '上海', '1144', '2018-11-20 12:00:01');
INSERT INTO `job_count` VALUES ('256', 'nodejs', '上海', '1044', '2018-11-20 12:00:01');
INSERT INTO `job_count` VALUES ('257', 'golang', '上海', '1150', '2018-11-21 12:00:01');
INSERT INTO `job_count` VALUES ('258', 'nodejs', '上海', '1049', '2018-11-21 12:00:01');
INSERT INTO `job_count` VALUES ('259', 'golang', '上海', '1143', '2018-11-22 12:00:01');
INSERT INTO `job_count` VALUES ('260', 'nodejs', '上海', '1044', '2018-11-22 12:00:01');
INSERT INTO `job_count` VALUES ('261', 'nodejs', '上海', '1043', '2018-11-23 12:00:00');
INSERT INTO `job_count` VALUES ('262', 'golang', '上海', '1150', '2018-11-23 12:00:01');
INSERT INTO `job_count` VALUES ('263', 'golang', '上海', '1148', '2018-11-24 12:00:01');
INSERT INTO `job_count` VALUES ('264', 'nodejs', '上海', '1046', '2018-11-24 12:00:01');
INSERT INTO `job_count` VALUES ('265', 'golang', '上海', '1142', '2018-11-25 12:00:01');
INSERT INTO `job_count` VALUES ('266', 'nodejs', '上海', '1042', '2018-11-25 12:00:01');
INSERT INTO `job_count` VALUES ('267', 'nodejs', '上海', '1041', '2018-11-26 12:00:01');
INSERT INTO `job_count` VALUES ('268', 'golang', '上海', '1133', '2018-11-26 12:00:01');
INSERT INTO `job_count` VALUES ('269', 'nodejs', '上海', '1049', '2018-11-27 12:00:00');
INSERT INTO `job_count` VALUES ('270', 'golang', '上海', '1130', '2018-11-27 12:00:01');
INSERT INTO `job_count` VALUES ('271', 'nodejs', '上海', '1062', '2018-11-28 12:00:00');
INSERT INTO `job_count` VALUES ('272', 'golang', '上海', '1143', '2018-11-28 12:00:01');
INSERT INTO `job_count` VALUES ('273', 'golang', '上海', '1134', '2018-11-29 12:00:01');
INSERT INTO `job_count` VALUES ('274', 'nodejs', '上海', '1048', '2018-11-29 12:00:01');
INSERT INTO `job_count` VALUES ('276', 'nodejs', '上海', '1052', '2018-11-30 12:00:01');
INSERT INTO `job_count` VALUES ('278', 'golang', '上海', '1071', '2018-12-01 12:00:00');
INSERT INTO `job_count` VALUES ('279', 'golang', '上海', '1074', '2018-12-02 12:00:01');
INSERT INTO `job_count` VALUES ('280', 'nodejs', '上海', '1044', '2018-12-02 12:00:01');
INSERT INTO `job_count` VALUES ('281', 'nodejs', '上海', '1030', '2018-12-03 12:00:00');
INSERT INTO `job_count` VALUES ('282', 'golang', '上海', '1082', '2018-12-03 12:00:00');
INSERT INTO `job_count` VALUES ('285', 'nodejs', '上海', '1042', '2018-12-05 12:00:01');
INSERT INTO `job_count` VALUES ('286', 'golang', '上海', '1091', '2018-12-05 12:00:01');
INSERT INTO `job_count` VALUES ('287', 'golang', '上海', '1098', '2018-12-06 12:00:01');
INSERT INTO `job_count` VALUES ('288', 'nodejs', '上海', '1047', '2018-12-06 12:00:01');
INSERT INTO `job_count` VALUES ('289', 'golang', '上海', '1101', '2018-12-07 12:00:01');
INSERT INTO `job_count` VALUES ('290', 'nodejs', '上海', '1046', '2018-12-07 12:00:01');
INSERT INTO `job_count` VALUES ('291', 'nodejs', '上海', '1046', '2018-12-08 12:00:01');
INSERT INTO `job_count` VALUES ('292', 'golang', '上海', '1093', '2018-12-08 12:00:01');
INSERT INTO `job_count` VALUES ('293', 'nodejs', '上海', '1042', '2018-12-09 12:00:01');
INSERT INTO `job_count` VALUES ('294', 'golang', '上海', '1086', '2018-12-09 12:00:01');
INSERT INTO `job_count` VALUES ('295', 'golang', '上海', '1084', '2018-12-10 12:00:00');
INSERT INTO `job_count` VALUES ('296', 'nodejs', '上海', '1040', '2018-12-10 12:00:01');
INSERT INTO `job_count` VALUES ('297', 'nodejs', '上海', '1050', '2018-12-11 12:00:01');
INSERT INTO `job_count` VALUES ('298', 'golang', '上海', '1093', '2018-12-11 12:00:01');
INSERT INTO `job_count` VALUES ('299', 'golang', '上海', '1096', '2018-12-12 12:00:01');
INSERT INTO `job_count` VALUES ('300', 'nodejs', '上海', '1056', '2018-12-12 12:00:01');
INSERT INTO `job_count` VALUES ('301', 'golang', '上海', '1086', '2018-12-13 12:00:01');
INSERT INTO `job_count` VALUES ('302', 'nodejs', '上海', '1051', '2018-12-13 12:00:01');
INSERT INTO `job_count` VALUES ('304', 'nodejs', '上海', '1048', '2018-12-14 12:00:00');
INSERT INTO `job_count` VALUES ('305', 'nodejs', '上海', '1042', '2018-12-15 12:00:01');
INSERT INTO `job_count` VALUES ('306', 'golang', '上海', '1086', '2018-12-15 12:00:01');
INSERT INTO `job_count` VALUES ('307', 'golang', '上海', '1084', '2018-12-16 12:00:01');
INSERT INTO `job_count` VALUES ('308', 'nodejs', '上海', '1035', '2018-12-16 12:00:01');
INSERT INTO `job_count` VALUES ('309', 'nodejs', '上海', '1031', '2018-12-17 12:00:01');
INSERT INTO `job_count` VALUES ('310', 'golang', '上海', '1078', '2018-12-17 12:00:01');
INSERT INTO `job_count` VALUES ('311', 'nodejs', '上海', '1029', '2018-12-18 12:00:01');
INSERT INTO `job_count` VALUES ('312', 'golang', '上海', '1097', '2018-12-18 12:00:01');
INSERT INTO `job_count` VALUES ('313', 'golang', '上海', '1096', '2018-12-19 12:00:01');
INSERT INTO `job_count` VALUES ('314', 'nodejs', '上海', '1033', '2018-12-19 12:00:01');
INSERT INTO `job_count` VALUES ('315', 'nodejs', '上海', '1033', '2018-12-20 12:00:00');
INSERT INTO `job_count` VALUES ('316', 'golang', '上海', '1096', '2018-12-20 12:00:01');
INSERT INTO `job_count` VALUES ('321', 'nodejs', '上海', '1026', '2018-12-25 15:24:01');
INSERT INTO `job_count` VALUES ('322', 'golang', '上海', '1097', '2018-12-25 15:24:01');
INSERT INTO `job_count` VALUES ('323', 'golang', '上海', '1085', '2018-12-26 12:00:00');
INSERT INTO `job_count` VALUES ('324', 'nodejs', '上海', '1020', '2018-12-26 12:00:01');
INSERT INTO `job_count` VALUES ('325', 'nodejs', '上海', '1017', '2018-12-27 12:00:01');
INSERT INTO `job_count` VALUES ('326', 'golang', '上海', '1080', '2018-12-27 12:00:01');
INSERT INTO `job_count` VALUES ('327', 'nodejs', '上海', '1008', '2018-12-28 12:00:01');
INSERT INTO `job_count` VALUES ('328', 'golang', '上海', '1074', '2018-12-28 12:00:01');
INSERT INTO `job_count` VALUES ('329', 'golang', '上海', '1081', '2018-12-29 12:00:01');
INSERT INTO `job_count` VALUES ('330', 'nodejs', '上海', '1002', '2018-12-29 12:00:01');
INSERT INTO `job_count` VALUES ('331', 'nodejs', '上海', '999', '2018-12-30 12:00:01');
INSERT INTO `job_count` VALUES ('332', 'golang', '上海', '1080', '2018-12-30 12:00:01');
INSERT INTO `job_count` VALUES ('333', 'golang', '上海', '1079', '2018-12-31 12:00:01');
INSERT INTO `job_count` VALUES ('334', 'nodejs', '上海', '993', '2018-12-31 12:00:01');
INSERT INTO `job_count` VALUES ('335', 'golang', '上海', '1076', '2019-01-01 12:00:01');
INSERT INTO `job_count` VALUES ('336', 'nodejs', '上海', '993', '2019-01-01 12:00:01');
INSERT INTO `job_count` VALUES ('337', 'nodejs', '上海', '998', '2019-01-02 12:00:01');
INSERT INTO `job_count` VALUES ('338', 'golang', '上海', '1075', '2019-01-02 12:00:01');
INSERT INTO `job_count` VALUES ('339', 'nodejs', '上海', '992', '2019-01-03 12:00:01');
INSERT INTO `job_count` VALUES ('340', 'golang', '上海', '1067', '2019-01-03 12:00:01');
INSERT INTO `job_count` VALUES ('341', 'nodejs', '上海', '986', '2019-01-04 12:00:01');
INSERT INTO `job_count` VALUES ('342', 'golang', '上海', '440', '2019-01-04 12:00:01');
INSERT INTO `job_count` VALUES ('349', 'golang', '上海', '1031', '2019-01-11 18:51:00');
INSERT INTO `job_count` VALUES ('350', 'nodejs', '上海', '960', '2019-01-11 18:51:00');
INSERT INTO `job_count` VALUES ('351', 'nodejs', '上海', '940', '2019-01-14 13:20:13');
INSERT INTO `job_count` VALUES ('352', 'golang', '上海', '1012', '2019-01-14 13:20:22');
INSERT INTO `job_count` VALUES ('353', 'nodejs', '上海', '954', '2019-01-16 18:57:01');
INSERT INTO `job_count` VALUES ('354', 'golang', '上海', '1010', '2019-01-16 18:58:43');
INSERT INTO `job_count` VALUES ('355', 'nodejs', '上海', '918', '2019-01-17 16:05:41');
INSERT INTO `job_count` VALUES ('356', 'golang', '上海', '1011', '2019-01-17 16:05:49');
INSERT INTO `job_count` VALUES ('357', 'nodejs', '上海', '920', '2019-01-18 16:17:14');
INSERT INTO `job_count` VALUES ('358', 'golang', '上海', '1012', '2019-01-18 16:17:22');
INSERT INTO `job_count` VALUES ('359', 'nodejs', '上海', '913', '2019-01-19 14:11:33');
INSERT INTO `job_count` VALUES ('360', 'golang', '上海', '447', '2019-01-19 14:12:00');
INSERT INTO `job_count` VALUES ('361', 'nodejs', '上海', '905', '2019-01-21 13:36:58');
INSERT INTO `job_count` VALUES ('362', 'golang', '上海', '999', '2019-01-21 13:37:07');
INSERT INTO `job_count` VALUES ('363', 'nodejs', '上海', '793', '2019-02-16 15:44:17');
INSERT INTO `job_count` VALUES ('364', 'golang', '上海', '421', '2019-02-16 15:44:29');
INSERT INTO `job_count` VALUES ('365', 'nodejs', '上海', '500', '2019-05-15 12:58:41');
INSERT INTO `job_count` VALUES ('366', 'golang', '上海', '427', '2019-05-15 12:58:58');
INSERT INTO `job_count` VALUES ('367', 'nodejs', '上海', '385', '2019-11-17 15:04:11');
INSERT INTO `job_count` VALUES ('368', 'golang', '上海', '126', '2019-11-17 15:04:26');
INSERT INTO `job_count` VALUES ('369', 'nodejs', '上海', '20', '2020-01-15 18:15:55');
INSERT INTO `job_count` VALUES ('370', 'golang', '上海', '123', '2020-01-15 18:16:16');
INSERT INTO `job_count` VALUES ('373', 'nodejs', '上海', '285', '2020-01-16 18:54:00');
INSERT INTO `job_count` VALUES ('374', 'golang', '上海', '120', '2020-01-16 18:54:00');
INSERT INTO `job_count` VALUES ('375', 'nodejs', '上海', '288', '2020-01-17 12:54:01');
INSERT INTO `job_count` VALUES ('376', 'golang', '上海', '120', '2020-01-17 12:54:01');
INSERT INTO `job_count` VALUES ('377', 'nodejs', '上海', '283', '2020-01-18 12:00:01');
INSERT INTO `job_count` VALUES ('378', 'golang', '上海', '120', '2020-01-18 12:00:01');
INSERT INTO `job_count` VALUES ('379', 'golang', '上海', '120', '2020-01-19 12:00:01');
INSERT INTO `job_count` VALUES ('380', 'nodejs', '上海', '284', '2020-01-19 12:00:01');
INSERT INTO `job_count` VALUES ('381', 'golang', '上海', '121', '2020-01-20 12:00:00');
INSERT INTO `job_count` VALUES ('382', 'nodejs', '上海', '285', '2020-01-20 12:00:00');
INSERT INTO `job_count` VALUES ('383', 'nodejs', '上海', '283', '2020-01-21 12:00:01');
INSERT INTO `job_count` VALUES ('384', 'golang', '上海', '119', '2020-01-21 12:00:01');
INSERT INTO `job_count` VALUES ('385', 'golang', '上海', '119', '2020-01-22 12:00:00');
INSERT INTO `job_count` VALUES ('386', 'nodejs', '上海', '286', '2020-01-22 12:00:00');
INSERT INTO `job_count` VALUES ('387', 'golang', '上海', '119', '2020-01-23 12:00:01');
INSERT INTO `job_count` VALUES ('388', 'nodejs', '上海', '285', '2020-01-23 12:00:01');
INSERT INTO `job_count` VALUES ('389', 'nodejs', '上海', '284', '2020-01-24 12:00:00');
INSERT INTO `job_count` VALUES ('390', 'golang', '上海', '119', '2020-01-24 12:00:00');
INSERT INTO `job_count` VALUES ('391', 'golang', '上海', '119', '2020-01-25 12:00:00');
INSERT INTO `job_count` VALUES ('392', 'nodejs', '上海', '285', '2020-01-25 12:00:00');
INSERT INTO `job_count` VALUES ('393', 'golang', '上海', '119', '2020-01-26 12:00:00');
INSERT INTO `job_count` VALUES ('394', 'nodejs', '上海', '286', '2020-01-26 12:00:00');
INSERT INTO `job_count` VALUES ('395', 'golang', '上海', '119', '2020-01-27 12:00:00');
INSERT INTO `job_count` VALUES ('396', 'nodejs', '上海', '286', '2020-01-27 12:00:00');
INSERT INTO `job_count` VALUES ('397', 'golang', '上海', '119', '2020-01-28 12:00:00');
INSERT INTO `job_count` VALUES ('398', 'nodejs', '上海', '285', '2020-01-28 12:00:00');
INSERT INTO `job_count` VALUES ('399', 'golang', '上海', '119', '2020-01-29 12:00:00');
INSERT INTO `job_count` VALUES ('400', 'nodejs', '上海', '286', '2020-01-29 12:00:00');
INSERT INTO `job_count` VALUES ('401', 'golang', '上海', '119', '2020-01-30 12:00:00');
INSERT INTO `job_count` VALUES ('402', 'nodejs', '上海', '287', '2020-01-30 12:00:00');
INSERT INTO `job_count` VALUES ('403', 'golang', '上海', '119', '2020-01-31 12:00:01');
INSERT INTO `job_count` VALUES ('404', 'nodejs', '上海', '286', '2020-01-31 12:00:01');
INSERT INTO `job_count` VALUES ('405', 'nodejs', '上海', '286', '2020-02-01 12:00:01');
INSERT INTO `job_count` VALUES ('406', 'golang', '上海', '119', '2020-02-01 12:00:01');
INSERT INTO `job_count` VALUES ('407', 'golang', '上海', '120', '2020-02-02 12:00:01');
INSERT INTO `job_count` VALUES ('408', 'nodejs', '上海', '287', '2020-02-02 12:00:01');
INSERT INTO `job_count` VALUES ('409', 'golang', '上海', '119', '2020-02-03 12:00:00');
INSERT INTO `job_count` VALUES ('410', 'nodejs', '上海', '288', '2020-02-03 12:00:01');
INSERT INTO `job_count` VALUES ('411', 'golang', '上海', '119', '2020-02-04 12:00:01');
INSERT INTO `job_count` VALUES ('412', 'nodejs', '上海', '292', '2020-02-04 12:00:01');
INSERT INTO `job_count` VALUES ('413', 'nodejs', '上海', '293', '2020-02-05 12:00:00');
INSERT INTO `job_count` VALUES ('414', 'golang', '上海', '119', '2020-02-05 12:00:00');
INSERT INTO `job_count` VALUES ('415', 'golang', '上海', '116', '2020-02-06 12:00:01');
INSERT INTO `job_count` VALUES ('416', 'nodejs', '上海', '295', '2020-02-06 12:00:01');
INSERT INTO `job_count` VALUES ('417', 'golang', '上海', '119', '2020-02-07 12:00:00');
INSERT INTO `job_count` VALUES ('418', 'nodejs', '上海', '296', '2020-02-07 12:00:00');
INSERT INTO `job_count` VALUES ('419', 'golang', '上海', '120', '2020-02-08 12:00:00');
INSERT INTO `job_count` VALUES ('420', 'nodejs', '上海', '297', '2020-02-08 12:00:00');
INSERT INTO `job_count` VALUES ('421', 'golang', '上海', '120', '2020-02-09 12:00:00');
INSERT INTO `job_count` VALUES ('422', 'nodejs', '上海', '296', '2020-02-09 12:00:00');
INSERT INTO `job_count` VALUES ('423', 'golang', '上海', '119', '2020-02-10 12:00:00');
INSERT INTO `job_count` VALUES ('424', 'nodejs', '上海', '296', '2020-02-10 12:00:01');
INSERT INTO `job_count` VALUES ('425', 'golang', '上海', '116', '2020-02-11 12:00:01');
INSERT INTO `job_count` VALUES ('426', 'nodejs', '上海', '299', '2020-02-11 12:00:01');
INSERT INTO `job_count` VALUES ('427', 'nodejs', '上海', '305', '2020-02-12 12:00:01');
INSERT INTO `job_count` VALUES ('428', 'golang', '上海', '119', '2020-02-12 12:00:01');
INSERT INTO `job_count` VALUES ('429', 'golang', '上海', '119', '2020-02-13 12:00:01');
INSERT INTO `job_count` VALUES ('430', 'nodejs', '上海', '305', '2020-02-13 12:00:01');
INSERT INTO `job_count` VALUES ('431', 'golang', '上海', '119', '2020-02-14 12:00:01');
INSERT INTO `job_count` VALUES ('432', 'nodejs', '上海', '308', '2020-02-14 12:00:01');
INSERT INTO `job_count` VALUES ('433', 'nodejs', '上海', '306', '2020-02-15 12:00:01');
INSERT INTO `job_count` VALUES ('434', 'golang', '上海', '119', '2020-02-15 12:00:01');
INSERT INTO `job_count` VALUES ('435', 'nodejs', '上海', '307', '2020-02-16 12:00:01');
INSERT INTO `job_count` VALUES ('436', 'golang', '上海', '119', '2020-02-16 12:00:01');
INSERT INTO `job_count` VALUES ('437', 'golang', '上海', '117', '2020-02-17 12:00:01');
INSERT INTO `job_count` VALUES ('438', 'nodejs', '上海', '305', '2020-02-17 12:00:01');
INSERT INTO `job_count` VALUES ('439', 'nodejs', '上海', '311', '2020-02-18 12:00:01');
INSERT INTO `job_count` VALUES ('440', 'golang', '上海', '118', '2020-02-18 12:00:01');
INSERT INTO `job_count` VALUES ('441', 'golang', '上海', '119', '2020-02-19 12:00:00');
INSERT INTO `job_count` VALUES ('442', 'nodejs', '上海', '309', '2020-02-19 12:00:01');
INSERT INTO `job_count` VALUES ('443', 'golang', '上海', '120', '2020-02-20 12:00:00');
INSERT INTO `job_count` VALUES ('444', 'nodejs', '上海', '322', '2020-02-20 12:00:01');
INSERT INTO `job_count` VALUES ('445', 'golang', '上海', '123', '2020-02-21 12:00:00');
INSERT INTO `job_count` VALUES ('446', 'nodejs', '上海', '317', '2020-02-21 12:00:00');
INSERT INTO `job_count` VALUES ('447', 'nodejs', '上海', '318', '2020-02-22 12:00:00');
INSERT INTO `job_count` VALUES ('448', 'golang', '上海', '123', '2020-02-22 12:00:00');
INSERT INTO `job_count` VALUES ('449', 'nodejs', '上海', '317', '2020-02-23 12:00:01');
INSERT INTO `job_count` VALUES ('450', 'golang', '上海', '123', '2020-02-23 12:00:01');
INSERT INTO `job_count` VALUES ('451', 'nodejs', '上海', '315', '2020-02-24 12:00:01');
INSERT INTO `job_count` VALUES ('452', 'golang', '上海', '125', '2020-02-24 12:00:01');
INSERT INTO `job_count` VALUES ('453', 'golang', '上海', '128', '2020-02-25 12:00:01');
INSERT INTO `job_count` VALUES ('454', 'nodejs', '上海', '318', '2020-02-25 12:00:01');
INSERT INTO `job_count` VALUES ('455', 'nodejs', '上海', '313', '2020-02-26 12:00:01');
INSERT INTO `job_count` VALUES ('456', 'golang', '上海', '128', '2020-02-26 12:00:01');
INSERT INTO `job_count` VALUES ('457', 'nodejs', '上海', '313', '2020-02-27 12:00:01');
INSERT INTO `job_count` VALUES ('458', 'golang', '上海', '129', '2020-02-27 12:00:01');
INSERT INTO `job_count` VALUES ('459', 'golang', '上海', '133', '2020-02-28 12:00:00');
INSERT INTO `job_count` VALUES ('460', 'nodejs', '上海', '318', '2020-02-28 12:00:01');
INSERT INTO `job_count` VALUES ('461', 'golang', '上海', '133', '2020-02-29 12:00:00');
INSERT INTO `job_count` VALUES ('462', 'nodejs', '上海', '323', '2020-02-29 12:00:00');
INSERT INTO `job_count` VALUES ('463', 'golang', '上海', '133', '2020-03-01 12:00:00');
INSERT INTO `job_count` VALUES ('464', 'nodejs', '上海', '325', '2020-03-01 12:00:00');
INSERT INTO `job_count` VALUES ('465', 'golang', '上海', '134', '2020-03-02 12:00:01');
INSERT INTO `job_count` VALUES ('466', 'nodejs', '上海', '325', '2020-03-02 12:00:01');
INSERT INTO `job_count` VALUES ('467', 'nodejs', '上海', '330', '2020-03-03 12:00:00');
INSERT INTO `job_count` VALUES ('468', 'golang', '上海', '130', '2020-03-03 12:00:00');
INSERT INTO `job_count` VALUES ('469', 'nodejs', '上海', '333', '2020-03-04 12:00:01');
INSERT INTO `job_count` VALUES ('470', 'golang', '上海', '130', '2020-03-04 12:00:01');
INSERT INTO `job_count` VALUES ('471', 'golang', '上海', '127', '2020-03-05 12:00:01');
INSERT INTO `job_count` VALUES ('472', 'nodejs', '上海', '335', '2020-03-05 12:00:01');
INSERT INTO `job_count` VALUES ('473', 'nodejs', '上海', '337', '2020-03-06 12:00:01');
INSERT INTO `job_count` VALUES ('474', 'golang', '上海', '128', '2020-03-06 12:00:01');
INSERT INTO `job_count` VALUES ('475', 'nodejs', '上海', '330', '2020-03-07 12:00:01');
INSERT INTO `job_count` VALUES ('476', 'golang', '上海', '128', '2020-03-07 12:00:01');
INSERT INTO `job_count` VALUES ('477', 'nodejs', '上海', '329', '2020-03-08 12:00:00');
INSERT INTO `job_count` VALUES ('478', 'golang', '上海', '129', '2020-03-08 12:00:00');
INSERT INTO `job_count` VALUES ('479', 'nodejs', '上海', '329', '2020-03-09 12:00:00');
INSERT INTO `job_count` VALUES ('480', 'golang', '上海', '128', '2020-03-09 12:00:00');
INSERT INTO `job_count` VALUES ('481', 'golang', '上海', '127', '2020-03-10 12:00:01');
INSERT INTO `job_count` VALUES ('482', 'nodejs', '上海', '328', '2020-03-10 12:00:01');
INSERT INTO `job_count` VALUES ('483', 'golang', '上海', '129', '2020-03-11 12:00:01');
INSERT INTO `job_count` VALUES ('484', 'nodejs', '上海', '328', '2020-03-11 12:00:01');
INSERT INTO `job_count` VALUES ('485', 'golang', '上海', '133', '2020-03-12 12:00:01');
INSERT INTO `job_count` VALUES ('486', 'nodejs', '上海', '329', '2020-03-12 12:00:01');
INSERT INTO `job_count` VALUES ('487', 'nodejs', '上海', '336', '2020-03-13 12:00:01');
INSERT INTO `job_count` VALUES ('488', 'golang', '上海', '140', '2020-03-13 12:00:01');
INSERT INTO `job_count` VALUES ('489', 'nodejs', '上海', '328', '2020-03-14 12:00:00');
INSERT INTO `job_count` VALUES ('490', 'golang', '上海', '140', '2020-03-14 12:00:00');
INSERT INTO `job_count` VALUES ('491', 'golang', '上海', '143', '2020-03-15 12:00:01');
INSERT INTO `job_count` VALUES ('492', 'nodejs', '上海', '325', '2020-03-15 12:00:01');
INSERT INTO `job_count` VALUES ('493', 'nodejs', '上海', '325', '2020-03-16 12:00:01');
INSERT INTO `job_count` VALUES ('494', 'golang', '上海', '143', '2020-03-16 12:00:01');
INSERT INTO `job_count` VALUES ('495', 'golang', '上海', '146', '2020-03-17 12:00:01');
INSERT INTO `job_count` VALUES ('496', 'nodejs', '上海', '330', '2020-03-17 12:00:01');
INSERT INTO `job_count` VALUES ('497', 'nodejs', '上海', '335', '2020-03-18 12:00:01');
INSERT INTO `job_count` VALUES ('498', 'golang', '上海', '146', '2020-03-18 12:00:01');
INSERT INTO `job_count` VALUES ('499', 'nodejs', '上海', '349', '2020-03-19 12:00:01');
INSERT INTO `job_count` VALUES ('500', 'golang', '上海', '152', '2020-03-19 12:00:01');
INSERT INTO `job_count` VALUES ('501', 'golang', '上海', '158', '2020-03-20 12:00:01');
INSERT INTO `job_count` VALUES ('502', 'nodejs', '上海', '356', '2020-03-20 12:00:01');
INSERT INTO `job_count` VALUES ('503', 'golang', '上海', '158', '2020-03-21 12:00:01');
INSERT INTO `job_count` VALUES ('504', 'nodejs', '上海', '355', '2020-03-21 12:00:01');
INSERT INTO `job_count` VALUES ('505', 'nodejs', '上海', '355', '2020-03-22 12:00:01');
INSERT INTO `job_count` VALUES ('506', 'golang', '上海', '160', '2020-03-22 12:00:01');
INSERT INTO `job_count` VALUES ('507', 'golang', '上海', '160', '2020-03-23 12:00:00');
INSERT INTO `job_count` VALUES ('508', 'nodejs', '上海', '356', '2020-03-23 12:00:00');
INSERT INTO `job_count` VALUES ('509', 'golang', '上海', '157', '2020-03-24 12:00:01');
INSERT INTO `job_count` VALUES ('510', 'nodejs', '上海', '355', '2020-03-24 12:00:01');
INSERT INTO `job_count` VALUES ('511', 'golang', '上海', '154', '2020-03-25 12:00:00');
INSERT INTO `job_count` VALUES ('512', 'nodejs', '上海', '349', '2020-03-25 12:00:00');
INSERT INTO `job_count` VALUES ('513', 'nodejs', '上海', '353', '2020-03-26 12:00:01');
INSERT INTO `job_count` VALUES ('514', 'golang', '上海', '156', '2020-03-26 12:00:01');
INSERT INTO `job_count` VALUES ('515', 'nodejs', '上海', '348', '2020-03-27 12:00:00');
INSERT INTO `job_count` VALUES ('516', 'golang', '上海', '160', '2020-03-27 12:00:01');
INSERT INTO `job_count` VALUES ('517', 'golang', '上海', '162', '2020-03-28 12:00:00');
INSERT INTO `job_count` VALUES ('518', 'nodejs', '上海', '352', '2020-03-28 12:00:00');
INSERT INTO `job_count` VALUES ('519', 'golang', '上海', '161', '2020-03-29 12:00:01');
INSERT INTO `job_count` VALUES ('520', 'nodejs', '上海', '352', '2020-03-29 12:00:01');
INSERT INTO `job_count` VALUES ('521', 'golang', '上海', '158', '2020-03-30 12:00:01');
INSERT INTO `job_count` VALUES ('522', 'nodejs', '上海', '352', '2020-03-30 12:00:01');
INSERT INTO `job_count` VALUES ('523', 'nodejs', '上海', '351', '2020-03-31 12:00:00');
INSERT INTO `job_count` VALUES ('524', 'golang', '上海', '161', '2020-03-31 12:00:01');
INSERT INTO `job_count` VALUES ('525', 'golang', '上海', '160', '2020-04-01 12:00:01');
INSERT INTO `job_count` VALUES ('526', 'nodejs', '上海', '346', '2020-04-01 12:00:01');
INSERT INTO `job_count` VALUES ('527', 'nodejs', '上海', '352', '2020-04-02 12:00:01');
INSERT INTO `job_count` VALUES ('528', 'golang', '上海', '159', '2020-04-02 12:00:01');
INSERT INTO `job_count` VALUES ('529', 'golang', '上海', '158', '2020-04-03 12:00:01');
INSERT INTO `job_count` VALUES ('530', 'nodejs', '上海', '358', '2020-04-03 12:00:01');
INSERT INTO `job_count` VALUES ('531', 'golang', '上海', '166', '2020-04-04 12:00:01');
INSERT INTO `job_count` VALUES ('532', 'nodejs', '上海', '360', '2020-04-04 12:00:01');
INSERT INTO `job_count` VALUES ('533', 'nodejs', '上海', '355', '2020-04-05 12:00:00');
INSERT INTO `job_count` VALUES ('534', 'golang', '上海', '166', '2020-04-05 12:00:00');
INSERT INTO `job_count` VALUES ('535', 'golang', '上海', '166', '2020-04-06 12:00:00');
INSERT INTO `job_count` VALUES ('536', 'nodejs', '上海', '355', '2020-04-06 12:00:00');
INSERT INTO `job_count` VALUES ('537', 'golang', '上海', '168', '2020-04-07 12:00:00');
INSERT INTO `job_count` VALUES ('538', 'nodejs', '上海', '359', '2020-04-07 12:00:01');
INSERT INTO `job_count` VALUES ('539', 'nodejs', '上海', '364', '2020-04-08 12:00:00');
INSERT INTO `job_count` VALUES ('540', 'golang', '上海', '167', '2020-04-08 12:00:01');
INSERT INTO `job_count` VALUES ('541', 'golang', '上海', '168', '2020-04-09 12:00:00');
INSERT INTO `job_count` VALUES ('542', 'nodejs', '上海', '369', '2020-04-09 12:00:01');
INSERT INTO `job_count` VALUES ('543', 'nodejs', '上海', '369', '2020-04-10 12:00:00');
INSERT INTO `job_count` VALUES ('544', 'golang', '上海', '167', '2020-04-10 12:00:00');
INSERT INTO `job_count` VALUES ('545', 'nodejs', '上海', '370', '2020-04-11 12:00:01');
INSERT INTO `job_count` VALUES ('546', 'golang', '上海', '167', '2020-04-11 12:00:01');
INSERT INTO `job_count` VALUES ('547', 'nodejs', '上海', '370', '2020-04-12 12:00:00');
INSERT INTO `job_count` VALUES ('548', 'golang', '上海', '165', '2020-04-12 12:00:01');
INSERT INTO `job_count` VALUES ('549', 'golang', '上海', '163', '2020-04-13 12:00:00');
INSERT INTO `job_count` VALUES ('550', 'nodejs', '上海', '372', '2020-04-13 12:00:00');
INSERT INTO `job_count` VALUES ('551', 'golang', '上海', '162', '2020-04-14 12:00:01');
INSERT INTO `job_count` VALUES ('552', 'nodejs', '上海', '375', '2020-04-14 12:00:01');
INSERT INTO `job_count` VALUES ('553', 'golang', '上海', '161', '2020-04-15 12:00:00');
INSERT INTO `job_count` VALUES ('554', 'nodejs', '上海', '381', '2020-04-15 12:00:00');
INSERT INTO `job_count` VALUES ('555', 'golang', '上海', '165', '2020-04-16 12:00:01');
INSERT INTO `job_count` VALUES ('556', 'nodejs', '上海', '391', '2020-04-16 12:00:01');
INSERT INTO `job_count` VALUES ('557', 'nodejs', '上海', '393', '2020-04-17 12:00:01');
INSERT INTO `job_count` VALUES ('558', 'golang', '上海', '165', '2020-04-17 12:00:01');
INSERT INTO `job_count` VALUES ('559', 'golang', '上海', '164', '2020-04-18 12:00:01');
INSERT INTO `job_count` VALUES ('560', 'nodejs', '上海', '394', '2020-04-18 12:00:01');
INSERT INTO `job_count` VALUES ('561', 'golang', '上海', '163', '2020-04-19 12:00:00');
INSERT INTO `job_count` VALUES ('562', 'nodejs', '上海', '392', '2020-04-19 12:00:00');
INSERT INTO `job_count` VALUES ('563', 'nodejs', '上海', '390', '2020-04-20 12:00:00');
INSERT INTO `job_count` VALUES ('564', 'golang', '上海', '163', '2020-04-20 12:00:00');
INSERT INTO `job_count` VALUES ('565', 'golang', '上海', '158', '2020-04-21 12:00:00');
INSERT INTO `job_count` VALUES ('566', 'nodejs', '上海', '392', '2020-04-21 12:00:00');
INSERT INTO `job_count` VALUES ('567', 'golang', '上海', '160', '2020-04-22 12:00:00');
INSERT INTO `job_count` VALUES ('568', 'nodejs', '上海', '393', '2020-04-22 12:00:01');
INSERT INTO `job_count` VALUES ('569', 'nodejs', '上海', '399', '2020-04-23 12:00:01');
INSERT INTO `job_count` VALUES ('570', 'golang', '上海', '158', '2020-04-24 12:00:01');
INSERT INTO `job_count` VALUES ('571', 'nodejs', '上海', '401', '2020-04-24 12:00:01');
INSERT INTO `job_count` VALUES ('572', 'nodejs', '上海', '399', '2020-04-25 12:00:01');
INSERT INTO `job_count` VALUES ('573', 'golang', '上海', '157', '2020-04-25 12:00:01');
INSERT INTO `job_count` VALUES ('574', 'golang', '上海', '158', '2020-04-23 16:46:06');
INSERT INTO `job_count` VALUES ('575', 'golang', '上海', '158', '2020-04-26 12:00:00');
INSERT INTO `job_count` VALUES ('576', 'nodejs', '上海', '391', '2020-04-26 12:00:00');
INSERT INTO `job_count` VALUES ('577', 'nodejs', '上海', '390', '2020-04-27 12:00:01');
INSERT INTO `job_count` VALUES ('578', 'nodejs', '上海', '385', '2020-04-28 12:00:01');
INSERT INTO `job_count` VALUES ('579', 'golang', '上海', '156', '2020-04-28 12:00:01');
INSERT INTO `job_count` VALUES ('580', 'nodejs', '上海', '384', '2020-04-29 12:00:01');
INSERT INTO `job_count` VALUES ('581', 'nodejs', '上海', '389', '2020-04-30 12:00:01');
INSERT INTO `job_count` VALUES ('582', 'golang', '上海', '153', '2020-05-01 12:00:01');
INSERT INTO `job_count` VALUES ('583', 'golang', '上海', '153', '2020-05-02 12:00:01');
INSERT INTO `job_count` VALUES ('584', 'nodejs', '上海', '388', '2020-05-02 12:00:01');
INSERT INTO `job_count` VALUES ('585', 'nodejs', '上海', '390', '2020-05-03 12:00:00');
INSERT INTO `job_count` VALUES ('586', 'golang', '上海', '153', '2020-05-03 12:00:00');
INSERT INTO `job_count` VALUES ('587', 'nodejs', '上海', '389', '2020-05-04 12:00:01');
INSERT INTO `job_count` VALUES ('588', 'golang', '上海', '152', '2020-05-04 12:00:01');
INSERT INTO `job_count` VALUES ('589', 'golang', '上海', '152', '2020-05-05 12:00:00');
INSERT INTO `job_count` VALUES ('590', 'nodejs', '上海', '379', '2020-05-05 12:00:00');
INSERT INTO `job_count` VALUES ('591', 'golang', '上海', '153', '2020-05-06 12:00:01');
INSERT INTO `job_count` VALUES ('592', 'nodejs', '上海', '384', '2020-05-07 12:00:00');
INSERT INTO `job_count` VALUES ('593', 'nodejs', '上海', '389', '2020-05-08 12:00:00');
INSERT INTO `job_count` VALUES ('594', 'golang', '上海', '156', '2020-05-08 12:00:01');
INSERT INTO `job_count` VALUES ('595', 'nodejs', '上海', '391', '2020-05-09 12:00:00');
INSERT INTO `job_count` VALUES ('596', 'golang', '上海', '160', '2020-05-09 12:00:00');
INSERT INTO `job_count` VALUES ('597', 'nodejs', '上海', '385', '2020-05-11 12:00:01');
INSERT INTO `job_count` VALUES ('598', 'golang', '上海', '161', '2020-05-11 12:00:01');
INSERT INTO `job_count` VALUES ('599', 'nodejs', '上海', '403', '2020-05-12 12:00:02');
INSERT INTO `job_count` VALUES ('600', 'golang', '上海', '163', '2020-05-12 12:00:03');
INSERT INTO `job_count` VALUES ('601', 'golang', '上海', '174', '2020-05-13 12:00:00');
INSERT INTO `job_count` VALUES ('602', 'nodejs', '上海', '404', '2020-05-13 12:00:00');
INSERT INTO `job_count` VALUES ('603', 'golang', '上海', '171', '2020-05-14 12:00:00');
INSERT INTO `job_count` VALUES ('604', 'nodejs', '上海', '407', '2020-05-14 12:00:01');
INSERT INTO `job_count` VALUES ('605', 'golang', '上海', '176', '2020-05-15 12:00:00');
INSERT INTO `job_count` VALUES ('606', 'nodejs', '上海', '413', '2020-05-15 12:00:00');
INSERT INTO `job_count` VALUES ('607', 'nodejs', '上海', '411', '2020-05-16 12:00:01');
INSERT INTO `job_count` VALUES ('608', 'golang', '上海', '174', '2020-05-16 12:00:01');
INSERT INTO `job_count` VALUES ('609', 'golang', '上海', '174', '2020-05-17 12:00:00');
INSERT INTO `job_count` VALUES ('610', 'nodejs', '上海', '408', '2020-05-17 12:00:00');
INSERT INTO `job_count` VALUES ('611', 'golang', '上海', '173', '2020-05-18 12:00:00');
INSERT INTO `job_count` VALUES ('612', 'nodejs', '上海', '414', '2020-05-18 12:00:00');
INSERT INTO `job_count` VALUES ('613', 'golang', '上海', '173', '2020-05-19 12:00:00');
INSERT INTO `job_count` VALUES ('614', 'nodejs', '上海', '420', '2020-05-19 12:00:00');
INSERT INTO `job_count` VALUES ('615', 'golang', '上海', '172', '2020-05-20 12:00:00');
INSERT INTO `job_count` VALUES ('616', 'nodejs', '上海', '418', '2020-05-20 12:00:00');
INSERT INTO `job_count` VALUES ('617', 'golang', '上海', '171', '2020-05-21 12:00:01');
INSERT INTO `job_count` VALUES ('618', 'nodejs', '上海', '424', '2020-05-21 12:00:01');
INSERT INTO `job_count` VALUES ('619', 'nodejs', '上海', '421', '2020-05-22 12:00:00');
INSERT INTO `job_count` VALUES ('620', 'golang', '上海', '168', '2020-05-22 12:00:01');
INSERT INTO `job_count` VALUES ('621', 'golang', '上海', '168', '2020-05-23 12:00:01');
INSERT INTO `job_count` VALUES ('622', 'nodejs', '上海', '423', '2020-05-23 12:00:01');
INSERT INTO `job_count` VALUES ('623', 'nodejs', '上海', '424', '2020-05-24 12:00:00');
INSERT INTO `job_count` VALUES ('624', 'golang', '上海', '168', '2020-05-24 12:00:00');
INSERT INTO `job_count` VALUES ('625', 'golang', '上海', '170', '2020-05-25 12:00:00');
INSERT INTO `job_count` VALUES ('626', 'nodejs', '上海', '427', '2020-05-25 12:00:01');
INSERT INTO `job_count` VALUES ('627', 'nodejs', '上海', '431', '2020-05-26 12:00:00');
INSERT INTO `job_count` VALUES ('628', 'golang', '上海', '170', '2020-05-26 12:00:00');
INSERT INTO `job_count` VALUES ('629', 'nodejs', '上海', '420', '2020-05-27 12:00:01');
INSERT INTO `job_count` VALUES ('630', 'golang', '上海', '170', '2020-05-27 12:00:01');
INSERT INTO `job_count` VALUES ('631', 'golang', '上海', '171', '2020-05-28 12:00:00');
INSERT INTO `job_count` VALUES ('632', 'nodejs', '上海', '423', '2020-05-28 12:00:00');
INSERT INTO `job_count` VALUES ('633', 'golang', '上海', '173', '2020-05-29 12:00:01');
INSERT INTO `job_count` VALUES ('634', 'nodejs', '上海', '431', '2020-05-29 12:00:01');
INSERT INTO `job_count` VALUES ('635', 'golang', '上海', '174', '2020-05-30 12:00:00');
INSERT INTO `job_count` VALUES ('636', 'nodejs', '上海', '433', '2020-05-30 12:00:00');
INSERT INTO `job_count` VALUES ('637', 'nodejs', '上海', '431', '2020-05-31 12:00:00');
INSERT INTO `job_count` VALUES ('638', 'golang', '上海', '174', '2020-05-31 12:00:00');
INSERT INTO `job_count` VALUES ('639', 'golang', '上海', '174', '2020-06-01 12:00:00');
INSERT INTO `job_count` VALUES ('640', 'nodejs', '上海', '432', '2020-06-01 12:00:00');
INSERT INTO `job_count` VALUES ('641', 'golang', '上海', '176', '2020-06-02 12:00:00');
INSERT INTO `job_count` VALUES ('642', 'nodejs', '上海', '435', '2020-06-02 12:00:00');
INSERT INTO `job_count` VALUES ('643', 'nodejs', '上海', '427', '2020-06-03 12:00:00');
INSERT INTO `job_count` VALUES ('644', 'golang', '上海', '171', '2020-06-03 12:00:01');
INSERT INTO `job_count` VALUES ('645', 'nodejs', '上海', '433', '2020-06-04 12:00:01');
INSERT INTO `job_count` VALUES ('646', 'golang', '上海', '172', '2020-06-04 12:00:01');
INSERT INTO `job_count` VALUES ('647', 'nodejs', '上海', '428', '2020-06-05 12:00:00');
INSERT INTO `job_count` VALUES ('648', 'golang', '上海', '175', '2020-06-05 12:00:01');
INSERT INTO `job_count` VALUES ('649', 'golang', '上海', '173', '2020-06-06 12:00:01');
INSERT INTO `job_count` VALUES ('650', 'nodejs', '上海', '428', '2020-06-06 12:00:01');
INSERT INTO `job_count` VALUES ('651', 'nodejs', '上海', '428', '2020-06-07 12:00:00');
INSERT INTO `job_count` VALUES ('652', 'golang', '上海', '173', '2020-06-07 12:00:00');
INSERT INTO `job_count` VALUES ('653', 'golang', '上海', '172', '2020-06-08 12:00:00');
INSERT INTO `job_count` VALUES ('654', 'nodejs', '上海', '427', '2020-06-08 12:00:00');
INSERT INTO `job_count` VALUES ('655', 'nodejs', '上海', '423', '2020-06-09 12:00:00');
INSERT INTO `job_count` VALUES ('656', 'golang', '上海', '173', '2020-06-09 12:00:00');
INSERT INTO `job_count` VALUES ('657', 'golang', '上海', '173', '2020-06-10 12:00:00');
INSERT INTO `job_count` VALUES ('658', 'nodejs', '上海', '425', '2020-06-10 12:00:00');
INSERT INTO `job_count` VALUES ('659', 'golang', '上海', '177', '2020-06-11 12:00:00');
INSERT INTO `job_count` VALUES ('660', 'nodejs', '上海', '422', '2020-06-11 12:00:00');
INSERT INTO `job_count` VALUES ('661', 'golang', '上海', '174', '2020-06-12 12:00:01');
INSERT INTO `job_count` VALUES ('662', 'nodejs', '上海', '420', '2020-06-12 12:00:01');
INSERT INTO `job_count` VALUES ('663', 'golang', '上海', '177', '2020-06-13 12:00:00');
INSERT INTO `job_count` VALUES ('664', 'nodejs', '上海', '422', '2020-06-13 12:00:00');
INSERT INTO `job_count` VALUES ('665', 'golang', '上海', '177', '2020-06-14 12:00:00');
INSERT INTO `job_count` VALUES ('666', 'nodejs', '上海', '421', '2020-06-14 12:00:00');
INSERT INTO `job_count` VALUES ('667', 'golang', '上海', '177', '2020-06-15 12:00:01');
INSERT INTO `job_count` VALUES ('668', 'nodejs', '上海', '419', '2020-06-15 12:00:01');
INSERT INTO `job_count` VALUES ('669', 'nodejs', '上海', '422', '2020-06-16 12:00:00');
INSERT INTO `job_count` VALUES ('670', 'golang', '上海', '179', '2020-06-16 12:00:00');
INSERT INTO `job_count` VALUES ('671', 'golang', '上海', '180', '2020-06-17 12:00:01');
INSERT INTO `job_count` VALUES ('672', 'nodejs', '上海', '433', '2020-06-17 12:00:01');
INSERT INTO `job_count` VALUES ('673', 'golang', '上海', '182', '2020-06-18 12:00:00');
INSERT INTO `job_count` VALUES ('674', 'nodejs', '上海', '431', '2020-06-18 12:00:00');
INSERT INTO `job_count` VALUES ('675', 'golang', '上海', '186', '2020-06-19 12:00:00');
INSERT INTO `job_count` VALUES ('676', 'nodejs', '上海', '433', '2020-06-19 12:00:00');
INSERT INTO `job_count` VALUES ('677', 'nodejs', '上海', '440', '2020-06-20 12:00:01');
INSERT INTO `job_count` VALUES ('678', 'golang', '上海', '185', '2020-06-20 12:00:01');
INSERT INTO `job_count` VALUES ('679', 'golang', '上海', '185', '2020-06-21 12:00:01');
INSERT INTO `job_count` VALUES ('680', 'nodejs', '上海', '434', '2020-06-21 12:00:01');
INSERT INTO `job_count` VALUES ('681', 'nodejs', '上海', '434', '2020-06-22 12:00:01');
INSERT INTO `job_count` VALUES ('682', 'golang', '上海', '183', '2020-06-22 12:00:01');
INSERT INTO `job_count` VALUES ('683', 'nodejs', '上海', '429', '2020-06-23 12:00:00');
INSERT INTO `job_count` VALUES ('684', 'golang', '上海', '182', '2020-06-23 12:00:00');
INSERT INTO `job_count` VALUES ('685', 'golang', '上海', '179', '2020-06-24 12:00:00');
INSERT INTO `job_count` VALUES ('686', 'nodejs', '上海', '427', '2020-06-24 12:00:00');
INSERT INTO `job_count` VALUES ('687', 'golang', '上海', '178', '2020-06-25 12:00:00');
INSERT INTO `job_count` VALUES ('688', 'nodejs', '上海', '424', '2020-06-25 12:00:00');
INSERT INTO `job_count` VALUES ('689', 'golang', '上海', '176', '2020-06-26 12:00:00');
INSERT INTO `job_count` VALUES ('690', 'nodejs', '上海', '423', '2020-06-26 12:00:00');
INSERT INTO `job_count` VALUES ('691', 'golang', '上海', '177', '2020-06-27 12:00:00');
INSERT INTO `job_count` VALUES ('692', 'nodejs', '上海', '420', '2020-06-27 12:00:00');
INSERT INTO `job_count` VALUES ('693', 'nodejs', '上海', '417', '2020-06-28 12:00:00');
INSERT INTO `job_count` VALUES ('694', 'golang', '上海', '180', '2020-06-28 12:00:00');
INSERT INTO `job_count` VALUES ('695', 'golang', '上海', '185', '2020-06-29 12:00:00');
INSERT INTO `job_count` VALUES ('696', 'nodejs', '上海', '426', '2020-06-29 12:00:00');
INSERT INTO `job_count` VALUES ('697', 'golang', '上海', '185', '2020-06-30 12:00:00');
INSERT INTO `job_count` VALUES ('698', 'nodejs', '上海', '426', '2020-06-30 12:00:00');
INSERT INTO `job_count` VALUES ('699', 'golang', '上海', '189', '2020-07-01 12:00:00');
INSERT INTO `job_count` VALUES ('700', 'nodejs', '上海', '428', '2020-07-01 12:00:01');
INSERT INTO `job_count` VALUES ('701', 'nodejs', '上海', '437', '2020-07-02 12:00:00');
INSERT INTO `job_count` VALUES ('702', 'golang', '上海', '187', '2020-07-02 12:00:00');
INSERT INTO `job_count` VALUES ('703', 'nodejs', '上海', '436', '2020-07-03 12:00:00');
INSERT INTO `job_count` VALUES ('704', 'golang', '上海', '186', '2020-07-03 12:00:00');
INSERT INTO `job_count` VALUES ('705', 'nodejs', '上海', '437', '2020-07-04 12:00:00');
INSERT INTO `job_count` VALUES ('706', 'golang', '上海', '187', '2020-07-04 12:00:00');
INSERT INTO `job_count` VALUES ('707', 'golang', '上海', '187', '2020-07-05 12:00:00');
INSERT INTO `job_count` VALUES ('708', 'nodejs', '上海', '437', '2020-07-05 12:00:00');
INSERT INTO `job_count` VALUES ('709', 'golang', '上海', '186', '2020-07-06 12:00:00');
INSERT INTO `job_count` VALUES ('710', 'nodejs', '上海', '436', '2020-07-06 12:00:00');
INSERT INTO `job_count` VALUES ('711', 'golang', '上海', '188', '2020-07-07 12:00:00');
INSERT INTO `job_count` VALUES ('712', 'nodejs', '上海', '437', '2020-07-07 12:00:01');
INSERT INTO `job_count` VALUES ('713', 'nodejs', '上海', '437', '2020-07-08 12:00:00');
INSERT INTO `job_count` VALUES ('714', 'golang', '上海', '189', '2020-07-08 12:00:00');
INSERT INTO `job_count` VALUES ('715', 'nodejs', '上海', '433', '2020-07-09 12:00:00');
INSERT INTO `job_count` VALUES ('716', 'golang', '上海', '191', '2020-07-09 12:00:01');
INSERT INTO `job_count` VALUES ('717', 'golang', '上海', '194', '2020-07-10 12:00:01');
INSERT INTO `job_count` VALUES ('718', 'nodejs', '上海', '431', '2020-07-10 12:00:01');
INSERT INTO `job_count` VALUES ('719', 'golang', '上海', '194', '2020-07-11 12:00:00');
INSERT INTO `job_count` VALUES ('720', 'nodejs', '上海', '433', '2020-07-11 12:00:00');
INSERT INTO `job_count` VALUES ('721', 'nodejs', '上海', '437', '2020-07-12 12:00:00');
INSERT INTO `job_count` VALUES ('722', 'golang', '上海', '194', '2020-07-12 12:00:00');
INSERT INTO `job_count` VALUES ('723', 'golang', '上海', '194', '2020-07-13 12:00:00');
INSERT INTO `job_count` VALUES ('724', 'nodejs', '上海', '433', '2020-07-13 12:00:00');
INSERT INTO `job_count` VALUES ('725', 'golang', '上海', '194', '2020-07-14 12:00:00');
INSERT INTO `job_count` VALUES ('726', 'nodejs', '上海', '463', '2020-07-14 12:00:00');
INSERT INTO `job_count` VALUES ('727', 'golang', '上海', '196', '2020-07-15 12:00:01');
INSERT INTO `job_count` VALUES ('728', 'nodejs', '上海', '460', '2020-07-15 12:00:01');
INSERT INTO `job_count` VALUES ('729', 'golang', '上海', '190', '2020-07-16 12:00:00');
INSERT INTO `job_count` VALUES ('730', 'nodejs', '上海', '466', '2020-07-16 12:00:00');
INSERT INTO `job_count` VALUES ('731', 'golang', '上海', '193', '2020-07-17 12:00:01');
INSERT INTO `job_count` VALUES ('732', 'nodejs', '上海', '458', '2020-07-17 12:00:01');
INSERT INTO `job_count` VALUES ('733', 'golang', '上海', '195', '2020-07-18 12:00:00');
INSERT INTO `job_count` VALUES ('734', 'nodejs', '上海', '466', '2020-07-18 12:00:01');
INSERT INTO `job_count` VALUES ('735', 'nodejs', '上海', '462', '2020-07-19 12:00:01');
INSERT INTO `job_count` VALUES ('736', 'golang', '上海', '195', '2020-07-19 12:00:01');
INSERT INTO `job_count` VALUES ('737', 'nodejs', '上海', '461', '2020-07-20 12:00:00');
INSERT INTO `job_count` VALUES ('738', 'golang', '上海', '194', '2020-07-20 12:00:00');
INSERT INTO `job_count` VALUES ('739', 'golang', '上海', '193', '2020-07-21 12:00:01');
INSERT INTO `job_count` VALUES ('740', 'nodejs', '上海', '456', '2020-07-21 12:00:01');
INSERT INTO `job_count` VALUES ('741', 'nodejs', '上海', '462', '2020-07-22 12:00:01');
INSERT INTO `job_count` VALUES ('742', 'golang', '上海', '193', '2020-07-22 12:00:01');
INSERT INTO `job_count` VALUES ('743', 'nodejs', '上海', '474', '2020-07-23 12:00:00');
INSERT INTO `job_count` VALUES ('744', 'golang', '上海', '198', '2020-07-23 12:00:00');
INSERT INTO `job_count` VALUES ('745', 'nodejs', '上海', '489', '2020-07-24 12:00:00');
INSERT INTO `job_count` VALUES ('746', 'golang', '上海', '201', '2020-07-24 12:00:00');
INSERT INTO `job_count` VALUES ('747', 'golang', '上海', '199', '2020-07-25 12:00:01');
INSERT INTO `job_count` VALUES ('748', 'nodejs', '上海', '492', '2020-07-25 12:00:01');
INSERT INTO `job_count` VALUES ('749', 'nodejs', '上海', '494', '2020-07-26 12:00:00');
INSERT INTO `job_count` VALUES ('750', 'golang', '上海', '196', '2020-07-26 12:00:01');
INSERT INTO `job_count` VALUES ('751', 'nodejs', '上海', '492', '2020-07-27 12:00:01');
INSERT INTO `job_count` VALUES ('752', 'golang', '上海', '193', '2020-07-27 12:00:01');
INSERT INTO `job_count` VALUES ('753', 'golang', '上海', '199', '2020-07-28 12:00:00');
INSERT INTO `job_count` VALUES ('754', 'nodejs', '上海', '482', '2020-07-28 12:00:00');
INSERT INTO `job_count` VALUES ('755', 'golang', '上海', '205', '2020-07-29 12:00:00');
INSERT INTO `job_count` VALUES ('756', 'nodejs', '上海', '481', '2020-07-29 12:00:00');

-- ----------------------------
-- Table structure for `log`
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mark` varchar(255) DEFAULT NULL COMMENT '日志说明',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=904 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('1', '登录IP:43.227.254.20，物理地址：中国  北京 北京', '2018-09-21 00:41:46', '2018-09-21 00:41:46');
INSERT INTO `log` VALUES ('2', '登录IP:101.81.62.69，物理地址：中国  上海 上海', '2018-09-25 14:10:11', '2018-09-25 14:10:11');
INSERT INTO `log` VALUES ('3', '登录IP:116.226.177.39，物理地址：中国  上海 上海', '2018-09-28 09:38:48', '2018-09-28 09:38:48');
INSERT INTO `log` VALUES ('4', '登录IP:222.209.182.112，物理地址：中国  四川 成都', '2018-09-29 17:44:54', '2018-09-29 17:44:54');
INSERT INTO `log` VALUES ('5', '登录IP:222.209.182.112，物理地址：中国  四川 成都', '2018-09-29 17:44:56', '2018-09-29 17:44:56');
INSERT INTO `log` VALUES ('6', '登录IP:101.81.61.204，物理地址：中国  上海 上海', '2018-10-08 13:26:26', '2018-10-08 13:26:26');
INSERT INTO `log` VALUES ('7', '登录IP:59.34.155.237，物理地址：中国  广东 茂名', '2018-10-11 19:42:01', '2018-10-11 19:42:01');
INSERT INTO `log` VALUES ('8', '登录IP:101.81.61.204，物理地址：中国  上海 上海', '2018-10-12 10:23:16', '2018-10-12 10:23:16');
INSERT INTO `log` VALUES ('9', '登录IP:104.245.14.72，物理地址：美国  加利福尼亚 洛杉矶', '2018-10-12 10:23:55', '2018-10-12 10:23:55');
INSERT INTO `log` VALUES ('10', '登录IP:193.110.202.121，物理地址：香港  香港 XX', '2018-10-18 13:24:13', '2018-10-18 13:24:13');
INSERT INTO `log` VALUES ('11', '登录IP:123.113.146.255，物理地址：中国  北京 北京', '2018-10-19 14:27:12', '2018-10-19 14:27:12');
INSERT INTO `log` VALUES ('12', '登录IP:61.141.64.4，物理地址：中国  广东 深圳', '2018-10-24 11:41:14', '2018-10-24 11:41:14');
INSERT INTO `log` VALUES ('13', '登录IP:112.65.30.15，物理地址：中国  上海 上海', '2018-10-24 20:56:05', '2018-10-24 20:56:05');
INSERT INTO `log` VALUES ('14', '登录IP:112.65.30.15，物理地址：中国  上海 上海', '2018-10-24 20:56:05', '2018-10-24 20:56:05');
INSERT INTO `log` VALUES ('15', '登录IP:112.65.30.15，物理地址：中国  上海 上海', '2018-10-24 20:56:41', '2018-10-24 20:56:41');
INSERT INTO `log` VALUES ('16', '登录IP:101.81.62.65，物理地址：中国  上海 上海', '2018-10-28 10:49:01', '2018-10-28 10:49:01');
INSERT INTO `log` VALUES ('17', '登录IP:183.221.39.12，物理地址：中国  四川 成都', '2018-10-29 17:20:34', '2018-10-29 17:20:34');
INSERT INTO `log` VALUES ('18', '登录IP:47.75.193.192，物理地址：香港  香港 XX', '2018-11-01 01:30:47', '2018-11-01 01:30:47');
INSERT INTO `log` VALUES ('19', '登录IP:116.231.91.253，物理地址：中国  上海 上海', '2018-11-02 10:24:27', '2018-11-02 10:24:27');
INSERT INTO `log` VALUES ('20', '登录IP:113.251.25.118，物理地址：中国  重庆 重庆', '2018-11-08 03:39:04', '2018-11-08 03:39:04');
INSERT INTO `log` VALUES ('21', '登录IP:139.224.131.252，物理地址：中国  上海 上海', '2018-11-13 10:07:54', '2018-11-13 10:07:54');
INSERT INTO `log` VALUES ('22', '登录IP:59.109.146.112，物理地址：中国  北京 北京', '2018-11-13 22:34:51', '2018-11-13 22:34:51');
INSERT INTO `log` VALUES ('23', '登录IP:183.3.220.32，物理地址：中国  广东 深圳', '2018-11-14 20:10:13', '2018-11-14 20:10:13');
INSERT INTO `log` VALUES ('24', '登录IP:58.33.180.124，物理地址：中国  上海 上海', '2018-11-15 16:43:22', '2018-11-15 16:43:22');
INSERT INTO `log` VALUES ('25', '登录IP:139.224.131.252，物理地址：中国  上海 上海', '2018-11-16 10:10:48', '2018-11-16 10:10:48');
INSERT INTO `log` VALUES ('26', '登录IP:218.241.193.75，物理地址：中国  北京 北京', '2018-11-16 14:46:37', '2018-11-16 14:46:37');
INSERT INTO `log` VALUES ('27', '登录IP:116.231.91.253，物理地址：中国  上海 上海', '2018-11-23 19:10:54', '2018-11-23 19:10:54');
INSERT INTO `log` VALUES ('28', '登录IP:117.25.245.148，物理地址：中国  福建 厦门', '2018-11-24 11:08:59', '2018-11-24 11:08:59');
INSERT INTO `log` VALUES ('29', '登录IP:116.231.91.253，物理地址：中国  上海 上海', '2018-11-26 14:49:01', '2018-11-26 14:49:01');
INSERT INTO `log` VALUES ('30', '登录IP:223.104.213.77，物理地址：中国  上海 上海', '2018-11-29 18:11:07', '2018-11-29 18:11:07');
INSERT INTO `log` VALUES ('31', '登录IP:124.93.248.69，物理地址：中国  辽宁 大连', '2018-12-02 20:38:14', '2018-12-02 20:38:14');
INSERT INTO `log` VALUES ('32', '登录IP:139.224.131.252，物理地址：中国  上海 上海', '2018-12-03 15:54:40', '2018-12-03 15:54:40');
INSERT INTO `log` VALUES ('33', '登录IP:103.14.252.249，物理地址：澳大利亚  XX XX', '2018-12-04 17:18:50', '2018-12-04 17:18:50');
INSERT INTO `log` VALUES ('34', '登录IP:220.133.64.76，物理地址：台湾  台湾 XX', '2018-12-05 13:46:43', '2018-12-05 13:46:43');
INSERT INTO `log` VALUES ('35', '登录IP:116.243.9.82，物理地址：中国  北京 北京', '2018-12-05 14:47:34', '2018-12-05 14:47:34');
INSERT INTO `log` VALUES ('36', '登录IP:59.53.183.217，物理地址：中国  江西 南昌', '2018-12-05 17:43:06', '2018-12-05 17:43:06');
INSERT INTO `log` VALUES ('37', '登录IP:139.224.131.252，物理地址：中国  上海 上海', '2018-12-07 13:35:40', '2018-12-07 13:35:40');
INSERT INTO `log` VALUES ('38', '登录IP:211.161.240.192，物理地址：中国  上海 上海', '2018-12-09 22:44:43', '2018-12-09 22:44:43');
INSERT INTO `log` VALUES ('39', '登录IP:211.161.240.192，物理地址：中国  上海 上海', '2018-12-09 22:44:47', '2018-12-09 22:44:47');
INSERT INTO `log` VALUES ('40', '登录IP:139.224.131.252，物理地址：中国  上海 上海', '2018-12-10 18:32:44', '2018-12-10 18:32:44');
INSERT INTO `log` VALUES ('41', '登录IP:153.37.51.83，物理地址：中国  江苏 盐城', '2018-12-11 09:25:35', '2018-12-11 09:25:35');
INSERT INTO `log` VALUES ('42', '登录IP:116.226.79.78，物理地址：中国  上海 上海', '2018-12-17 15:27:14', '2018-12-17 15:27:14');
INSERT INTO `log` VALUES ('43', '登录IP:114.219.135.10，物理地址：中国  江苏 苏州', '2018-12-18 14:38:26', '2018-12-18 14:38:26');
INSERT INTO `log` VALUES ('44', '登录IP:116.226.79.78，物理地址：中国  上海 上海', '2018-12-21 10:07:59', '2018-12-21 10:07:59');
INSERT INTO `log` VALUES ('45', '登录IP:121.69.28.58，物理地址：中国  北京 北京', '2018-12-21 11:31:20', '2018-12-21 11:31:20');
INSERT INTO `log` VALUES ('46', '登录IP:116.231.91.253，物理地址：中国  上海 上海', '2018-12-25 15:32:06', '2018-12-25 15:32:06');
INSERT INTO `log` VALUES ('47', '登录IP:1.119.195.123，物理地址：中国  北京 北京', '2018-12-28 09:33:21', '2018-12-28 09:33:21');
INSERT INTO `log` VALUES ('48', '登录IP:116.226.78.16，物理地址：中国  上海 上海', '2018-12-29 14:22:19', '2018-12-29 14:22:19');
INSERT INTO `log` VALUES ('49', '登录IP:211.161.240.140，物理地址：中国  上海 上海', '2018-12-31 22:25:36', '2018-12-31 22:25:36');
INSERT INTO `log` VALUES ('50', '登录IP:211.161.240.140，物理地址：中国  上海 上海', '2018-12-31 22:25:36', '2018-12-31 22:25:36');
INSERT INTO `log` VALUES ('51', '登录IP:119.183.197.113，物理地址：中国  山东 潍坊', '2019-01-01 00:47:11', '2019-01-01 00:47:11');
INSERT INTO `log` VALUES ('52', '登录IP:139.224.131.252，物理地址：中国  上海 上海', '2019-01-04 11:45:31', '2019-01-04 11:45:31');
INSERT INTO `log` VALUES ('53', '登录IP:60.217.194.178，物理地址：中国  山东 济南', '2019-01-10 17:14:05', '2019-01-10 17:14:05');
INSERT INTO `log` VALUES ('54', '登录IP:112.65.31.68，物理地址：中国  上海 上海', '2019-01-16 16:16:36', '2019-01-16 16:16:36');
INSERT INTO `log` VALUES ('55', '登录IP:112.65.31.68，物理地址：中国  上海 上海', '2019-01-16 17:04:47', '2019-01-16 17:04:47');
INSERT INTO `log` VALUES ('56', '登录IP:116.226.75.16，物理地址：上海市', '2019-01-17 11:03:17', '2019-01-17 11:03:17');
INSERT INTO `log` VALUES ('57', '登录IP:211.161.240.40，物理地址：上海市', '2019-01-20 09:56:44', '2019-01-20 09:56:44');
INSERT INTO `log` VALUES ('58', '登录IP:112.82.28.89，物理地址：江苏省盐城市', '2019-01-20 20:22:08', '2019-01-20 20:22:08');
INSERT INTO `log` VALUES ('59', '登录IP:112.65.31.68，物理地址：上海市', '2019-01-21 12:15:00', '2019-01-21 12:15:00');
INSERT INTO `log` VALUES ('60', '登录IP:183.14.132.189，物理地址：广东省深圳市', '2019-01-22 09:37:16', '2019-01-22 09:37:16');
INSERT INTO `log` VALUES ('61', '登录IP:114.86.145.188，物理地址：上海市', '2019-01-23 13:59:51', '2019-01-23 13:59:51');
INSERT INTO `log` VALUES ('62', '登录IP:59.41.163.90，物理地址：广东省广州市', '2019-01-25 11:54:53', '2019-01-25 11:54:53');
INSERT INTO `log` VALUES ('63', '登录IP:49.156.3.13，物理地址：', '2019-01-28 00:59:24', '2019-01-28 00:59:24');
INSERT INTO `log` VALUES ('64', '登录IP:47.75.173.131，物理地址：', '2019-01-31 17:01:43', '2019-01-31 17:01:43');
INSERT INTO `log` VALUES ('65', '登录IP:183.17.235.0，物理地址：广东省深圳市', '2019-02-02 23:47:26', '2019-02-02 23:47:26');
INSERT INTO `log` VALUES ('66', '登录IP:211.161.240.70，物理地址：上海市', '2019-02-09 20:13:18', '2019-02-09 20:13:18');
INSERT INTO `log` VALUES ('67', '登录IP:123.129.149.217，物理地址：山东省枣庄市', '2019-02-10 09:14:25', '2019-02-10 09:14:25');
INSERT INTO `log` VALUES ('68', '登录IP:114.86.145.188，物理地址：上海市', '2019-02-11 11:01:56', '2019-02-11 11:01:56');
INSERT INTO `log` VALUES ('69', '登录IP:118.112.74.169，物理地址：四川省成都市', '2019-02-14 10:30:27', '2019-02-14 10:30:27');
INSERT INTO `log` VALUES ('70', '登录IP:112.65.31.68，物理地址：上海市', '2019-02-15 11:37:08', '2019-02-15 11:37:08');
INSERT INTO `log` VALUES ('71', '登录IP:112.65.31.68，物理地址：上海市', '2019-02-15 14:59:47', '2019-02-15 14:59:47');
INSERT INTO `log` VALUES ('72', '登录IP:211.161.240.239，物理地址：上海市', '2019-02-17 16:05:24', '2019-02-17 16:05:24');
INSERT INTO `log` VALUES ('73', '登录IP:180.153.219.15，物理地址：上海市', '2019-02-18 15:51:36', '2019-02-18 15:51:36');
INSERT INTO `log` VALUES ('74', '登录IP:61.135.169.79，物理地址：北京市', '2019-02-19 16:03:12', '2019-02-19 16:03:12');
INSERT INTO `log` VALUES ('75', '登录IP:112.65.31.68，物理地址：上海市', '2019-02-19 18:51:04', '2019-02-19 18:51:04');
INSERT INTO `log` VALUES ('76', '登录IP:112.65.31.68，物理地址：上海市', '2019-02-22 17:31:11', '2019-02-22 17:31:11');
INSERT INTO `log` VALUES ('77', '登录IP:211.161.240.239，物理地址：上海市', '2019-02-22 22:06:41', '2019-02-22 22:06:41');
INSERT INTO `log` VALUES ('78', '登录IP:211.161.240.239，物理地址：上海市', '2019-02-24 20:58:32', '2019-02-24 20:58:32');
INSERT INTO `log` VALUES ('79', '登录IP:114.86.145.188，物理地址：上海市', '2019-02-26 15:37:06', '2019-02-26 15:37:06');
INSERT INTO `log` VALUES ('80', '登录IP:120.234.31.10，物理地址：广东省深圳市', '2019-02-27 15:21:36', '2019-02-27 15:21:36');
INSERT INTO `log` VALUES ('81', '登录IP:112.64.6.75，物理地址：上海市', '2019-02-28 16:24:41', '2019-02-28 16:24:41');
INSERT INTO `log` VALUES ('82', '登录IP:112.64.6.75，物理地址：上海市', '2019-02-28 16:25:28', '2019-02-28 16:25:28');
INSERT INTO `log` VALUES ('83', '登录IP:222.90.233.78，物理地址：陕西省西安市', '2019-02-28 17:14:03', '2019-02-28 17:14:03');
INSERT INTO `log` VALUES ('84', '登录IP:106.120.206.175，物理地址：北京市', '2019-02-28 17:22:44', '2019-02-28 17:22:44');
INSERT INTO `log` VALUES ('85', '登录IP:115.192.78.133，物理地址：浙江省杭州市', '2019-02-28 18:35:56', '2019-02-28 18:35:56');
INSERT INTO `log` VALUES ('86', '登录IP:115.192.78.133，物理地址：浙江省杭州市', '2019-02-28 18:36:36', '2019-02-28 18:36:36');
INSERT INTO `log` VALUES ('87', '登录IP:115.192.78.133，物理地址：浙江省杭州市', '2019-02-28 18:37:54', '2019-02-28 18:37:54');
INSERT INTO `log` VALUES ('88', '登录IP:222.67.157.152，物理地址：上海市', '2019-02-28 18:50:44', '2019-02-28 18:50:44');
INSERT INTO `log` VALUES ('89', '登录IP:112.10.27.30，物理地址：浙江省杭州市', '2019-02-28 19:52:07', '2019-02-28 19:52:07');
INSERT INTO `log` VALUES ('90', '登录IP:36.157.232.199，物理地址：湖南省衡阳市', '2019-02-28 20:43:53', '2019-02-28 20:43:53');
INSERT INTO `log` VALUES ('91', '登录IP:223.166.116.22，物理地址：上海市', '2019-02-28 23:29:58', '2019-02-28 23:29:58');
INSERT INTO `log` VALUES ('92', '登录IP:123.151.77.48，物理地址：天津市', '2019-03-01 07:56:42', '2019-03-01 07:56:42');
INSERT INTO `log` VALUES ('93', '登录IP:146.222.49.92，物理地址：', '2019-03-01 11:07:54', '2019-03-01 11:07:54');
INSERT INTO `log` VALUES ('94', '登录IP:119.39.21.51，物理地址：湖南省长沙市', '2019-03-01 12:11:13', '2019-03-01 12:11:13');
INSERT INTO `log` VALUES ('95', '登录IP:61.148.212.141，物理地址：北京市', '2019-03-01 14:20:44', '2019-03-01 14:20:44');
INSERT INTO `log` VALUES ('96', '登录IP:27.17.19.98，物理地址：湖北省武汉市', '2019-03-01 15:05:14', '2019-03-01 15:05:14');
INSERT INTO `log` VALUES ('97', '登录IP:58.135.84.38，物理地址：北京市', '2019-03-01 16:16:36', '2019-03-01 16:16:36');
INSERT INTO `log` VALUES ('98', '登录IP:124.207.221.66，物理地址：北京市', '2019-03-01 17:39:51', '2019-03-01 17:39:51');
INSERT INTO `log` VALUES ('99', '登录IP:211.161.240.239，物理地址：上海市', '2019-03-02 21:58:18', '2019-03-02 21:58:18');
INSERT INTO `log` VALUES ('100', '登录IP:113.140.18.178，物理地址：陕西省西安市', '2019-03-04 11:15:53', '2019-03-04 11:15:53');
INSERT INTO `log` VALUES ('101', '登录IP:182.48.102.114，物理地址：北京市', '2019-03-04 18:46:00', '2019-03-04 18:46:00');
INSERT INTO `log` VALUES ('102', '登录IP:183.237.64.70，物理地址：广东省深圳市', '2019-03-04 20:51:16', '2019-03-04 20:51:16');
INSERT INTO `log` VALUES ('103', '登录IP:113.119.28.116，物理地址：广东省广州市', '2019-03-05 08:30:24', '2019-03-05 08:30:24');
INSERT INTO `log` VALUES ('104', '登录IP:114.102.146.51，物理地址：安徽省合肥市', '2019-03-05 15:31:17', '2019-03-05 15:31:17');
INSERT INTO `log` VALUES ('105', '登录IP:119.96.70.209，物理地址：湖北省武汉市', '2019-03-06 11:33:58', '2019-03-06 11:33:58');
INSERT INTO `log` VALUES ('106', '登录IP:182.148.58.106，物理地址：四川省成都市', '2019-03-06 17:53:18', '2019-03-06 17:53:18');
INSERT INTO `log` VALUES ('107', '登录IP:183.6.157.42，物理地址：广东省广州市', '2019-03-07 18:03:13', '2019-03-07 18:03:13');
INSERT INTO `log` VALUES ('108', '登录IP:114.242.250.91，物理地址：北京市', '2019-03-07 18:19:08', '2019-03-07 18:19:08');
INSERT INTO `log` VALUES ('109', '登录IP:222.77.89.161，物理地址：福建省泉州市', '2019-03-08 09:15:00', '2019-03-08 09:15:00');
INSERT INTO `log` VALUES ('110', '登录IP:122.5.25.226，物理地址：山东省烟台市', '2019-03-08 17:24:32', '2019-03-08 17:24:32');
INSERT INTO `log` VALUES ('111', '登录IP:120.230.87.184，物理地址：广东省广州市', '2019-03-09 12:35:13', '2019-03-09 12:35:13');
INSERT INTO `log` VALUES ('112', '登录IP:211.161.240.95，物理地址：上海市', '2019-03-09 14:33:28', '2019-03-09 14:33:28');
INSERT INTO `log` VALUES ('113', '登录IP:112.48.5.170，物理地址：福建省厦门市', '2019-03-10 20:28:58', '2019-03-10 20:28:58');
INSERT INTO `log` VALUES ('114', '登录IP:101.85.210.165，物理地址：上海市', '2019-03-10 22:19:55', '2019-03-10 22:19:55');
INSERT INTO `log` VALUES ('115', '登录IP:223.73.116.202，物理地址：广东省广州市', '2019-03-10 22:20:33', '2019-03-10 22:20:33');
INSERT INTO `log` VALUES ('116', '登录IP:61.148.75.238，物理地址：北京市', '2019-03-11 10:04:09', '2019-03-11 10:04:09');
INSERT INTO `log` VALUES ('117', '登录IP:116.226.75.16，物理地址：上海市', '2019-03-11 19:57:15', '2019-03-11 19:57:15');
INSERT INTO `log` VALUES ('118', '登录IP:117.136.117.252，物理地址：广东省', '2019-03-12 10:43:24', '2019-03-12 10:43:24');
INSERT INTO `log` VALUES ('119', '登录IP:101.25.115.219，物理地址：河北省张家口市', '2019-03-12 15:37:15', '2019-03-12 15:37:15');
INSERT INTO `log` VALUES ('120', '登录IP:61.49.74.189，物理地址：北京市', '2019-03-12 21:51:56', '2019-03-12 21:51:56');
INSERT INTO `log` VALUES ('121', '登录IP:61.49.74.189，物理地址：北京市', '2019-03-13 22:41:58', '2019-03-13 22:41:58');
INSERT INTO `log` VALUES ('122', '登录IP:116.226.77.216，物理地址：上海市', '2019-03-14 16:31:19', '2019-03-14 16:31:19');
INSERT INTO `log` VALUES ('123', '登录IP:116.226.73.79，物理地址：上海市', '2019-03-14 16:53:58', '2019-03-14 16:53:58');
INSERT INTO `log` VALUES ('124', '登录IP:113.218.175.47，物理地址：湖南省常德市', '2019-03-15 09:34:01', '2019-03-15 09:34:01');
INSERT INTO `log` VALUES ('125', '登录IP:222.244.92.182，物理地址：湖南省长沙市', '2019-03-16 11:46:09', '2019-03-16 11:46:09');
INSERT INTO `log` VALUES ('126', '登录IP:113.116.123.218，物理地址：广东省深圳市', '2019-03-16 22:17:09', '2019-03-16 22:17:09');
INSERT INTO `log` VALUES ('127', '登录IP:122.96.170.215，物理地址：江苏省盐城市', '2019-03-17 07:39:20', '2019-03-17 07:39:20');
INSERT INTO `log` VALUES ('128', '登录IP:114.251.159.65，物理地址：北京市', '2019-03-19 09:34:07', '2019-03-19 09:34:07');
INSERT INTO `log` VALUES ('129', '登录IP:180.153.219.15，物理地址：上海市', '2019-03-19 20:23:02', '2019-03-19 20:23:02');
INSERT INTO `log` VALUES ('130', '登录IP:101.93.29.191，物理地址：上海市', '2019-03-20 10:05:58', '2019-03-20 10:05:58');
INSERT INTO `log` VALUES ('131', '登录IP:114.118.30.11，物理地址：北京市', '2019-03-20 16:51:16', '2019-03-20 16:51:16');
INSERT INTO `log` VALUES ('132', '登录IP:58.32.0.183，物理地址：上海市', '2019-03-20 17:23:49', '2019-03-20 17:23:49');
INSERT INTO `log` VALUES ('133', '登录IP:101.84.200.6，物理地址：上海市', '2019-03-21 11:06:40', '2019-03-21 11:06:40');
INSERT INTO `log` VALUES ('134', '登录IP:223.223.200.216，物理地址：北京市', '2019-03-22 15:12:48', '2019-03-22 15:12:48');
INSERT INTO `log` VALUES ('135', '登录IP:119.39.96.38，物理地址：湖南省长沙市', '2019-03-23 14:19:43', '2019-03-23 14:19:43');
INSERT INTO `log` VALUES ('136', '登录IP:115.174.165.141，物理地址：上海市', '2019-03-24 18:33:47', '2019-03-24 18:33:47');
INSERT INTO `log` VALUES ('137', '登录IP:101.71.140.12，物理地址：广东省深圳市', '2019-03-24 22:46:28', '2019-03-24 22:46:28');
INSERT INTO `log` VALUES ('138', '登录IP:125.122.69.79，物理地址：浙江省杭州市', '2019-03-25 13:39:46', '2019-03-25 13:39:46');
INSERT INTO `log` VALUES ('139', '登录IP:61.145.216.219，物理地址：广东省东莞市', '2019-03-26 17:38:15', '2019-03-26 17:38:15');
INSERT INTO `log` VALUES ('140', '登录IP:183.14.134.18，物理地址：广东省深圳市', '2019-03-27 14:16:03', '2019-03-27 14:16:03');
INSERT INTO `log` VALUES ('141', '登录IP:101.93.29.191，物理地址：上海市', '2019-03-28 13:40:44', '2019-03-28 13:40:44');
INSERT INTO `log` VALUES ('142', '登录IP:218.70.106.66，物理地址：重庆市', '2019-03-29 10:39:26', '2019-03-29 10:39:26');
INSERT INTO `log` VALUES ('143', '登录IP:220.248.15.58，物理地址：上海市', '2019-04-01 11:35:35', '2019-04-01 11:35:35');
INSERT INTO `log` VALUES ('144', '登录IP:123.165.48.124，物理地址：黑龙江省哈尔滨市', '2019-04-01 14:31:53', '2019-04-01 14:31:53');
INSERT INTO `log` VALUES ('145', '登录IP:123.165.48.124，物理地址：黑龙江省哈尔滨市', '2019-04-01 15:13:23', '2019-04-01 15:13:23');
INSERT INTO `log` VALUES ('146', '登录IP:125.70.78.33，物理地址：四川省成都市', '2019-04-01 22:57:15', '2019-04-01 22:57:15');
INSERT INTO `log` VALUES ('147', '登录IP:113.81.197.179，物理地址：广东省深圳市', '2019-04-04 15:33:34', '2019-04-04 15:33:34');
INSERT INTO `log` VALUES ('148', '登录IP:58.215.108.75，物理地址：上海市', '2019-04-10 17:50:39', '2019-04-10 17:50:39');
INSERT INTO `log` VALUES ('149', '登录IP:116.226.76.164，物理地址：上海市', '2019-04-11 11:20:03', '2019-04-11 11:20:03');
INSERT INTO `log` VALUES ('150', '登录IP:118.26.133.242，物理地址：北京市', '2019-04-11 17:36:05', '2019-04-11 17:36:05');
INSERT INTO `log` VALUES ('151', '登录IP:114.252.49.25，物理地址：北京市', '2019-04-13 23:00:39', '2019-04-13 23:00:39');
INSERT INTO `log` VALUES ('152', '登录IP:113.251.25.183，物理地址：重庆市', '2019-04-14 00:07:00', '2019-04-14 00:07:00');
INSERT INTO `log` VALUES ('153', '登录IP:223.72.56.204，物理地址：北京市', '2019-04-14 01:11:08', '2019-04-14 01:11:08');
INSERT INTO `log` VALUES ('154', '登录IP:123.149.103.144，物理地址：河南省郑州市', '2019-04-15 11:41:04', '2019-04-15 11:41:04');
INSERT INTO `log` VALUES ('155', '登录IP:115.61.107.87，物理地址：河南省开封市', '2019-04-15 17:45:46', '2019-04-15 17:45:46');
INSERT INTO `log` VALUES ('156', '登录IP:114.251.159.68，物理地址：北京市', '2019-04-16 19:16:19', '2019-04-16 19:16:19');
INSERT INTO `log` VALUES ('157', '登录IP:112.85.211.15，物理地址：江苏省徐州市', '2019-04-16 23:41:32', '2019-04-16 23:41:32');
INSERT INTO `log` VALUES ('158', '登录IP:125.70.178.57，物理地址：四川省成都市', '2019-04-17 23:33:50', '2019-04-17 23:33:50');
INSERT INTO `log` VALUES ('159', '登录IP:101.93.29.191，物理地址：上海市', '2019-04-19 19:04:03', '2019-04-19 19:04:03');
INSERT INTO `log` VALUES ('160', '登录IP:117.159.10.43，物理地址：河南省新乡市', '2019-04-21 08:46:01', '2019-04-21 08:46:01');
INSERT INTO `log` VALUES ('161', '登录IP:14.134.1.186，物理地址：宁夏回族自治区银川市', '2019-04-21 16:42:29', '2019-04-21 16:42:29');
INSERT INTO `log` VALUES ('162', '登录IP:14.134.1.186，物理地址：宁夏回族自治区银川市', '2019-04-21 16:44:32', '2019-04-21 16:44:32');
INSERT INTO `log` VALUES ('163', '登录IP:14.134.1.186，物理地址：宁夏回族自治区银川市', '2019-04-21 16:46:21', '2019-04-21 16:46:21');
INSERT INTO `log` VALUES ('164', '登录IP:222.209.10.191，物理地址：四川省成都市', '2019-04-22 18:30:40', '2019-04-22 18:30:40');
INSERT INTO `log` VALUES ('165', '登录IP:171.83.124.231，物理地址：湖北省武汉市', '2019-04-22 21:18:51', '2019-04-22 21:18:51');
INSERT INTO `log` VALUES ('166', '登录IP:52.141.37.218，物理地址：', '2019-04-23 19:41:00', '2019-04-23 19:41:00');
INSERT INTO `log` VALUES ('167', '登录IP:111.194.82.92，物理地址：北京市', '2019-04-24 13:49:48', '2019-04-24 13:49:48');
INSERT INTO `log` VALUES ('168', '登录IP:203.137.166.44，物理地址：', '2019-04-28 18:42:15', '2019-04-28 18:42:15');
INSERT INTO `log` VALUES ('169', '登录IP:124.232.146.133，物理地址：湖南省长沙市', '2019-04-30 16:44:25', '2019-04-30 16:44:25');
INSERT INTO `log` VALUES ('170', '登录IP:153.0.2.248，物理地址：海南省海口市', '2019-05-01 18:45:30', '2019-05-01 18:45:30');
INSERT INTO `log` VALUES ('171', '登录IP:153.0.2.248，物理地址：海南省海口市', '2019-05-01 18:45:38', '2019-05-01 18:45:38');
INSERT INTO `log` VALUES ('172', '登录IP:219.232.77.45，物理地址：广西壮族自治区玉林市', '2019-05-01 20:46:18', '2019-05-01 20:46:18');
INSERT INTO `log` VALUES ('173', '登录IP:117.136.0.229，物理地址：北京市', '2019-05-03 20:46:49', '2019-05-03 20:46:49');
INSERT INTO `log` VALUES ('174', '登录IP:110.90.228.41，物理地址：福建省', '2019-05-06 16:44:33', '2019-05-06 16:44:33');
INSERT INTO `log` VALUES ('175', '登录IP:182.50.118.228，物理地址：北京市', '2019-05-07 17:59:15', '2019-05-07 17:59:15');
INSERT INTO `log` VALUES ('176', '登录IP:113.105.12.152，物理地址：广东省广州市', '2019-05-08 14:57:32', '2019-05-08 14:57:32');
INSERT INTO `log` VALUES ('177', '登录IP:221.0.27.72，物理地址：山东省济南市', '2019-05-08 23:14:43', '2019-05-08 23:14:43');
INSERT INTO `log` VALUES ('178', '登录IP:222.72.134.250，物理地址：上海市', '2019-05-09 20:28:05', '2019-05-09 20:28:05');
INSERT INTO `log` VALUES ('179', '登录IP:223.104.64.146，物理地址：广东省深圳市', '2019-05-11 18:38:00', '2019-05-11 18:38:00');
INSERT INTO `log` VALUES ('180', '登录IP:210.13.104.121，物理地址：上海市', '2019-05-13 18:40:41', '2019-05-13 18:40:41');
INSERT INTO `log` VALUES ('181', '登录IP:61.242.59.25，物理地址：广东省广州市', '2019-05-13 23:41:40', '2019-05-13 23:41:40');
INSERT INTO `log` VALUES ('182', '登录IP:59.41.70.170，物理地址：广东省广州市', '2019-05-14 14:24:18', '2019-05-14 14:24:18');
INSERT INTO `log` VALUES ('183', '登录IP:182.148.112.32，物理地址：四川省成都市', '2019-05-15 15:21:04', '2019-05-15 15:21:04');
INSERT INTO `log` VALUES ('184', '登录IP:112.64.6.75，物理地址：上海市', '2019-05-15 16:39:54', '2019-05-15 16:39:54');
INSERT INTO `log` VALUES ('185', '登录IP:125.120.229.237，物理地址：浙江省杭州市', '2019-05-16 13:09:16', '2019-05-16 13:09:16');
INSERT INTO `log` VALUES ('186', '登录IP:61.173.13.116，物理地址：上海市', '2019-05-16 18:59:29', '2019-05-16 18:59:29');
INSERT INTO `log` VALUES ('187', '登录IP:61.242.59.204，物理地址：广东省广州市', '2019-05-16 22:27:23', '2019-05-16 22:27:23');
INSERT INTO `log` VALUES ('188', '登录IP:183.247.183.82，物理地址：浙江省杭州市', '2019-05-17 09:07:22', '2019-05-17 09:07:22');
INSERT INTO `log` VALUES ('189', '登录IP:114.94.190.40，物理地址：上海市', '2019-05-17 10:15:27', '2019-05-17 10:15:27');
INSERT INTO `log` VALUES ('190', '登录IP:113.81.196.19，物理地址：广东省深圳市', '2019-05-17 16:40:59', '2019-05-17 16:40:59');
INSERT INTO `log` VALUES ('191', '登录IP:117.136.52.246，物理地址：湖北省武汉市', '2019-05-19 22:59:10', '2019-05-19 22:59:10');
INSERT INTO `log` VALUES ('192', '登录IP:117.136.52.246，物理地址：湖北省武汉市', '2019-05-19 23:19:58', '2019-05-19 23:19:58');
INSERT INTO `log` VALUES ('193', '登录IP:223.104.172.16，物理地址：江西省九江市', '2019-05-20 01:15:21', '2019-05-20 01:15:21');
INSERT INTO `log` VALUES ('194', '登录IP:219.87.144.107，物理地址：台湾省', '2019-05-20 14:38:23', '2019-05-20 14:38:23');
INSERT INTO `log` VALUES ('195', '登录IP:124.204.33.178，物理地址：北京市', '2019-05-20 15:05:11', '2019-05-20 15:05:11');
INSERT INTO `log` VALUES ('196', '登录IP:119.123.122.79，物理地址：广东省深圳市', '2019-05-20 17:40:01', '2019-05-20 17:40:01');
INSERT INTO `log` VALUES ('197', '登录IP:220.113.107.111，物理地址：湖北省武汉市', '2019-05-21 22:33:27', '2019-05-21 22:33:27');
INSERT INTO `log` VALUES ('198', '登录IP:120.236.193.39，物理地址：广东省广州市', '2019-05-22 11:35:39', '2019-05-22 11:35:39');
INSERT INTO `log` VALUES ('199', '登录IP:182.34.218.97，物理地址：山东省淄博市', '2019-05-22 17:55:40', '2019-05-22 17:55:40');
INSERT INTO `log` VALUES ('200', '登录IP:61.242.59.248，物理地址：广东省广州市', '2019-05-23 22:01:55', '2019-05-23 22:01:55');
INSERT INTO `log` VALUES ('201', '登录IP:183.156.9.30，物理地址：浙江省杭州市', '2019-05-24 06:57:56', '2019-05-24 06:57:56');
INSERT INTO `log` VALUES ('202', '登录IP:103.218.216.97，物理地址：广东省深圳市', '2019-05-24 14:24:43', '2019-05-24 14:24:43');
INSERT INTO `log` VALUES ('203', '登录IP:1.204.65.176，物理地址：贵州省贵阳市', '2019-05-25 01:59:30', '2019-05-25 01:59:30');
INSERT INTO `log` VALUES ('204', '登录IP:139.224.131.252，物理地址：上海市', '2019-05-26 09:53:42', '2019-05-26 09:53:42');
INSERT INTO `log` VALUES ('205', '登录IP:183.60.191.113，物理地址：广东省广州市', '2019-05-27 18:02:52', '2019-05-27 18:02:52');
INSERT INTO `log` VALUES ('206', '登录IP:115.172.118.76，物理地址：广东省广州市', '2019-05-28 19:47:05', '2019-05-28 19:47:05');
INSERT INTO `log` VALUES ('207', '登录IP:183.11.237.42，物理地址：广东省深圳市', '2019-05-29 08:45:39', '2019-05-29 08:45:39');
INSERT INTO `log` VALUES ('208', '登录IP:116.231.91.92，物理地址：上海市', '2019-05-29 10:14:18', '2019-05-29 10:14:18');
INSERT INTO `log` VALUES ('209', '登录IP:61.173.13.116，物理地址：上海市', '2019-05-29 15:50:35', '2019-05-29 15:50:35');
INSERT INTO `log` VALUES ('210', '登录IP:180.212.38.186，物理地址：天津市', '2019-05-30 13:24:45', '2019-05-30 13:24:45');
INSERT INTO `log` VALUES ('211', '登录IP:119.123.120.198，物理地址：广东省深圳市', '2019-05-31 09:23:37', '2019-05-31 09:23:37');
INSERT INTO `log` VALUES ('212', '登录IP:118.192.166.82，物理地址：北京市', '2019-05-31 17:19:40', '2019-05-31 17:19:40');
INSERT INTO `log` VALUES ('213', '登录IP:222.209.152.99，物理地址：四川省成都市', '2019-05-31 20:23:23', '2019-05-31 20:23:23');
INSERT INTO `log` VALUES ('214', '登录IP:113.96.219.250，物理地址：广东省广州市', '2019-05-31 23:00:40', '2019-05-31 23:00:40');
INSERT INTO `log` VALUES ('215', '登录IP:123.120.46.40，物理地址：北京市', '2019-06-02 00:15:57', '2019-06-02 00:15:57');
INSERT INTO `log` VALUES ('216', '登录IP:120.39.60.128，物理地址：福建省福州市', '2019-06-02 11:08:21', '2019-06-02 11:08:21');
INSERT INTO `log` VALUES ('217', '登录IP:114.102.185.88，物理地址：安徽省合肥市', '2019-06-03 15:01:51', '2019-06-03 15:01:51');
INSERT INTO `log` VALUES ('218', '登录IP:180.173.114.208，物理地址：上海市', '2019-06-04 08:55:12', '2019-06-04 08:55:12');
INSERT INTO `log` VALUES ('219', '登录IP:119.90.88.106，物理地址：北京市', '2019-06-04 14:30:38', '2019-06-04 14:30:38');
INSERT INTO `log` VALUES ('220', '登录IP:60.1.217.105，物理地址：河北省石家庄市', '2019-06-04 23:34:29', '2019-06-04 23:34:29');
INSERT INTO `log` VALUES ('221', '登录IP:113.81.197.117，物理地址：广东省深圳市', '2019-06-05 09:24:46', '2019-06-05 09:24:46');
INSERT INTO `log` VALUES ('222', '登录IP:101.229.218.240，物理地址：上海市', '2019-06-05 11:34:33', '2019-06-05 11:34:33');
INSERT INTO `log` VALUES ('223', '登录IP:219.145.5.32，物理地址：陕西省咸阳市', '2019-06-07 10:30:13', '2019-06-07 10:30:13');
INSERT INTO `log` VALUES ('224', '登录IP:111.58.16.10，物理地址：广西壮族自治区桂林市', '2019-06-07 10:36:22', '2019-06-07 10:36:22');
INSERT INTO `log` VALUES ('225', '登录IP:117.136.79.166，物理地址：广东省深圳市', '2019-06-08 01:34:46', '2019-06-08 01:34:46');
INSERT INTO `log` VALUES ('226', '登录IP:125.69.44.113，物理地址：四川省成都市', '2019-06-08 21:13:20', '2019-06-08 21:13:20');
INSERT INTO `log` VALUES ('227', '登录IP:183.17.233.248，物理地址：广东省深圳市', '2019-06-09 10:40:14', '2019-06-09 10:40:14');
INSERT INTO `log` VALUES ('228', '登录IP:36.7.69.7，物理地址：安徽省合肥市', '2019-06-11 11:08:30', '2019-06-11 11:08:30');
INSERT INTO `log` VALUES ('229', '登录IP:1.198.215.151，物理地址：河南省郑州市', '2019-06-12 16:36:11', '2019-06-12 16:36:11');
INSERT INTO `log` VALUES ('230', '登录IP:101.24.206.123，物理地址：河北省石家庄市', '2019-06-12 22:08:28', '2019-06-12 22:08:28');
INSERT INTO `log` VALUES ('231', '登录IP:116.231.91.92，物理地址：上海市', '2019-06-13 11:26:30', '2019-06-13 11:26:30');
INSERT INTO `log` VALUES ('232', '登录IP:113.240.168.36，物理地址：湖南省长沙市', '2019-06-13 23:08:05', '2019-06-13 23:08:05');
INSERT INTO `log` VALUES ('233', '登录IP:61.140.178.41，物理地址：广东省广州市', '2019-06-14 15:14:47', '2019-06-14 15:14:47');
INSERT INTO `log` VALUES ('234', '登录IP:113.116.194.199，物理地址：广东省深圳市', '2019-06-16 10:28:14', '2019-06-16 10:28:14');
INSERT INTO `log` VALUES ('235', '登录IP:42.197.30.143，物理地址：广东省广州市', '2019-06-16 23:31:56', '2019-06-16 23:31:56');
INSERT INTO `log` VALUES ('236', '登录IP:120.230.102.92，物理地址：广东省广州市', '2019-06-18 00:54:47', '2019-06-18 00:54:47');
INSERT INTO `log` VALUES ('237', '登录IP:61.242.59.59，物理地址：广东省广州市', '2019-06-18 23:18:46', '2019-06-18 23:18:46');
INSERT INTO `log` VALUES ('238', '登录IP:222.174.55.106，物理地址：山东省德州市', '2019-06-19 11:42:28', '2019-06-19 11:42:28');
INSERT INTO `log` VALUES ('239', '登录IP:180.164.60.178，物理地址：上海市', '2019-06-19 15:50:27', '2019-06-19 15:50:27');
INSERT INTO `log` VALUES ('240', '登录IP:182.118.8.42，物理地址：河南省郑州市', '2019-06-20 16:26:02', '2019-06-20 16:26:02');
INSERT INTO `log` VALUES ('241', '登录IP:171.217.40.122，物理地址：四川省成都市', '2019-06-21 22:56:53', '2019-06-21 22:56:53');
INSERT INTO `log` VALUES ('242', '登录IP:124.15.225.111，物理地址：上海市', '2019-06-21 23:00:56', '2019-06-21 23:00:56');
INSERT INTO `log` VALUES ('243', '登录IP:45.115.159.14，物理地址：北京市', '2019-06-23 10:34:53', '2019-06-23 10:34:53');
INSERT INTO `log` VALUES ('244', '登录IP:122.96.43.137，物理地址：江苏省南京市', '2019-06-23 17:27:23', '2019-06-23 17:27:23');
INSERT INTO `log` VALUES ('245', '登录IP:61.242.59.57，物理地址：广东省广州市', '2019-06-24 21:28:43', '2019-06-24 21:28:43');
INSERT INTO `log` VALUES ('246', '登录IP:61.242.59.57，物理地址：广东省广州市', '2019-06-24 22:14:43', '2019-06-24 22:14:43');
INSERT INTO `log` VALUES ('247', '登录IP:119.84.107.59，物理地址：广东省深圳市', '2019-06-25 14:23:32', '2019-06-25 14:23:32');
INSERT INTO `log` VALUES ('248', '登录IP:116.192.175.129，物理地址：上海市', '2019-06-25 14:24:42', '2019-06-25 14:24:42');
INSERT INTO `log` VALUES ('249', '登录IP:111.202.192.7，物理地址：北京市', '2019-06-25 14:38:34', '2019-06-25 14:38:34');
INSERT INTO `log` VALUES ('250', '登录IP:183.234.48.155，物理地址：广东省佛山市', '2019-06-25 19:19:29', '2019-06-25 19:19:29');
INSERT INTO `log` VALUES ('251', '登录IP:183.63.76.242，物理地址：广东省广州市', '2019-06-26 14:00:09', '2019-06-26 14:00:09');
INSERT INTO `log` VALUES ('252', '登录IP:60.177.97.49，物理地址：浙江省杭州市', '2019-06-26 14:08:29', '2019-06-26 14:08:29');
INSERT INTO `log` VALUES ('253', '登录IP:119.178.213.188，物理地址：山东省菏泽市', '2019-06-27 23:14:48', '2019-06-27 23:14:48');
INSERT INTO `log` VALUES ('254', '登录IP:203.90.239.78，物理地址：香港特别行政区', '2019-06-28 02:46:38', '2019-06-28 02:46:38');
INSERT INTO `log` VALUES ('255', '登录IP:116.231.91.106，物理地址：上海市', '2019-06-28 13:21:50', '2019-06-28 13:21:50');
INSERT INTO `log` VALUES ('256', '登录IP:117.136.40.166，物理地址：广东省广州市', '2019-06-28 14:39:31', '2019-06-28 14:39:31');
INSERT INTO `log` VALUES ('257', '登录IP:171.223.96.88，物理地址：四川省成都市', '2019-06-28 21:05:46', '2019-06-28 21:05:46');
INSERT INTO `log` VALUES ('258', '登录IP:120.229.36.234，物理地址：广东省深圳市', '2019-06-29 17:50:50', '2019-06-29 17:50:50');
INSERT INTO `log` VALUES ('259', '登录IP:211.94.195.8，物理地址：天津市', '2019-06-29 18:51:36', '2019-06-29 18:51:36');
INSERT INTO `log` VALUES ('260', '登录IP:113.61.50.145，物理地址：', '2019-06-29 19:34:36', '2019-06-29 19:34:36');
INSERT INTO `log` VALUES ('261', '登录IP:117.62.229.139，物理地址：江苏省南京市', '2019-07-01 09:35:03', '2019-07-01 09:35:03');
INSERT INTO `log` VALUES ('262', '登录IP:125.70.179.24，物理地址：四川省成都市', '2019-07-02 08:57:21', '2019-07-02 08:57:21');
INSERT INTO `log` VALUES ('263', '登录IP:116.231.91.106，物理地址：上海市', '2019-07-02 17:19:18', '2019-07-02 17:19:18');
INSERT INTO `log` VALUES ('264', '登录IP:121.18.229.234，物理地址：河北省保定市', '2019-07-03 17:28:43', '2019-07-03 17:28:43');
INSERT INTO `log` VALUES ('265', '登录IP:118.247.58.29，物理地址：北京市', '2019-07-03 17:30:51', '2019-07-03 17:30:51');
INSERT INTO `log` VALUES ('266', '登录IP:14.116.71.95，物理地址：广东省珠海市', '2019-07-03 19:04:53', '2019-07-03 19:04:53');
INSERT INTO `log` VALUES ('267', '登录IP:220.112.124.193，物理地址：上海市', '2019-07-04 21:52:33', '2019-07-04 21:52:33');
INSERT INTO `log` VALUES ('268', '登录IP:111.201.244.46，物理地址：北京市', '2019-07-06 10:59:32', '2019-07-06 10:59:32');
INSERT INTO `log` VALUES ('269', '登录IP:116.231.91.106，物理地址：上海市', '2019-07-08 13:15:52', '2019-07-08 13:15:52');
INSERT INTO `log` VALUES ('270', '登录IP:61.165.175.68，物理地址：上海市', '2019-07-08 20:59:28', '2019-07-08 20:59:28');
INSERT INTO `log` VALUES ('271', '登录IP:125.122.33.241，物理地址：浙江省杭州市', '2019-07-09 13:42:58', '2019-07-09 13:42:58');
INSERT INTO `log` VALUES ('272', '登录IP:183.6.50.151，物理地址：广东省广州市', '2019-07-09 17:47:27', '2019-07-09 17:47:27');
INSERT INTO `log` VALUES ('273', '登录IP:218.76.8.51，物理地址：湖南省长沙市', '2019-07-10 16:37:51', '2019-07-10 16:37:51');
INSERT INTO `log` VALUES ('274', '登录IP:202.38.75.182，物理地址：安徽省合肥市', '2019-07-11 17:41:21', '2019-07-11 17:41:21');
INSERT INTO `log` VALUES ('275', '登录IP:139.224.131.252，物理地址：上海市', '2019-07-11 20:20:38', '2019-07-11 20:20:38');
INSERT INTO `log` VALUES ('276', '登录IP:123.120.120.160，物理地址：北京市', '2019-07-12 11:30:50', '2019-07-12 11:30:50');
INSERT INTO `log` VALUES ('277', '登录IP:183.14.29.246，物理地址：广东省深圳市', '2019-07-12 14:28:17', '2019-07-12 14:28:17');
INSERT INTO `log` VALUES ('278', '登录IP:116.231.91.106，物理地址：上海市', '2019-07-12 14:44:35', '2019-07-12 14:44:35');
INSERT INTO `log` VALUES ('279', '登录IP:116.231.91.106，物理地址：上海市', '2019-07-12 14:44:36', '2019-07-12 14:44:36');
INSERT INTO `log` VALUES ('280', '登录IP:221.221.152.199，物理地址：北京市', '2019-07-12 18:34:24', '2019-07-12 18:34:24');
INSERT INTO `log` VALUES ('281', '登录IP:58.243.186.254，物理地址：安徽省芜湖市', '2019-07-13 09:39:50', '2019-07-13 09:39:50');
INSERT INTO `log` VALUES ('282', '登录IP:182.109.165.96，物理地址：江西省吉安市', '2019-07-14 20:16:23', '2019-07-14 20:16:23');
INSERT INTO `log` VALUES ('283', '登录IP:167.179.76.63，物理地址：', '2019-07-14 20:18:39', '2019-07-14 20:18:39');
INSERT INTO `log` VALUES ('284', '登录IP:124.237.155.7，物理地址：河北省保定市', '2019-07-15 09:39:06', '2019-07-15 09:39:06');
INSERT INTO `log` VALUES ('285', '登录IP:117.141.183.30，物理地址：广西壮族自治区百色市', '2019-07-15 12:05:41', '2019-07-15 12:05:41');
INSERT INTO `log` VALUES ('286', '登录IP:150.109.116.19，物理地址：北京市', '2019-07-15 15:20:53', '2019-07-15 15:20:53');
INSERT INTO `log` VALUES ('287', '登录IP:117.30.205.67，物理地址：福建省厦门市', '2019-07-15 20:45:07', '2019-07-15 20:45:07');
INSERT INTO `log` VALUES ('288', '登录IP:59.173.31.83，物理地址：湖北省武汉市', '2019-07-16 16:53:00', '2019-07-16 16:53:00');
INSERT INTO `log` VALUES ('289', '登录IP:116.231.89.218，物理地址：上海市', '2019-07-17 12:59:10', '2019-07-17 12:59:10');
INSERT INTO `log` VALUES ('290', '登录IP:116.231.89.218，物理地址：上海市', '2019-07-17 13:05:07', '2019-07-17 13:05:07');
INSERT INTO `log` VALUES ('291', '登录IP:115.238.95.194，物理地址：浙江省杭州市', '2019-07-18 18:28:23', '2019-07-18 18:28:23');
INSERT INTO `log` VALUES ('292', '登录IP:106.37.70.35，物理地址：北京市', '2019-07-18 20:51:21', '2019-07-18 20:51:21');
INSERT INTO `log` VALUES ('293', '登录IP:183.192.27.193，物理地址：上海市', '2019-07-20 10:01:31', '2019-07-20 10:01:31');
INSERT INTO `log` VALUES ('294', '登录IP:101.230.197.230，物理地址：上海市', '2019-07-21 18:39:34', '2019-07-21 18:39:34');
INSERT INTO `log` VALUES ('295', '登录IP:1.203.173.97，物理地址：北京市', '2019-07-22 11:33:54', '2019-07-22 11:33:54');
INSERT INTO `log` VALUES ('296', '登录IP:36.102.208.154，物理地址：北京市', '2019-07-22 15:01:43', '2019-07-22 15:01:43');
INSERT INTO `log` VALUES ('297', '登录IP:111.75.193.21，物理地址：江西省南昌市', '2019-07-22 16:40:16', '2019-07-22 16:40:16');
INSERT INTO `log` VALUES ('298', '登录IP:116.231.89.218，物理地址：上海市', '2019-07-23 13:59:49', '2019-07-23 13:59:49');
INSERT INTO `log` VALUES ('299', '登录IP:116.231.88.208，物理地址：上海市', '2019-07-24 10:56:56', '2019-07-24 10:56:56');
INSERT INTO `log` VALUES ('300', '登录IP:112.112.140.172，物理地址：云南省昆明市', '2019-07-24 13:59:30', '2019-07-24 13:59:30');
INSERT INTO `log` VALUES ('301', '登录IP:118.112.59.149，物理地址：四川省成都市', '2019-07-24 23:04:58', '2019-07-24 23:04:58');
INSERT INTO `log` VALUES ('302', '登录IP:221.218.209.211，物理地址：北京市', '2019-07-25 10:23:39', '2019-07-25 10:23:39');
INSERT INTO `log` VALUES ('303', '登录IP:35.200.4.243，物理地址：', '2019-07-25 18:14:32', '2019-07-25 18:14:32');
INSERT INTO `log` VALUES ('304', '登录IP:59.42.185.78，物理地址：广东省广州市', '2019-07-26 14:57:57', '2019-07-26 14:57:57');
INSERT INTO `log` VALUES ('305', '登录IP:223.104.37.216，物理地址：安徽省合肥市', '2019-07-26 21:27:25', '2019-07-26 21:27:25');
INSERT INTO `log` VALUES ('306', '登录IP:114.243.175.87，物理地址：北京市', '2019-07-28 19:21:39', '2019-07-28 19:21:39');
INSERT INTO `log` VALUES ('307', '登录IP:171.216.69.243，物理地址：四川省成都市', '2019-07-28 21:42:24', '2019-07-28 21:42:24');
INSERT INTO `log` VALUES ('308', '登录IP:116.231.90.211，物理地址：上海市', '2019-07-29 10:00:49', '2019-07-29 10:00:49');
INSERT INTO `log` VALUES ('309', '登录IP:117.35.158.110，物理地址：陕西省西安市', '2019-07-29 18:32:00', '2019-07-29 18:32:00');
INSERT INTO `log` VALUES ('310', '登录IP:180.153.219.15，物理地址：上海市', '2019-07-31 09:44:07', '2019-07-31 09:44:07');
INSERT INTO `log` VALUES ('311', '登录IP:119.123.77.2，物理地址：广东省深圳市', '2019-07-31 11:27:08', '2019-07-31 11:27:08');
INSERT INTO `log` VALUES ('312', '登录IP:119.137.52.127，物理地址：广东省深圳市', '2019-08-01 16:23:57', '2019-08-01 16:23:57');
INSERT INTO `log` VALUES ('313', '登录IP:52.79.78.102，物理地址：', '2019-08-02 11:40:04', '2019-08-02 11:40:04');
INSERT INTO `log` VALUES ('314', '登录IP:218.16.97.90，物理地址：广东省东莞市', '2019-08-02 14:38:38', '2019-08-02 14:38:38');
INSERT INTO `log` VALUES ('315', '登录IP:113.99.127.237，物理地址：广东省深圳市', '2019-08-02 17:43:34', '2019-08-02 17:43:34');
INSERT INTO `log` VALUES ('316', '登录IP:117.143.44.193，物理地址：上海市', '2019-08-02 21:29:39', '2019-08-02 21:29:39');
INSERT INTO `log` VALUES ('317', '登录IP:116.231.88.166，物理地址：上海市', '2019-08-06 11:17:22', '2019-08-06 11:17:22');
INSERT INTO `log` VALUES ('318', '登录IP:116.231.88.166，物理地址：上海市', '2019-08-06 11:17:22', '2019-08-06 11:17:22');
INSERT INTO `log` VALUES ('319', '登录IP:106.38.48.226，物理地址：北京市', '2019-08-07 10:01:14', '2019-08-07 10:01:14');
INSERT INTO `log` VALUES ('320', '登录IP:183.206.15.148，物理地址：江苏省南京市', '2019-08-10 22:40:40', '2019-08-10 22:40:40');
INSERT INTO `log` VALUES ('321', '登录IP:115.236.9.84，物理地址：浙江省杭州市', '2019-08-15 20:23:30', '2019-08-15 20:23:30');
INSERT INTO `log` VALUES ('322', '登录IP:118.122.107.213，物理地址：四川省成都市', '2019-08-16 09:40:55', '2019-08-16 09:40:55');
INSERT INTO `log` VALUES ('323', '登录IP:118.122.107.213，物理地址：四川省成都市', '2019-08-16 10:11:55', '2019-08-16 10:11:55');
INSERT INTO `log` VALUES ('324', '登录IP:101.229.59.206，物理地址：上海市', '2019-08-16 11:22:16', '2019-08-16 11:22:16');
INSERT INTO `log` VALUES ('325', '登录IP:113.226.241.67，物理地址：辽宁省大连市', '2019-08-19 09:41:18', '2019-08-19 09:41:18');
INSERT INTO `log` VALUES ('326', '登录IP:183.167.47.21，物理地址：安徽省淮南市', '2019-08-19 09:42:08', '2019-08-19 09:42:08');
INSERT INTO `log` VALUES ('327', '登录IP:116.231.89.131，物理地址：上海市', '2019-08-19 17:37:39', '2019-08-19 17:37:39');
INSERT INTO `log` VALUES ('328', '登录IP:117.149.19.113，物理地址：浙江省杭州市', '2019-08-20 17:53:06', '2019-08-20 17:53:06');
INSERT INTO `log` VALUES ('329', '登录IP:101.88.98.250，物理地址：上海市', '2019-08-20 22:14:37', '2019-08-20 22:14:37');
INSERT INTO `log` VALUES ('330', '登录IP:219.142.144.243，物理地址：北京市', '2019-08-24 10:33:55', '2019-08-24 10:33:55');
INSERT INTO `log` VALUES ('331', '登录IP:59.33.111.85，物理地址：广东省中山市', '2019-08-25 09:39:34', '2019-08-25 09:39:34');
INSERT INTO `log` VALUES ('332', '登录IP:112.27.201.103，物理地址：安徽省', '2019-08-26 12:35:42', '2019-08-26 12:35:42');
INSERT INTO `log` VALUES ('333', '登录IP:112.31.98.232，物理地址：安徽省蚌埠市', '2019-08-26 13:25:01', '2019-08-26 13:25:01');
INSERT INTO `log` VALUES ('334', '登录IP:113.68.155.40，物理地址：广东省广州市', '2019-08-26 16:31:18', '2019-08-26 16:31:18');
INSERT INTO `log` VALUES ('335', '登录IP:96.45.191.29，物理地址：', '2019-08-27 11:22:05', '2019-08-27 11:22:05');
INSERT INTO `log` VALUES ('336', '登录IP:113.81.233.85，物理地址：广东省深圳市', '2019-08-27 17:37:37', '2019-08-27 17:37:37');
INSERT INTO `log` VALUES ('337', '登录IP:106.3.225.92，物理地址：广东省深圳市', '2019-08-27 17:41:01', '2019-08-27 17:41:01');
INSERT INTO `log` VALUES ('338', '登录IP:219.230.76.31，物理地址：江苏省南京市', '2019-08-28 09:04:03', '2019-08-28 09:04:03');
INSERT INTO `log` VALUES ('339', '登录IP:222.65.105.222，物理地址：上海市', '2019-08-28 13:52:54', '2019-08-28 13:52:54');
INSERT INTO `log` VALUES ('340', '登录IP:183.197.158.208，物理地址：河北省廊坊市', '2019-08-29 01:00:13', '2019-08-29 01:00:13');
INSERT INTO `log` VALUES ('341', '登录IP:115.236.52.6，物理地址：浙江省杭州市', '2019-08-30 17:57:02', '2019-08-30 17:57:02');
INSERT INTO `log` VALUES ('342', '登录IP:175.9.141.64，物理地址：湖南省长沙市', '2019-08-31 09:50:45', '2019-08-31 09:50:45');
INSERT INTO `log` VALUES ('343', '登录IP:218.75.207.105，物理地址：湖南省株洲市', '2019-08-31 09:52:34', '2019-08-31 09:52:34');
INSERT INTO `log` VALUES ('344', '登录IP:59.153.88.148，物理地址：', '2019-08-31 23:58:23', '2019-08-31 23:58:23');
INSERT INTO `log` VALUES ('345', '登录IP:103.251.99.145，物理地址：广西壮族自治区南宁市', '2019-09-01 11:42:09', '2019-09-01 11:42:09');
INSERT INTO `log` VALUES ('346', '登录IP:171.221.70.170，物理地址：四川省成都市', '2019-09-02 07:38:35', '2019-09-02 07:38:35');
INSERT INTO `log` VALUES ('347', '登录IP:171.221.70.170，物理地址：四川省成都市', '2019-09-02 07:41:01', '2019-09-02 07:41:01');
INSERT INTO `log` VALUES ('348', '登录IP:114.102.146.237，物理地址：安徽省合肥市', '2019-09-02 10:18:31', '2019-09-02 10:18:31');
INSERT INTO `log` VALUES ('349', '登录IP:183.14.28.153，物理地址：广东省深圳市', '2019-09-02 11:12:50', '2019-09-02 11:12:50');
INSERT INTO `log` VALUES ('350', '登录IP:183.14.133.230，物理地址：广东省深圳市', '2019-09-02 15:14:34', '2019-09-02 15:14:34');
INSERT INTO `log` VALUES ('351', '登录IP:118.186.18.138，物理地址：北京市', '2019-09-02 17:41:43', '2019-09-02 17:41:43');
INSERT INTO `log` VALUES ('352', '登录IP:183.3.227.100，物理地址：广东省广州市', '2019-09-02 20:09:30', '2019-09-02 20:09:30');
INSERT INTO `log` VALUES ('353', '登录IP:222.209.156.77，物理地址：四川省成都市', '2019-09-03 23:14:04', '2019-09-03 23:14:04');
INSERT INTO `log` VALUES ('354', '登录IP:103.27.25.121，物理地址：广东省佛山市', '2019-09-04 21:31:31', '2019-09-04 21:31:31');
INSERT INTO `log` VALUES ('355', '登录IP:219.147.175.81，物理地址：黑龙江省哈尔滨市', '2019-09-04 22:19:19', '2019-09-04 22:19:19');
INSERT INTO `log` VALUES ('356', '登录IP:125.84.61.53，物理地址：重庆市', '2019-09-05 13:51:04', '2019-09-05 13:51:04');
INSERT INTO `log` VALUES ('357', '登录IP:125.84.61.53，物理地址：重庆市', '2019-09-05 13:51:04', '2019-09-05 13:51:04');
INSERT INTO `log` VALUES ('358', '登录IP:222.128.15.95，物理地址：北京市', '2019-09-05 14:04:17', '2019-09-05 14:04:17');
INSERT INTO `log` VALUES ('359', '登录IP:125.84.61.53，物理地址：重庆市', '2019-09-05 15:32:46', '2019-09-05 15:32:46');
INSERT INTO `log` VALUES ('360', '登录IP:125.84.61.53，物理地址：重庆市', '2019-09-05 15:32:58', '2019-09-05 15:32:58');
INSERT INTO `log` VALUES ('361', '登录IP:134.159.116.62，物理地址：香港特别行政区', '2019-09-07 15:26:05', '2019-09-07 15:26:05');
INSERT INTO `log` VALUES ('362', '登录IP:183.64.119.114，物理地址：重庆市', '2019-09-08 18:53:39', '2019-09-08 18:53:39');
INSERT INTO `log` VALUES ('363', '登录IP:180.130.2.32，物理地址：云南省昆明市', '2019-09-08 19:22:39', '2019-09-08 19:22:39');
INSERT INTO `log` VALUES ('364', '登录IP:180.110.163.160，物理地址：江苏省南京市', '2019-09-08 22:16:42', '2019-09-08 22:16:42');
INSERT INTO `log` VALUES ('365', '登录IP:101.87.237.251，物理地址：上海市', '2019-09-08 23:02:05', '2019-09-08 23:02:05');
INSERT INTO `log` VALUES ('366', '登录IP:115.56.38.239，物理地址：河南省商丘市', '2019-09-09 09:54:13', '2019-09-09 09:54:13');
INSERT INTO `log` VALUES ('367', '登录IP:101.68.250.167，物理地址：浙江省嘉兴市', '2019-09-09 17:12:33', '2019-09-09 17:12:33');
INSERT INTO `log` VALUES ('368', '登录IP:120.85.87.233，物理地址：广东省广州市', '2019-09-09 19:08:01', '2019-09-09 19:08:01');
INSERT INTO `log` VALUES ('369', '登录IP:125.73.110.223，物理地址：广西壮族自治区柳州市', '2019-09-10 00:34:05', '2019-09-10 00:34:05');
INSERT INTO `log` VALUES ('370', '登录IP:101.71.251.134，物理地址：浙江省杭州市', '2019-09-10 16:11:24', '2019-09-10 16:11:24');
INSERT INTO `log` VALUES ('371', '登录IP:60.191.78.148，物理地址：浙江省杭州市', '2019-09-10 17:37:30', '2019-09-10 17:37:30');
INSERT INTO `log` VALUES ('372', '登录IP:110.80.38.76，物理地址：福建省厦门市', '2019-09-11 14:21:00', '2019-09-11 14:21:00');
INSERT INTO `log` VALUES ('373', '登录IP:219.129.8.156，物理地址：广东省湛江市', '2019-09-12 09:50:27', '2019-09-12 09:50:27');
INSERT INTO `log` VALUES ('374', '登录IP:103.68.181.134，物理地址：香港特别行政区', '2019-09-12 17:31:10', '2019-09-12 17:31:10');
INSERT INTO `log` VALUES ('375', '登录IP:14.204.0.119，物理地址：云南省昆明市', '2019-09-15 12:38:38', '2019-09-15 12:38:38');
INSERT INTO `log` VALUES ('376', '登录IP:14.204.0.119，物理地址：云南省昆明市', '2019-09-15 12:39:00', '2019-09-15 12:39:00');
INSERT INTO `log` VALUES ('377', '登录IP:14.204.0.119，物理地址：云南省昆明市', '2019-09-15 12:43:57', '2019-09-15 12:43:57');
INSERT INTO `log` VALUES ('378', '登录IP:111.194.45.45，物理地址：北京市', '2019-09-15 17:13:51', '2019-09-15 17:13:51');
INSERT INTO `log` VALUES ('379', '登录IP:119.123.78.6，物理地址：广东省深圳市', '2019-09-16 14:41:11', '2019-09-16 14:41:11');
INSERT INTO `log` VALUES ('380', '登录IP:119.2.9.218，物理地址：北京市', '2019-09-16 14:55:30', '2019-09-16 14:55:30');
INSERT INTO `log` VALUES ('381', '登录IP:1.204.206.69，物理地址：贵州省贵阳市', '2019-09-17 10:35:17', '2019-09-17 10:35:17');
INSERT INTO `log` VALUES ('382', '登录IP:116.231.89.64，物理地址：上海市', '2019-09-17 11:24:09', '2019-09-17 11:24:09');
INSERT INTO `log` VALUES ('383', '登录IP:122.231.56.164，物理地址：浙江省杭州市', '2019-09-17 14:03:06', '2019-09-17 14:03:06');
INSERT INTO `log` VALUES ('384', '登录IP:119.122.213.147，物理地址：广东省深圳市', '2019-09-17 15:20:52', '2019-09-17 15:20:52');
INSERT INTO `log` VALUES ('385', '登录IP:117.136.79.66，物理地址：广东省佛山市', '2019-09-17 20:18:25', '2019-09-17 20:18:25');
INSERT INTO `log` VALUES ('386', '登录IP:120.204.209.42，物理地址：上海市', '2019-09-17 22:10:01', '2019-09-17 22:10:01');
INSERT INTO `log` VALUES ('387', '登录IP:219.136.94.42，物理地址：广东省广州市', '2019-09-19 11:33:19', '2019-09-19 11:33:19');
INSERT INTO `log` VALUES ('388', '登录IP:43.250.200.56，物理地址：湖南省长沙市', '2019-09-20 00:06:07', '2019-09-20 00:06:07');
INSERT INTO `log` VALUES ('389', '登录IP:219.147.8.238，物理地址：山东省青岛市', '2019-09-20 16:31:08', '2019-09-20 16:31:08');
INSERT INTO `log` VALUES ('390', '登录IP:183.192.29.27，物理地址：上海市', '2019-09-22 10:49:00', '2019-09-22 10:49:00');
INSERT INTO `log` VALUES ('391', '登录IP:223.112.27.34，物理地址：江苏省南京市', '2019-09-23 08:58:22', '2019-09-23 08:58:22');
INSERT INTO `log` VALUES ('392', '登录IP:121.18.229.235，物理地址：河北省保定市', '2019-09-23 17:04:26', '2019-09-23 17:04:26');
INSERT INTO `log` VALUES ('393', '登录IP:113.71.193.44，物理地址：广东省佛山市', '2019-09-24 16:27:03', '2019-09-24 16:27:03');
INSERT INTO `log` VALUES ('394', '登录IP:182.150.28.176，物理地址：四川省成都市', '2019-09-25 09:53:34', '2019-09-25 09:53:34');
INSERT INTO `log` VALUES ('395', '登录IP:183.15.178.222，物理地址：广东省深圳市', '2019-09-25 11:59:26', '2019-09-25 11:59:26');
INSERT INTO `log` VALUES ('396', '登录IP:123.116.250.99，物理地址：北京市', '2019-09-26 11:30:31', '2019-09-26 11:30:31');
INSERT INTO `log` VALUES ('397', '登录IP:120.36.248.62，物理地址：福建省厦门市', '2019-09-26 14:01:19', '2019-09-26 14:01:19');
INSERT INTO `log` VALUES ('398', '登录IP:118.122.250.103，物理地址：四川省成都市', '2019-09-26 14:48:18', '2019-09-26 14:48:18');
INSERT INTO `log` VALUES ('399', '登录IP:114.242.67.49，物理地址：北京市', '2019-09-27 09:58:47', '2019-09-27 09:58:47');
INSERT INTO `log` VALUES ('400', '登录IP:116.231.89.97，物理地址：上海市', '2019-09-27 17:37:25', '2019-09-27 17:37:25');
INSERT INTO `log` VALUES ('401', '登录IP:223.152.114.0，物理地址：湖南省郴州市', '2019-09-27 18:28:17', '2019-09-27 18:28:17');
INSERT INTO `log` VALUES ('402', '登录IP:111.200.23.52，物理地址：北京市', '2019-09-28 14:35:55', '2019-09-28 14:35:55');
INSERT INTO `log` VALUES ('403', '登录IP:61.141.254.57，物理地址：广东省深圳市', '2019-09-28 23:46:00', '2019-09-28 23:46:00');
INSERT INTO `log` VALUES ('404', '登录IP:183.63.75.58，物理地址：广东省广州市', '2019-09-30 14:37:48', '2019-09-30 14:37:48');
INSERT INTO `log` VALUES ('405', '登录IP:116.231.89.97，物理地址：上海市', '2019-09-30 16:21:29', '2019-09-30 16:21:29');
INSERT INTO `log` VALUES ('406', '登录IP:183.192.29.27，物理地址：上海市', '2019-10-01 09:02:26', '2019-10-01 09:02:26');
INSERT INTO `log` VALUES ('407', '登录IP:112.8.186.179，物理地址：山东省泰安市', '2019-10-03 15:07:50', '2019-10-03 15:07:50');
INSERT INTO `log` VALUES ('408', '登录IP:171.42.193.237，物理地址：湖北省随州市', '2019-10-04 11:08:24', '2019-10-04 11:08:24');
INSERT INTO `log` VALUES ('409', '登录IP:36.157.75.205，物理地址：湖南省邵阳市', '2019-10-04 19:59:43', '2019-10-04 19:59:43');
INSERT INTO `log` VALUES ('410', '登录IP:116.30.7.105，物理地址：广东省深圳市', '2019-10-04 22:55:15', '2019-10-04 22:55:15');
INSERT INTO `log` VALUES ('411', '登录IP:115.205.64.124，物理地址：浙江省杭州市', '2019-10-07 14:14:18', '2019-10-07 14:14:18');
INSERT INTO `log` VALUES ('412', '登录IP:172.96.205.18，物理地址：', '2019-10-08 15:16:28', '2019-10-08 15:16:28');
INSERT INTO `log` VALUES ('413', '登录IP:113.75.104.115，物理地址：广东省河源市', '2019-10-09 07:38:35', '2019-10-09 07:38:35');
INSERT INTO `log` VALUES ('414', '登录IP:116.231.89.97，物理地址：上海市', '2019-10-09 12:01:41', '2019-10-09 12:01:41');
INSERT INTO `log` VALUES ('415', '登录IP:120.39.41.0，物理地址：福建省福州市', '2019-10-09 12:42:18', '2019-10-09 12:42:18');
INSERT INTO `log` VALUES ('416', '登录IP:124.78.12.242，物理地址：上海市', '2019-10-09 17:46:35', '2019-10-09 17:46:35');
INSERT INTO `log` VALUES ('417', '登录IP:222.187.195.115，物理地址：江苏省宿迁市', '2019-10-09 19:44:23', '2019-10-09 19:44:23');
INSERT INTO `log` VALUES ('418', '登录IP:183.69.201.179，物理地址：重庆市', '2019-10-13 11:36:41', '2019-10-13 11:36:41');
INSERT INTO `log` VALUES ('419', '登录IP:116.1.231.98，物理地址：广西壮族自治区玉林市', '2019-10-13 15:29:35', '2019-10-13 15:29:35');
INSERT INTO `log` VALUES ('420', '登录IP:116.22.202.52，物理地址：广东省广州市', '2019-10-15 04:10:12', '2019-10-15 04:10:12');
INSERT INTO `log` VALUES ('421', '登录IP:116.231.89.97，物理地址：上海市', '2019-10-15 11:37:06', '2019-10-15 11:37:06');
INSERT INTO `log` VALUES ('422', '登录IP:218.30.116.183，物理地址：北京市', '2019-10-18 11:37:43', '2019-10-18 11:37:43');
INSERT INTO `log` VALUES ('423', '登录IP:14.23.103.210，物理地址：广东省广州市', '2019-10-19 15:37:39', '2019-10-19 15:37:39');
INSERT INTO `log` VALUES ('424', '登录IP:113.115.67.41，物理地址：广东省广州市', '2019-10-21 15:31:06', '2019-10-21 15:31:06');
INSERT INTO `log` VALUES ('425', '登录IP:59.173.128.241，物理地址：湖北省武汉市', '2019-10-21 17:11:10', '2019-10-21 17:11:10');
INSERT INTO `log` VALUES ('426', '登录IP:203.86.25.1，物理地址：广东省深圳市', '2019-10-22 16:53:52', '2019-10-22 16:53:52');
INSERT INTO `log` VALUES ('427', '登录IP:183.14.31.211，物理地址：广东省深圳市', '2019-10-22 21:22:14', '2019-10-22 21:22:14');
INSERT INTO `log` VALUES ('428', '登录IP:115.193.36.134，物理地址：浙江省杭州市', '2019-10-23 14:40:58', '2019-10-23 14:40:58');
INSERT INTO `log` VALUES ('429', '登录IP:58.61.244.90，物理地址：广东省广州市', '2019-10-24 11:23:23', '2019-10-24 11:23:23');
INSERT INTO `log` VALUES ('430', '登录IP:106.120.217.44，物理地址：北京市', '2019-10-24 17:32:54', '2019-10-24 17:32:54');
INSERT INTO `log` VALUES ('431', '登录IP:14.116.133.171，物理地址：广东省广州市', '2019-10-25 07:44:02', '2019-10-25 07:44:02');
INSERT INTO `log` VALUES ('432', '登录IP:120.229.108.205，物理地址：广东省东莞市', '2019-10-25 08:56:42', '2019-10-25 08:56:42');
INSERT INTO `log` VALUES ('433', '登录IP:116.231.88.16，物理地址：上海市', '2019-10-25 09:52:10', '2019-10-25 09:52:10');
INSERT INTO `log` VALUES ('434', '登录IP:173.242.125.73，物理地址：', '2019-10-25 13:18:19', '2019-10-25 13:18:19');
INSERT INTO `log` VALUES ('435', '登录IP:39.130.110.241，物理地址：云南省', '2019-10-27 14:29:12', '2019-10-27 14:29:12');
INSERT INTO `log` VALUES ('436', '登录IP:120.52.147.47，物理地址：北京市', '2019-10-28 16:07:05', '2019-10-28 16:07:05');
INSERT INTO `log` VALUES ('437', '登录IP:113.227.245.187，物理地址：辽宁省大连市', '2019-10-28 16:17:21', '2019-10-28 16:17:21');
INSERT INTO `log` VALUES ('438', '登录IP:113.218.172.12，物理地址：湖南省长沙市', '2019-10-29 12:02:15', '2019-10-29 12:02:15');
INSERT INTO `log` VALUES ('439', '登录IP:27.215.160.216，物理地址：山东省枣庄市', '2019-10-29 17:51:53', '2019-10-29 17:51:53');
INSERT INTO `log` VALUES ('440', '登录IP:171.10.64.69，物理地址：河南省郑州市', '2019-10-29 19:52:41', '2019-10-29 19:52:41');
INSERT INTO `log` VALUES ('441', '登录IP:113.81.234.245，物理地址：广东省深圳市', '2019-10-30 10:00:09', '2019-10-30 10:00:09');
INSERT INTO `log` VALUES ('442', '登录IP:218.68.220.43，物理地址：天津市', '2019-10-30 11:12:03', '2019-10-30 11:12:03');
INSERT INTO `log` VALUES ('443', '登录IP:119.129.130.207，物理地址：广东省广州市', '2019-10-31 17:13:07', '2019-10-31 17:13:07');
INSERT INTO `log` VALUES ('444', '登录IP:116.231.91.66，物理地址：上海市', '2019-10-31 17:31:07', '2019-10-31 17:31:07');
INSERT INTO `log` VALUES ('445', '登录IP:116.231.88.16，物理地址：上海市', '2019-10-31 17:36:27', '2019-10-31 17:36:27');
INSERT INTO `log` VALUES ('446', '登录IP:120.35.11.195，物理地址：福建省福州市', '2019-11-01 16:05:06', '2019-11-01 16:05:06');
INSERT INTO `log` VALUES ('447', '登录IP:58.215.108.75，物理地址：江苏省无锡市', '2019-11-01 16:27:45', '2019-11-01 16:27:45');
INSERT INTO `log` VALUES ('448', '登录IP:61.141.65.10，物理地址：广东省深圳市', '2019-11-02 10:51:07', '2019-11-02 10:51:07');
INSERT INTO `log` VALUES ('449', '登录IP:219.151.248.151，物理地址：重庆市', '2019-11-03 19:11:20', '2019-11-03 19:11:20');
INSERT INTO `log` VALUES ('450', '登录IP:61.131.11.253，物理地址：福建省福州市', '2019-11-04 11:58:00', '2019-11-04 11:58:00');
INSERT INTO `log` VALUES ('451', '登录IP:58.37.148.120，物理地址：上海市', '2019-11-04 17:27:22', '2019-11-04 17:27:22');
INSERT INTO `log` VALUES ('452', '登录IP:117.32.131.98，物理地址：陕西省西安市', '2019-11-05 10:35:56', '2019-11-05 10:35:56');
INSERT INTO `log` VALUES ('453', '登录IP:113.90.244.159，物理地址：广东省深圳市', '2019-11-05 14:40:40', '2019-11-05 14:40:40');
INSERT INTO `log` VALUES ('454', '登录IP:59.173.128.241，物理地址：湖北省武汉市', '2019-11-05 15:34:18', '2019-11-05 15:34:18');
INSERT INTO `log` VALUES ('455', '登录IP:218.204.70.58，物理地址：江西省九江市', '2019-11-06 16:06:55', '2019-11-06 16:06:55');
INSERT INTO `log` VALUES ('456', '登录IP:42.228.230.82，物理地址：河南省洛阳市', '2019-11-07 16:20:31', '2019-11-07 16:20:31');
INSERT INTO `log` VALUES ('457', '登录IP:172.104.190.203，物理地址：', '2019-11-08 04:41:39', '2019-11-08 04:41:39');
INSERT INTO `log` VALUES ('458', '登录IP:101.93.247.173，物理地址：上海市', '2019-11-08 12:00:25', '2019-11-08 12:00:25');
INSERT INTO `log` VALUES ('459', '登录IP:58.247.145.208，物理地址：上海市', '2019-11-09 13:51:39', '2019-11-09 13:51:39');
INSERT INTO `log` VALUES ('460', '登录IP:175.167.138.120，物理地址：辽宁省沈阳市', '2019-11-09 17:11:03', '2019-11-09 17:11:03');
INSERT INTO `log` VALUES ('461', '登录IP:113.87.131.245，物理地址：广东省深圳市', '2019-11-10 14:45:46', '2019-11-10 14:45:46');
INSERT INTO `log` VALUES ('462', '登录IP:123.234.188.54，物理地址：山东省青岛市', '2019-11-10 22:59:59', '2019-11-10 22:59:59');
INSERT INTO `log` VALUES ('463', '登录IP:58.247.145.208，物理地址：上海市', '2019-11-11 13:20:46', '2019-11-11 13:20:46');
INSERT INTO `log` VALUES ('464', '登录IP:61.140.26.132，物理地址：广东省广州市', '2019-11-11 14:34:45', '2019-11-11 14:34:45');
INSERT INTO `log` VALUES ('465', '登录IP:114.93.241.99，物理地址：上海市', '2019-11-12 15:21:05', '2019-11-12 15:21:05');
INSERT INTO `log` VALUES ('466', '登录IP:115.194.106.47，物理地址：浙江省杭州市', '2019-11-12 16:28:01', '2019-11-12 16:28:01');
INSERT INTO `log` VALUES ('467', '登录IP:58.248.229.154，物理地址：广东省广州市', '2019-11-12 17:43:11', '2019-11-12 17:43:11');
INSERT INTO `log` VALUES ('468', '登录IP:113.89.1.73，物理地址：广东省深圳市', '2019-11-13 15:42:43', '2019-11-13 15:42:43');
INSERT INTO `log` VALUES ('469', '登录IP:116.228.44.178，物理地址：上海市', '2019-11-13 18:05:18', '2019-11-13 18:05:18');
INSERT INTO `log` VALUES ('470', '登录IP:180.154.17.46，物理地址：上海市', '2019-11-13 18:34:57', '2019-11-13 18:34:57');
INSERT INTO `log` VALUES ('471', '登录IP:219.135.155.73，物理地址：广东省广州市', '2019-11-14 15:21:55', '2019-11-14 15:21:55');
INSERT INTO `log` VALUES ('472', '登录IP:39.82.157.198，物理地址：山东省济南市', '2019-11-16 15:39:01', '2019-11-16 15:39:01');
INSERT INTO `log` VALUES ('473', '登录IP:120.241.64.18，物理地址：广东省广州市', '2019-11-17 17:43:19', '2019-11-17 17:43:19');
INSERT INTO `log` VALUES ('474', '登录IP:123.177.19.234，物理地址：辽宁省大连市', '2019-11-18 17:45:33', '2019-11-18 17:45:33');
INSERT INTO `log` VALUES ('475', '登录IP:223.104.64.247，物理地址：广东省广州市', '2019-11-20 18:46:52', '2019-11-20 18:46:52');
INSERT INTO `log` VALUES ('476', '登录IP:123.52.16.236，物理地址：河南省郑州市', '2019-11-21 09:24:51', '2019-11-21 09:24:51');
INSERT INTO `log` VALUES ('477', '登录IP:116.77.75.248，物理地址：广东省深圳市', '2019-11-21 16:06:04', '2019-11-21 16:06:04');
INSERT INTO `log` VALUES ('478', '登录IP:58.247.66.114，物理地址：上海市', '2019-11-21 17:49:49', '2019-11-21 17:49:49');
INSERT INTO `log` VALUES ('479', '登录IP:27.17.104.49，物理地址：湖北省武汉市', '2019-11-22 23:56:50', '2019-11-22 23:56:50');
INSERT INTO `log` VALUES ('480', '登录IP:117.62.230.179，物理地址：江苏省南京市', '2019-11-23 08:11:20', '2019-11-23 08:11:20');
INSERT INTO `log` VALUES ('481', '登录IP:183.253.53.224，物理地址：福建省厦门市', '2019-11-24 22:01:22', '2019-11-24 22:01:22');
INSERT INTO `log` VALUES ('482', '登录IP:183.63.75.58，物理地址：广东省广州市', '2019-11-26 12:12:58', '2019-11-26 12:12:58');
INSERT INTO `log` VALUES ('483', '登录IP:124.202.217.146，物理地址：北京市', '2019-11-27 13:49:15', '2019-11-27 13:49:15');
INSERT INTO `log` VALUES ('484', '登录IP:125.122.189.217，物理地址：浙江省杭州市', '2019-11-27 14:34:32', '2019-11-27 14:34:32');
INSERT INTO `log` VALUES ('485', '登录IP:106.11.41.216，物理地址：北京市', '2019-11-28 14:28:40', '2019-11-28 14:28:40');
INSERT INTO `log` VALUES ('486', '登录IP:120.36.175.81，物理地址：福建省厦门市', '2019-11-29 13:09:07', '2019-11-29 13:09:07');
INSERT INTO `log` VALUES ('487', '登录IP:218.250.8.10，物理地址：香港特别行政区', '2019-11-29 14:05:35', '2019-11-29 14:05:35');
INSERT INTO `log` VALUES ('488', '登录IP:58.247.145.208，物理地址：上海市', '2019-12-12 17:18:41', '2019-12-12 17:18:41');
INSERT INTO `log` VALUES ('489', '登录IP:36.47.162.85，物理地址：陕西省西安市', '2019-12-13 11:37:03', '2019-12-13 11:37:03');
INSERT INTO `log` VALUES ('490', '登录IP:180.124.135.28，物理地址：江苏省徐州市', '2019-12-13 12:52:43', '2019-12-13 12:52:43');
INSERT INTO `log` VALUES ('491', '登录IP:117.139.252.147，物理地址：四川省成都市', '2019-12-13 16:47:54', '2019-12-13 16:47:54');
INSERT INTO `log` VALUES ('492', '登录IP:222.174.55.106，物理地址：山东省德州市', '2019-12-14 14:27:22', '2019-12-14 14:27:22');
INSERT INTO `log` VALUES ('493', '登录IP:113.57.152.160，物理地址：湖北省武汉市', '2019-12-14 16:21:52', '2019-12-14 16:21:52');
INSERT INTO `log` VALUES ('494', '登录IP:123.233.207.52，物理地址：山东省济南市', '2019-12-14 17:05:35', '2019-12-14 17:05:35');
INSERT INTO `log` VALUES ('495', '登录IP:171.115.10.38，物理地址：湖北省鄂州市', '2019-12-14 17:07:32', '2019-12-14 17:07:32');
INSERT INTO `log` VALUES ('496', '登录IP:150.109.76.80，物理地址：北京市', '2019-12-14 18:29:37', '2019-12-14 18:29:37');
INSERT INTO `log` VALUES ('497', '登录IP:171.116.145.181，物理地址：山西省太原市', '2019-12-17 02:41:11', '2019-12-17 02:41:11');
INSERT INTO `log` VALUES ('498', '登录IP:58.247.145.208，物理地址：上海市', '2019-12-17 13:27:30', '2019-12-17 13:27:30');
INSERT INTO `log` VALUES ('499', '登录IP:113.87.182.137，物理地址：广东省深圳市', '2019-12-17 21:40:28', '2019-12-17 21:40:28');
INSERT INTO `log` VALUES ('500', '登录IP:140.143.224.212，物理地址：江西省南昌市', '2019-12-17 22:34:44', '2019-12-17 22:34:44');
INSERT INTO `log` VALUES ('501', '登录IP:58.243.250.29，物理地址：安徽省合肥市', '2019-12-18 14:43:29', '2019-12-18 14:43:29');
INSERT INTO `log` VALUES ('502', '登录IP:218.240.148.82，物理地址：北京市', '2019-12-19 10:05:03', '2019-12-19 10:05:03');
INSERT INTO `log` VALUES ('503', '登录IP:116.247.99.130，物理地址：上海市', '2019-12-19 13:51:01', '2019-12-19 13:51:01');
INSERT INTO `log` VALUES ('504', '登录IP:183.16.237.67，物理地址：广东省深圳市', '2019-12-19 16:40:36', '2019-12-19 16:40:36');
INSERT INTO `log` VALUES ('505', '登录IP:112.23.115.147，物理地址：江苏省苏州市', '2019-12-20 04:09:55', '2019-12-20 04:09:55');
INSERT INTO `log` VALUES ('506', '登录IP:113.87.117.247，物理地址：广东省深圳市', '2019-12-20 11:10:09', '2019-12-20 11:10:09');
INSERT INTO `log` VALUES ('507', '登录IP:183.192.98.158，物理地址：上海市', '2019-12-21 18:40:09', '2019-12-21 18:40:09');
INSERT INTO `log` VALUES ('508', '登录IP:120.28.43.234，物理地址：', '2019-12-22 18:19:05', '2019-12-22 18:19:05');
INSERT INTO `log` VALUES ('509', '登录IP:223.112.27.34，物理地址：江苏省南京市', '2019-12-23 09:38:48', '2019-12-23 09:38:48');
INSERT INTO `log` VALUES ('510', '登录IP:218.14.89.5，物理地址：广东省惠州市', '2019-12-23 09:56:06', '2019-12-23 09:56:06');
INSERT INTO `log` VALUES ('511', '登录IP:223.104.3.62，物理地址：北京市', '2019-12-24 13:48:35', '2019-12-24 13:48:35');
INSERT INTO `log` VALUES ('512', '登录IP:119.90.20.98，物理地址：北京市', '2019-12-24 16:51:09', '2019-12-24 16:51:09');
INSERT INTO `log` VALUES ('513', '登录IP:220.160.15.103，物理地址：福建省福州市', '2019-12-24 18:09:34', '2019-12-24 18:09:34');
INSERT INTO `log` VALUES ('514', '登录IP:120.239.171.201，物理地址：广东省中山市', '2019-12-24 22:46:47', '2019-12-24 22:46:47');
INSERT INTO `log` VALUES ('515', '登录IP:112.22.247.54，物理地址：江苏省苏州市', '2019-12-24 23:35:28', '2019-12-24 23:35:28');
INSERT INTO `log` VALUES ('516', '登录IP:14.17.22.35，物理地址：广东省深圳市', '2019-12-25 10:49:41', '2019-12-25 10:49:41');
INSERT INTO `log` VALUES ('517', '登录IP:180.107.58.200，物理地址：江苏省苏州市', '2019-12-25 13:37:52', '2019-12-25 13:37:52');
INSERT INTO `log` VALUES ('518', '登录IP:182.108.39.128，物理地址：江西省南昌市', '2019-12-26 19:11:06', '2019-12-26 19:11:06');
INSERT INTO `log` VALUES ('519', '登录IP:113.45.120.20，物理地址：北京市', '2019-12-27 12:56:46', '2019-12-27 12:56:46');
INSERT INTO `log` VALUES ('520', '登录IP:58.247.145.208，物理地址：上海市', '2019-12-27 16:09:26', '2019-12-27 16:09:26');
INSERT INTO `log` VALUES ('521', '登录IP:119.123.79.50，物理地址：广东省深圳市', '2019-12-28 12:14:43', '2019-12-28 12:14:43');
INSERT INTO `log` VALUES ('522', '登录IP:182.32.182.42，物理地址：山东省德州市', '2019-12-29 20:46:33', '2019-12-29 20:46:33');
INSERT INTO `log` VALUES ('523', '登录IP:121.204.112.58，物理地址：福建省福州市', '2019-12-30 14:53:39', '2019-12-30 14:53:39');
INSERT INTO `log` VALUES ('524', '登录IP:222.172.175.39，物理地址：云南省昆明市', '2019-12-30 15:40:14', '2019-12-30 15:40:14');
INSERT INTO `log` VALUES ('526', '登录IP:171.217.6.117，物理地址：四川省成都市', '2019-12-31 19:42:25', '2019-12-31 19:42:25');
INSERT INTO `log` VALUES ('529', '登录IP:123.58.249.2，物理地址：河北省廊坊市', '2020-01-03 13:25:36', '2020-01-03 13:25:36');
INSERT INTO `log` VALUES ('531', '登录IP:112.65.29.38，物理地址：上海市', '2020-01-03 15:37:21', '2020-01-03 15:37:21');
INSERT INTO `log` VALUES ('534', '登录IP:27.17.104.9，物理地址：湖北省武汉市', '2020-01-04 11:28:13', '2020-01-04 11:28:13');
INSERT INTO `log` VALUES ('537', '登录IP:34.92.88.157，物理地址：', '2020-01-04 19:30:46', '2020-01-04 19:30:46');
INSERT INTO `log` VALUES ('538', '登录IP:183.14.132.40，物理地址：广东省深圳市', '2020-01-06 10:08:45', '2020-01-06 10:08:45');
INSERT INTO `log` VALUES ('540', '登录IP:220.199.108.183，物理地址：广东省湛江市', '2020-01-06 14:33:55', '2020-01-06 14:33:55');
INSERT INTO `log` VALUES ('542', '登录IP:111.198.238.149，物理地址：北京市', '2020-01-08 16:47:32', '2020-01-08 16:47:32');
INSERT INTO `log` VALUES ('547', '登录IP:112.65.29.38，物理地址：上海市', '2020-01-09 17:44:44', '2020-01-09 17:44:44');
INSERT INTO `log` VALUES ('574', '登录IP:58.240.228.66，物理地址：江苏省苏州市', '2020-01-10 16:38:16', '2020-01-10 16:38:16');
INSERT INTO `log` VALUES ('593', '登录IP:171.114.55.2，物理地址：湖北省宜昌市', '2020-01-11 00:09:44', '2020-01-11 00:09:44');
INSERT INTO `log` VALUES ('615', '登录IP:218.62.255.51，物理地址：云南省昆明市', '2020-01-13 10:00:15', '2020-01-13 10:00:15');
INSERT INTO `log` VALUES ('616', '登录IP:112.65.29.38，物理地址：上海市', '2020-01-15 14:23:14', '2020-01-15 14:23:14');
INSERT INTO `log` VALUES ('630', '登录IP:183.93.155.185，物理地址：湖北省襄阳市', '2020-01-17 17:21:23', '2020-01-17 17:21:23');
INSERT INTO `log` VALUES ('631', '登录IP:111.41.248.56，物理地址：黑龙江省佳木斯市', '2020-01-17 20:38:53', '2020-01-17 20:38:53');
INSERT INTO `log` VALUES ('632', '登录IP:111.41.248.56，物理地址：黑龙江省佳木斯市', '2020-01-17 21:08:48', '2020-01-17 21:08:48');
INSERT INTO `log` VALUES ('633', '登录IP:220.112.121.79，物理地址：上海市', '2020-01-17 23:20:02', '2020-01-17 23:20:02');
INSERT INTO `log` VALUES ('634', '登录IP:35.229.213.226，物理地址：', '2020-01-18 17:39:44', '2020-01-18 17:39:44');
INSERT INTO `log` VALUES ('635', '登录IP:220.112.121.79，物理地址：上海市', '2020-01-18 22:15:24', '2020-01-18 22:15:24');
INSERT INTO `log` VALUES ('636', '登录IP:123.116.148.75，物理地址：北京市', '2020-01-19 12:31:26', '2020-01-19 12:31:26');
INSERT INTO `log` VALUES ('637', '登录IP:112.65.29.38，物理地址：上海市', '2020-01-19 13:51:28', '2020-01-19 13:51:28');
INSERT INTO `log` VALUES ('638', '登录IP:220.249.89.226，物理地址：湖北省武汉市', '2020-01-19 13:57:00', '2020-01-19 13:57:00');
INSERT INTO `log` VALUES ('639', '登录IP:182.129.43.54，物理地址：四川省南充市', '2020-01-20 01:34:18', '2020-01-20 01:34:18');
INSERT INTO `log` VALUES ('640', '登录IP:183.250.89.190，物理地址：福建省厦门市', '2020-01-21 14:55:59', '2020-01-21 14:55:59');
INSERT INTO `log` VALUES ('641', '登录IP:117.136.100.121，物理地址：安徽省', '2020-01-21 15:10:18', '2020-01-21 15:10:18');
INSERT INTO `log` VALUES ('642', '登录IP:182.148.58.150，物理地址：四川省成都市', '2020-01-21 15:33:27', '2020-01-21 15:33:27');
INSERT INTO `log` VALUES ('643', '登录IP:123.139.89.78，物理地址：陕西省西安市', '2020-01-22 09:51:51', '2020-01-22 09:51:51');
INSERT INTO `log` VALUES ('644', '登录IP:220.112.121.79，物理地址：上海市', '2020-01-23 20:25:37', '2020-01-23 20:25:37');
INSERT INTO `log` VALUES ('645', '登录IP:220.112.121.79，物理地址：上海市', '2020-01-25 16:21:45', '2020-01-25 16:21:45');
INSERT INTO `log` VALUES ('646', '登录IP:117.43.12.151，物理地址：江西省九江市', '2020-01-26 23:07:01', '2020-01-26 23:07:01');
INSERT INTO `log` VALUES ('647', '登录IP:121.62.7.90，物理地址：湖北省十堰市', '2020-01-27 14:47:24', '2020-01-27 14:47:24');
INSERT INTO `log` VALUES ('648', '登录IP:117.155.251.124，物理地址：湖北省黄石市', '2020-01-29 15:58:05', '2020-01-29 15:58:05');
INSERT INTO `log` VALUES ('649', '登录IP:183.228.1.42，物理地址：重庆市', '2020-01-30 14:24:42', '2020-01-30 14:24:42');
INSERT INTO `log` VALUES ('650', '登录IP:117.157.38.73，物理地址：甘肃省白银市', '2020-01-30 19:44:00', '2020-01-30 19:44:00');
INSERT INTO `log` VALUES ('651', '登录IP:101.233.254.85，物理地址：广东省深圳市', '2020-02-01 18:24:28', '2020-02-01 18:24:28');
INSERT INTO `log` VALUES ('652', '登录IP:39.172.138.169，物理地址：浙江省丽水市', '2020-02-01 19:38:14', '2020-02-01 19:38:14');
INSERT INTO `log` VALUES ('653', '登录IP:27.38.241.240，物理地址：广东省深圳市', '2020-02-01 21:02:58', '2020-02-01 21:02:58');
INSERT INTO `log` VALUES ('654', '登录IP:115.174.204.206，物理地址：上海市', '2020-02-02 22:14:47', '2020-02-02 22:14:47');
INSERT INTO `log` VALUES ('655', '登录IP:128.199.198.83，物理地址：', '2020-02-03 18:39:30', '2020-02-03 18:39:30');
INSERT INTO `log` VALUES ('656', '登录IP:115.174.204.206，物理地址：上海市', '2020-02-04 10:36:04', '2020-02-04 10:36:04');
INSERT INTO `log` VALUES ('657', '登录IP:27.192.87.143，物理地址：山东省潍坊市', '2020-02-04 21:03:36', '2020-02-04 21:03:36');
INSERT INTO `log` VALUES ('658', '登录IP:115.174.204.206，物理地址：上海市', '2020-02-05 00:07:31', '2020-02-05 00:07:31');
INSERT INTO `log` VALUES ('659', '登录IP:183.3.234.62，物理地址：广东省广州市', '2020-02-06 12:53:14', '2020-02-06 12:53:14');
INSERT INTO `log` VALUES ('660', '登录IP:112.8.51.65，物理地址：山东省临沂市', '2020-02-07 23:27:03', '2020-02-07 23:27:03');
INSERT INTO `log` VALUES ('661', '登录IP:120.230.117.175，物理地址：广东省广州市', '2020-02-08 15:20:47', '2020-02-08 15:20:47');
INSERT INTO `log` VALUES ('662', '登录IP:218.26.248.132，物理地址：山西省太原市', '2020-02-08 17:33:47', '2020-02-08 17:33:47');
INSERT INTO `log` VALUES ('663', '登录IP:153.34.18.120，物理地址：江苏省苏州市', '2020-02-08 18:06:58', '2020-02-08 18:06:58');
INSERT INTO `log` VALUES ('664', '登录IP:223.74.69.137，物理地址：广东省广州市', '2020-02-09 19:34:44', '2020-02-09 19:34:44');
INSERT INTO `log` VALUES ('665', '登录IP:114.245.81.23，物理地址：北京市', '2020-02-09 20:09:36', '2020-02-09 20:09:36');
INSERT INTO `log` VALUES ('666', '登录IP:113.83.194.67，物理地址：广东省惠州市', '2020-02-11 10:54:56', '2020-02-11 10:54:56');
INSERT INTO `log` VALUES ('667', '登录IP:116.66.184.178，物理地址：', '2020-02-11 16:28:00', '2020-02-11 16:28:00');
INSERT INTO `log` VALUES ('668', '登录IP:220.112.121.125，物理地址：上海市', '2020-02-11 17:40:43', '2020-02-11 17:40:43');
INSERT INTO `log` VALUES ('669', '登录IP:220.112.121.125，物理地址：上海市', '2020-02-12 10:31:40', '2020-02-12 10:31:40');
INSERT INTO `log` VALUES ('670', '登录IP:113.97.35.62，物理地址：广东省深圳市', '2020-02-12 19:56:18', '2020-02-12 19:56:18');
INSERT INTO `log` VALUES ('671', '登录IP:172.96.246.55，物理地址：', '2020-02-13 09:53:11', '2020-02-13 09:53:11');
INSERT INTO `log` VALUES ('672', '登录IP:112.50.72.245，物理地址：福建省漳州市', '2020-02-13 12:40:28', '2020-02-13 12:40:28');
INSERT INTO `log` VALUES ('673', '登录IP:112.10.90.56，物理地址：浙江省杭州市', '2020-02-13 13:13:28', '2020-02-13 13:13:28');
INSERT INTO `log` VALUES ('674', '登录IP:220.112.121.125，物理地址：上海市', '2020-02-13 14:19:42', '2020-02-13 14:19:42');
INSERT INTO `log` VALUES ('675', '登录IP:124.126.129.209，物理地址：北京市', '2020-02-13 15:36:03', '2020-02-13 15:36:03');
INSERT INTO `log` VALUES ('676', '登录IP:163.125.117.162，物理地址：广东省深圳市', '2020-02-13 18:32:21', '2020-02-13 18:32:21');
INSERT INTO `log` VALUES ('677', '登录IP:183.156.102.4，物理地址：浙江省杭州市', '2020-02-14 17:18:28', '2020-02-14 17:18:28');
INSERT INTO `log` VALUES ('678', '登录IP:47.90.86.65，物理地址：', '2020-02-15 00:38:48', '2020-02-15 00:38:48');
INSERT INTO `log` VALUES ('679', '登录IP:125.80.231.58，物理地址：重庆市', '2020-02-15 09:42:28', '2020-02-15 09:42:28');
INSERT INTO `log` VALUES ('680', '登录IP:223.91.150.165，物理地址：河南省漯河市', '2020-02-16 14:03:57', '2020-02-16 14:03:57');
INSERT INTO `log` VALUES ('681', '登录IP:101.245.146.144，物理地址：上海市', '2020-02-17 11:48:08', '2020-02-17 11:48:08');
INSERT INTO `log` VALUES ('682', '登录IP:182.107.239.71，物理地址：江西省赣州市', '2020-02-17 13:26:01', '2020-02-17 13:26:01');
INSERT INTO `log` VALUES ('683', '登录IP:171.9.125.251，物理地址：河南省周口市', '2020-02-17 14:17:25', '2020-02-17 14:17:25');
INSERT INTO `log` VALUES ('684', '登录IP:171.9.125.251，物理地址：河南省周口市', '2020-02-17 16:38:02', '2020-02-17 16:38:02');
INSERT INTO `log` VALUES ('685', '登录IP:218.75.221.240，物理地址：湖南省株洲市', '2020-02-20 10:11:28', '2020-02-20 10:11:28');
INSERT INTO `log` VALUES ('686', '登录IP:183.21.242.207，物理地址：广东省韶关市', '2020-02-21 00:57:39', '2020-02-21 00:57:39');
INSERT INTO `log` VALUES ('687', '登录IP:222.247.98.34，物理地址：湖南省长沙市', '2020-02-21 07:32:08', '2020-02-21 07:32:08');
INSERT INTO `log` VALUES ('688', '登录IP:222.247.232.100，物理地址：湖南省长沙市', '2020-02-21 14:55:52', '2020-02-21 14:55:52');
INSERT INTO `log` VALUES ('689', '登录IP:211.161.247.17，物理地址：上海市', '2020-02-22 22:04:56', '2020-02-22 22:04:56');
INSERT INTO `log` VALUES ('690', '登录IP:113.118.44.15，物理地址：广东省深圳市', '2020-02-23 10:36:10', '2020-02-23 10:36:10');
INSERT INTO `log` VALUES ('691', '登录IP:113.118.44.15，物理地址：广东省深圳市', '2020-02-23 10:41:19', '2020-02-23 10:41:19');
INSERT INTO `log` VALUES ('692', '登录IP:116.27.45.212，物理地址：广东省茂名市', '2020-02-23 18:53:47', '2020-02-23 18:53:47');
INSERT INTO `log` VALUES ('693', '登录IP:114.84.220.116，物理地址：上海市', '2020-02-25 13:31:31', '2020-02-25 13:31:31');
INSERT INTO `log` VALUES ('694', '登录IP:150.107.0.7，物理地址：香港特别行政区', '2020-02-27 16:54:44', '2020-02-27 16:54:44');
INSERT INTO `log` VALUES ('695', '登录IP:183.15.177.238，物理地址：广东省深圳市', '2020-02-27 16:58:16', '2020-02-27 16:58:16');
INSERT INTO `log` VALUES ('696', '登录IP:121.35.180.193，物理地址：广东省深圳市', '2020-02-28 03:40:48', '2020-02-28 03:40:48');
INSERT INTO `log` VALUES ('697', '登录IP:58.247.145.48，物理地址：上海市', '2020-02-28 10:01:07', '2020-02-28 10:01:07');
INSERT INTO `log` VALUES ('698', '登录IP:114.230.45.237，物理地址：江苏省扬州市', '2020-02-28 17:19:00', '2020-02-28 17:19:00');
INSERT INTO `log` VALUES ('699', '登录IP:115.204.111.67，物理地址：浙江省杭州市', '2020-02-29 00:54:15', '2020-02-29 00:54:15');
INSERT INTO `log` VALUES ('700', '登录IP:58.221.96.42，物理地址：江苏省南通市', '2020-02-29 12:57:38', '2020-02-29 12:57:38');
INSERT INTO `log` VALUES ('701', '登录IP:223.74.168.88，物理地址：广东省东莞市', '2020-03-01 13:14:22', '2020-03-01 13:14:22');
INSERT INTO `log` VALUES ('702', '登录IP:223.77.178.226，物理地址：湖北省', '2020-03-01 17:05:48', '2020-03-01 17:05:48');
INSERT INTO `log` VALUES ('703', '登录IP:119.187.206.165，物理地址：山东省东营市', '2020-03-03 10:48:43', '2020-03-03 10:48:43');
INSERT INTO `log` VALUES ('704', '登录IP:171.42.18.142，物理地址：湖北省宜昌市', '2020-03-03 21:58:02', '2020-03-03 21:58:02');
INSERT INTO `log` VALUES ('705', '登录IP:120.204.97.224，物理地址：上海市', '2020-03-04 00:21:53', '2020-03-04 00:21:53');
INSERT INTO `log` VALUES ('706', '登录IP:117.136.52.14，物理地址：湖北省武汉市', '2020-03-04 15:27:41', '2020-03-04 15:27:41');
INSERT INTO `log` VALUES ('707', '登录IP:113.72.40.146，物理地址：广东省佛山市', '2020-03-04 16:13:50', '2020-03-04 16:13:50');
INSERT INTO `log` VALUES ('708', '登录IP:106.121.70.62，物理地址：北京市', '2020-03-05 10:40:31', '2020-03-05 10:40:31');
INSERT INTO `log` VALUES ('709', '登录IP:120.204.160.93，物理地址：上海市', '2020-03-05 20:54:20', '2020-03-05 20:54:20');
INSERT INTO `log` VALUES ('710', '登录IP:58.211.119.218，物理地址：江苏省苏州市', '2020-03-06 13:53:25', '2020-03-06 13:53:25');
INSERT INTO `log` VALUES ('711', '登录IP:222.210.45.164，物理地址：四川省成都市', '2020-03-06 22:42:39', '2020-03-06 22:42:39');
INSERT INTO `log` VALUES ('712', '登录IP:220.112.121.49，物理地址：上海市', '2020-03-07 10:52:03', '2020-03-07 10:52:03');
INSERT INTO `log` VALUES ('713', '登录IP:171.112.5.201，物理地址：湖北省孝感市', '2020-03-08 19:44:00', '2020-03-08 19:44:00');
INSERT INTO `log` VALUES ('714', '登录IP:113.68.153.231，物理地址：广东省广州市', '2020-03-10 00:47:58', '2020-03-10 00:47:58');
INSERT INTO `log` VALUES ('715', '登录IP:113.68.153.231，物理地址：广东省广州市', '2020-03-10 00:48:07', '2020-03-10 00:48:07');
INSERT INTO `log` VALUES ('716', '登录IP:223.91.83.74，物理地址：河南省南阳市', '2020-03-11 10:22:07', '2020-03-11 10:22:07');
INSERT INTO `log` VALUES ('717', '登录IP:58.247.145.48，物理地址：上海市', '2020-03-11 18:43:22', '2020-03-11 18:43:22');
INSERT INTO `log` VALUES ('718', '登录IP:1.119.186.234，物理地址：北京市', '2020-03-12 14:47:58', '2020-03-12 14:47:58');
INSERT INTO `log` VALUES ('719', '登录IP:39.88.44.228，物理地址：山东省青岛市', '2020-03-12 18:07:48', '2020-03-12 18:07:48');
INSERT INTO `log` VALUES ('720', '登录IP:27.211.233.25，物理地址：山东省济南市', '2020-03-12 18:22:11', '2020-03-12 18:22:11');
INSERT INTO `log` VALUES ('721', '登录IP:125.79.20.235，物理地址：福建省漳州市', '2020-03-12 22:37:34', '2020-03-12 22:37:34');
INSERT INTO `log` VALUES ('722', '登录IP:61.133.217.141，物理地址：宁夏回族自治区银川市', '2020-03-13 08:50:00', '2020-03-13 08:50:00');
INSERT INTO `log` VALUES ('723', '登录IP:111.202.145.34，物理地址：北京市', '2020-03-13 17:27:17', '2020-03-13 17:27:17');
INSERT INTO `log` VALUES ('724', '登录IP:223.96.53.70，物理地址：山东省菏泽市', '2020-03-14 11:23:54', '2020-03-14 11:23:54');
INSERT INTO `log` VALUES ('725', '登录IP:118.24.122.131，物理地址：北京市', '2020-03-14 19:58:50', '2020-03-14 19:58:50');
INSERT INTO `log` VALUES ('726', '登录IP:115.174.210.66，物理地址：上海市', '2020-03-15 22:58:52', '2020-03-15 22:58:52');
INSERT INTO `log` VALUES ('727', '登录IP:112.65.29.80，物理地址：上海市', '2020-03-16 14:20:13', '2020-03-16 14:20:13');
INSERT INTO `log` VALUES ('728', '登录IP:180.168.161.214，物理地址：上海市', '2020-03-16 17:14:04', '2020-03-16 17:14:04');
INSERT INTO `log` VALUES ('729', '登录IP:14.154.28.152，物理地址：广东省深圳市', '2020-03-18 18:54:03', '2020-03-18 18:54:03');
INSERT INTO `log` VALUES ('730', '登录IP:183.250.137.46，物理地址：福建省龙岩市', '2020-03-19 23:05:17', '2020-03-19 23:05:17');
INSERT INTO `log` VALUES ('731', '登录IP:103.216.43.37，物理地址：北京市', '2020-03-20 09:40:58', '2020-03-20 09:40:58');
INSERT INTO `log` VALUES ('732', '登录IP:218.79.204.147，物理地址：上海市', '2020-03-20 15:28:36', '2020-03-20 15:28:36');
INSERT INTO `log` VALUES ('733', '登录IP:175.188.159.119，物理地址：河南省郑州市', '2020-03-20 22:36:30', '2020-03-20 22:36:30');
INSERT INTO `log` VALUES ('734', '登录IP:123.149.75.78，物理地址：河南省郑州市', '2020-03-20 22:53:42', '2020-03-20 22:53:42');
INSERT INTO `log` VALUES ('735', '登录IP:116.247.129.157，物理地址：上海市', '2020-03-21 21:03:27', '2020-03-21 21:03:27');
INSERT INTO `log` VALUES ('736', '登录IP:223.150.139.155，物理地址：湖南省常德市', '2020-03-23 08:35:49', '2020-03-23 08:35:49');
INSERT INTO `log` VALUES ('737', '登录IP:218.109.199.55，物理地址：浙江省杭州市', '2020-03-23 09:51:05', '2020-03-23 09:51:05');
INSERT INTO `log` VALUES ('738', '登录IP:222.67.245.250，物理地址：上海市', '2020-03-23 13:14:14', '2020-03-23 13:14:14');
INSERT INTO `log` VALUES ('739', '登录IP:124.202.243.34，物理地址：北京市', '2020-03-23 17:29:25', '2020-03-23 17:29:25');
INSERT INTO `log` VALUES ('740', '登录IP:124.202.243.34，物理地址：北京市', '2020-03-23 17:29:25', '2020-03-23 17:29:25');
INSERT INTO `log` VALUES ('741', '登录IP:139.227.67.84，物理地址：上海市', '2020-03-24 19:27:09', '2020-03-24 19:27:09');
INSERT INTO `log` VALUES ('742', '登录IP:14.131.27.70，物理地址：北京市', '2020-03-24 20:52:37', '2020-03-24 20:52:37');
INSERT INTO `log` VALUES ('743', '登录IP:222.182.196.187，物理地址：重庆市', '2020-03-24 21:05:48', '2020-03-24 21:05:48');
INSERT INTO `log` VALUES ('744', '登录IP:115.213.193.11，物理地址：浙江省丽水市', '2020-03-25 09:32:23', '2020-03-25 09:32:23');
INSERT INTO `log` VALUES ('745', '登录IP:58.250.18.156，物理地址：广东省深圳市', '2020-03-26 13:48:23', '2020-03-26 13:48:23');
INSERT INTO `log` VALUES ('746', '登录IP:14.204.168.251，物理地址：云南省曲靖市', '2020-03-26 16:10:21', '2020-03-26 16:10:21');
INSERT INTO `log` VALUES ('747', '登录IP:113.247.75.91，物理地址：湖南省长沙市', '2020-03-27 00:49:16', '2020-03-27 00:49:16');
INSERT INTO `log` VALUES ('748', '登录IP:119.4.178.82，物理地址：四川省成都市', '2020-03-27 15:59:08', '2020-03-27 15:59:08');
INSERT INTO `log` VALUES ('749', '登录IP:115.183.185.156，物理地址：北京市', '2020-03-28 09:38:58', '2020-03-28 09:38:58');
INSERT INTO `log` VALUES ('750', '登录IP:101.45.200.150，物理地址：上海市', '2020-03-29 14:47:08', '2020-03-29 14:47:08');
INSERT INTO `log` VALUES ('751', '登录IP:223.91.27.82，物理地址：河南省周口市', '2020-03-30 20:43:51', '2020-03-30 20:43:51');
INSERT INTO `log` VALUES ('752', '登录IP:183.42.40.221，物理地址：广东省深圳市', '2020-03-31 20:39:49', '2020-03-31 20:39:49');
INSERT INTO `log` VALUES ('753', '登录IP:221.219.103.197，物理地址：北京市', '2020-04-03 09:04:49', '2020-04-03 09:04:49');
INSERT INTO `log` VALUES ('754', '登录IP:104.251.231.112，物理地址：', '2020-04-06 08:46:34', '2020-04-06 08:46:34');
INSERT INTO `log` VALUES ('755', '登录IP:120.232.182.141，物理地址：广东省深圳市', '2020-04-06 14:10:07', '2020-04-06 14:10:07');
INSERT INTO `log` VALUES ('756', '登录IP:115.174.220.197，物理地址：上海市', '2020-04-07 22:31:22', '2020-04-07 22:31:22');
INSERT INTO `log` VALUES ('757', '登录IP:101.86.245.208，物理地址：上海市', '2020-04-08 22:01:12', '2020-04-08 22:01:12');
INSERT INTO `log` VALUES ('758', '登录IP:116.22.202.204，物理地址：广东省广州市', '2020-04-08 23:35:41', '2020-04-08 23:35:41');
INSERT INTO `log` VALUES ('759', '登录IP:116.231.89.105，物理地址：上海市', '2020-04-14 14:29:22', '2020-04-14 14:29:22');
INSERT INTO `log` VALUES ('760', '登录IP:183.192.93.0，物理地址：上海市', '2020-04-16 23:57:41', '2020-04-16 23:57:41');
INSERT INTO `log` VALUES ('761', '登录IP:49.7.44.247，物理地址：广东省', '2020-04-17 10:07:25', '2020-04-17 10:07:25');
INSERT INTO `log` VALUES ('762', '登录IP:119.123.132.25，物理地址：广东省深圳市', '2020-04-18 17:24:35', '2020-04-18 17:24:35');
INSERT INTO `log` VALUES ('763', '登录IP:123.52.17.202，物理地址：河南省郑州市', '2020-04-20 12:51:29', '2020-04-20 12:51:29');
INSERT INTO `log` VALUES ('764', '登录IP:116.24.67.224，物理地址：广东省深圳市', '2020-04-21 11:57:32', '2020-04-21 11:57:32');
INSERT INTO `log` VALUES ('765', '登录IP:123.59.170.215，物理地址：北京市', '2020-04-21 14:16:00', '2020-04-21 14:16:00');
INSERT INTO `log` VALUES ('766', '登录IP:123.122.85.115，物理地址：北京市', '2020-04-21 15:29:16', '2020-04-21 15:29:16');
INSERT INTO `log` VALUES ('767', '登录IP:116.213.168.191，物理地址：北京市', '2020-04-21 17:15:50', '2020-04-21 17:15:50');
INSERT INTO `log` VALUES ('768', '登录IP:222.67.246.5，物理地址：上海市', '2020-04-22 13:57:54', '2020-04-22 13:57:54');
INSERT INTO `log` VALUES ('769', '登录IP:158.101.5.126，物理地址：', '2020-04-22 15:02:16', '2020-04-22 15:02:16');
INSERT INTO `log` VALUES ('770', '登录IP:1.197.85.125，物理地址：河南省周口市', '2020-04-25 00:33:16', '2020-04-25 00:33:16');
INSERT INTO `log` VALUES ('771', '登录IP:222.67.246.5，物理地址：上海市', '2020-04-25 09:26:49', '2020-04-25 09:26:49');
INSERT INTO `log` VALUES ('772', '登录IP:116.253.140.18，物理地址：广西壮族自治区柳州市', '2020-04-25 11:13:35', '2020-04-25 11:13:35');
INSERT INTO `log` VALUES ('773', '登录IP:27.38.232.113，物理地址：广东省深圳市', '2020-04-25 23:47:25', '2020-04-25 23:47:25');
INSERT INTO `log` VALUES ('774', '登录IP:58.250.18.156，物理地址：广东省深圳市', '2020-04-26 09:48:25', '2020-04-26 09:48:25');
INSERT INTO `log` VALUES ('775', '登录IP:183.14.28.152，物理地址：广东省深圳市', '2020-04-27 10:58:50', '2020-04-27 10:58:50');
INSERT INTO `log` VALUES ('776', '登录IP:171.83.89.131，物理地址：湖北省武汉市', '2020-04-28 15:21:24', '2020-04-28 15:21:24');
INSERT INTO `log` VALUES ('777', '登录IP:118.212.205.190，物理地址：江西省南昌市', '2020-05-02 22:52:53', '2020-05-02 22:52:53');
INSERT INTO `log` VALUES ('778', '登录IP:111.196.247.241，物理地址：北京市', '2020-05-03 11:55:12', '2020-05-03 11:55:12');
INSERT INTO `log` VALUES ('779', '登录IP:117.136.66.100，物理地址：江苏省南京市', '2020-05-03 18:36:28', '2020-05-03 18:36:28');
INSERT INTO `log` VALUES ('780', '登录IP:106.39.84.154，物理地址：北京市', '2020-05-03 21:44:29', '2020-05-03 21:44:29');
INSERT INTO `log` VALUES ('781', '登录IP:220.112.121.80，物理地址：上海市', '2020-05-04 23:23:18', '2020-05-04 23:23:18');
INSERT INTO `log` VALUES ('782', '登录IP:121.35.100.78，物理地址：广东省深圳市', '2020-05-06 09:45:19', '2020-05-06 09:45:19');
INSERT INTO `log` VALUES ('783', '登录IP:220.174.250.150，物理地址：海南省海口市', '2020-05-06 16:19:23', '2020-05-06 16:19:23');
INSERT INTO `log` VALUES ('784', '登录IP:220.249.89.226，物理地址：湖北省武汉市', '2020-05-07 11:06:35', '2020-05-07 11:06:35');
INSERT INTO `log` VALUES ('785', '登录IP:116.253.133.222，物理地址：广西壮族自治区柳州市', '2020-05-09 15:54:45', '2020-05-09 15:54:45');
INSERT INTO `log` VALUES ('786', '登录IP:220.112.121.80，物理地址：上海市', '2020-05-10 10:37:38', '2020-05-10 10:37:38');
INSERT INTO `log` VALUES ('787', '登录IP:211.97.31.6，物理地址：广东省广州市', '2020-05-10 14:39:00', '2020-05-10 14:39:00');
INSERT INTO `log` VALUES ('788', '登录IP:220.112.121.80，物理地址：上海市', '2020-05-10 21:57:53', '2020-05-10 21:57:53');
INSERT INTO `log` VALUES ('789', '登录IP:183.48.22.163，物理地址：广东省广州市', '2020-05-10 22:38:46', '2020-05-10 22:38:46');
INSERT INTO `log` VALUES ('790', '登录IP:123.117.160.231，物理地址：北京市', '2020-05-11 11:32:12', '2020-05-11 11:32:12');
INSERT INTO `log` VALUES ('791', '登录IP:111.17.42.147，物理地址：山东省泰安市', '2020-05-12 00:02:16', '2020-05-12 00:02:16');
INSERT INTO `log` VALUES ('792', '登录IP:27.189.203.106，物理地址：河北省廊坊市', '2020-05-12 09:38:18', '2020-05-12 09:38:18');
INSERT INTO `log` VALUES ('793', '登录IP:219.132.152.252，物理地址：广东省梅州市', '2020-05-14 08:28:14', '2020-05-14 08:28:14');
INSERT INTO `log` VALUES ('794', '登录IP:61.141.64.19，物理地址：广东省深圳市', '2020-05-14 14:55:11', '2020-05-14 14:55:11');
INSERT INTO `log` VALUES ('795', '登录IP:112.23.154.153，物理地址：江苏省南通市', '2020-05-14 18:21:27', '2020-05-14 18:21:27');
INSERT INTO `log` VALUES ('796', '登录IP:47.75.117.180，物理地址：', '2020-05-14 19:39:48', '2020-05-14 19:39:48');
INSERT INTO `log` VALUES ('797', '登录IP:116.231.88.143，物理地址：上海市', '2020-05-15 11:28:19', '2020-05-15 11:28:19');
INSERT INTO `log` VALUES ('798', '登录IP:123.139.112.2，物理地址：陕西省西安市', '2020-05-15 20:58:29', '2020-05-15 20:58:29');
INSERT INTO `log` VALUES ('799', '登录IP:116.21.133.107，物理地址：广东省广州市', '2020-05-15 21:41:19', '2020-05-15 21:41:19');
INSERT INTO `log` VALUES ('800', '登录IP:193.38.139.75，物理地址：', '2020-05-16 16:47:21', '2020-05-16 16:47:21');
INSERT INTO `log` VALUES ('801', '登录IP:220.112.121.80，物理地址：上海市', '2020-05-17 11:26:31', '2020-05-17 11:26:31');
INSERT INTO `log` VALUES ('802', '登录IP:183.229.129.168，物理地址：重庆市', '2020-05-17 13:53:27', '2020-05-17 13:53:27');
INSERT INTO `log` VALUES ('803', '登录IP:180.164.178.88，物理地址：上海市', '2020-05-19 14:27:12', '2020-05-19 14:27:12');
INSERT INTO `log` VALUES ('804', '登录IP:180.164.178.88，物理地址：上海市', '2020-05-19 15:26:29', '2020-05-19 15:26:29');
INSERT INTO `log` VALUES ('805', '登录IP:115.194.106.135，物理地址：浙江省杭州市', '2020-05-20 13:14:23', '2020-05-20 13:14:23');
INSERT INTO `log` VALUES ('806', '登录IP:115.194.106.135，物理地址：浙江省杭州市', '2020-05-20 13:20:46', '2020-05-20 13:20:46');
INSERT INTO `log` VALUES ('807', '登录IP:114.240.55.235，物理地址：北京市', '2020-05-20 14:55:39', '2020-05-20 14:55:39');
INSERT INTO `log` VALUES ('808', '登录IP:112.10.55.90，物理地址：浙江省杭州市', '2020-05-20 23:10:57', '2020-05-20 23:10:57');
INSERT INTO `log` VALUES ('809', '登录IP:124.127.178.186，物理地址：北京市', '2020-05-21 13:56:59', '2020-05-21 13:56:59');
INSERT INTO `log` VALUES ('810', '登录IP:115.195.66.155，物理地址：浙江省杭州市', '2020-05-21 16:44:14', '2020-05-21 16:44:14');
INSERT INTO `log` VALUES ('811', '登录IP:123.235.217.155，物理地址：山东省青岛市', '2020-05-21 17:43:44', '2020-05-21 17:43:44');
INSERT INTO `log` VALUES ('812', '登录IP:113.88.15.14，物理地址：广东省深圳市', '2020-05-25 13:59:09', '2020-05-25 13:59:09');
INSERT INTO `log` VALUES ('813', '登录IP:222.67.243.102，物理地址：上海市', '2020-05-25 14:28:00', '2020-05-25 14:28:00');
INSERT INTO `log` VALUES ('814', '登录IP:113.45.53.227，物理地址：北京市', '2020-05-25 21:04:49', '2020-05-25 21:04:49');
INSERT INTO `log` VALUES ('815', '登录IP:59.173.131.240，物理地址：湖北省武汉市', '2020-05-26 09:30:00', '2020-05-26 09:30:00');
INSERT INTO `log` VALUES ('816', '登录IP:180.168.161.214，物理地址：上海市', '2020-05-26 15:28:32', '2020-05-26 15:28:32');
INSERT INTO `log` VALUES ('817', '登录IP:120.239.196.86，物理地址：广东省珠海市', '2020-05-26 23:51:02', '2020-05-26 23:51:02');
INSERT INTO `log` VALUES ('818', '登录IP:220.178.25.22，物理地址：安徽省合肥市', '2020-05-27 10:30:15', '2020-05-27 10:30:15');
INSERT INTO `log` VALUES ('819', '登录IP:117.139.247.210，物理地址：四川省成都市', '2020-05-27 11:35:42', '2020-05-27 11:35:42');
INSERT INTO `log` VALUES ('820', '登录IP:119.98.111.111，物理地址：湖北省武汉市', '2020-05-27 12:51:40', '2020-05-27 12:51:40');
INSERT INTO `log` VALUES ('821', '登录IP:218.30.113.45，物理地址：北京市', '2020-05-27 17:31:13', '2020-05-27 17:31:13');
INSERT INTO `log` VALUES ('822', '登录IP:218.79.40.215，物理地址：上海市', '2020-05-28 18:18:29', '2020-05-28 18:18:29');
INSERT INTO `log` VALUES ('823', '登录IP:103.219.185.66，物理地址：北京市', '2020-05-28 21:37:18', '2020-05-28 21:37:18');
INSERT INTO `log` VALUES ('824', '登录IP:140.207.23.127，物理地址：上海市', '2020-05-29 10:18:17', '2020-05-29 10:18:17');
INSERT INTO `log` VALUES ('825', '登录IP:113.247.136.218，物理地址：湖南省长沙市', '2020-05-29 10:56:26', '2020-05-29 10:56:26');
INSERT INTO `log` VALUES ('826', '登录IP:114.87.128.36，物理地址：上海市', '2020-05-29 17:20:30', '2020-05-29 17:20:30');
INSERT INTO `log` VALUES ('827', '登录IP:203.100.83.15，物理地址：北京市', '2020-05-29 17:59:57', '2020-05-29 17:59:57');
INSERT INTO `log` VALUES ('828', '登录IP:183.197.159.6，物理地址：河北省廊坊市', '2020-05-30 15:32:18', '2020-05-30 15:32:18');
INSERT INTO `log` VALUES ('829', '登录IP:117.136.39.99，物理地址：广东省深圳市', '2020-05-30 16:43:22', '2020-05-30 16:43:22');
INSERT INTO `log` VALUES ('830', '登录IP:47.57.68.67，物理地址：', '2020-06-01 11:46:52', '2020-06-01 11:46:52');
INSERT INTO `log` VALUES ('831', '登录IP:183.54.238.215，物理地址：广东省广州市', '2020-06-01 18:31:58', '2020-06-01 18:31:58');
INSERT INTO `log` VALUES ('832', '登录IP:27.102.102.177，物理地址：', '2020-06-01 20:01:52', '2020-06-01 20:01:52');
INSERT INTO `log` VALUES ('833', '登录IP:123.58.106.11，物理地址：北京市', '2020-06-03 09:11:12', '2020-06-03 09:11:12');
INSERT INTO `log` VALUES ('834', '登录IP:183.60.191.113，物理地址：广东省广州市', '2020-06-03 11:05:02', '2020-06-03 11:05:02');
INSERT INTO `log` VALUES ('835', '登录IP:47.244.17.236，物理地址：', '2020-06-04 18:02:06', '2020-06-04 18:02:06');
INSERT INTO `log` VALUES ('836', '登录IP:223.104.175.118，物理地址：辽宁省沈阳市', '2020-06-04 20:21:54', '2020-06-04 20:21:54');
INSERT INTO `log` VALUES ('837', '登录IP:49.145.104.166，物理地址：', '2020-06-04 21:15:47', '2020-06-04 21:15:47');
INSERT INTO `log` VALUES ('838', '登录IP:47.240.63.135，物理地址：', '2020-06-05 09:43:08', '2020-06-05 09:43:08');
INSERT INTO `log` VALUES ('839', '登录IP:171.83.91.52，物理地址：湖北省武汉市', '2020-06-05 22:12:20', '2020-06-05 22:12:20');
INSERT INTO `log` VALUES ('840', '登录IP:120.244.212.99，物理地址：北京市', '2020-06-05 23:02:32', '2020-06-05 23:02:32');
INSERT INTO `log` VALUES ('841', '登录IP:183.238.182.84，物理地址：广东省深圳市', '2020-06-08 15:29:52', '2020-06-08 15:29:52');
INSERT INTO `log` VALUES ('842', '登录IP:218.19.154.150，物理地址：广东省广州市', '2020-06-08 21:02:09', '2020-06-08 21:02:09');
INSERT INTO `log` VALUES ('843', '登录IP:180.137.104.50，物理地址：广西壮族自治区北海市', '2020-06-09 09:27:09', '2020-06-09 09:27:09');
INSERT INTO `log` VALUES ('844', '登录IP:112.44.82.163，物理地址：四川省南充市', '2020-06-09 11:46:02', '2020-06-09 11:46:02');
INSERT INTO `log` VALUES ('845', '登录IP:42.120.75.87，物理地址：浙江省杭州市', '2020-06-10 17:39:15', '2020-06-10 17:39:15');
INSERT INTO `log` VALUES ('846', '登录IP:222.67.246.5，物理地址：上海市', '2020-06-11 15:54:06', '2020-06-11 15:54:06');
INSERT INTO `log` VALUES ('847', '登录IP:113.68.110.65，物理地址：广东省广州市', '2020-06-11 17:06:28', '2020-06-11 17:06:28');
INSERT INTO `log` VALUES ('848', '登录IP:101.244.22.100，物理地址：上海市', '2020-06-11 22:07:49', '2020-06-11 22:07:49');
INSERT INTO `log` VALUES ('849', '登录IP:175.168.73.15，物理地址：辽宁省沈阳市', '2020-06-12 15:14:00', '2020-06-12 15:14:00');
INSERT INTO `log` VALUES ('850', '登录IP:113.65.15.94，物理地址：广东省广州市', '2020-06-12 18:36:25', '2020-06-12 18:36:25');
INSERT INTO `log` VALUES ('851', '登录IP:119.131.169.229，物理地址：广东省广州市', '2020-06-13 17:17:45', '2020-06-13 17:17:45');
INSERT INTO `log` VALUES ('852', '登录IP:222.67.246.5，物理地址：上海市', '2020-06-17 12:49:08', '2020-06-17 12:49:08');
INSERT INTO `log` VALUES ('853', '登录IP:223.100.160.107，物理地址：辽宁省大连市', '2020-06-18 09:17:37', '2020-06-18 09:17:37');
INSERT INTO `log` VALUES ('854', '登录IP:221.2.140.247，物理地址：山东省威海市', '2020-06-18 15:17:30', '2020-06-18 15:17:30');
INSERT INTO `log` VALUES ('855', '登录IP:47.97.155.106，物理地址：浙江省', '2020-06-18 15:38:20', '2020-06-18 15:38:20');
INSERT INTO `log` VALUES ('856', '登录IP:36.35.33.54，物理地址：安徽省芜湖市', '2020-06-18 17:49:49', '2020-06-18 17:49:49');
INSERT INTO `log` VALUES ('857', '登录IP:220.172.42.167，物理地址：贵州省贵阳市', '2020-06-18 17:58:24', '2020-06-18 17:58:24');
INSERT INTO `log` VALUES ('858', '登录IP:123.12.190.118，物理地址：河南省周口市', '2020-06-18 21:03:03', '2020-06-18 21:03:03');
INSERT INTO `log` VALUES ('859', '登录IP:58.40.17.84，物理地址：上海市', '2020-06-19 08:38:40', '2020-06-19 08:38:40');
INSERT INTO `log` VALUES ('860', '登录IP:221.235.79.131，物理地址：湖北省武汉市', '2020-06-19 10:33:06', '2020-06-19 10:33:06');
INSERT INTO `log` VALUES ('861', '登录IP:124.64.17.143，物理地址：北京市', '2020-06-19 12:36:26', '2020-06-19 12:36:26');
INSERT INTO `log` VALUES ('862', '登录IP:219.152.17.139，物理地址：重庆市', '2020-06-19 15:53:19', '2020-06-19 15:53:19');
INSERT INTO `log` VALUES ('863', '登录IP:114.141.190.122，物理地址：上海市', '2020-06-19 18:47:57', '2020-06-19 18:47:57');
INSERT INTO `log` VALUES ('864', '登录IP:58.40.86.166，物理地址：上海市', '2020-06-20 23:06:18', '2020-06-20 23:06:18');
INSERT INTO `log` VALUES ('865', '登录IP:119.250.162.16，物理地址：河北省廊坊市', '2020-06-21 14:00:43', '2020-06-21 14:00:43');
INSERT INTO `log` VALUES ('866', '登录IP:120.231.11.231，物理地址：广东省湛江市', '2020-06-21 15:00:13', '2020-06-21 15:00:13');
INSERT INTO `log` VALUES ('867', '登录IP:116.231.89.99，物理地址：上海市', '2020-06-23 10:06:01', '2020-06-23 10:06:01');
INSERT INTO `log` VALUES ('868', '登录IP:113.91.211.96，物理地址：广东省深圳市', '2020-06-23 23:17:15', '2020-06-23 23:17:15');
INSERT INTO `log` VALUES ('869', '登录IP:58.250.250.254，物理地址：广东省深圳市', '2020-06-24 11:19:54', '2020-06-24 11:19:54');
INSERT INTO `log` VALUES ('870', '登录IP:49.69.118.37，物理地址：江苏省盐城市', '2020-06-28 00:09:35', '2020-06-28 00:09:35');
INSERT INTO `log` VALUES ('871', '登录IP:218.79.92.175，物理地址：上海市', '2020-06-28 09:52:50', '2020-06-28 09:52:50');
INSERT INTO `log` VALUES ('872', '登录IP:140.207.113.90，物理地址：上海市', '2020-06-28 10:36:45', '2020-06-28 10:36:45');
INSERT INTO `log` VALUES ('873', '登录IP:221.217.103.223，物理地址：北京市', '2020-06-28 15:02:57', '2020-06-28 15:02:57');
INSERT INTO `log` VALUES ('874', '登录IP:36.27.85.140，物理地址：浙江省杭州市', '2020-06-29 17:47:13', '2020-06-29 17:47:13');
INSERT INTO `log` VALUES ('875', '登录IP:60.207.218.214，物理地址：北京市', '2020-06-30 13:11:54', '2020-06-30 13:11:54');
INSERT INTO `log` VALUES ('876', '登录IP:58.17.200.197，物理地址：重庆市', '2020-07-02 11:00:09', '2020-07-02 11:00:09');
INSERT INTO `log` VALUES ('877', '登录IP:112.64.7.57，物理地址：上海市', '2020-07-03 14:12:59', '2020-07-03 14:12:59');
INSERT INTO `log` VALUES ('878', '登录IP:116.66.184.178，物理地址：', '2020-07-03 16:00:19', '2020-07-03 16:00:19');
INSERT INTO `log` VALUES ('879', '登录IP:110.90.229.15，物理地址：福建省', '2020-07-04 10:20:27', '2020-07-04 10:20:27');
INSERT INTO `log` VALUES ('880', '登录IP:111.32.76.144，物理地址：天津市', '2020-07-05 01:45:29', '2020-07-05 01:45:29');
INSERT INTO `log` VALUES ('881', '登录IP:123.118.17.210，物理地址：北京市', '2020-07-12 20:47:04', '2020-07-12 20:47:04');
INSERT INTO `log` VALUES ('882', '登录IP:120.36.254.41，物理地址：福建省厦门市', '2020-07-13 23:02:54', '2020-07-13 23:02:54');
INSERT INTO `log` VALUES ('883', '登录IP:116.231.90.90，物理地址：上海市', '2020-07-14 14:29:48', '2020-07-14 14:29:48');
INSERT INTO `log` VALUES ('884', '登录IP:120.244.154.80，物理地址：北京市', '2020-07-15 01:31:43', '2020-07-15 01:31:43');
INSERT INTO `log` VALUES ('885', '登录IP:61.240.17.139，物理地址：天津市', '2020-07-16 10:17:04', '2020-07-16 10:17:04');
INSERT INTO `log` VALUES ('886', '登录IP:218.189.125.130，物理地址：香港特别行政区', '2020-07-16 17:01:48', '2020-07-16 17:01:48');
INSERT INTO `log` VALUES ('887', '登录IP:112.11.193.104，物理地址：浙江省湖州市', '2020-07-16 20:45:03', '2020-07-16 20:45:03');
INSERT INTO `log` VALUES ('888', '登录IP:180.138.19.181，物理地址：广西壮族自治区柳州市', '2020-07-16 22:17:00', '2020-07-16 22:17:00');
INSERT INTO `log` VALUES ('889', '登录IP:36.35.33.57，物理地址：安徽省芜湖市', '2020-07-17 15:15:13', '2020-07-17 15:15:13');
INSERT INTO `log` VALUES ('890', '登录IP:116.231.91.186，物理地址：上海市', '2020-07-18 12:09:35', '2020-07-18 12:09:35');
INSERT INTO `log` VALUES ('891', '登录IP:116.231.90.90，物理地址：上海市', '2020-07-18 13:08:56', '2020-07-18 13:08:56');
INSERT INTO `log` VALUES ('892', '登录IP:116.231.91.186，物理地址：上海市', '2020-07-18 17:06:27', '2020-07-18 17:06:27');
INSERT INTO `log` VALUES ('893', '登录IP:117.30.54.54，物理地址：福建省厦门市', '2020-07-20 10:14:58', '2020-07-20 10:14:58');
INSERT INTO `log` VALUES ('894', '登录IP:116.231.90.232，物理地址：上海市', '2020-07-22 13:26:30', '2020-07-22 13:26:30');
INSERT INTO `log` VALUES ('895', '登录IP:219.147.12.134，物理地址：山东省青岛市', '2020-07-22 15:29:13', '2020-07-22 15:29:13');
INSERT INTO `log` VALUES ('896', '登录IP:118.113.162.219，物理地址：四川省成都市', '2020-07-23 15:47:53', '2020-07-23 15:47:53');
INSERT INTO `log` VALUES ('897', '登录IP:113.15.103.239，物理地址：广西壮族自治区柳州市', '2020-07-23 20:32:32', '2020-07-23 20:32:32');
INSERT INTO `log` VALUES ('898', '登录IP:61.144.88.242，物理地址：广东省广州市', '2020-07-23 20:57:49', '2020-07-23 20:57:49');
INSERT INTO `log` VALUES ('899', '登录IP:218.81.20.233，物理地址：上海市', '2020-07-24 17:28:32', '2020-07-24 17:28:32');
INSERT INTO `log` VALUES ('900', '登录IP:218.18.137.26，物理地址：广东省深圳市', '2020-07-25 15:51:21', '2020-07-25 15:51:21');
INSERT INTO `log` VALUES ('901', '登录IP:220.114.194.170，物理地址：河南省郑州市', '2020-07-26 00:23:38', '2020-07-26 00:23:38');
INSERT INTO `log` VALUES ('902', '登录IP:183.17.231.109，物理地址：广东省深圳市', '2020-07-28 17:39:09', '2020-07-28 17:39:09');
INSERT INTO `log` VALUES ('903', '登录IP:116.231.90.232，物理地址：上海市', '2020-07-29 18:11:16', '2020-07-29 18:11:16');

-- ----------------------------
-- Table structure for `people_feature_relation`
-- ----------------------------
DROP TABLE IF EXISTS `people_feature_relation`;
CREATE TABLE `people_feature_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `assis_people_id` int(11) DEFAULT NULL,
  `feature_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of people_feature_relation
-- ----------------------------

-- ----------------------------
-- Table structure for `picture`
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pic_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of picture
-- ----------------------------
INSERT INTO `picture` VALUES ('1', '//static.cnodejs.org/Ft685Ah4vM0Z3QLB_Kht2YnTDNp9', '0', 'Microtask,Macrotask', '2019-03-20 10:06:55', '2019-03-20 10:06:55');
INSERT INTO `picture` VALUES ('2', 'http://dockone.io/uploads/article/20150913/e31fd491a376d3398fd4ca2dfcc98a9c.png', '1', '', '2019-05-15 16:42:35', '2019-05-15 16:42:35');
INSERT INTO `picture` VALUES ('3', '', '0', '', '2019-05-19 23:17:32', '2019-05-19 23:17:32');
INSERT INTO `picture` VALUES ('4', '', '0', '', '2019-05-19 23:18:35', '2019-05-19 23:18:35');
INSERT INTO `picture` VALUES ('5', '', '0', '', '2019-09-30 14:38:08', '2019-09-30 14:38:08');
INSERT INTO `picture` VALUES ('6', '', '0', '', '2019-10-24 13:39:29', '2019-10-24 13:39:29');
INSERT INTO `picture` VALUES ('7', '', '0', '', '2019-10-24 13:40:07', '2019-10-24 13:40:07');
INSERT INTO `picture` VALUES ('8', '', '0', '', '2019-10-24 13:40:09', '2019-10-24 13:40:09');
INSERT INTO `picture` VALUES ('9', '', '0', ',,', '2019-10-24 13:40:48', '2019-10-24 13:40:48');
INSERT INTO `picture` VALUES ('10', '', '0', ',', '2019-10-24 13:43:25', '2019-10-24 13:43:25');
INSERT INTO `picture` VALUES ('11', '', '0', '', '2019-11-13 18:07:05', '2019-11-13 18:07:05');
INSERT INTO `picture` VALUES ('12', '', '0', '', '2019-12-14 17:06:59', '2019-12-14 17:06:59');
INSERT INTO `picture` VALUES ('13', 'http://5b0988e595225.cdn.sohucs.com/images/20190807/a1061be84397443ea273736378690cdd.png', '1', '持续集成（CI）,持续交付和持续部署（CD）,CI/CD的优势', '2020-03-25 16:33:12', '2020-03-25 16:33:12');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groups` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限列表',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '说明',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='可以给一个角色很多权限，也可以通过很多角色组合来拥有很多权限';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'AdminController:UserList,AdminController:UserListRoute', '管理员', '2018-04-21 14:00:18', '2018-04-21 14:00:23');
INSERT INTO `role` VALUES ('2', 'AdminController:UserListRoute', '普通管理员', '2018-04-21 14:00:15', '2018-04-21 14:00:21');
INSERT INTO `role` VALUES ('3', 'AdminController:POST', '添加用户', '2018-04-20 13:29:49', '2018-04-20 13:29:52');
INSERT INTO `role` VALUES ('4', 'AdminController:PUT', '编辑用户', '2018-06-11 13:05:02', '2018-06-11 13:05:05');
INSERT INTO `role` VALUES ('5', 'AdminController:DeleteUser', '删除用户', '2018-06-11 13:07:02', '2018-06-11 13:07:07');
INSERT INTO `role` VALUES ('6', 'AdminController:UserList', '用户列表', '2018-06-11 13:09:09', '2018-06-11 13:09:12');
INSERT INTO `role` VALUES ('7', 'AdminController:ArticleEdit', '编辑文章', '2019-02-15 13:37:51', '2019-02-15 13:37:55');
INSERT INTO `role` VALUES ('8', 'AdminController:ArticleDelete', '删除文章', '2019-02-16 14:21:04', '2019-02-16 14:21:07');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mobile` varchar(255) NOT NULL DEFAULT '',
  `user_name` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `gender` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `addr` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '1',
  `description` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mobile_uniq` (`mobile`) USING BTREE,
  UNIQUE KEY `idx_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '13477889900', '犬夜叉33', '960232f4a37f948b480a3f8a5512c6f8', '1', '13477889900@139.com', '日暮神社', '0', '半妖', '2018-03-17 20:46:31', '2020-04-21 13:38:10');
INSERT INTO `user` VALUES ('2', '18701897513', '戈薇', 'abc72b24857be42850f67d3160f8710e', '1', '18701897513@139.com', '日暮神社', '1', '博主我感觉你好牛批', '2018-03-17 20:49:44', '2019-10-21 17:11:58');
INSERT INTO `user` VALUES ('5', '18701893513', '桔梗', 'abc72b24857be42850f67d3160f8710e', '0', '18611118146@139.com', '看见的任何司空见惯和', '0', '奈落都害怕的女人', '2017-07-27 03:25:01', '2019-08-16 09:41:42');
INSERT INTO `user` VALUES ('8', '10701897527', '弥勒', '8fa2952fff72d92c98f9f43e46dfc6bd', '0', 'huo@gmail.com', '吉林大街好地方', '0', '而喝了酒而温柔你感觉', '2017-07-27 09:00:43', '2018-03-19 11:10:50');
INSERT INTO `user` VALUES ('9', '10706597527', '七宝1', '8fa2952fff72d92c98f9f43e46dfc6bd', '0', '438473@qq.com', '发顺丰', '0', '收到了架构过人家饿啊人工', '2017-07-29 10:38:06', '2019-09-02 15:03:46');
INSERT INTO `user` VALUES ('13', '18701497527', '杀生丸', '8fa2952fff72d92c98f9f43e46dfc6bd', '1', 'hp@sina.com', '送就送山东黄金人数', '1', '视频国际投行饿哦日后我如何进入', '2018-02-05 04:20:37', '2018-12-02 20:38:37');
INSERT INTO `user` VALUES ('14', '12345678909', '珊瑚', '5335412ee0f17806e1017e607149336a', '0', 'ligh@163.com', '很快就都大佛开盘后具体要', '1', '我感觉哦过仁和堂撒今天', '2018-02-05 08:07:37', '2018-04-06 17:03:04');
INSERT INTO `user` VALUES ('21', '18721897527', '奈落', '8fa2952fff72d92c98f9f43e46dfc6bd', '1', '18611118146@139.com', '送就送山东黄金人数几乎是丢改好', '1', '就fdfda', '2018-02-11 07:53:18', '2018-10-24 11:43:07');
INSERT INTO `user` VALUES ('22', '18766464985', '云母', '442ba06a1ac9ad299865c11234b9c492', '0', 'ligh@163.com', '送就送山东黄金人数几乎是丢改好看机会', '1', '', '2018-02-11 15:58:10', '2019-02-24 21:01:36');
INSERT INTO `user` VALUES ('23', '12335678909', '邪见', '5335412ee0f17806e1017e607149336a', '1', '13344442929@163.com', '看见的任何', '0', '', '2018-02-11 16:05:53', '2019-02-24 21:01:51');
INSERT INTO `user` VALUES ('25', '18111897528', '铃', '033554527363fed57bacfcab7c77c5fb', '0', 'lig@163.com', 'dfpkgipniu', '0', '当人看了韩国人都', '2018-02-28 10:34:39', '2019-02-24 21:02:23');
INSERT INTO `user` VALUES ('26', '18765464985', '神乐', '442ba06a1ac9ad299865c11234b9c492', '0', '13344442929@163.com', '很快就都大佛开盘后具体要', '0', '客人很多事让她二炮还叫人', '2018-02-28 10:34:58', '2019-02-24 21:02:58');
INSERT INTO `user` VALUES ('27', '18701817525', '神无', '67c70763ce38919105acc783fa5e834d', '0', '18765464985', '了PDF你好逗', '1', '哦【但是若干年后天赋', '2018-02-28 10:35:20', '2019-02-24 21:03:14');
INSERT INTO `user` VALUES ('28', '15800699208', '梦幻之白夜', 'dfda39bb37573e74338338642162d85b', '0', '8974@qq.com', '工时费', '0', '好回家哦个积极破解', '2018-04-05 23:19:33', '2019-02-24 21:03:53');
INSERT INTO `user` VALUES ('29', '11111111111', 'admin111', 'd384ece233ea14a88e887d2e0b363753', '0', '111111111', '1111111111111', '0', '11111111111111', '2019-07-25 12:58:58', '2019-07-25 12:58:58');
INSERT INTO `user` VALUES ('31', '1231312313', '1111', '14a5f308f01e71018e9531b2f43dbeb8', '0', '123123@qq.com', '啊手动阀', '0', '阿迪斯', '2019-09-15 12:41:15', '2019-09-15 12:41:15');
INSERT INTO `user` VALUES ('32', '13927459802', 'admin', '0838bbf98cc735eda3cab04d098387be', '1', '330490409@qq.com', '', '0', '', '2020-01-27 14:48:44', '2020-01-27 14:48:44');
