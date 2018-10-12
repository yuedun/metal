/*
Navicat MySQL Data Transfer

Source Server         : alimysql
Source Server Version : 50722
Source Host           : 112.74.171.94:3306
Source Database       : issue

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-10-11 21:40:06
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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', 'Go语言优势', '<p>一、\r\n                  部署简单。Go 编译生成的是一个静态可执行文件，除了 glibc 外没有其他外部依赖。这让部署变得异常方便：目标机器上只需要一个基础的系统和必要的管理、\r\n                  监控工具，完全不需要操心应用所需的各种包、库的依赖关系，大大减轻了维护的负担。这和 Python 有着巨大的区别。由于历史的原因，\r\n                  Python 的部署工具生态相当混乱【比如 setuptools, distutils, pip, buildout 的不同适用场合以及兼容性问题】。官方 PyPI 源又经常出问题，\r\n                  需要搭建私有镜像，而维护这个镜像又要花费不少时间和精力。\r\n              </p>\r\n              <p>二、并发性好。Goroutine 和 channel 使得编写高并发的服务端软件变得相当容易，很多情况下完全不需要考虑锁机制以及由此带来的各种问题。单个 Go 应用也能有效的利用多个 CPU 核，并行执行的性能好。这和 Python 也是天壤之比。多线程和多进程的服务端程序编写起来并不简单，而且由于全局锁 GIL 的原因，多线程的 Python 程序并不能有效利用多核，只能用多进程的方式部署；如果用标准库里的 multiprocessing 包又会对监控和管理造成不少的挑战【我们用的 supervisor 管理进程，对 fork 支持不好】。部署 Python 应用的时候通常是每个 CPU 核部署一个应用，这会造成不少资源的浪费，比如假设某个 Python 应用启动后需要占用 100MB 内存，而服务器有 32 个 CPU 核，那么留一个核给系统、运行 31 个应用副本就要浪费 3GB 的内存资源。\r\n              </p>\r\n              <p>三、良好的语言设计。从学术的角度讲 Go 语言其实非常平庸，不支持许多高级的语言特性；但从工程的角度讲，Go 的设计是非常优秀的：规范足够简单灵活，有其他语言基础的程序员都能迅速上手。更重要的是 Go 自带完善的工具链，大大提高了团队协作的一致性。比如 gofmt 自动排版 Go 代码，很大程度上杜绝了不同人写的代码排版风格不一致的问题。把编辑器配置成在编辑存档的时候自动运行 gofmt，这样在编写代码的时候可以随意摆放位置，存档的时候自动变成正确排版的代码。此外还有 gofix, govet 等非常有用的工具。\r\n              </p>\r\n              <p>四、执行性能好。虽然不如 C 和 Java，但通常比原生 Python 应用还是高一个数量级的，适合编写一些瓶颈业务。内存占用也非常省。</p>', '2018-10-11 16:44:51', '2018-10-11 16:44:51');
INSERT INTO `article` VALUES ('2', '各平台mysql重启', 'linux平台及windows平台mysql重启方法\r\n\r\n　　Linux下重启MySQL的正确方法：\r\n\r\n　　1、通过rpm包安装的MySQL\r\n\r\n　　service mysqld restart\r\n\r\n　　2、从源码包安装的MySQL\r\n\r\n　　// linux关闭MySQL的命令\r\n\r\n　　$mysql_dir/bin/mysqladmin -uroot -p shutdown\r\n\r\n　　// linux启动MySQL的命令\r\n\r\n　　$mysql_dir/bin/mysqld_safe &\r\n\r\n　　其中mysql_dir为MySQL的安装目录，mysqladmin和mysqld_safe位于MySQL安装目录的bin目录下，很容易找到的。\r\n\r\n　　3、以上方法都无效的时候，可以通过强行命令：“killall mysql”来关闭MySQL，但是不建议用这样的方式，因为这种野蛮的方法会强行终止MySQL数据库服务，有可能导致表损坏\r\n\r\n　　步骤或方法:RedHat Linux (Fedora Core/Cent OS)\r\n\r\n　　1.启动：/etc/init.d/mysqld start\r\n\r\n　　2.停止：/etc/init.d/mysqld stop\r\n\r\n　　3.重启：/etc/init.d/mysqld restart\r\n\r\n　　Debian / Ubuntu Linux\r\n\r\n　　1.启动：/etc/init.d/mysql start\r\n\r\n　　2.停止：/etc/init.d/mysql stop\r\n\r\n　　3.重启：/etc/init.d/mysql restart\r\n\r\n　　Windows\r\n\r\n　　1.点击“开始”->“运行”(快捷键Win+R)。\r\n\r\n　　2.启动：输入 net stop mysql\r\n\r\n　　3.停止：输入 net start mysql\r\n\r\n　　提示* Redhat Linux 也支持service command，启动：# service mysqld start 停止：# service mysqld stop 重启：# service mysqld restart\r\n\r\n　　* Windows下不能直接重启(restart)，只能先停止，再启动。\r\n\r\n　　MySQL启动，停止，重启方法：\r\n\r\n　　一、启动方式\r\n\r\n　　1、使用 service 启动：service mysqld start\r\n\r\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld start\r\n\r\n　　3、使用 safe_mysqld 启动：safe_mysqld&\r\n\r\n　　二、停止\r\n\r\n　　1、使用 service 启动：service mysqld stop\r\n\r\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld stop\r\n\r\n　　3、mysqladmin shutdown\r\n\r\n　　三、重启\r\n\r\n　　1、使用 service 启动：service mysqld restart\r\n\r\n　　2、使用 mysqld 脚本启动：/etc/inint.d/mysqld restart', '2018-10-11 16:47:02', '2018-10-11 16:47:02');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO `groups` VALUES ('6', '2', '3', '2018-04-28 17:35:30', '2018-04-28 17:35:32');
INSERT INTO `groups` VALUES ('7', '2', '1', '2018-04-28 13:16:33', '2018-04-28 13:16:36');
INSERT INTO `groups` VALUES ('8', '2', '2', '2018-06-11 13:10:12', '2018-06-11 13:10:15');
INSERT INTO `groups` VALUES ('9', '2', '4', '2018-06-11 13:10:25', '2018-06-11 13:10:28');
INSERT INTO `groups` VALUES ('10', '2', '5', '2018-06-11 13:10:38', '2018-06-11 13:10:40');
INSERT INTO `groups` VALUES ('11', '2', '6', '2018-06-11 13:10:50', '2018-06-11 13:10:55');

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
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `job_count` VALUES ('185', 'nodejs', '上海', '0', '2018-10-11 12:00:00');
INSERT INTO `job_count` VALUES ('186', 'golang', '上海', '0', '2018-10-11 12:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

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
INSERT INTO `user` VALUES ('1', '13477889900', '犬夜叉', '960232f4a37f948b480a3f8a5512c6f8', '1', '13477889900@139.com', '日暮神社', '0', '半妖', '2018-03-17 20:46:31', '2018-03-17 20:46:31');
INSERT INTO `user` VALUES ('2', '18701897513', '月盾', 'abc72b24857be42850f67d3160f8710e', '1', '18701897513@139.com', '上海', '1', 'golang开发者', '2018-03-17 20:49:44', '2018-06-11 12:56:34');
INSERT INTO `user` VALUES ('5', '18701893513', '施工图人力', 'abc72b24857be42850f67d3160f8710e', '1', '18611118146@139.com', '看见的任何司空见惯和', '1', '', '2017-07-27 03:25:01', '2018-02-28 11:57:56');
INSERT INTO `user` VALUES ('8', '10701897527', '缇欧', '8fa2952fff72d92c98f9f43e46dfc6bd', '0', 'huo@gmail.com', '吉林大街好地方', '1', '而喝了酒而温柔你感觉', '2017-07-27 09:00:43', '2018-03-19 11:10:50');
INSERT INTO `user` VALUES ('9', '10706597527', '瑞泰居', '8fa2952fff72d92c98f9f43e46dfc6bd', '0', '438473@qq.com', '连接哦哦发给你基地', '1', '收到了架构过人家饿啊人工', '2017-07-29 10:38:06', '2018-04-06 17:02:03');
INSERT INTO `user` VALUES ('13', '18701497527', '杀生丸', '8fa2952fff72d92c98f9f43e46dfc6bd', '1', 'hp@sina.com', '送就送山东黄金人数', '1', '视频国际投行饿哦日后我如何进入', '2018-02-05 04:20:37', '2018-03-26 21:50:21');
INSERT INTO `user` VALUES ('14', '12345678909', '珊瑚', '5335412ee0f17806e1017e607149336a', '0', 'ligh@163.com', '很快就都大佛开盘后具体要', '1', '我感觉哦过仁和堂撒今天', '2018-02-05 08:07:37', '2018-04-06 17:03:04');
INSERT INTO `user` VALUES ('21', '18721897527', '让大哥', '8fa2952fff72d92c98f9f43e46dfc6bd', '0', '18611118146@139.com', '送就送山东黄金人数几乎是丢改好', '1', '', '2018-02-11 07:53:18', '2018-02-11 15:56:36');
INSERT INTO `user` VALUES ('22', '18766464985', '接收到过', '442ba06a1ac9ad299865c11234b9c492', '0', 'ligh@163.com', '送就送山东黄金人数几乎是丢改好看机会', '1', '', '2018-02-11 15:58:10', '2018-02-11 16:00:32');
INSERT INTO `user` VALUES ('23', '12335678909', 'UI一天', '5335412ee0f17806e1017e607149336a', '1', '13344442929@163.com', '看见的任何', '1', '', '2018-02-11 16:05:53', '2018-02-27 13:03:52');
INSERT INTO `user` VALUES ('25', '18111897528', '突然间和', '033554527363fed57bacfcab7c77c5fb', '0', 'lig@163.com', 'dfpkgipniu', '1', '当人看了韩国人都', '2018-02-28 10:34:39', '2018-02-28 10:34:39');
INSERT INTO `user` VALUES ('26', '18765464985', '偶遇', '442ba06a1ac9ad299865c11234b9c492', '0', '13344442929@163.com', '很快就都大佛开盘后具体要', '1', '客人很多事让她二炮还叫人', '2018-02-28 10:34:58', '2018-02-28 10:34:58');
INSERT INTO `user` VALUES ('27', '18701817525', '鹅肉你以后', '67c70763ce38919105acc783fa5e834d', '1', '18765464985', '了PDF你好逗', '1', '哦【但是若干年后天赋', '2018-02-28 10:35:20', '2018-02-28 10:35:20');
INSERT INTO `user` VALUES ('28', '15800739208', 'gurdian90', 'dfda39bb37573e74338338642162d85b', '0', '8974@qq.com', '长安路1138号', '0', '好回家哦个积极破解', '2018-04-05 23:19:33', '2018-04-05 23:19:33');
