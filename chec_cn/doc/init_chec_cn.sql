/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : chec_cn

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2014-04-06 22:28:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` varchar(32) NOT NULL,
  `cate_pid` varchar(32) NOT NULL COMMENT '父ID',
  `cate_type` varchar(255) default NULL COMMENT '分类类别-用于区分类的类别',
  `cate_order` int(11) default NULL,
  `cate_is_show` tinyint(4) default '1' COMMENT '是否显示0=否，1=是',
  `cate_is_list` tinyint(4) default '1' COMMENT '是否为列表0=否，1=是',
  `cate_name` varchar(200) default NULL COMMENT '栏目名称',
  `cate_alias_name` varchar(200) default NULL COMMENT '名字简写',
  `cate_img` varchar(100) default NULL COMMENT '栏目图片',
  `cate_flv` varchar(100) default NULL COMMENT '栏目flash',
  `cate_desc` text COMMENT '栏目简介',
  KEY `idx_cate_id` USING BTREE (`id`),
  KEY `idx_cate_pid` (`cate_pid`),
  KEY `idx_cate_type` (`cate_type`),
  KEY `idx_cate_is_show` (`cate_is_show`),
  KEY `idx_cate_is_list` (`cate_is_list`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目表';

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for `dic`
-- ----------------------------
DROP TABLE IF EXISTS `dic`;
CREATE TABLE `dic` (
  `key` varchar(100) NOT NULL COMMENT '字典表的key',
  `value` text COMMENT '字典表的value',
  PRIMARY KEY  (`key`),
  UNIQUE KEY `idx_dic_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of dic
-- ----------------------------

-- ----------------------------
-- Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` varchar(32) NOT NULL,
  `cate_id_fk` varchar(32) NOT NULL COMMENT '栏目ID',
  `cate_type_fk` varchar(32) NOT NULL COMMENT '栏目类型、文章类型（没太大用处）',
  `title` varchar(500) default NULL COMMENT '标题',
  `author` varchar(100) default NULL COMMENT '发布人',
  `source` varchar(100) default NULL COMMENT '来源',
  `publish_time` datetime default NULL COMMENT '发布时间',
  `update_time` datetime default NULL COMMENT '修改时间',
  `out_link` varchar(100) default NULL COMMENT '外链地址（如果非空，直接跳转到对应的连接地址）',
  `is_show_index` tinyint(4) default '1' COMMENT '是否首页显示0=否 1=是',
  `is_show_list` tinyint(4) default '1' COMMENT '是否列表也显示0=否，1=是',
  `is_valid` tinyint(4) default NULL COMMENT '是否有效，0=已经删除 1=有效',
  `is_foucs` tinyint(4) default '0' COMMENT '是否为焦点图1=是 0=否',
  `foucs_img` varchar(100) default NULL COMMENT '如果is_foucs=1，foucs_img必须有值（默认从中正文中获取第一张图片）',
  `summary` varchar(500) default NULL COMMENT '摘要信息',
  `content` text COMMENT '正文内容',
  KEY `idx_post_id` (`id`),
  KEY `idx_post_cate_id_fk` (`cate_id_fk`),
  KEY `idx_post_cate_type_fk` (`cate_type_fk`),
  KEY `idx_post_show_index` (`is_show_index`),
  KEY `idx_post_show_list` (`is_show_list`),
  KEY `idx_post_is_valid` (`is_valid`),
  KEY `idx_post_is_foucs` (`is_foucs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章内容';

-- ----------------------------
-- Records of post
-- ----------------------------

#20140407#
ALTER TABLE `category`
ADD COLUMN `cate_has_children`  tinyint NULL DEFAULT 0 COMMENT '是否有孩子 1=是 0=否' AFTER `cate_is_list`;

