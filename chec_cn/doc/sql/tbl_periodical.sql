/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : chec_cn

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2014-04-28 23:25:03
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
  `filename` varchar(200) default NULL,
  `filesize` bigint(20) default NULL COMMENT '文件大小byte',
  `createtime` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `idx_periodical_id` (`id`),
  KEY `idx_periodical_years` (`years`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='华电工程期刊（periodical）';

-- ----------------------------
-- Records of tbl_periodical
-- ----------------------------
INSERT INTO `tbl_periodical` VALUES ('6ZBvUn', '2008年第1期 总第38期', null, '/upload/images/20107/2010723102522811249.jpg', '2008', '1', '38', '/upload/accessory/20107/201071691141687522.pdf', '201071691141687522.pdf', '47124480', '2008-01-01 01:01:01');
INSERT INTO `tbl_periodical` VALUES ('Br6zmq', '2008年第3期 总第40期', null, '/upload/images/20107/20107231025358591221.jpg', '2008', '3', '40', '/upload/accessory/20107/20107221014574069670.pdf', '20107221014574069670.pdf', '37120000', null);
INSERT INTO `tbl_periodical` VALUES ('BV3iai', '2008年第4期 总第41期', null, '/upload/images/20107/2010723102554781889.jpg', '2008', '4', '40', '/upload/accessory/20107/201072210226156809.pdf', '201072210226156809.pdf', '39331840', null);
INSERT INTO `tbl_periodical` VALUES ('u2muUv', '2008年第2期 总第39期', null, '/upload/images/20107/20107231025205155505.jpg', '2008', '2', '39', '/upload/accessory/20107/2010722101014628888.pdf', '2010722101014628888.pdf', '38400000', '2008-01-01 01:01:01');
