/*
Navicat MySQL Data Transfer

Source Server         : alimysql
Source Server Version : 50723
Source Host           : 112.74.171.94:3306
Source Database       : issue

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2018-12-26 11:16:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', 'Go语言优势', '<p>一、\n                  部署简单。Go 编译生成的是一个静态可执行文件，除了 glibc 外没有其他外部依赖。这让部署变得异常方便：目标机器上只需要一个基础的系统和必要的管理、\n                  监控工具，完全不需要操心应用所需的各种包、库的依赖关系，大大减轻了维护的负担。这和 Python 有着巨大的区别。由于历史的原因，\n                  Python 的部署工具生态相当混乱【比如 setuptools, distutils, pip, buildout 的不同适用场合以及兼容性问题】。官方 PyPI 源又经常出问题，\n                  需要搭建私有镜像，而维护这个镜像又要花费不少时间和精力。\n              </p>\n              <p>二、并发性好。Goroutine 和 channel 使得编写高并发的服务端软件变得相当容易，很多情况下完全不需要考虑锁机制以及由此带来的各种问题。单个 Go 应用也能有效的利用多个 CPU 核，并行执行的性能好。这和 Python 也是天壤之比。多线程和多进程的服务端程序编写起来并不简单，而且由于全局锁 GIL 的原因，多线程的 Python 程序并不能有效利用多核，只能用多进程的方式部署；如果用标准库里的 multiprocessing 包又会对监控和管理造成不少的挑战【我们用的 supervisor 管理进程，对 fork 支持不好】。部署 Python 应用的时候通常是每个 CPU 核部署一个应用，这会造成不少资源的浪费，比如假设某个 Python 应用启动后需要占用 100MB 内存，而服务器有 32 个 CPU 核，那么留一个核给系统、运行 31 个应用副本就要浪费 3GB 的内存资源。\n              </p>\n              <p>三、良好的语言设计。从学术的角度讲 Go 语言其实非常平庸，不支持许多高级的语言特性；但从工程的角度讲，Go 的设计是非常优秀的：规范足够简单灵活，有其他语言基础的程序员都能迅速上手。更重要的是 Go 自带完善的工具链，大大提高了团队协作的一致性。比如 gofmt 自动排版 Go 代码，很大程度上杜绝了不同人写的代码排版风格不一致的问题。把编辑器配置成在编辑存档的时候自动运行 gofmt，这样在编写代码的时候可以随意摆放位置，存档的时候自动变成正确排版的代码。此外还有 gofix, govet 等非常有用的工具。\n              </p>\n              <p>四、执行性能好。虽然不如 C 和 Java，但通常比原生 Python 应用还是高一个数量级的，适合编写一些瓶颈业务。内存占用也非常省。</p>', '1', '2018-10-24 11:42:33', '2018-10-24 11:42:34');
INSERT INTO `article` VALUES ('2', '各平台mysql重启', 'linux平台及windows平台mysql重启方法\r\n\r\n　　Linux下重启MySQL的正确方法：\r\n\r\n　　1、通过rpm包安装的MySQL\r\n\r\n　　service mysqld restart\r\n\r\n　　2、从源码包安装的MySQL\r\n\r\n　　// linux关闭MySQL的命令\r\n\r\n　　$mysql_dir/bin/mysqladmin -uroot -p shutdown\r\n\r\n　　// linux启动MySQL的命令\r\n\r\n　　$mysql_dir/bin/mysqld_safe &\r\n\r\n　　其中mysql_dir为MySQL的安装目录，mysqladmin和mysqld_safe位于MySQL安装目录的bin目录下，很容易找到的。\r\n\r\n　　3、以上方法都无效的时候，可以通过强行命令：“killall mysql”来关闭MySQL，但是不建议用这样的方式，因为这种野蛮的方法会强行终止MySQL数据库服务，有可能导致表损坏\r\n\r\n　　步骤或方法:RedHat Linux (Fedora Core/Cent OS)\r\n\r\n　　1.启动：/etc/init.d/mysqld start\r\n\r\n　　2.停止：/etc/init.d/mysqld stop\r\n\r\n　　3.重启：/etc/init.d/mysqld restart\r\n\r\n　　Debian / Ubuntu Linux\r\n\r\n　　1.启动：/etc/init.d/mysql start\r\n\r\n　　2.停止：/etc/init.d/mysql stop\r\n\r\n　　3.重启：/etc/init.d/mysql restart\r\n\r\n　　Windows\r\n\r\n　　1.点击“开始”->“运行”(快捷键Win+R)。\r\n\r\n　　2.启动：输入 net stop mysql\r\n\r\n　　3.停止：输入 net start mysql\r\n\r\n　　提示* Redhat Linux 也支持service command，启动：# service mysqld start 停止：# service mysqld stop 重启：# service mysqld restart\r\n\r\n　　* Windows下不能直接重启(restart)，只能先停止，再启动。\r\n\r\n　　MySQL启动，停止，重启方法：\r\n\r\n　　一、启动方式\r\n\r\n　　1、使用 service 启动：service mysqld start\r\n\r\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld start\r\n\r\n　　3、使用 safe_mysqld 启动：safe_mysqld&\r\n\r\n　　二、停止\r\n\r\n　　1、使用 service 启动：service mysqld stop\r\n\r\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld stop\r\n\r\n　　3、mysqladmin shutdown\r\n\r\n　　三、重启\r\n\r\n　　1、使用 service 启动：service mysqld restart\r\n\r\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld restart', '1', '2018-10-11 16:47:02', '2018-10-11 16:47:02');
INSERT INTO `article` VALUES ('6', '说道说道前后端分离 ', '<p>\n<p>要说前端界的发展速度，那真是快！\n2012年那时候接触过extjs，用于企业级后台开发还真不错，有好看的UI界面，组件丰富，基本能满足各类需求。但此时，HTML5正在蓬勃发展，尤其是乔布斯宣布苹果设备不支持flash后HTML5发展更是迅猛。并且angularjs这类MVVM框架被大多数所知，reactjs,vuejs如雨后春笋般生长。</p>\n<p>2014年使用了一段时间angularjs，感觉学习难度有点大，2015年使用vue1.0做了一个项目后我逢人就说angular，vue有多好用，推荐他们放弃jquery使用vue。不到2年时间再看看前端界，vue，react等框架已经是前端开发标配，如果你说公司项目还在使用jquery会被人笑话，对于前端新人MVVM框架是必学，jquery反而不会重视。</p>\n<p>这就导致一个结果：“手里拿着锤子，看什么都是钉子”，因为有锤子的关系，遇到任何问题，都会先想如何用锤子解决。久而久之，陷入了一种思维定式。任何工具带来便利的同时，也带来了局限性。而这往往是用锤子的人很难看到的。就拿一个需要SEO的网站来说，该选择哪种技术好？如果只会vue，不熟悉jquery的人来说肯定是选择vue，就算vue不太适合做这类网站，也会拿出ssr来强行做事。殊不知需要SEO的网站使用静态文件是最合适的。大多数人认为前后端分离是使用vue，react，angular，使用jquery的不叫前后端分离，这完全是搞混了概念，实际上后端的controller层也属于视图层，也可以归属于前端。</p>\n<p>现在去网上一搜，问一下身边的人怎么看待前后端分离的，大多数人秉持着支持的态度，认为前后端分离好处多多，列举几条：</p>\n<ul>\n<li>专业的人做专业的事</li>\n<li>前后并行开发，效率高</li>\n<li>前端工程化，组件化</li>\n<li>解耦</li>\n<li>降低了开发学习难度</li>\n</ul>\n<p>等等……\n<img alt=\"\" src=\"http://hopefully-img.yuedun.wang/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20180805104325.jpg\">\n大家说的都说到点上了，这也是前后端分离能发展起来的驱动力。但是道理说的都挺好，如果不结合实际情况的话就是大炮打蚊子，不但达不到理想的效果还浪费资源。而且前后端分离带来的负面情况也不可忽视：</p>\n<ul>\n<li>增加了沟通成本，一些前后端都可以做又都不想做的事或许只能由权利大的来决定。</li>\n<li>一般前端开发速度会比后端快，在接口没开发好时前端只能闲等着。也有反过来的情况。前后端分离也意味着任务关联性减弱，可能不是同时开发，需要一方催着一方来完成。</li>\n<li>跨域问题导致联调困难，前端只能等待接口开发上了服务器才能调试。</li>\n<li>职责分离后确认职责也困难，一个问题出现到底是谁的问题？谁解决？</li>\n<li>一个需求需要前后端开发同时参与理解需求，有理解偏差问题。</li>\n<li>小公司多一个人多一份支出。</li>\n</ul>\n<p>那么到底该不该进行前后端分离，如何进行技术选型？这需要根据一些实际情况来决定，大体判断准则有以下几点：</p>\n<ul>\n<li>后台系统采用前后端分离比较合适。</li>\n<li>需要SEO引流的就不要强行前后端分离了，react，vue的服务端渲染也很勉强，徒增开发难度而已。</li>\n<li>数据交互比较多的使用前后端分离，操作数据比jquery方便。</li>\n<li>页面本身特别简单，只负责简单数据展示，要求打开速度，直接服务端渲染即可。这种页面本身就是单页面，如果还要使用框架就是多此一举，增加页面负担，增加开发调试难度。</li>\n<li>开发资源充足最好前后端分离，开发资源不足时不分离，一人包揽前后台端反而更快。</li>\n</ul>\n<p>最后，前后端分离是一个趋势，但不是必须。更准确的说法应该叫做“前后端分工”，毕竟在5年前这些活都是一个开发来做的，因为技术复杂性提升，前端不想只是切图，后端不想学变化太快的前端就出现了分离。你可以想象测试的工作，现在的测试大多还是测业务，但是也出现了一个自动化测试的职位，因为测试不想天天鼠标点呀点的测，想搞点高深的东西，而开发又特别烦写单元测试代码，这就又出现分离。再者，数据库也是一样，所以出现了DBA这个角色。谁知哪一天又会合起来呢！</p>\n\n<br></p>', '1', '2018-10-12 12:19:51', '2018-10-12 12:19:51');

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
  UNIQUE KEY `idx_user_group` (`user_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO `groups` VALUES ('6', '2', '3', '2018-04-28 17:35:30', '2018-04-28 17:35:32');
INSERT INTO `groups` VALUES ('7', '2', '1', '2018-04-28 13:16:33', '2018-04-28 13:16:36');
INSERT INTO `groups` VALUES ('8', '2', '2', '2018-06-11 13:10:12', '2018-06-11 13:10:15');
INSERT INTO `groups` VALUES ('9', '2', '4', '2018-06-11 13:10:25', '2018-06-11 13:10:28');
INSERT INTO `groups` VALUES ('10', '2', '5', '2018-06-11 13:10:38', '2018-06-11 13:10:40');
INSERT INTO `groups` VALUES ('11', '2', '6', '2018-06-11 13:10:50', '2018-06-11 13:10:55');
INSERT INTO `groups` VALUES ('12', '1', '3', '2018-11-01 01:31:22', '2018-11-01 01:31:22');

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
  `region` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '地区',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '职位数',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

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
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groups` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限列表',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '说明',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='可以给一个角色很多权限，也可以通过很多角色组合来拥有很多权限';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'UserController:UserList,UserController:UserListRoute', '管理员', '2018-04-21 14:00:18', '2018-04-21 14:00:23');
INSERT INTO `role` VALUES ('2', 'UserController:UserListRoute', '普通管理员', '2018-04-21 14:00:15', '2018-04-21 14:00:21');
INSERT INTO `role` VALUES ('3', 'UserController:POST', '添加用户', '2018-04-20 13:29:49', '2018-04-20 13:29:52');
INSERT INTO `role` VALUES ('4', 'UserController:PUT', '编辑用户', '2018-06-11 13:05:02', '2018-06-11 13:05:05');
INSERT INTO `role` VALUES ('5', 'UserController:DeleteUser', '删除用户', '2018-06-11 13:07:02', '2018-06-11 13:07:07');
INSERT INTO `role` VALUES ('6', 'UserController:UserList', '用户列表', '2018-06-11 13:09:09', '2018-06-11 13:09:12');

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
  UNIQUE KEY `idx_mobile_uniq` (`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '13477889900', '犬夜叉', '960232f4a37f948b480a3f8a5512c6f8', '1', '13477889900@139.com', '日暮神社', '0', '半妖', '2018-03-17 20:46:31', '2018-11-01 01:31:17');
INSERT INTO `user` VALUES ('2', '18701897513', '月盾', 'abc72b24857be42850f67d3160f8710e', '1', '18701897513@139.com', '上海', '1', 'golang开发者', '2018-03-17 20:49:44', '2018-06-11 12:56:34');
INSERT INTO `user` VALUES ('5', '18701893513', '施工图人力', 'abc72b24857be42850f67d3160f8710e', '1', '18611118146@139.com', '看见的任何司空见惯和', '1', '', '2017-07-27 03:25:01', '2018-02-28 11:57:56');
INSERT INTO `user` VALUES ('8', '10701897527', '缇欧', '8fa2952fff72d92c98f9f43e46dfc6bd', '0', 'huo@gmail.com', '吉林大街好地方', '1', '而喝了酒而温柔你感觉', '2017-07-27 09:00:43', '2018-03-19 11:10:50');
INSERT INTO `user` VALUES ('9', '10706597527', '瑞泰居', '8fa2952fff72d92c98f9f43e46dfc6bd', '0', '438473@qq.com', '连接哦哦发给你基地', '1', '收到了架构过人家饿啊人工', '2017-07-29 10:38:06', '2018-04-06 17:02:03');
INSERT INTO `user` VALUES ('13', '18701497527', '杀生丸', '8fa2952fff72d92c98f9f43e46dfc6bd', '1', 'hp@sina.com', '送就送山东黄金人数', '1', '视频国际投行饿哦日后我如何进入', '2018-02-05 04:20:37', '2018-12-02 20:38:37');
INSERT INTO `user` VALUES ('14', '12345678909', '珊瑚', '5335412ee0f17806e1017e607149336a', '0', 'ligh@163.com', '很快就都大佛开盘后具体要', '1', '我感觉哦过仁和堂撒今天', '2018-02-05 08:07:37', '2018-04-06 17:03:04');
INSERT INTO `user` VALUES ('21', '18721897527', '让大哥', '8fa2952fff72d92c98f9f43e46dfc6bd', '1', '18611118146@139.com', '送就送山东黄金人数几乎是丢改好', '1', '就fdfda', '2018-02-11 07:53:18', '2018-10-24 11:43:07');
INSERT INTO `user` VALUES ('22', '18766464985', '接收到过', '442ba06a1ac9ad299865c11234b9c492', '0', 'ligh@163.com', '送就送山东黄金人数几乎是丢改好看机会', '1', '', '2018-02-11 15:58:10', '2018-02-11 16:00:32');
INSERT INTO `user` VALUES ('23', '12335678909', 'UI一天', '5335412ee0f17806e1017e607149336a', '1', '13344442929@163.com', '看见的任何', '1', '', '2018-02-11 16:05:53', '2018-02-27 13:03:52');
INSERT INTO `user` VALUES ('25', '18111897528', '突然间和', '033554527363fed57bacfcab7c77c5fb', '0', 'lig@163.com', 'dfpkgipniu', '1', '当人看了韩国人都', '2018-02-28 10:34:39', '2018-02-28 10:34:39');
INSERT INTO `user` VALUES ('26', '18765464985', '偶遇', '442ba06a1ac9ad299865c11234b9c492', '0', '13344442929@163.com', '很快就都大佛开盘后具体要', '1', '客人很多事让她二炮还叫人', '2018-02-28 10:34:58', '2018-02-28 10:34:58');
INSERT INTO `user` VALUES ('27', '18701817525', '鹅肉你以后', '67c70763ce38919105acc783fa5e834d', '1', '18765464985', '了PDF你好逗', '1', '哦【但是若干年后天赋', '2018-02-28 10:35:20', '2018-02-28 10:35:20');
INSERT INTO `user` VALUES ('28', '15800739208', 'gurdian90', 'dfda39bb37573e74338338642162d85b', '0', '8974@qq.com', '长安路1138号', '0', '好回家哦个积极破解', '2018-04-05 23:19:33', '2018-04-05 23:19:33');

-- ----------------------------
-- Table structure for `picture`
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pic_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

