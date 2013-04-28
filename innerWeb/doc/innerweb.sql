/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : 127.0.0.1:3306
Source Database       : innerweb

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2013-04-28 16:30:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_category`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_category`;
CREATE TABLE `tbl_category` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `describe` varchar(1000) default NULL COMMENT '描述',
  `showtype` tinyint(1) default '0' COMMENT '0=列表页 1内容页',
  `showindex` tinyint(1) default '0' COMMENT '是否首页显示1=是 0=否',
  `parentid` varchar(32) NOT NULL default '0' COMMENT '父ID。根默认为0',
  `categorytype` varchar(32) default NULL COMMENT '分类所属的类型,例如本次为新闻分类等',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类信息';

-- ----------------------------
-- Records of tbl_category
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_content`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_content`;
CREATE TABLE `tbl_content` (
  `id_fk` varchar(32) NOT NULL,
  `content` text COMMENT '正文内容'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='正文内容';

-- ----------------------------
-- Records of tbl_content
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
INSERT INTO `tbl_meta` VALUES ('1', 'news_category', '1');
INSERT INTO `tbl_meta` VALUES ('2', 'notice_category', '2');
INSERT INTO `tbl_meta` VALUES ('3', 'links_category', '3');

-- ----------------------------
-- Table structure for `tbl_post`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_post`;
CREATE TABLE `tbl_post` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='内容主表';

-- ----------------------------
-- Records of tbl_post
-- ----------------------------
