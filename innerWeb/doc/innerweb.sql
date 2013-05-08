/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : innerweb

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2013-05-08 19:02:09
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
INSERT INTO `tbl_category` VALUES ('6ZNFni', '公司通知公告', '公司通知公告', 'gsgzgg', '公司通知公告', '0', '1', '0', 'E7FFN3', 'notices', null, '2013-05-07 08:15:22');
INSERT INTO `tbl_category` VALUES ('E7FFN3', '通知公告', '通知公告', 'notices', '通知公告', '0', '1', '0', '0', 'notices', null, null);
INSERT INTO `tbl_category` VALUES ('eaAZFf', '战略研究', '战略研究', 'zlyj', '战略研究', '0', '1', '0', 'm226Ff', 'news', null, '2013-05-07 08:14:17');
INSERT INTO `tbl_category` VALUES ('euEBf2', '华电快捷入口', '华电快捷入口', 'checneentrance', '华电快捷入口', '0', '1', '0', '0', 'links', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('m226Ff', '新闻动态', '新闻动态', 'news', '新闻动态', '0', '1', '0', '0', 'news', null, null);
INSERT INTO `tbl_category` VALUES ('MRNVze', '工程管理', '工程管理', 'gcgl', '工程管理', '0', '1', '0', 'm226Ff', 'news', null, '2013-05-07 08:14:34');
INSERT INTO `tbl_category` VALUES ('MvUzEf', '部门通知公告', '部门通知公告', 'bmtzgg', '部门通知公告', '1', '1', '0', 'E7FFN3', 'notices', null, '2013-05-07 08:15:37');
INSERT INTO `tbl_category` VALUES ('mYzuM3', '公司新闻', '公司新闻', 'gsxw', '公司新闻', '0', '1', '0', 'm226Ff', 'news', null, '2013-05-07 08:13:34');
INSERT INTO `tbl_category` VALUES ('nQvI73', '市场信息', '市场信息', 'ccxx', '市场信息', '0', '1', '0', 'm226Ff', 'news', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('VB7vYv', '集团快捷入口', '集团快捷入口', 'groupentrance', '集团快捷入口', '0', '1', '0', '0', 'links', null, '2013-05-07 08:14:55');

-- ----------------------------
-- Table structure for `tbl_links`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_links`;
CREATE TABLE `tbl_links` (
  `id` varchar(32) NOT NULL COMMENT '唯一标识',
  `links_name` varchar(500) NOT NULL,
  `links_ulr` varchar(500) NOT NULL,
  `links_category_id` varchar(32) NOT NULL,
  `links_category_type` varchar(32) NOT NULL,
  `links_image` varchar(500) default NULL,
  `links_order` int(11) default NULL,
  `links_latestdate` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='链接管理';

-- ----------------------------
-- Records of tbl_links
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_meta`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_meta`;
CREATE TABLE `tbl_meta` (
  `id` int(32) NOT NULL auto_increment COMMENT '唯一主键,递增',
  `meta_name` varchar(250) NOT NULL COMMENT '标识位名字',
  `meta_value` varchar(250) NOT NULL COMMENT '标识位名字对应的值',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统所有变量的标识Map(key-value)';

-- ----------------------------
-- Records of tbl_meta
-- ----------------------------
INSERT INTO `tbl_meta` VALUES ('1', 'news', '1');
INSERT INTO `tbl_meta` VALUES ('2', 'notice', '2');
INSERT INTO `tbl_meta` VALUES ('3', 'links', '3');

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
INSERT INTO `tbl_post` VALUES ('euymye', 'news', 'eaAZFf', '市场战略研究是不是真的有用呢？', '周杨', '战略委员会', '2013-05-07 18:42:45', '1', '0', '0', '0', '0', '市场战略研究是不是真的有用呢？', 'userfiles/upload/user-images/2013/05/07/20130507133109.jpg', '市场战略研究是不是真的有用呢？');
INSERT INTO `tbl_post` VALUES ('IvqY3m', 'news', 'eaAZFf', '市场信息1', '市场信息1', '市场信息1', '2013-05-07 18:46:13', '0', '0', '0', '0', '1', '市场信息1', 'userfiles/upload/user-images/2013/05/07/20130507135045.jpg', '市场信息1');
