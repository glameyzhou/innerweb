/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : chec_cn

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2014-04-28 18:17:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_periodical`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_periodical`;
CREATE TABLE `tbl_periodical` (
  `id` varchar(32) NOT NULL default '',
  `title` varchar(500) default NULL COMMENT '标题',
  `summary` text COMMENT '描述',
  `image` varchar(200) default NULL,
  `years` int(11) default NULL COMMENT '年份',
  `periodical` int(11) default NULL COMMENT '期刊，第几期',
  `periodical_all` int(11) default NULL COMMENT '总期刊',
  `filepath` varchar(200) default NULL COMMENT '文件路径',
  `filesize` bigint(20) default NULL COMMENT '文件大小k',
  `createtime` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_periodical_id` (`id`),
  KEY `idx_periodical_years` (`years`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='华电工程期刊（periodical）';

-- ----------------------------
-- Records of tbl_periodical
-- ----------------------------
