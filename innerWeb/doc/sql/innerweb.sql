/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : innerweb

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2013-05-21 22:41:43
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
INSERT INTO `tbl_category` VALUES ('3u6rmu', '煤炭清洁利用研发中心', '煤炭清洁利用', 'mtqjlyyfzx', '煤炭清洁利用研发中心', '0', '1', '8', 'm226Ff', 'news', null, '2013-05-20 11:09:00');
INSERT INTO `tbl_category` VALUES ('6JJVnm', '集团部门', '集团部门', 'dept', '集团部门', '0', '0', '0', '0', 'dept', null, null);
INSERT INTO `tbl_category` VALUES ('7B7rIb', '政府部门', '政府部门', 'gv', '政府部门', '0', '0', '1', '2meuyy', 'friendlyLinks', null, '2013-05-16 16:30:25');
INSERT INTO `tbl_category` VALUES ('aENvee', '页岩气研发中心', '页岩气', 'yyqyfzx', '页岩气研发中心', '0', '1', '7', 'm226Ff', 'news', null, '2013-05-20 11:08:32');
INSERT INTO `tbl_category` VALUES ('Bbq6n2', '综合管理部', '综合管理部', 'zongheguanlibu', '综合管理部', '0', '1', '2', 'm226Ff', 'news', null, '2013-05-20 11:06:33');
INSERT INTO `tbl_category` VALUES ('bY3Uju', '公司通知公告', '公司通知公告', 'gongsiNotices', '公司通知公告', '0', '1', '1', 'E7FFN3', 'notices', null, '2013-05-20 11:00:57');
INSERT INTO `tbl_category` VALUES ('E7FFN3', '通知公告', '通知公告', 'notices', '通知公告', '0', '1', '0', '0', 'notices', null, null);
INSERT INTO `tbl_category` VALUES ('I3meqq', '技经院', '技经院', 'jijingyuan', 'jijingyuan', '0', '1', '20', 'm226Ff', 'news', null, '2013-05-20 11:16:59');
INSERT INTO `tbl_category` VALUES ('IfM7Zz', '人力资源', '人力资源', 'renliziyuan', '人力资源', '0', '1', '4', 'm226Ff', 'news', null, '2013-05-20 11:07:11');
INSERT INTO `tbl_category` VALUES ('m226Ff', '新闻动态', '新闻动态', 'news', '新闻动态', '0', '1', '0', '0', 'news', null, null);
INSERT INTO `tbl_category` VALUES ('MJfmQz', '支部活动', '支部活动', 'zhibuhuodong', '支部活动', '0', '1', '10', 'm226Ff', 'news', null, '2013-05-20 11:09:45');
INSERT INTO `tbl_category` VALUES ('mYre2a', '各部门内部通告', '各部门内部通告', 'deptInnerNotices', '各部门内部通告', '0', '1', '2', 'E7FFN3', 'notices', null, '2013-05-20 11:01:24');
INSERT INTO `tbl_category` VALUES ('NJNzQ3', '兄弟部门', '兄弟部门', 'br', '', '0', '0', '3', '2meuyy', 'friendlyLinks', null, '2013-05-16 16:30:56');
INSERT INTO `tbl_category` VALUES ('NjQrmi', '人事部门', null, '', null, '0', '0', '0', '6JJVnm', 'dept', null, '2013-05-17 14:04:10');
INSERT INTO `tbl_category` VALUES ('NnEvIb', '总院快捷入口', '总院快捷入口', 'outfastentrance', '总院快捷入口', '0', '1', '0', '0', 'outfastentrance', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('Q7BJzm', '财务信息', '财务信息', 'caiwuxinxi', '财务信息', '0', '1', '5', 'm226Ff', 'news', null, '2013-05-20 11:07:27');
INSERT INTO `tbl_category` VALUES ('qQJvEz', '员工生活', '员工生活', 'yuangongshenghuo', '员工生活，显示与导航条上', '0', '1', '1', 'm226Ff', 'news', null, '2013-05-20 10:59:09');
INSERT INTO `tbl_category` VALUES ('QZbM7n', '集团系统快捷入口', '集团系统快捷入口', 'infastentrance', '集团系统快捷入口', '0', '1', '0', '0', 'infastentrance', null, '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('RBVBVf', '分布式能源实验室', '分布式能源', 'fbsnysys', '分布式能源实验室', '0', '1', '6', 'm226Ff', 'news', null, '2013-05-20 11:08:02');
INSERT INTO `tbl_category` VALUES ('remuEb', '科研项目管理部', '科研项目管理部', 'keyanxiangmubu', '科研项目管理部', '0', '1', '3', 'm226Ff', 'news', null, '2013-05-20 11:06:55');
INSERT INTO `tbl_category` VALUES ('rm6nQv', '专题活动', '专题活动', 'zhuantihuodong', '专题活动', '0', '1', '11', 'm226Ff', 'news', null, '2013-05-20 11:10:01');
INSERT INTO `tbl_category` VALUES ('zeMvu2', '集团KS', null, '', null, '0', '0', '0', '6JJVnm', 'dept', null, '2013-05-17 14:05:29');

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
INSERT INTO `tbl_links` VALUES ('eI7z6f', '哥弟神剪', 'http://www.checne.comcn12', 'NJNzQ3', 'friendlyLinks', null, '3', '1', '2013-05-18 08:33:56');
INSERT INTO `tbl_links` VALUES ('FB7N7r', 'zfbm1', 'http://emial.com', '2meuyy', 'friendlyLinks', null, '1', '1', '2013-05-16 19:14:02');
INSERT INTO `tbl_links` VALUES ('feUn6b', 'qqq', 'qqq', '7B7rIb', 'friendlyLinks', null, '1', '1', '2013-05-16 19:50:17');
INSERT INTO `tbl_links` VALUES ('iAbYve', '政府部门连接', 'http://www.checne.comcn1', '7B7rIb', 'friendlyLinks', null, '45', '1', '2013-05-17 08:13:41');
INSERT INTO `tbl_links` VALUES ('Nruqmy', '集团邮箱', 'http://emial.com', 'NnEvIb', 'outfastentrance', null, '2', '0', '2013-05-16 19:13:39');
INSERT INTO `tbl_links` VALUES ('uymUVr', '集团OA', 'http://oa.com', 'NnEvIb', 'outfastentrance', null, '1', '1', '2013-05-16 16:28:15');
INSERT INTO `tbl_links` VALUES ('zMzIFf', '人事系统', 'http://www.r.com', 'QZbM7n', 'infastentrance', null, '2', '1', '2013-05-16 16:29:30');
INSERT INTO `tbl_links` VALUES ('Zr6bUr', '流程系统', 'http://emial.comqqqq', 'QZbM7n', 'infastentrance', null, '66', '0', '2013-05-17 08:26:23');
INSERT INTO `tbl_links` VALUES ('zyqEru', '兄弟部门1', 'http://www.google.com.hk1', '2meuyy', 'friendlyLinks', null, '41', '0', '2013-05-17 08:19:00');
INSERT INTO `tbl_links` VALUES ('ZZFZNn', '集团KS', 'http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack', 'NnEvIb', 'outfastentrance', null, '12', '1', '2013-05-16 19:13:33');

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
INSERT INTO `tbl_meta` VALUES ('page_foot', '<div class=\"footer\">\r\n    <center>\r\n        <table width=\"650\" border=\"0\" cellspacing=\"0\" align=\"center\">\r\n            <tr>\r\n                <td rowspan=\"3\" width=\"75\"><img src=\"${basePath}res/front/images/footer.jpg\"/></td>\r\n                <td>中国华电集团科学技术研究总院 版权所有 京ICP备05084797号 邮编：100077 传真：010-52392444</td>\r\n            </tr>\r\n            <tr>\r\n                <td>地址：北京市东城区永定门西滨河路8号院7号楼中海地产广场东塔11层 电话：010-51966891</td>\r\n            </tr>\r\n            <tr>\r\n                <td>建议使用IE6.0以上版本浏览器1024*768分辨率浏览本网站</td>\r\n            </tr>\r\n        </table>\r\n    </center>\r\n</div>');
INSERT INTO `tbl_meta` VALUES ('popular_Links', '\r\n<div class=\"body_left_1\" style=\"margin-top:10px;\">\r\n                <div class=\"body_left_tit\">\r\n                    <ul class=\"tit_biao\">\r\n                        <li><img src=\"${basePath}res/front/images/left_tit_biao1.png\"/></li>\r\n                        <li style=\"padding-left:15px;\">常用链接</li>\r\n                    </ul>\r\n                </div>\r\n\r\n                <div class=\"body_left_con1\">\r\n<ul>\r\n                        <li><select name=\"\" class=\"xiala\">\r\n                            <option value=\"------集团系统网站链接------\" selected=\"selected\">------集团系统网站链接------</option>\r\n                        </select></li>\r\n                        <li><select name=\"\" class=\"xiala\">\r\n                            <option value=\"------常用网站链接------\" selected=\"selected\">------常用网站链接------</option>\r\n                        </select></li>\r\n                    </ul>\r\n                </div>\r\n            </div>');

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
INSERT INTO `tbl_post` VALUES ('6JNNve', 'news', 'j6rmu2', '新闻1', '周杨', '新闻1', '2013-05-16 16:27:47', '1', '0', '0', '0', '0', '暗室逢灯', null, '爱上对方');
INSERT INTO `tbl_post` VALUES ('73mAvq', 'news', 'uiMbIb', '21123123123sadfasdf', '1233123123123asdf', '12312312asdf', '2013-05-18 23:20:44', '1', '1', '1', '1', '1', '1231233123123asdf', null, '123123123123123asdf');
INSERT INTO `tbl_post` VALUES ('BfieAr', 'news', 'uiMbIb', '21123123123sadfasdf', '1233123123123asdf', '12312312asdf', '2013-05-18 23:20:44', '1', '1', '1', '1', '1', '1231233123123asdf', null, '123123123123123asdf');
INSERT INTO `tbl_post` VALUES ('Eb6ZRv', 'news', 'qQJvEz', '员工生活好又好', '周杨', '中新社', '2013-05-20 11:52:05', '1', '1', '1', '0', '1', '员工生活好又好', null, '员工生活好又好员工生活好又好员工生活好又好员工生活好又好员工生活好又好');
INSERT INTO `tbl_post` VALUES ('ENBjYz', 'news', 'uiMbIb', '21123123123', '1233123123123', '12312312', '2013-05-18 23:20:44', '1', '1', '1', '1', '1', '1231233123123', null, '123123123123123');
INSERT INTO `tbl_post` VALUES ('iERnEb', 'news', 'uiMbIb', '21123123', '123', '123', '2013-05-18 23:20:44', '1', '1', '1', '1', '1', '123123', null, '123123');
INSERT INTO `tbl_post` VALUES ('jYRbQr', 'news', 'uiMbIb', '21123123123sadfasdf', '1233123123123asdf', '12312312asdf', '2013-05-18 23:20:44', '1', '1', '1', '1', '1', '1231233123123asdf', null, '123123123123123asdf');
INSERT INTO `tbl_post` VALUES ('z2yeAn', 'news', 'uiMbIb', '21123123123sadfasdf', '1233123123123asdf', '12312312asdf', '2013-05-18 23:20:44', '1', '1', '1', '1', '1', '1231233123123asdf', null, '123123123123123asdf');
INSERT INTO `tbl_post` VALUES ('zuYbeu', 'news', 'uiMbIb', '21123123123sadfasdf', '1233123123123asdf', '12312312asdf', '2013-05-18 23:20:44', '1', '1', '1', '1', '1', '1231233123123asdf', null, '123123123123123asdf');

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

-- ----------------------------
-- Table structure for `tbl_rights`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_rights`;
CREATE TABLE `tbl_rights` (
  `rights_id` varchar(100) default NULL,
  `rights_name` varchar(100) default NULL,
  `rights_desc` text,
  `rights_value` text,
  `rights_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统权限表';

-- ----------------------------
-- Records of tbl_rights
-- ----------------------------
INSERT INTO `tbl_rights` VALUES ('U3AvE3', '新闻管理', '新闻管理', 'mg/news/news-list.htm', '2013-05-18 14:07:54');
INSERT INTO `tbl_rights` VALUES ('QFNJby', '公司新闻管理1', '公司新闻管理1', 'mg/news/news-list.htm1', '2013-05-18 14:22:28');
INSERT INTO `tbl_rights` VALUES ('fYnQRz', '新闻管理--行业动态', '新闻管理--行业动态', 'mg/news/news-list.htm', '2013-05-18 14:08:37');
INSERT INTO `tbl_rights` VALUES ('uaqIZb', 'sdfasdf', 'sdfasdf', 'mg/news/news-list.htm1', '2013-05-18 14:22:47');
INSERT INTO `tbl_rights` VALUES ('f6RZR3', '1111', '1111', 'mg/news/news-list.htm1', '2013-05-18 14:22:51');
INSERT INTO `tbl_rights` VALUES ('imyQZn', '2222222', '2222222', 'mg/news/news-list.htm1', '2013-05-18 14:22:55');

-- ----------------------------
-- Table structure for `tbl_role`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_role`;
CREATE TABLE `tbl_role` (
  `role_id` varchar(50) default NULL,
  `role_name` varchar(100) default NULL,
  `role_desc` text,
  `role_rights_id` text COMMENT '功能权限集合，中间通过'',''分割',
  `role_time` time default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户角色管理';

-- ----------------------------
-- Records of tbl_role
-- ----------------------------
INSERT INTO `tbl_role` VALUES ('ZNfm2y', '普通用户', '普通用户', 'imyQZn,f6RZR3,uaqIZb,QFNJby,fYnQRz,U3AvE3', '17:11:21');
INSERT INTO `tbl_role` VALUES ('aeaami', '超级管理员', '超级管理员', 'imyQZn,f6RZR3,uaqIZb,QFNJby,fYnQRz,U3AvE3', '17:11:43');

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
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('biymau', 'admin', '3bac8cc87db33021623d0d88a287982a5845b3c1989b620c', '周杨111', '12311', '12123123211', '12311', '123111', 'NjQrmi', 'ZNfm2y', '1', '2013-05-20 14:12:33');
