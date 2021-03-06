/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : innerweb

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2013-06-09 07:28:51
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
INSERT INTO `tbl_category` VALUES ('2iA3Mj', '杂志', '杂志', 'zazhi', '', '0', '0', '0', 'RrEvqi', 'library', null, '2013-06-08 14:08:18');
INSERT INTO `tbl_category` VALUES ('2meuyy', '友情链接', '友情链接', 'friendlyLinks', '友情链接', '0', '1', '0', '0', 'friendlyLinks', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('2UNv6v', '分布式能源', '分布式能源', 'fenbushinengyuan', '', '0', '1', '2', 'QRZrUb', 'library', '', '2013-06-03 15:58:32');
INSERT INTO `tbl_category` VALUES ('3u6rmu', '煤炭清洁利用研发中心', '煤炭清洁利用', 'mtqjlyyfzx', '煤炭清洁利用研发中心', '0', '1', '8', 'm226Ff', 'news', null, '2013-05-20 11:09:00');
INSERT INTO `tbl_category` VALUES ('6JJVnm', '集团部门', '集团部门', 'dept', '集团部门', '0', '0', '0', '0', 'dept', null, null);
INSERT INTO `tbl_category` VALUES ('7B7rIb', '政府部门', '政府部门', 'gv', '政府部门', '0', '0', '11', '2meuyy', 'friendlyLinks', null, '2013-05-16 16:30:25');
INSERT INTO `tbl_category` VALUES ('7bym6z', '应急管理', '应急管理', 'yingjiguanli', '应急管理', '0', '1', '2', 'YfQB7r', 'safe', null, '2013-06-08 16:29:46');
INSERT INTO `tbl_category` VALUES ('7VNzE3', '煤炭煤化工', '煤炭煤化工', 'meitanmeihuagong', '', '0', '1', '6', 'QRZrUb', 'library', '', '2013-06-03 15:59:11');
INSERT INTO `tbl_category` VALUES ('7ZRfUz', '储能', '储能', 'chuneng', '', '0', '1', '10', 'QRZrUb', 'library', '', '2013-06-03 16:32:33');
INSERT INTO `tbl_category` VALUES ('ABfyUz', '系统经验', '系统经验', 'xitongjingyan', '系统经验', '0', '1', '4', 'YfQB7r', 'safe', null, '2013-06-08 16:30:13');
INSERT INTO `tbl_category` VALUES ('aEbAva', '汽车', '汽车', 'qiche', '', '0', '1', '12', 'QRZrUb', 'library', '', '2013-06-03 16:32:48');
INSERT INTO `tbl_category` VALUES ('aENvee', '页岩气研发中心', '页岩气', 'yyqyfzx', '页岩气研发中心', '0', '1', '7', 'm226Ff', 'news', null, '2013-05-20 11:08:32');
INSERT INTO `tbl_category` VALUES ('bamMBf', '政策、规划', '政策、规划', 'zhengce、guihua', '', '0', '1', '4', '0', 'library', '', '2013-06-03 15:33:52');
INSERT INTO `tbl_category` VALUES ('BbeYfq', '图书选荐', '图书', 'tushuxuanjian', '', '0', '1', '12', '0', 'library', '', '2013-06-03 15:36:37');
INSERT INTO `tbl_category` VALUES ('Bbq6n2', '综合管理部', '综合管理部', 'zongheguanlibu', '综合管理部', '0', '1', '2', 'm226Ff', 'news', null, '2013-05-20 11:06:33');
INSERT INTO `tbl_category` VALUES ('beu6Nv', '视频链接', '视频链接', 'ofenLinksVidos', '视频链接', '0', '1', '2', 'memAvy', 'ofenLinks', null, '2013-05-25 10:12:01');
INSERT INTO `tbl_category` VALUES ('BfqeYz', '新闻媒体', '新闻媒体', 'xwmt', '', '0', '0', '8', '2meuyy', 'friendlyLinks', null, '2013-05-21 09:17:56');
INSERT INTO `tbl_category` VALUES ('BNZ7ze', '集团要求', '集团要求', 'jituanyaoqiu', '集团要求', '0', '1', '3', 'YfQB7r', 'safe', null, '2013-06-08 16:29:59');
INSERT INTO `tbl_category` VALUES ('bY3Uju', '公司通知公告', '公司通知公告', 'gongsiNotices', '公司通知公告', '0', '1', '1', 'E7FFN3', 'notices', null, '2013-05-20 11:00:57');
INSERT INTO `tbl_category` VALUES ('E7FFN3', '通知公告', '通知公告', 'notices', '通知公告', '0', '1', '0', '0', 'notices', null, null);
INSERT INTO `tbl_category` VALUES ('ea6rQf', '新能源', '新能源', 'xinnengyuan', '', '0', '1', '8', 'QRZrUb', 'library', '', '2013-06-03 15:59:46');
INSERT INTO `tbl_category` VALUES ('eaAr6j', '行业权威机构、网站', '行业机构、网站', 'xingyequanweijigou、wangzhan', '', '0', '1', '10', '0', 'library', '', '2013-06-03 15:36:18');
INSERT INTO `tbl_category` VALUES ('FbIr6b', '国家“千人计划”专家', '“千人计划”', 'guojia“qianrenjihua”zhuanjia', '', '0', '1', '6', 'j2imAr', 'library', '', '2013-06-03 15:41:17');
INSERT INTO `tbl_category` VALUES ('fIBrmm', '能源企业', '能源企业', 'nyqy', '', '0', '0', '6', '2meuyy', 'friendlyLinks', null, '2013-05-21 09:17:35');
INSERT INTO `tbl_category` VALUES ('fUF7rm', '牛逼分类', '牛逼分类', 'niubifenlei', '牛逼分类', '0', '1', '111', '0', 'library', null, '2013-06-07 17:29:50');
INSERT INTO `tbl_category` VALUES ('i2ima2', '技经院', '技经院', '', '技经院', '0', '0', '0', '6JJVnm', 'dept', null, '2013-05-23 07:32:46');
INSERT INTO `tbl_category` VALUES ('I3meqq', '技经院', '技经院', 'jijingyuan', 'jijingyuan', '0', '1', '20', 'm226Ff', 'news', null, '2013-05-20 11:16:59');
INSERT INTO `tbl_category` VALUES ('IfM7Zz', '人力资源', '人力资源', 'renliziyuan', '人力资源', '0', '1', '4', 'm226Ff', 'news', null, '2013-05-20 11:07:11');
INSERT INTO `tbl_category` VALUES ('j2imAr', '专家简介', '专家', 'zhuanjiajianjie', '', '0', '1', '20', '0', 'library', '', '2013-06-03 15:39:30');
INSERT INTO `tbl_category` VALUES ('J3a6re', '后勤服务', '后勤服务', 'houqinfuwu', '后勤服务', '0', '1', '0', 'm226Ff', 'news', null, '2013-06-08 16:25:40');
INSERT INTO `tbl_category` VALUES ('m226Ff', '信息动态', '信息动态', 'news', '信息动态', '0', '1', '0', '0', 'news', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('m2iYBn', '科技专家', '科技专家', 'kejizhuanjia', '', '0', '1', '4', 'j2imAr', 'library', '', '2013-06-03 15:40:40');
INSERT INTO `tbl_category` VALUES ('memAvy', '常用链接', '常用链接', 'ofenLinks', '常用链接', '1', '1', '0', '0', 'ofenLinks', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('mEV3Ef', '安全规章', '安全规章', 'anquanguizhang', '安全规章', '0', '1', '5', 'YfQB7r', 'safe', null, '2013-06-08 16:30:27');
INSERT INTO `tbl_category` VALUES ('MFnU7v', '经济专家', '经济专家', 'jingjizhuanjia', '', '0', '1', '2', 'j2imAr', 'library', '', '2013-06-03 15:40:19');
INSERT INTO `tbl_category` VALUES ('MJfmQz', '支部活动', '支部活动', 'zhibuhuodong', '支部活动', '0', '1', '10', 'm226Ff', 'news', null, '2013-05-20 11:09:45');
INSERT INTO `tbl_category` VALUES ('mQZv2u', '油气', '油气', 'youqi', '', '0', '1', '4', 'QRZrUb', 'library', '', '2013-06-03 15:58:48');
INSERT INTO `tbl_category` VALUES ('mUnqii', '权威和知名期刊', '期刊', 'quanweihezhimingqikan', '', '0', '1', '6', '0', 'library', '', '2013-06-03 15:34:31');
INSERT INTO `tbl_category` VALUES ('mYre2a', '各部门内部通告', '各部门内部通告', 'deptInnerNotices', '各部门内部通告', '0', '1', '2', 'E7FFN3', 'notices', null, '2013-05-20 11:01:24');
INSERT INTO `tbl_category` VALUES ('NJ7r2y', '新闻链接', '新闻链接', 'ofenLinksNews', '新闻链接', '0', '1', '1', 'memAvy', 'ofenLinks', null, '2013-05-25 10:11:45');
INSERT INTO `tbl_category` VALUES ('NJNzQ3', '行业协会', '行业协会', 'hy', '', '0', '0', '3', '2meuyy', 'friendlyLinks', null, '2013-05-16 16:30:56');
INSERT INTO `tbl_category` VALUES ('NjQrmi', '综合管理部1', '综合管理部1', '', '综合管理部1', '0', '0', '0', '6JJVnm', 'dept', null, '2013-05-17 14:04:10');
INSERT INTO `tbl_category` VALUES ('NnEvIb', '总院快捷入口', '总院快捷入口', 'outfastentrance', '总院快捷入口', '0', '1', '0', '0', 'outfastentrance', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('Q7BJzm', '财务信息', '财务信息', 'caiwuxinxi', '财务信息', '0', '1', '5', 'm226Ff', 'news', null, '2013-05-20 11:07:27');
INSERT INTO `tbl_category` VALUES ('qQJvEz', '员工生活', '员工生活', 'yuangongshenghuo', '员工生活，显示与导航条上', '0', '1', '1', 'm226Ff', 'news', null, '2013-05-20 10:59:09');
INSERT INTO `tbl_category` VALUES ('QRZrUb', '行业研究报告', '行研报告', 'xingyeyanjiubaogao', '', '0', '1', '2', '0', 'library', '', '2013-06-03 15:32:49');
INSERT INTO `tbl_category` VALUES ('QZbM7n', '集团系统快捷入口', '集团系统快捷入口', 'infastentrance', '集团系统快捷入口', '0', '1', '0', '0', 'infastentrance', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('RB7bey', '电力杂志', 'dlzz', 'dianlizazhi', '', '0', '1', '0', '2eAFze', 'library', '', '2013-06-02 22:30:51');
INSERT INTO `tbl_category` VALUES ('RBVBVf', '分布式能源实验室', '分布式能源', 'fbsnysys', '分布式能源实验室', '0', '1', '6', 'm226Ff', 'news', null, '2013-05-20 11:08:02');
INSERT INTO `tbl_category` VALUES ('remuEb', '科研项目管理部', '科研项目管理部', 'keyanxiangmubu', '科研项目管理部', '0', '1', '3', 'm226Ff', 'news', null, '2013-05-20 11:06:55');
INSERT INTO `tbl_category` VALUES ('rm6nQv', '专题活动', '专题活动', 'zhuantihuodong', '专题活动', '0', '1', '11', 'm226Ff', 'news', null, '2013-05-20 11:10:01');
INSERT INTO `tbl_category` VALUES ('RrEj2y', '华电系统资料', '华电资料', 'huadianxitongziliao', '', '0', '1', '14', '0', 'library', '', '2013-06-03 15:37:03');
INSERT INTO `tbl_category` VALUES ('RrEvqi', '每月科技一讲', '每月一讲', 'meiyuekejiyijiang', '', '0', '1', '16', '0', 'library', '', '2013-06-03 15:37:44');
INSERT INTO `tbl_category` VALUES ('RveU73', '总院活动', '总院活动', 'zongyuanhuodong', '总院活动', '0', '1', '1', 'YfQB7r', 'safe', null, '2013-06-08 16:29:30');
INSERT INTO `tbl_category` VALUES ('UJNFZf', '34', '34', '34', '34', '0', '0', '34', 'NNFz6b', 'library', null, '2013-06-01 17:27:43');
INSERT INTO `tbl_category` VALUES ('Uvuyqy', '科研项目管理部', '科研项目管理部', '', '科研项目管理部', '0', '0', '0', '6JJVnm', 'dept', null, '2013-05-23 07:32:30');
INSERT INTO `tbl_category` VALUES ('vqMn2i', '安全法规', '安全法规', 'anquanfazhang', '安全法规', '0', '1', '6', 'YfQB7r', 'safe', null, '2013-06-08 16:30:41');
INSERT INTO `tbl_category` VALUES ('YfQB7r', '安全管理', '安全管理', 'safe', '安全管理', '0', '0', '0', '0', 'safe', null, '2013-06-08 12:12:12');
INSERT INTO `tbl_category` VALUES ('yMfAvi', '12', '12', '12', '12', '0', '1', '12', 'NNFz6b', 'library', null, '2013-06-01 17:27:35');
INSERT INTO `tbl_category` VALUES ('Z3M7Rz', '报纸', '报纸', 'baozhi', '', '0', '1', '8', '0', 'library', '', '2013-06-03 15:35:38');
INSERT INTO `tbl_category` VALUES ('zeMvu2', '总办', '总办', '', '总办', '0', '0', '0', '6JJVnm', 'dept', null, '2013-05-17 14:05:29');
INSERT INTO `tbl_category` VALUES ('ZnyyUn', '规章制度', '规章制度', 'guizhangzhidu', '规章制度', '0', '1', '1', 'm226Ff', 'news', null, '2013-06-03 07:15:20');

-- ----------------------------
-- Table structure for `tbl_library`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_library`;
CREATE TABLE `tbl_library` (
  `lib_id` varchar(32) NOT NULL,
  `lib_category_id` varchar(32) default NULL,
  `lib_type` tinyint(4) default NULL COMMENT '1、正常 2、内容 3、图片',
  `lib_name` varchar(500) default NULL,
  `lib_url` varchar(500) default NULL,
  `lib_content` text,
  `lib_image` varchar(500) default NULL,
  `lib_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_library
-- ----------------------------
INSERT INTO `tbl_library` VALUES ('qmiiae', 'mQZv2u', '1', '中华人民共和国', 'http://www.baidu.com', null, null, '2013-06-03 18:57:50');
INSERT INTO `tbl_library` VALUES ('IJFnie', 'mQZv2u', '1', '中华人民共和国', 'http://www.qq.com', null, null, '2013-06-03 18:57:44');
INSERT INTO `tbl_library` VALUES ('QBjyeq', '2UNv6v', '1', '郑州生物中心', 'http://www.qq.com', null, null, '2013-06-03 18:57:38');
INSERT INTO `tbl_library` VALUES ('MjAnM3', '7VNzE3', '1', '郑州生物中心', 'http://www.qq.com', null, null, '2013-06-03 18:57:29');
INSERT INTO `tbl_library` VALUES ('mMfIvy', '2UNv6v', '1', '郑州生物中心', 'http://www.qq.com', null, null, '2013-06-03 18:57:21');
INSERT INTO `tbl_library` VALUES ('ZR3Qre', '2UNv6v', '2', '自定义内容', null, '自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容', null, '2013-06-03 18:57:14');
INSERT INTO `tbl_library` VALUES ('vANzaq', '2UNv6v', '1', '切切切切切切切切切切切切切切切切去', 'http://www.baidu.com', null, null, '2013-06-07 17:54:45');
INSERT INTO `tbl_library` VALUES ('QNVZjy', '2UNv6v', '1', '网秦新闻1', 'asdfasdf', null, null, '2013-06-07 17:54:57');
INSERT INTO `tbl_library` VALUES ('qmqM73', '2UNv6v', '1', '网秦新闻1', 'asdfasdfadsfadsf', null, null, '2013-06-07 17:55:05');
INSERT INTO `tbl_library` VALUES ('R3Qv2u', '2UNv6v', '1', 'asdfasdfadsfasdfasdfasdf', 'asdfasdfasdfasdfasdf', null, null, '2013-06-07 17:55:14');
INSERT INTO `tbl_library` VALUES ('aaeERb', '2UNv6v', '1', 'asdfasdfadsfasdfasdfasdf', 'asdfasdfadfadfadsfasdf', null, null, '2013-06-07 17:55:21');
INSERT INTO `tbl_library` VALUES ('bmEfau', '2UNv6v', '1', '撒大大发的发生的范德萨发方大', 'asdfasdfasdfasdfadsfasdf', null, null, '2013-06-07 17:55:38');
INSERT INTO `tbl_library` VALUES ('Qny2a2', '2UNv6v', '1', 'asdfa阿斯顿发撒旦法撒旦法撒旦法', 'afadsfadfadfadfasdf', null, null, '2013-06-07 17:55:49');
INSERT INTO `tbl_library` VALUES ('jI3mim', '2UNv6v', '1', '阿斯顿发撒旦法撒旦法撒旦法阿斯顿发撒旦法撒旦法撒旦法阿斯顿发撒旦法撒旦法撒旦法阿斯顿发撒旦法撒旦法撒旦法', 'asdfasdfadfadfadf', null, null, '2013-06-07 18:12:24');
INSERT INTO `tbl_library` VALUES ('7jy222', '2iA3Mj', '1', '杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志', 'http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack', null, null, '2013-06-08 14:08:33');
INSERT INTO `tbl_library` VALUES ('EJNBFb', '2iA3Mj', '1', '杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志', 'http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack', null, null, '2013-06-08 14:08:43');
INSERT INTO `tbl_library` VALUES ('Fbai2y', '2iA3Mj', '1', '杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志', 'http://www.qq.com', null, null, '2013-06-08 14:08:53');
INSERT INTO `tbl_library` VALUES ('vyEVry', '2iA3Mj', '1', '杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志杂志', 'http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack', null, null, '2013-06-08 14:09:01');

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
INSERT INTO `tbl_links` VALUES ('2U7BRv', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:23');
INSERT INTO `tbl_links` VALUES ('3aaMZz', '搜狐网', 'http://www.sohu.com', 'NJ7r2y', 'ofenLinks', null, '2', '1', '2013-05-25 02:12:29');
INSERT INTO `tbl_links` VALUES ('3meiM3', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:28');
INSERT INTO `tbl_links` VALUES ('ABBJ3q', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:33');
INSERT INTO `tbl_links` VALUES ('AfyYvi', '技经院', 'http://emial.comqqqq', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:53:04');
INSERT INTO `tbl_links` VALUES ('b2ErMz', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:20');
INSERT INTO `tbl_links` VALUES ('ba6JBv', '999999', '999999999999', '', 'friendlyLinks', null, '999', '1', '2013-05-25 17:04:42');
INSERT INTO `tbl_links` VALUES ('BbmYN3', '243234', '234234', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-05-25 16:53:54');
INSERT INTO `tbl_links` VALUES ('bUF3Iv', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:18');
INSERT INTO `tbl_links` VALUES ('Bvm6re', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:34');
INSERT INTO `tbl_links` VALUES ('BZnQNb', '新浪网', 'http://www.sina.com.cn', 'NJ7r2y', 'ofenLinks', null, '1', '1', '2013-05-25 02:12:18');
INSERT INTO `tbl_links` VALUES ('E3qy22', '测试URL', 'http://emial.comqqqq', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:52:49');
INSERT INTO `tbl_links` VALUES ('eaMVfy', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:27');
INSERT INTO `tbl_links` VALUES ('EBNj6j', '网易网', 'http://www.163.com', 'NJ7r2y', 'ofenLinks', null, '3', '1', '2013-05-25 02:12:45');
INSERT INTO `tbl_links` VALUES ('EBRr2y', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:21');
INSERT INTO `tbl_links` VALUES ('eIzEF3', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:30');
INSERT INTO `tbl_links` VALUES ('EJjai2', '技经院', 'http://emial.comqqqq', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:53:01');
INSERT INTO `tbl_links` VALUES ('EjQRr2', '技经院', 'http://emial.comqqqq', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:53:03');
INSERT INTO `tbl_links` VALUES ('ENJFje', '邮件系统', '#', 'NnEvIb', 'outfastentrance', null, '1', '1', '2013-05-21 01:06:05');
INSERT INTO `tbl_links` VALUES ('EzuIR3', '技经院', 'http://emial.comqqqq', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:52:59');
INSERT INTO `tbl_links` VALUES ('F3UZBn', '科技成果发布(在建)', '#', 'NnEvIb', 'outfastentrance', null, '7', '1', '2013-05-21 01:07:36');
INSERT INTO `tbl_links` VALUES ('FB7N7r', 'zfbm1', 'http://emial.com', '2meuyy', 'friendlyLinks', null, '1', '1', '2013-05-16 11:14:02');
INSERT INTO `tbl_links` VALUES ('fIBJBj', '视频会议系统(在建)', '#', 'NnEvIb', 'outfastentrance', null, '3', '1', '2013-05-21 01:06:42');
INSERT INTO `tbl_links` VALUES ('FJJzYb', '乐视网', 'http://www.letv.com', 'beu6Nv', 'ofenLinks', null, '2', '1', '2013-05-25 02:13:09');
INSERT INTO `tbl_links` VALUES ('FJnyUv', '优酷网', 'http://www.youku.com', 'beu6Nv', 'ofenLinks', null, '1', '1', '2013-05-25 02:13:00');
INSERT INTO `tbl_links` VALUES ('FR36by', '中国新能源中国新能源', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:52:21');
INSERT INTO `tbl_links` VALUES ('iINvMf', '档案管理系统(在建)', '#', 'NnEvIb', 'outfastentrance', null, '5', '1', '2013-05-21 01:07:11');
INSERT INTO `tbl_links` VALUES ('iIRRZv', '4545', '45454', '', 'friendlyLinks', null, '4545', '1', '2013-05-25 17:04:42');
INSERT INTO `tbl_links` VALUES ('iQFzay', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:17');
INSERT INTO `tbl_links` VALUES ('iUvyAr', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:23');
INSERT INTO `tbl_links` VALUES ('Ivq2Mr', '集团通讯录', '#', 'QZbM7n', 'infastentrance', null, '0', '1', '2013-05-21 01:09:19');
INSERT INTO `tbl_links` VALUES ('jaqEvm', '后勤服务(在建)', 'pl-news-j3a6re.htm', 'NnEvIb', 'outfastentrance', null, '6', '1', '2013-06-08 16:26:57');
INSERT INTO `tbl_links` VALUES ('JB7fYr', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:52:30');
INSERT INTO `tbl_links` VALUES ('JfQR3q', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:24');
INSERT INTO `tbl_links` VALUES ('jyMJJf', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:31');
INSERT INTO `tbl_links` VALUES ('JZbYje', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:33');
INSERT INTO `tbl_links` VALUES ('Mfquum', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:25');
INSERT INTO `tbl_links` VALUES ('mYbumm', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:35');
INSERT INTO `tbl_links` VALUES ('MzaYbu', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:32');
INSERT INTO `tbl_links` VALUES ('MZnYfq', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:14');
INSERT INTO `tbl_links` VALUES ('N3iA3u', '技经院', 'http://emial.comqqqq', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:53:06');
INSERT INTO `tbl_links` VALUES ('NVN3Az', '技经院', 'http://emial.comqqqq', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:53:07');
INSERT INTO `tbl_links` VALUES ('Qnmyma', '土豆网', 'http://www.tudou.com', 'beu6Nv', 'ofenLinks', null, '3', '1', '2013-05-25 02:13:21');
INSERT INTO `tbl_links` VALUES ('QRvmIn', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:18');
INSERT INTO `tbl_links` VALUES ('qyMZFv', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:36');
INSERT INTO `tbl_links` VALUES ('qYV7Zv', '集团信息门户', '#', 'QZbM7n', 'infastentrance', null, '1', '1', '2013-05-21 01:09:35');
INSERT INTO `tbl_links` VALUES ('R3qMNj', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:20');
INSERT INTO `tbl_links` VALUES ('RnYb6n', '通讯录', 'mg/home.htm?opt=contact', 'NnEvIb', 'outfastentrance', null, '0', '1', '2013-05-25 02:16:41');
INSERT INTO `tbl_links` VALUES ('RR7bae', '技经院', 'http://emial.comqqqq', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:52:56');
INSERT INTO `tbl_links` VALUES ('U7Vzie', '安全管理', 'safe.htm', 'NnEvIb', 'outfastentrance', null, '0', '1', '2013-06-08 16:27:51');
INSERT INTO `tbl_links` VALUES ('UbuMzu', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:21');
INSERT INTO `tbl_links` VALUES ('uERjA3', '换点工程', 'http://www.baidu.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 06:52:41');
INSERT INTO `tbl_links` VALUES ('UnMRZb', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:26');
INSERT INTO `tbl_links` VALUES ('VbM7nm', '科研项目管理系统(在建)', '#', 'NnEvIb', 'outfastentrance', null, '4', '1', '2013-05-21 01:06:59');
INSERT INTO `tbl_links` VALUES ('Y7nmI3', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:30');
INSERT INTO `tbl_links` VALUES ('Zbayi2', '中国能源网', 'http://www.chec.com.cn', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-06-01 15:51:28');
INSERT INTO `tbl_links` VALUES ('zIfaAr', 'OA系统', '#', 'NnEvIb', 'outfastentrance', null, '2', '1', '2013-05-21 01:06:13');
INSERT INTO `tbl_links` VALUES ('ZrIjqi', 'Google香港', 'http://www.qq.com', '7B7rIb', 'friendlyLinks', null, '0', '1', '2013-06-01 07:47:15');
INSERT INTO `tbl_links` VALUES ('zyqEru', '兄弟部门1', 'http://www.google.com.hk1', '2meuyy', 'friendlyLinks', null, '41', '0', '2013-05-17 00:19:00');

-- ----------------------------
-- Table structure for `tbl_message`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_message`;
CREATE TABLE `tbl_message` (
  `msg_id` varchar(32) NOT NULL default '',
  `msg_title` text,
  `msg_content` text,
  `msg_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  `msg_from` varchar(100) default NULL,
  `msg_to` varchar(100) default NULL,
  `msg_flag` tinyint(4) default '0' COMMENT '是否已经阅读 1=是 0=否',
  PRIMARY KEY  (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_message
-- ----------------------------
INSERT INTO `tbl_message` VALUES ('2i6Bz2', '123123', '123123', '2013-05-25 17:07:03', 'biymau', 'fUJRFr', '2');
INSERT INTO `tbl_message` VALUES ('3i6FV3', '21123', '123123', '2013-05-25 17:08:43', 'biymau', 'fUJRFr', '2');

-- ----------------------------
-- Table structure for `tbl_meta`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_meta`;
CREATE TABLE `tbl_meta` (
  `meta_name` varchar(250) NOT NULL COMMENT '标识位名字',
  `meta_value` text COMMENT '标识位名字对应的值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统所有变量的标识Map(key-value)';

-- ----------------------------
-- Records of tbl_meta
-- ----------------------------
INSERT INTO `tbl_meta` VALUES ('permit_notices', '1');
INSERT INTO `tbl_meta` VALUES ('area_1', 'bY3Uju,mYre2a');
INSERT INTO `tbl_meta` VALUES ('area_2', 'Bbq6n2,remuEb,IfM7Zz,Q7BJzm');
INSERT INTO `tbl_meta` VALUES ('area_3', 'RBVBVf,aENvee,3u6rmu,I3meqq');
INSERT INTO `tbl_meta` VALUES ('area_4', 'MJfmQz,rm6nQv');
INSERT INTO `tbl_meta` VALUES ('page_foot', '<div class=\"footer\">\r\n    <center>\r\n        <table width=\"650\" border=\"0\" cellspacing=\"0\" align=\"center\">\r\n            <tr>\r\n                <td rowspan=\"3\" width=\"75\"><img src=\"res/front/images/footer.jpg\"/></td>\r\n                <td>中国华电集团科学技术研究总院 版权所有 京ICP备05084797号 邮编：100077 传真：010-52392444</td>\r\n            </tr>\r\n            <tr>\r\n                <td>地址：北京市东城区永定门西滨河路8号院7号楼中海地产广场东塔11层 电话：010-51966891</td>\r\n            </tr>\r\n            <tr>\r\n                <td>建议使用IE6.0以上版本浏览器1024*768分辨率浏览本网站</td>\r\n            </tr>\r\n        </table>\r\n    </center>\r\n</div>');
INSERT INTO `tbl_meta` VALUES ('popular_Links', '<div class=\"body_left_1\" style=\"margin-top:10px;\">\r\n                <div class=\"body_left_tit\">\r\n                    <ul class=\"tit_biao\">\r\n                        <li><img src=\"res/front/images/left_tit_biao1.png\"/></li>\r\n                        <li style=\"padding-left:15px;\">常用链接</li>\r\n                    </ul>\r\n                </div>\r\n\r\n                <div class=\"body_left_con1\">\r\n<ul>\r\n                        <li><select name=\"\" class=\"xiala\" onclick=\"javascript:jumpLinks(this.value);\">\r\n                            <option value=\"http://www.sina.com.cn\" selected=\"selected\">------新浪------</option>\r\n                            <option value=\"http://www.163.com\" >------网易------</option>\r\n                            <option value=\"http://www.sohu.com.cn\" >------搜狐------</option>\r\n\r\n                        </select></li>\r\n                        <li><select name=\"\" class=\"xiala\" onclick=\"javascript:jumpLinks(this.value);\">\r\n                            <option value=\"http://www.sina.com.cn\" >------新浪------</option>\r\n                            <option value=\"http://www.163.com\" selected=\"selected\">------网易------</option>\r\n                            <option value=\"http://www.sohu.com.cn\" >------搜狐------</option>\r\n                        </select></li>\r\n                    </ul>\r\n                </div>\r\n            </div>');
INSERT INTO `tbl_meta` VALUES ('notices_can_see', '1');
INSERT INTO `tbl_meta` VALUES ('notices_who_can_see', 'zA3eem');

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
INSERT INTO `tbl_post` VALUES ('677jqu', 'notices', 'mYre2a', '及经办', 'biymau', 'zeMvu2', '2013-05-25 10:45:48', '1', '1', '0', '1', '0', '及经办', null, '及经办及经办及经办及经办及经办及经办');
INSERT INTO `tbl_post` VALUES ('7bMJVf', 'news', 'qQJvEz', '员工生活1', 'biymau', '', '2013-05-25 16:02:43', '0', '0', '1', '0', '0', '员工生活', null, '<p>\r\n	员工生活\r\n</p>\r\n<p>\r\n	员工生活\r\n</p>\r\n<p>\r\n	员工生活\r\n</p>\r\n<p>\r\n	员工生活\r\n</p>');
INSERT INTO `tbl_post` VALUES ('miyiAf', 'notices', 'mYre2a', '111', 'biymau', 'zeMvu2', '2013-05-26 09:23:58', '1', '1', '0', '1', '1', '1212', null, '121221');
INSERT INTO `tbl_post` VALUES ('NrEJNb', 'notices', 'mYre2a', '科技部11111', 'biymau', 'zeMvu2', '2013-05-26 09:29:27', '1', '1', '0', '1', '1', '123123123', null, '123123123123123');
INSERT INTO `tbl_post` VALUES ('QzEZfy', 'news', 'ZnyyUn', 'werwqer', 'biymau', 'zeMvu2', '2013-06-03 08:28:27', '1', '1', '0', '0', '0', 'qwerwqer', null, '<a href=\"/userfiles/file/20130603/20130603082841_117.docx\" target=\"_blank\">/userfiles/file/20130603/20130603082841_117.docx</a>\r\n<p>\r\n	&nbsp;\r\n</p>');
INSERT INTO `tbl_post` VALUES ('Ub2Q3e', 'notices', 'mYre2a', '科研公告', 'UNb63y', 'Uvuyqy', '2013-05-26 14:57:52', '1', '1', '0', '1', '1', '科研公告', null, '科研公告');
INSERT INTO `tbl_post` VALUES ('vIBNjq', 'notices', 'bY3Uju', '111111111', 'biymau', 'zeMvu2', '2013-05-25 20:01:12', '1', '0', '0', '0', '0', '1111111111111', null, '11111111111111111111111');
INSERT INTO `tbl_post` VALUES ('ZzUBV3', 'safe', 'RveU73', '1231231', 'biymau', 'zeMvu2', '2013-06-08 17:05:04', '1', '1', '0', '0', '0', '123123', null, '12313123123');

-- ----------------------------
-- Table structure for `tbl_post_read`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_post_read`;
CREATE TABLE `tbl_post_read` (
  `post_id` varchar(32) default NULL,
  `post_user_id` varchar(100) default '0' COMMENT '是否已读1=是 0=否',
  `post_read_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP COMMENT '操作时间',
  KEY `idx_post_read` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='post内容是否已经阅读';

-- ----------------------------
-- Records of tbl_post_read
-- ----------------------------
INSERT INTO `tbl_post_read` VALUES ('AFBJN3', 'biymau', '2013-05-22 23:50:35');
INSERT INTO `tbl_post_read` VALUES ('AFBJN3', '2aEJ3e', '2013-05-22 23:51:05');
INSERT INTO `tbl_post_read` VALUES ('qu6rUn', '2aEJ3e', '2013-05-22 23:55:35');
INSERT INTO `tbl_post_read` VALUES ('ruUVVv', '2aEJ3e', '2013-05-22 23:56:32');
INSERT INTO `tbl_post_read` VALUES ('73mAvq', 'biymau', '2013-05-23 00:45:20');
INSERT INTO `tbl_post_read` VALUES ('ruUVVv', 'biymau', '2013-05-23 22:56:24');
INSERT INTO `tbl_post_read` VALUES ('6JNNve', 'biymau', '2013-05-23 23:47:44');
INSERT INTO `tbl_post_read` VALUES ('677jqu', 'biymau', '2013-05-25 10:51:55');
INSERT INTO `tbl_post_read` VALUES ('677jqu', 'fUJRFr', '2013-05-25 11:23:14');
INSERT INTO `tbl_post_read` VALUES ('NrEJNb', 'biymau', '2013-05-26 13:54:27');
INSERT INTO `tbl_post_read` VALUES ('Ub2Q3e', 'biymau', '2013-05-29 17:26:04');
INSERT INTO `tbl_post_read` VALUES ('vIBNjq', 'biymau', '2013-06-01 15:31:19');
INSERT INTO `tbl_post_read` VALUES ('QvY77f', 'biymau', '2013-06-03 07:18:39');
INSERT INTO `tbl_post_read` VALUES ('7bMJVf', 'biymau', '2013-06-05 13:34:48');
INSERT INTO `tbl_post_read` VALUES ('ZzUBV3', 'biymau', '2013-06-08 17:05:16');

-- ----------------------------
-- Table structure for `tbl_rights`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_rights`;
CREATE TABLE `tbl_rights` (
  `rights_id` varchar(100) default NULL,
  `rights_name` varchar(100) default NULL,
  `rights_desc` text,
  `rights_value` text COMMENT '功能入口',
  `rights_resouce` text COMMENT '资源链接,通过","分割，允许正则表达式',
  `rights_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统权限表';

-- ----------------------------
-- Records of tbl_rights
-- ----------------------------
INSERT INTO `tbl_rights` VALUES ('EjUvEf', '个人信息管理', '个人信息管理', 'mg/user/user-psersonal-show.htm?userId=', null, '2013-05-25 13:19:26');
INSERT INTO `tbl_rights` VALUES ('JRFBFb', '新闻分类管理', '新闻分类管理', 'mg/post/news/category-list.htm', null, '2013-05-25 13:19:02');
INSERT INTO `tbl_rights` VALUES ('INRRz2', '通知公告分类管理', '通知公告分类管理', 'mg/post/notices/category-list.htm', null, '2013-05-25 13:19:05');
INSERT INTO `tbl_rights` VALUES ('nA3eqy', '总院快捷入口管理', '总院快捷入口管理', 'mg/links/outfastentrance/links-list.htm', null, '2013-05-25 13:19:07');
INSERT INTO `tbl_rights` VALUES ('meAb2q', '集团系统快捷入口管理', '集团系统快捷入口管理', 'mg/links/infastentrance/links-list.htm', null, '2013-05-25 13:19:09');
INSERT INTO `tbl_rights` VALUES ('JJneEr', '友情链接分类管理', '友情链接分类管理', 'mg/links/friendlyLinks/category-list.htm', null, '2013-05-25 13:19:11');
INSERT INTO `tbl_rights` VALUES ('U73mMj', '友情链接管理', '友情链接管理', 'mg/links/friendlyLinks/links-list.htm?categoryId=', null, '2013-05-25 13:19:29');
INSERT INTO `tbl_rights` VALUES ('V7FZ32', '常用链接分类管理', '常用链接分类管理', 'mg/links/ofenLinks/category-list.htm', null, '2013-05-25 13:18:36');
INSERT INTO `tbl_rights` VALUES ('Nz2aiu', '常用链接管理', '常用链接管理', 'mg/links/ofenLinks/links-list.htm?categoryId=', null, '2013-05-25 13:18:27');
INSERT INTO `tbl_rights` VALUES ('BZ3qIr', '站内信列表', '站内信列表', 'mg/message/message-list.htm', null, '2013-05-25 13:18:42');
INSERT INTO `tbl_rights` VALUES ('jIBbAj', '发站内信', '发站内信', 'mg/message/message-show.htm', null, '2013-05-25 11:07:04');
INSERT INTO `tbl_rights` VALUES ('63amym', '全局配置', '全局配置', 'mg/sys/sys-list.htm', null, '2013-05-25 13:18:45');
INSERT INTO `tbl_rights` VALUES ('aeYnqy', '功能权限管理', '功能权限管理', 'mg/user/rights-list.htm', null, '2013-05-25 13:18:52');
INSERT INTO `tbl_rights` VALUES ('63m2iq', '角色配置管理', '角色配置管理', 'mg/user/role-list.htm', null, '2013-05-25 13:18:54');
INSERT INTO `tbl_rights` VALUES ('ba6bIj', '系统用户配置管理', '系统用户配置管理', 'mg/user/user-list.htm', null, '2013-05-25 13:18:58');

-- ----------------------------
-- Table structure for `tbl_role`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_role`;
CREATE TABLE `tbl_role` (
  `role_id` varchar(50) default NULL,
  `role_name` varchar(100) default NULL,
  `role_desc` text,
  `role_rights_id` text COMMENT '功能权限集合，中间通过'',''分割',
  `role_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户角色管理';

-- ----------------------------
-- Records of tbl_role
-- ----------------------------
INSERT INTO `tbl_role` VALUES ('zA3eem', '超级系统管理员', '超级系统管理员', '01,01_news_J3a6re_create,01_news_J3a6re_delete,01_news_J3a6re_update,01_news_ZnyyUn_create,01_news_ZnyyUn_delete,01_news_ZnyyUn_update,01_news_qQJvEz_create,01_news_qQJvEz_delete,01_news_qQJvEz_update,01_news_Bbq6n2_create,01_news_Bbq6n2_delete,01_news_Bbq6n2_update,01_news_remuEb_create,01_news_remuEb_delete,01_news_remuEb_update,01_news_IfM7Zz_create,01_news_IfM7Zz_delete,01_news_IfM7Zz_update,01_news_Q7BJzm_create,01_news_Q7BJzm_delete,01_news_Q7BJzm_update,01_news_RBVBVf_create,01_news_RBVBVf_delete,01_news_RBVBVf_update,01_news_aENvee_create,01_news_aENvee_delete,01_news_aENvee_update,01_news_3u6rmu_create,01_news_3u6rmu_delete,01_news_3u6rmu_update,01_news_MJfmQz_create,01_news_MJfmQz_delete,01_news_MJfmQz_update,01_news_rm6nQv_create,01_news_rm6nQv_delete,01_news_rm6nQv_update,01_news_I3meqq_create,01_news_I3meqq_delete,01_news_I3meqq_update,02,02_notices_bY3Uju_create,02_notices_bY3Uju_delete,02_notices_bY3Uju_update,02_notices_bY3Uju_permit,02_notices_mYre2a_create,02_notices_mYre2a_delete,02_notices_mYre2a_update,02_notices_mYre2a_permit,12,12_safe_RveU73_create,12_safe_RveU73_delete,12_safe_RveU73_update,12_safe_7bym6z_create,12_safe_7bym6z_delete,12_safe_7bym6z_update,12_safe_BNZ7ze_create,12_safe_BNZ7ze_delete,12_safe_BNZ7ze_update,12_safe_ABfyUz_create,12_safe_ABfyUz_delete,12_safe_ABfyUz_update,12_safe_mEV3Ef_create,12_safe_mEV3Ef_delete,12_safe_mEV3Ef_update,12_safe_vqMn2i_create,12_safe_vqMn2i_delete,12_safe_vqMn2i_update,03,04,05,06,07,08,09,09,10,11', '2013-06-08 16:34:27');
INSERT INTO `tbl_role` VALUES ('JrMBRf', '管理员', '管理员（管理用户）', '01,01_news_qQJvEz_create,01_news_qQJvEz_delete,01_news_qQJvEz_update,01_news_Bbq6n2_create,01_news_Bbq6n2_delete,01_news_Bbq6n2_update,01_news_remuEb_create,01_news_remuEb_delete,01_news_remuEb_update,01_news_IfM7Zz_create,01_news_IfM7Zz_delete,01_news_IfM7Zz_update,01_news_Q7BJzm_create,01_news_Q7BJzm_delete,01_news_Q7BJzm_update,01_news_RBVBVf_create,01_news_RBVBVf_delete,01_news_RBVBVf_update,01_news_aENvee_create,01_news_aENvee_delete,01_news_aENvee_update,01_news_3u6rmu_create,01_news_3u6rmu_delete,01_news_3u6rmu_update,01_news_MJfmQz_create,01_news_MJfmQz_delete,01_news_MJfmQz_update,01_news_rm6nQv_create,01_news_rm6nQv_delete,01_news_rm6nQv_update,01_news_I3meqq_create,01_news_I3meqq_delete,01_news_I3meqq_update,02,02_notices_mYre2a_create,02_notices_mYre2a_delete,02_notices_mYre2a_update,02_notices_mYre2a_permit,08,09', '2013-05-31 11:56:42');
INSERT INTO `tbl_role` VALUES ('rYBVfy', '国产', 'sfd', '01_qQJvEz_create,01_qQJvEz_delete,01_qQJvEz_update,01_Bbq6n2_delete,01_Bbq6n2_update,01_remuEb_delete,01_remuEb_update,01_IfM7Zz_delete,01_IfM7Zz_update,01_Q7BJzm_create,01_Q7BJzm_delete,01_Q7BJzm_update,01_RBVBVf_create,01_RBVBVf_delete,01_RBVBVf_update,01_aENvee_create,01_aENvee_delete,01_aENvee_update,01_3u6rmu_create,01_3u6rmu_delete,01_3u6rmu_update,01_MJfmQz_create,01_MJfmQz_delete,01_MJfmQz_update,01_rm6nQv_create,01_rm6nQv_delete,01_rm6nQv_update,01_I3meqq_create,01_I3meqq_delete,01_I3meqq_update,02,02_bY3Uju_create,02_bY3Uju_delete,02_bY3Uju_update,02_bY3Uju_permit,02_mYre2a_create,02_mYre2a_delete,02_mYre2a_update,02_mYre2a_permit,03,04,05,06,07,08,09', '2013-05-25 18:42:28');

-- ----------------------------
-- Table structure for `tbl_user`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `user_id` varchar(100) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_passwd` varchar(500) NOT NULL,
  `user_nickname` varchar(100) default NULL,
  `user_phone` varchar(100) default NULL,
  `user_mobile` varchar(100) default NULL,
  `user_email` varchar(100) default NULL,
  `user_address` text,
  `user_dept_id` varchar(100) default NULL,
  `user_role_id` varchar(100) default NULL,
  `user_islive` tinyint(4) default '0' COMMENT '是否激活 1=是 0=否',
  `user_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  `user_nicknamepinyin` varchar(500) default NULL COMMENT '昵称拼音',
  `user_showorder` int(11) default '0' COMMENT '用户显示顺序',
  `user_isincontact` tinyint(4) default '1' COMMENT '是否显示在通讯录中1=是 0=否',
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('2aEJ3e', 'testjjy', 'd3ee17c56c580eefcf0d8ee57bcfea24bdeb2c5719f1d0f7', 'test-技经院', '', '12123123211', '', '', 'i2ima2', 'zA3eem', '1', '2013-06-01 15:28:10', 'TEST-jijingyuan', '4', '1');
INSERT INTO `tbl_user` VALUES ('biymau', 'admin', '3bac8cc87db33021623d0d88a287982a5845b3c1989b620c', '测试超级系统管理员', '12311', '12123123211', '12311', '123111', 'zeMvu2', 'zA3eem', '1', '2013-06-03 16:26:32', 'ceshichaojixitongguanliyuan', '0', '0');
INSERT INTO `tbl_user` VALUES ('fUJRFr', 'keji', 'cd3424bbc0ae5ec3157d5460e0a367298122f5d9cfdfd97d', '科技管理', '', '1234567', '', '', 'Uvuyqy', 'zA3eem', '1', '2013-06-03 16:26:55', 'kejiguanli', '8', '1');
INSERT INTO `tbl_user` VALUES ('UNb63y', 'zhouyang', 'dec6844dcb3d95770e74a8cfe9906c46da9726aff05388f012f855b6a39724d3', '周杨', '', '15011150369', '', '', 'Uvuyqy', 'zA3eem', '1', '2013-06-03 16:27:01', 'zhouyang', '1', '1');
