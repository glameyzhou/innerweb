/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : innerweb

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2013-05-16 19:54:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_category`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_category`;
CREATE TABLE `tbl_category` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `shortname` varchar(100) default NULL COMMENT '短名字',
  `aliasname` varchar(100) default NULL COMMENT '别名，用户URL显示，建议为数字、字母、下划线',
  `categorydescribe` varchar(1000) default NULL COMMENT '描述',
  `showtype` tinyint(1) default '0' COMMENT '0=列表页 1内容页',
  `showindex` tinyint(1) default '0' COMMENT '是否首页显示1=是 0=否',
  `categoryorder` int(10) default '0' COMMENT '分类排序，数值越小优先级越高',
  `parentid` varchar(32) NOT NULL default '0' COMMENT '父ID。根默认为0',
  `categorytype` varchar(32) default NULL COMMENT '分类所属的类型,例如本次为新闻分类等',
  `categoryimage` varchar(100) default NULL COMMENT '分类图片',
  `categorytime` varchar(100) default NULL COMMENT '创建时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类信息';

-- ----------------------------
-- Records of tbl_category
-- ----------------------------
INSERT INTO `tbl_category` VALUES ('2meuyy', '友情链接', '友情链接', 'friendlyLinks', '友情链接', '0', '1', '0', '0', 'friendlyLinks', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('7B7rIb', '政府部门', '政府部门', 'gv', '政府部门', '0', '0', '1', '2meuyy', 'friendlyLinks', null, '2013-05-16 16:30:25');
INSERT INTO `tbl_category` VALUES ('E7FFN3', '通知公告', '通知公告', 'notices', '通知公告', '0', '1', '0', '0', 'notices', null, null);
INSERT INTO `tbl_category` VALUES ('j6rmu2', '行政动态', '行政动态', 'xingzhengdongtai', '行政动态', '0', '1', '1', 'm226Ff', 'news', null, '2013-05-16 16:19:43');
INSERT INTO `tbl_category` VALUES ('m226Ff', '新闻动态', '新闻动态', 'news', '新闻动态', '0', '1', '0', '0', 'news', null, null);
INSERT INTO `tbl_category` VALUES ('NJNzQ3', '兄弟部门', '兄弟部门', 'br', '', '0', '0', '3', '2meuyy', 'friendlyLinks', null, '2013-05-16 16:30:56');
INSERT INTO `tbl_category` VALUES ('NnEvIb', '集团快捷入口', '集团快捷入口', 'outfastentrance', '集团快捷入口', '0', '1', '0', '0', 'outfastentrance', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('QZbM7n', '华电快捷入口', '华电快捷入口', 'infastentrance', '华电快捷入口', '0', '1', '0', '0', 'infastentrance', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('uiMbIb', '行业动态', '行业动态', 'hangyedongtai', '行业动态', '0', '1', '2', 'm226Ff', 'news', null, '2013-05-16 16:20:05');

-- ----------------------------
-- Table structure for `tbl_links`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_links`;
CREATE TABLE `tbl_links` (
  `id` varchar(32) NOT NULL COMMENT '唯一标识',
  `links_name` varchar(500) NOT NULL,
  `links_url` varchar(500) NOT NULL,
  `links_category_id` varchar(32) NOT NULL,
  `links_category_type` varchar(32) NOT NULL,
  `links_image` varchar(500) default NULL,
  `links_order` int(11) default NULL,
  `links_showindex` tinyint(1) default '1' COMMENT '是否显示在首页1=是 0=否',
  `links_latestdate` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='链接管理';

-- ----------------------------
-- Records of tbl_links
-- ----------------------------
INSERT INTO `tbl_links` VALUES ('AvMZNj', '通讯录', 'http://www.a.com', 'QZbM7n', 'infastentrance', null, '1', '1', '2013-05-16 16:29:02');
INSERT INTO `tbl_links` VALUES ('FB7N7r', 'zfbm1', 'http://emial.com', '2meuyy', 'friendlyLinks', null, '1', '1', '2013-05-16 19:14:02');
INSERT INTO `tbl_links` VALUES ('feUn6b', 'qqq', 'qqq', '7B7rIb', 'friendlyLinks', null, '1', '1', '2013-05-16 19:50:17');
INSERT INTO `tbl_links` VALUES ('jeYfQ3', 'adadf', 'http://emial.com', '7B7rIb', 'friendlyLinks', null, '1', '1', '2013-05-16 19:50:15');
INSERT INTO `tbl_links` VALUES ('Nruqmy', '集团邮箱', 'http://emial.com', 'NnEvIb', 'outfastentrance', null, '2', '0', '2013-05-16 19:13:39');
INSERT INTO `tbl_links` VALUES ('uymUVr', '集团OA', 'http://oa.com', 'NnEvIb', 'outfastentrance', null, '1', '1', '2013-05-16 16:28:15');
INSERT INTO `tbl_links` VALUES ('zMzIFf', '人事系统', 'http://www.r.com', 'QZbM7n', 'infastentrance', null, '2', '1', '2013-05-16 16:29:30');
INSERT INTO `tbl_links` VALUES ('ZZFZNn', '集团KS', 'http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack', 'NnEvIb', 'outfastentrance', null, '12', '1', '2013-05-16 19:13:33');

-- ----------------------------
-- Table structure for `tbl_meta`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_meta`;
CREATE TABLE `tbl_meta` (
  `meta_name` varchar(250) NOT NULL COMMENT '标识位名字',
  `meta_value` varchar(250) NOT NULL COMMENT '标识位名字对应的值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统所有变量的标识Map(key-value)';

-- ----------------------------
-- Records of tbl_meta
-- ----------------------------
INSERT INTO `tbl_meta` VALUES ('news', '1');
INSERT INTO `tbl_meta` VALUES ('notice', '2');
INSERT INTO `tbl_meta` VALUES ('links', '3');

-- ----------------------------
-- Table structure for `tbl_post`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_post`;
CREATE TABLE `tbl_post` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `post_category_type` varchar(32) default NULL COMMENT '内容分类类型-tbl_category-categoryType',
  `post_category_id` varchar(32) default NULL COMMENT '分类主键tbl_category_id',
  `post_title` varchar(1000) default NULL COMMENT '标题',
  `post_author` varchar(100) default NULL COMMENT '发布人',
  `post_source` varchar(100) default NULL COMMENT '内容来源',
  `post_time` varchar(50) default NULL,
  `post_showindex` tinyint(1) default '0' COMMENT '是否首页显示1=是 0=否',
  `post_showlist` tinyint(1) default '0' COMMENT '是否列表显示 1=是 0=否',
  `post_apply` tinyint(1) default '0' COMMENT '是否通过审核 1=是 0=否',
  `post_focusimage` tinyint(1) default '0' COMMENT '是否为焦点图 1=是 0=否',
  `post_hot` tinyint(1) default '0' COMMENT '是否为热点新闻 1=是 0=否',
  `post_summary` text COMMENT '摘要',
  `post_image` varchar(500) default NULL COMMENT '图片',
  `post_content` text COMMENT '内容',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主体内容';

-- ----------------------------
-- Records of tbl_post
-- ----------------------------
INSERT INTO `tbl_post` VALUES ('6JNNve', 'news', 'j6rmu2', '新闻1', '周杨', '新闻1', '2013-05-16 16:27:47', '0', '0', '0', '0', '0', '暗室逢灯', null, '爱上对方');

-- ----------------------------
-- Table structure for `tbl_user`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `user_id` varchar(100) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_passwd` varchar(100) NOT NULL,
  `user_nickname` varchar(100) default NULL,
  `user_phone` varchar(100) default NULL,
  `user_mobile` varchar(100) default NULL,
  `user_email` varchar(100) default NULL,
  `user_address` text,
  `user_dept_id` varchar(100) default NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
