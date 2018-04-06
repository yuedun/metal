/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : issue

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-04-06 18:30:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `assistance`
-- ----------------------------
DROP TABLE IF EXISTS `assistance`;
CREATE TABLE `assistance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
-- Table structure for `helpers`
-- ----------------------------
DROP TABLE IF EXISTS `helpers`;
CREATE TABLE `helpers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
-- Table structure for `helper_feature_relation`
-- ----------------------------
DROP TABLE IF EXISTS `helper_feature_relation`;
CREATE TABLE `helper_feature_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
-- Table structure for `people_feature_relation`
-- ----------------------------
DROP TABLE IF EXISTS `people_feature_relation`;
CREATE TABLE `people_feature_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  UNIQUE KEY `idx_mobile_uniq` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '13477889900', '犬夜叉', '123', '1', '13477889900@139.com', '日暮神社', '1', '半妖', '2018-03-17 20:46:31', '2018-03-17 20:46:31');
INSERT INTO `user` VALUES ('2', '18701897513', '戈薇', 'abc72b24857be42850f67d3160f8710e', '0', '18701897513@139.com', '日暮神社', '1', '巫女桔梗转生', '2018-03-17 20:49:44', '2018-03-17 20:55:25');
INSERT INTO `user` VALUES ('5', '18701893513', '施工图人力', 'abc72b24857be42850f67d3160f8710e', '1', '18611118146@139.com', '看见的任何司空见惯和', '1', '', '2017-07-27 03:25:01', '2018-02-28 11:57:56');
INSERT INTO `user` VALUES ('8', '10701897527', '缇欧', '', '0', 'huo.win.n@gmail.com', '吉林大街好地方', '1', '而喝了酒而温柔你感觉', '2017-07-27 09:00:43', '2018-03-19 11:10:50');
INSERT INTO `user` VALUES ('9', '10706597527', '瑞泰居', '', '0', '438473005@qq.com', '连接哦哦发给你基地', '1', '收到了架构过人家饿啊人工', '2017-07-29 10:38:06', '2018-04-06 17:02:03');
INSERT INTO `user` VALUES ('13', '18701497527', '杀生丸', 'hiuhiuh', '1', 'hp_if@sina.com', '送就送山东黄金人数', '1', '视频国际投行饿哦日后我如何进入', '2018-02-05 04:20:37', '2018-03-26 21:50:21');
INSERT INTO `user` VALUES ('14', '12345678909', '珊瑚', 'hgggggg', '0', 'light_v@163.com', '很快就都大佛开盘后具体要', '1', '我感觉哦过仁和堂撒今天', '2018-02-05 08:07:37', '2018-04-06 17:03:04');
INSERT INTO `user` VALUES ('21', '18721897527', '让大哥', '', '0', '18611118146@139.com', '送就送山东黄金人数几乎是丢改好', '1', '', '2018-02-11 07:53:18', '2018-02-11 15:56:36');
INSERT INTO `user` VALUES ('22', '18766464985', '接收到过', '', '0', 'light_v@163.com', '送就送山东黄金人数几乎是丢改好看机会', '1', '', '2018-02-11 15:58:10', '2018-02-11 16:00:32');
INSERT INTO `user` VALUES ('23', '12335678909', 'UI一天', '', '1', '13344442929@163.com', '看见的任何', '1', '', '2018-02-11 16:05:53', '2018-02-27 13:03:52');
INSERT INTO `user` VALUES ('25', '1811897527', '突然间和', '', '0', 'light_v@163.com', 'dfpkgipniu', '1', '当人看了韩国人都', '2018-02-28 10:34:39', '2018-02-28 10:34:39');
INSERT INTO `user` VALUES ('26', '18765464985', '偶遇', '', '0', '13344442929@163.com', '很快就都大佛开盘后具体要', '1', '客人很多事让她二炮还叫人', '2018-02-28 10:34:58', '2018-02-28 10:34:58');
INSERT INTO `user` VALUES ('27', '18701817525', '鹅肉你以后', '', '1', '18765464985', '了PDF你好逗', '1', '哦【但是若干年后天赋', '2018-02-28 10:35:20', '2018-02-28 10:35:20');
INSERT INTO `user` VALUES ('28', '15800739208', 'gurdian90', 'dfda39bb37573e74338338642162d85b', '0', '897452332@qq.com', '长安路1138号中房华东大厦21A', '0', '好回家哦个积极破解', '2018-04-05 23:19:33', '2018-04-05 23:19:33');
