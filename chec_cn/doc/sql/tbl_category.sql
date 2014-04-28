/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : chec_cn

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2014-04-27 23:04:55
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
  `showindex` tinyint(1) default '1' COMMENT '是否首页显示1=是 0=否',
  `showintree` tinyint(1) default '1' COMMENT '是否显示在树形菜单中 1=是 0=否',
  `treeorder` int(11) default NULL COMMENT '分类树的排序，越小越靠前',
  `categoryorder` int(10) default '0' COMMENT '分类排序，越小越靠前',
  `parentid` varchar(32) NOT NULL default '0' COMMENT '父ID。根默认为0',
  `categorytype` varchar(32) default NULL COMMENT '分类所属的类型,例如本次为新闻分类等',
  `categoryimage` varchar(100) default NULL COMMENT '分类图片',
  `categoryflash` varchar(100) default NULL COMMENT '分类对应的flash',
  `hasChild` tinyint(1) default '0' COMMENT '是否有子分类 1=是 0=否',
  `categorytime` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`id`),
  KEY `idx_category_id` (`id`),
  KEY `idx_category_type` (`categorytype`),
  KEY `idx_category_pid` (`parentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类信息';

-- ----------------------------
-- Records of tbl_category
-- ----------------------------
INSERT INTO `tbl_category` VALUES ('2ea6Jv', '新能源技术', '新能源技术', 'XINNENGYUANJISHU', '新能源技术', '1', '1', '1', '0', '3', 'bEzInu', 'BUSINESS', null, null, '0', '2014-04-12 18:59:35');
INSERT INTO `tbl_category` VALUES ('3I7RZj', '精神文明', '精神文明', 'JINGSHENWENMING', '精神文明', '0', '1', '1', '0', '2', 'v6vIBv', 'CULTURE', null, null, '0', '2014-04-12 23:52:10');
INSERT INTO `tbl_category` VALUES ('6ZBZRj', '公司新闻', '公司新闻', 'GONGSIXINWEN', '公司新闻', '0', '1', '1', '0', '2', 'yQBjMz', 'NEWS', null, null, '0', '2014-04-12 18:54:24');
INSERT INTO `tbl_category` VALUES ('7famEv', '公司业务', '公司业务', 'GONGSIYEWU', '公司业务', '0', '1', '1', '0', '1', 'ni6nIv', 'LINKS', null, null, '0', '2014-04-13 12:59:49');
INSERT INTO `tbl_category` VALUES ('a2IBbi', '人才政策', '人才政策', 'RENCAIZHENGCE', '人才政策', '1', '1', '1', '0', '1', 'A7buqq', 'HR', null, null, '0', '2014-04-12 23:57:28');
INSERT INTO `tbl_category` VALUES ('A7buqq', '人力资源', '人力资源', 'HR', '人力资源', '0', '1', '1', '0', '0', '0', 'HR', null, null, '1', '2014-04-12 23:56:43');
INSERT INTO `tbl_category` VALUES ('ayuuAf', '法规制度', '法规制度', 'FAGUIZHIDU', '法规制度', '0', '1', '1', '0', '3', 'U3IRBr', 'JCSJ', null, null, '0', '2014-04-27 18:00:32');
INSERT INTO `tbl_category` VALUES ('beYjum', '资质荣誉', '资质荣誉', 'ZIZHIRONGYU', '华电工程已通过ISO9001, ISO14001, OHSAS18001体系认证，具有进出口权和外经权及对外承包工程经营资格，是国家级高新技术企业和3A级信用等级单位。\r\n    华电工程具有《工程设计资质(甲级)》、《工程咨询单位资格(甲级)》证书；具有专业级和甲级《监理单位资质等级证书》。华电工程已在电力、环保、新能源建设等领域申请了149项技术专利，其中发明专利16项。', '1', '1', '1', '0', '5', 'n6vMje', 'INTRODUCE', null, null, '1', '2014-04-12 18:21:53');
INSERT INTO `tbl_category` VALUES ('bEzInu', '业务概况', '业务概况', 'BUSINESS', '&nbsp;&nbsp;&nbsp; &nbsp;业务概况华电华电工程主要从事重工、环保水务、工程总承包、、清洁能源、能源服务五大板块业务，产品和服务涵盖电力、煤炭、石油、化工、冶金、矿山、建材、市政、 港口、进出口贸易等十多个领域，遍布全国31个省、市、自治区，并出口到欧美及东南亚的十多个国家和地区。公司自主研制的长距离曲线胶带机、管状带式输送 机、全封闭大储量圆型料场、卸船机、大流量水处理设备、火电厂烟气脱硫脱硝设备等产品，在国内享有较高声誉。', '0', '1', '1', '0', '0', '0', 'BUSINESS', null, null, '1', '2014-04-12 18:55:48');
INSERT INTO `tbl_category` VALUES ('BfAR7j', '公司业绩', '公司业绩', 'PERFORMANCE', '公司业绩', '0', '1', '1', '0', '0', '0', 'PERFORMANCE', null, null, '1', '2014-04-12 19:03:10');
INSERT INTO `tbl_category` VALUES ('BZnInm', '环保水务', '环保水务', 'HUANBAOSHUIWU', '环保水务', '1', '1', '1', '0', '2', 'bEzInu', 'BUSINESS', null, null, '1', '2014-04-12 18:59:18');
INSERT INTO `tbl_category` VALUES ('BZzuMv', '成员企业', '成员企业', 'CHENGYUANQIYE', '成员企业', '0', '1', '1', '0', '2', 'ni6nIv', 'LINKS', null, null, '0', '2014-04-13 13:00:03');
INSERT INTO `tbl_category` VALUES ('eiUBrm', '工会活动', '工会活动', 'GONGHUIHUODONG', '工会活动', '0', '1', '1', '0', '4', 'v6vIBv', 'CULTURE', null, null, '0', '2014-04-12 23:52:46');
INSERT INTO `tbl_category` VALUES ('FnQNjm', '要闻快递', '要闻快递', 'YAOWENKUAIDI', '要闻快递', '0', '1', '1', '0', '1', 'yQBjMz', 'NEWS', null, null, '0', '2014-04-12 18:54:14');
INSERT INTO `tbl_category` VALUES ('FNZF3m', '工程管理部', '工程管理部', 'GONGCHENGGUANLIBU', '工程管理部', '0', '1', '1', '0', '1', 'vYN7b2', 'DEPT', null, null, '0', '2014-04-13 10:47:28');
INSERT INTO `tbl_category` VALUES ('fYjAza', '公司领导', '公司领导', 'GONGSILINGDAO', '公司领导', '1', '1', '1', '0', '2', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:15:55');
INSERT INTO `tbl_category` VALUES ('Fz2Avm', '博士后工作站', '博士后工作站', 'BOSHIHOUGONGZUOZHAN', '博士后工作站', '1', '1', '1', '0', '2', 'A7buqq', 'HR', null, null, '0', '2014-04-12 23:57:50');
INSERT INTO `tbl_category` VALUES ('iAbEFn', '企业理念', '企业理念', 'QIYELINIAN', '企业理念', '1', '1', '1', '0', '1', 'v6vIBv', 'CULTURE', null, null, '0', '2014-04-12 23:51:53');
INSERT INTO `tbl_category` VALUES ('iiuaue', '国内主要业绩', '国内主要业绩', 'GUONEIZHUYAOYEJI', '国内主要业绩', '0', '1', '1', '0', '1', 'BfAR7j', 'PERFORMANCE', null, null, '0', '2014-04-12 19:05:46');
INSERT INTO `tbl_category` VALUES ('iuMreq', '能源技术研究与服务', '能源技术研究与服务', 'NENGYUANJISHUYANJIUYUFUWU', '能源技术研究与服务', '0', '1', '1', '0', '5', 'bEzInu', 'BUSINESS', null, null, '0', '2014-04-12 19:00:28');
INSERT INTO `tbl_category` VALUES ('jmEZZ3', '工程总承包', '工程总承包', 'GONGCHENGZONGCHENGBAO', '工程总承包', '0', '1', '1', '0', '4', 'bEzInu', 'BUSINESS', null, null, '0', '2014-04-12 18:59:55');
INSERT INTO `tbl_category` VALUES ('m6v2Iv', '华电集团简介', '华电集团简介', 'HUADIANJITUANJIANJIE', '华电集团简介', '1', '1', '1', '0', '8', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:23:10');
INSERT INTO `tbl_category` VALUES ('MrYJJ3', '案例分析', '案例分析', 'ANLIFENXI', '案例分析', '0', '1', '1', '0', '2', 'U3IRBr', 'JCSJ', null, null, '0', '2014-04-27 18:00:21');
INSERT INTO `tbl_category` VALUES ('MVRR3m', '监审动态', '监审动态', 'JIANSHENDONGTAI', '监审动态', '0', '1', '1', '0', '1', 'U3IRBr', 'JCSJ', null, null, '0', '2014-04-27 17:59:55');
INSERT INTO `tbl_category` VALUES ('n6vMje', '公司简介', '公司简介', 'INTRODUCE', '公司简介', '0', '1', '1', '0', '0', '0', 'INTRODUCE', null, null, '1', '2013-05-29 09:19:44');
INSERT INTO `tbl_category` VALUES ('ni6nIv', '链接', '链接', 'LINKS', '链接', '0', '1', '1', '0', '0', '0', 'LINKS', null, null, '1', '2014-04-13 12:57:28');
INSERT INTO `tbl_category` VALUES ('nMjQBz', '组织结构', '组织结构', 'ZUZHIJIEGOU', '组织结构', '1', '1', '1', '0', '3', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:20:55');
INSERT INTO `tbl_category` VALUES ('QBZZRv', '党建工作', '党建工作', 'DANGJIANGONGZUO', '党建工作', '0', '1', '1', '0', '3', 'v6vIBv', 'CULTURE', null, null, '0', '2014-04-12 23:52:24');
INSERT INTO `tbl_category` VALUES ('r2AnMz', '主要经营范围', '主要经营范围', 'ZHUYAOJINGYINGFANWEI', '主要经营范围', '1', '1', '1', '0', '7', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:22:54');
INSERT INTO `tbl_category` VALUES ('raY7fe', '水务', '水务', 'SHUIWU', '水务', '1', '1', '1', '0', '2', 'BZnInm', 'BUSINESS', null, null, '0', '2014-04-12 19:01:26');
INSERT INTO `tbl_category` VALUES ('RF3qey', '总经理工作部', '总经理工作部', 'ZONGJINGLIGONGZUOBU', '总经理工作部', '0', '1', '1', '0', '2', 'vYN7b2', 'DEPT', null, null, '0', '2014-04-13 10:47:50');
INSERT INTO `tbl_category` VALUES ('rqYFF3', '相关链接', '相关链接', 'XIANGGUANLIANJIE', '相关链接', '0', '1', '1', '0', '3', 'ni6nIv', 'LINKS', null, null, '0', '2014-04-13 13:00:14');
INSERT INTO `tbl_category` VALUES ('rUvARv', '首页', '首页', 'SHOUYE', '首页', '0', '1', '1', '0', '0', '0', 'INDEX', null, null, '0', '2013-05-29 09:19:44');
INSERT INTO `tbl_category` VALUES ('U3IRBr', '监察审计', '监察审计', 'JCSJ', '监察审计', '0', '1', '1', '0', '0', '0', 'JCSJ', null, null, '1', '2014-04-12 23:56:43');
INSERT INTO `tbl_category` VALUES ('UJrAf2', '华电重工', '华电重工', 'HUADIANZHONGGONG', '华电重工', '1', '1', '1', '0', '1', 'bEzInu', 'BUSINESS', null, null, '0', '2014-04-12 18:58:29');
INSERT INTO `tbl_category` VALUES ('UnMFny', '国外主要业绩', '国外主要业绩', 'GUOWAIZHUYAOYEJI', '国外主要业绩', '1', '1', '1', '0', '2', 'BfAR7j', 'PERFORMANCE', null, null, '0', '2014-04-12 19:06:00');
INSERT INTO `tbl_category` VALUES ('v6vIBv', '企业文化', '企业文化', 'CULTURE', '企业文化', '0', '1', '1', '0', '0', '0', 'CULTURE', null, null, '1', '2014-04-12 23:50:58');
INSERT INTO `tbl_category` VALUES ('V7VVre', '公司资质', '公司资质', 'GONGSIZIZHI', '公司资质', '0', '1', '1', '0', '1', 'beYjum', 'INTRODUCE', null, null, '0', '2014-04-12 18:31:47');
INSERT INTO `tbl_category` VALUES ('VbAZ7v', '团青工作', '团青工作', 'TUANQINGGONGZUO', '团青工作', '0', '1', '1', '0', '5', 'v6vIBv', 'CULTURE', null, null, '0', '2014-04-12 23:53:01');
INSERT INTO `tbl_category` VALUES ('VBvABv', '公司介绍', '公司介绍', 'GONGSIJIESHAO', '公司介绍', '1', '1', '1', '0', '1', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:11:41');
INSERT INTO `tbl_category` VALUES ('vYN7b2', '招聘部门', '招聘部门', 'DEPT', '招聘部门', '0', '1', '1', '0', '0', '0', 'DEPT', null, null, '1', '2014-04-13 10:42:15');
INSERT INTO `tbl_category` VALUES ('yQBjMz', '公司新闻', '公司新闻', 'NEWS', '公司新闻', '0', '1', '1', '0', '0', '0', 'NEWS', null, null, '0', '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('yyMNj2', '公司荣誉', '公司荣誉', 'GONGSIRONGYU', '公司荣誉', '0', '1', '1', '0', '2', 'beYjum', 'INTRODUCE', null, null, '0', '2014-04-12 18:31:59');
INSERT INTO `tbl_category` VALUES ('Z3eeMf', '环保', '环保', 'HUANBAO', '环保', '1', '1', '1', '0', '1', 'BZnInm', 'BUSINESS', null, null, '0', '2014-04-12 19:01:15');
INSERT INTO `tbl_category` VALUES ('ZjMb22', '发展战略', '发展战略', 'FAZHANZHANLVE', '发展战略', '1', '1', '1', '0', '4', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:21:26');
INSERT INTO `tbl_category` VALUES ('ZV3Aby', '发展历程', '发展历程', 'FAZHANLICHENG', '发展历程', '1', '1', '1', '0', '6', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:22:38');
