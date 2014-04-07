/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : chec_cn

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2014-04-08 01:38:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_category`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_category`;
CREATE TABLE `tbl_category` (
  `id` varchar(32) NOT NULL,
  `cate_pid` varchar(32) NOT NULL COMMENT '父ID',
  `cate_type` varchar(255) default NULL COMMENT '分类类别-用于区分类的类别',
  `cate_order` int(11) default '0' COMMENT '越大越靠前',
  `cate_is_show` tinyint(4) default '1' COMMENT '是否显示0=否，1=是',
  `cate_is_list` tinyint(4) default '1' COMMENT '是否为列表0=否，1=是',
  `cate_has_children` tinyint(4) default '0' COMMENT '是否有孩子 1=是 0=否',
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
-- Records of tbl_category
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_dic`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic`;
CREATE TABLE `tbl_dic` (
  `key` varchar(100) NOT NULL COMMENT '字典表的key',
  `value` text COMMENT '字典表的value',
  PRIMARY KEY  (`key`),
  UNIQUE KEY `idx_dic_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of tbl_dic
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_post`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_post`;
CREATE TABLE `tbl_post` (
  `id` varchar(32) NOT NULL,
  `cate_id_fk` varchar(32) NOT NULL COMMENT '栏目ID',
  `cate_type_fk` varchar(32) NOT NULL COMMENT '栏目类型、文章类型（没太大用处）',
  `title` varchar(500) default NULL COMMENT '标题',
  `author` varchar(100) default NULL COMMENT '发布人',
  `source` varchar(100) default NULL COMMENT '来源',
  `publish_time` datetime default NULL COMMENT '发布时间',
  `update_time` datetime default NULL COMMENT '修改时间',
  `out_link` varchar(100) default '' COMMENT '外链地址（如果非空，直接跳转到对应的连接地址）',
  `post_order` int(11) default '0' COMMENT '排序，越大越靠前',
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
-- Records of tbl_post
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
  `role_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户角色管理';

-- ----------------------------
-- Records of tbl_role
-- ----------------------------
INSERT INTO `tbl_role` VALUES ('zA3eem', '超级管理员', '超级管理员', '00,01,02,08,09,03,04,05_category_move,05_category_manage,05_ARBrEr,05_yEJRF3,05_mUnqii,05_QRZrUb,05_mMN7Vz,05_ZjYZR3,05_eaAr6j,05_RrEvqi,05_bamMBf,05_BbeYfq,05_FBRvYf,05_beqiMn,05_Z3M7Rz,05_fEV7vu,05_j2imAr,05_RjIV7n,05_JBRbEv,06,07,11,12,13,14_FbeYFv,14_AzErIb,14_veumEn,14_7VNb2q', '2014-04-03 22:09:24');
INSERT INTO `tbl_role` VALUES ('mQbMJv', '总院用户', '', '00', '2014-01-26 11:27:17');
INSERT INTO `tbl_role` VALUES ('M3MFBv', '集团总部', '', '00', '2014-01-26 11:28:29');
INSERT INTO `tbl_role` VALUES ('zu2q2q', '集团领导', '', '00', '2014-01-26 11:28:15');
INSERT INTO `tbl_role` VALUES ('6beyqy', '华电系统用户', '', '00,07', '2014-03-05 12:40:30');
INSERT INTO `tbl_role` VALUES ('IbUrYv', '外部用户', '', '00', '2014-01-26 11:28:23');
INSERT INTO `tbl_role` VALUES ('f22qIf', '游客', '', '00,07', '2013-09-16 12:22:43');
INSERT INTO `tbl_role` VALUES ('Q7nyY3', '总院管理员', '', '00,01,02,08,09,03,04,05_category_move,05_category_manage,05_ARBrEr,05_yEJRF3,05_mUnqii,05_QRZrUb,05_mMN7Vz,05_ZjYZR3,05_eaAr6j,05_RrEvqi,05_bamMBf,05_BbeYfq,05_FBRvYf,05_beqiMn,05_Z3M7Rz,05_fEV7vu,05_j2imAr,05_RjIV7n,05_MFRNbe,05_JBRbEv,05_7jee6v,06,07,11', '2014-02-21 17:26:53');
INSERT INTO `tbl_role` VALUES ('yIZ732', '普通用户', '', '00', '2014-01-26 11:28:07');
INSERT INTO `tbl_role` VALUES ('fUJ7Jr', 'VIP', '', '00,07', '2013-09-16 12:31:15');
INSERT INTO `tbl_role` VALUES ('jeuuqu', '总院领导', '', '00', '2014-01-26 11:27:53');
INSERT INTO `tbl_role` VALUES ('NbiiQv', '华电系统领导', '', '00', '2014-01-26 11:26:56');

-- ----------------------------
-- Table structure for `tbl_user`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `user_id` varchar(100) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_passwd` varchar(500) NOT NULL,
  `user_nickname` varchar(100) default NULL,
  `user_nicknamepinyin` varchar(500) default NULL,
  `user_question` text,
  `user_answer` text,
  `user_company` varchar(500) default NULL,
  `user_dept` varchar(500) default NULL,
  `user_duty` varchar(500) default NULL,
  `user_address` text,
  `user_phone` varchar(100) default NULL,
  `user_mobile` varchar(100) default NULL,
  `user_email` varchar(200) default NULL,
  `user_islive` tinyint(4) default '0' COMMENT '是否激活 1=是 0=否',
  `user_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`user_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_uid_pawd` (`user_name`,`user_passwd`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('2iqQJr', '刘维成', 'ec7d59cc13a5f892e4960e9c1c074aded411136f8d97fb4d', '刘维成', 'liuweicheng', null, null, '集团公司政法部', '', '', '', '8356 6778', '18601086586', 'weicheng-liu@chd.com.cn', '1', '2013-12-24 16:12:26');
INSERT INTO `tbl_user` VALUES ('2UNNNn', '陈浩', '3f8406ae412a11a63a3ca350863dff4af9fb69c0edb41864', '陈浩', 'chenhao', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:11:50');
INSERT INTO `tbl_user` VALUES ('2yueeq', '黄溯', '1ba120cc484fca0cb3805d89e1f6086884edd2c8bc5504f3', '黄溯', 'huangshuo', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:11:55');
INSERT INTO `tbl_user` VALUES ('2YVVZz', 'yangyong', '6fb49e4a326c4afe4d4f9b4d92e42db6810a4dddb9155520', '杨勇', 'yangyong', null, null, '华电工程领导', '', '', '', '', '', '', '1', '2014-01-26 11:23:25');
INSERT INTO `tbl_user` VALUES ('3IBVba', '孔飞', 'e186fef4e46d7f515bca18fe664aa5e099a61dd7859d126b01777947ce8e841f', '孔飞', 'kongfei', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:11:57');
INSERT INTO `tbl_user` VALUES ('3Q7rey', '李哲非', '70f93184ccc75d6d0d6767d1172b6545db0f5dd50f698f81', '李哲非', 'lizhefei', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:11:58');
INSERT INTO `tbl_user` VALUES ('3QJFvu', '孙青松', '37b9ee6e3de33874b83e9c6daed528dab70a2c52749d4c94', '孙青松', 'sunqingsong', null, null, '', '', '', '', '', '', '', '1', '2013-09-16 12:31:34');
INSERT INTO `tbl_user` VALUES ('3QruUf', '张圣鹏', '102d52d24742b2ff0e2fd8c029ea89374baeda266d64d73a27983c7a6b87078a', '张圣鹏', 'zhangshengpeng', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:01');
INSERT INTO `tbl_user` VALUES ('6NBrMn', '曹文广', '29ca9483e6ba45fb3ae50a7a6f873fb58a1fba56b3ce693c8c9a719b3301abb7', '曹文广', 'caowenguang', null, null, '', '', '', '', '', '', '', '1', '2014-04-03 22:41:25');
INSERT INTO `tbl_user` VALUES ('6VfaEr', '奚萍', 'cd2124a285bf4b9e67a00e1a151a9fdc38ca4449a3cdfe4b', '奚萍', 'xiping', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:07');
INSERT INTO `tbl_user` VALUES ('7BFnA3', '杨立强', '6894d1b3fcc8357df4d107296f2f3a061419b6e85886ddff', '杨立强', 'yangliqiang', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:09');
INSERT INTO `tbl_user` VALUES ('7BN7Ff', 'zhuang-xu', '6b6f3da6509a0ad0114d565dde7b108ef3f3a77198b59be8534834acc393dfdb', '许壮', 'xuzhuang', null, null, '科研总院', '煤炭中心', null, null, '6263', '18210007018', 'zhuang-xu@chdi.ac.cn', '1', '2014-01-23 15:54:53');
INSERT INTO `tbl_user` VALUES ('7FJRvy', 'huangyuanhong', 'c6858e490987b6d5d1f1032ae5dfd024af56754d766ff146', '黄源红', 'huangyuanhong', null, null, '华电系统领导', '', '', '', '', '', '', '1', '2014-01-26 11:24:45');
INSERT INTO `tbl_user` VALUES ('7nAbUb', 'chenlidong', '4d2f8fb4837a0d535d207086ced97af7360e6015fa9192f7', '陈礼东', 'chenlidong', null, null, '华电系统领导', '', '', '', '', '', '', '1', '2014-01-26 11:20:43');
INSERT INTO `tbl_user` VALUES ('7RzQVz', '董方', 'd7d99b9e560f7079018922814f3817aca62fd11a62b8695c', '董方', 'dongfang', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:11');
INSERT INTO `tbl_user` VALUES ('AfuU7n', '翟燕萍', '5e9e862fe918dec040a247004e821a8d2ab2096e8f89b4e3e77436f7745706c9', '翟燕萍', 'zhaiyanping', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:14');
INSERT INTO `tbl_user` VALUES ('amem6f', 'yanxinrong', '5ca838226412edfaa9cfbc67fc0b419f1ec415d3f7c3a81e', '严新荣', 'yanxinrong', null, null, '集团科环部', '', '', '', '', '', '', '1', '2014-02-17 09:16:32');
INSERT INTO `tbl_user` VALUES ('bAZnUj', 'timothy', 'b8b1be0dd21e90b5572ff85d47cc24f7733889354c311548fe689a2578ba6c68', '付喆', 'fuzhe', null, null, '华电国际', '人力资源', null, null, '', '', 'fuzhe1987@126.com', '1', '2013-12-10 22:19:24');
INSERT INTO `tbl_user` VALUES ('biymau', 'admin', 'cf7eae85609f415d9da2fa870a89c0ffcab85b04798c7597048722abc35a75fc', '管理员', 'guanliyuan', null, null, '华电科研总院', '综合管理部', '', '', '010-5196 6662', '18911803600', 'chdtsg@163.com', '1', '2013-11-04 13:45:41');
INSERT INTO `tbl_user` VALUES ('Bv6RBn', '王珍', 'b8079e42f665ea031264cb88971678fc8624d47ad1f980df', '王珍', 'wangzhen', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:16');
INSERT INTO `tbl_user` VALUES ('byQnEv', 'zouchongen', '7850f742f9e7d10bd4070386e4d6b7f866c01ee80f680e603bff0b0e988c4d87', '邹重恩', 'zouzhongen', null, null, '', '', null, null, '010-59216230', '18611191622', 'chongen-zou@chdi.ac.cn', '1', '2014-03-12 11:01:38');
INSERT INTO `tbl_user` VALUES ('Bz63Qr', '陈远台', 'adf0b5c423b8836f5199f94d2ffdb64347d9df1daca3c0e3', '陈远台', 'chenyuantai', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:18');
INSERT INTO `tbl_user` VALUES ('Eryy6n', 'liuxianming', '5da15553cea336bbae953aa3abb2b5480229ab1608999752', '刘显明', 'liuxianming', null, null, '华电工程分布式能源公司', '', '', '', '', '', '', '1', '2014-03-06 15:28:43');
INSERT INTO `tbl_user` VALUES ('eYZvui', '肖克勤', '7bc22738029beeef4e531ffb7fe9683d4e5655a0b70e0a13', '肖克勤', 'xiaokeqin', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:20');
INSERT INTO `tbl_user` VALUES ('f6bYje', 'lichangxu', '2733dac91f1495ac6cad2615e663e29be0f3899faea06fbd', '李长旭', 'lizhangxu', null, null, '华电系统领导', '', '', '', '', '', '', '1', '2014-01-26 11:22:31');
INSERT INTO `tbl_user` VALUES ('fE3AFf', '纪宇飞', 'e913b0652ea3d889fc53c85207c611c4b186d81b3d7c910e', '纪宇飞', 'jiyufei', null, null, '科研总院', '智能分布式能源系统中心实验室', '', '北京市东城区', '010-59216221', '15901386859', 'yufei-ji@chdi.ac.cn', '1', '2014-03-12 12:56:45');
INSERT INTO `tbl_user` VALUES ('fEbMjq', '赵江', 'f3706bd681868a97a00b76b07d64d0892717b6b7e35026e0', '赵江', 'zhaojiang', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:27');
INSERT INTO `tbl_user` VALUES ('fiu6Rf', '傅昱斐', '90dfd934b1aa5455458e45e26cba6b781c05a00948ce9781', '傅昱斐', 'fulifei', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:30');
INSERT INTO `tbl_user` VALUES ('fiYz22', '许全坤', '7b8bb367ef9358763a98f46a7f03ee156976e557f66de6d8', '许全坤', 'xuquankun', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:33');
INSERT INTO `tbl_user` VALUES ('Fjeaqa', '余卫平', 'b8fbe63d02273376fc9fd8e555995a44ee620ac849edb660', '余卫平', 'yuweiping', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:35');
INSERT INTO `tbl_user` VALUES ('FJzyum', '胡小夫', '9d55f18c72130bb51da167dec56e58019e836908c659a660', '胡小夫', 'huxiaofu', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:36');
INSERT INTO `tbl_user` VALUES ('FNNNvy', '王先德', 'c00792b36139d50fc24e53891bdfcd4d95ba717f6c3c0268', '王先德', 'wangxiande', null, null, '', '', '', '', '', '', '', '1', '2014-02-18 09:45:14');
INSERT INTO `tbl_user` VALUES ('FRJbM3', '邓建玲', '870ef9314b75160ed71972ce09dadf8522d36229af91bcd5', '邓建玲', 'dengjianling', null, null, '', '', '', '', '', '', '', '1', '2013-09-16 12:32:20');
INSERT INTO `tbl_user` VALUES ('fUzMBj', '卢仁江', '723b52ed4475800c4052a63707466b970bca29ed6dbfa1a3', '卢仁江', 'lurenjiang', null, null, '集团公司政法部', '', '', '', '8356 6736', '18601086189', 'renjiang-lu@chd.com.cn', '1', '2013-12-24 16:11:06');
INSERT INTO `tbl_user` VALUES ('FVfIJr', '彭维明', 'f6ea10e58124b703c24883a0d63da49411723c40a3cfaca4', '彭维明', 'pengweiming', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:41');
INSERT INTO `tbl_user` VALUES ('fyeuEb', '刘川', 'ec8e460863eaa11e4472490dd7a4a80e35a29d3de5ec461ade97a5833410e44f', '刘川', 'liuchuan', null, null, '华电集团科研总院', '分布式能源', null, null, '', '18611616137', 'chuan-liu@chdi.ac.cn', '1', '2014-03-11 14:18:24');
INSERT INTO `tbl_user` VALUES ('i2mIZj', '马治安', '3f3b1f9ca6a70459ab47a2e988e6f5d2123fb24c84d5d446', '马治安', 'mazhian', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:43');
INSERT INTO `tbl_user` VALUES ('I7RjYb', 'sunqingsong', 'f86acc74b568b5946e1a53dd09af47f0015a68c418979910', '孙青松', 'sunqingsong', null, null, '华电工程、科研总院领导', '', '', '', '', '', '', '1', '2014-01-26 11:18:12');
INSERT INTO `tbl_user` VALUES ('iauemi', '张国远', '9c23655c5b610938c165bc283d9daeeb780d8472c4c9dc77b6531531ff8c23aa', '张国远', 'zhangguoyuan', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:47');
INSERT INTO `tbl_user` VALUES ('IVfU32', '中国华电', '81affc375412d0a4fc6d5055e3431b6aafdf18237b1ee4c1', '李鹏云', 'lipengyun', null, null, '', '政法部', '', '', '83566735', '18601086188', 'pengyun-li@chd.com.cn', '1', '2014-01-13 09:06:43');
INSERT INTO `tbl_user` VALUES ('IzIb6j', 'liuxiuru', 'e8d3879c9bce3504b293b8d9bb9cdc3007a9ee9161171777', '刘秀如', 'liuxiuru', null, null, '科研总院', '煤炭', '', '', '59216262', '15901174526', 'xiuru-liu@chdi.ac.cn', '1', '2014-03-11 13:42:46');
INSERT INTO `tbl_user` VALUES ('J7vMz2', 'guoxiaojun', '8190525fbed95883f1758c0845afcf02230ca58d6d00e526', '郭效军', 'guoxiaojun', null, null, '华电系统领导', '', '', '', '', '', '', '1', '2014-01-26 11:24:00');
INSERT INTO `tbl_user` VALUES ('J7ZBvi', '王家亮', '17b6729ec491e40091550715e69f96e28a6a34b9d359d7dc', '王家亮', 'wangjialiang', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:52');
INSERT INTO `tbl_user` VALUES ('jaEzQn', '黄群', 'f88b998978ec3ea9298f82b1df88b6f3a82504d3a8499cc1', '黄群', 'huangqun', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:54');
INSERT INTO `tbl_user` VALUES ('jANvuq', '刘勇', '96bf7119cb02fd11867472c025f7d85f33972f1c6fbf1ed9', '刘勇', 'liuyong', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:12:59');
INSERT INTO `tbl_user` VALUES ('jEbAba', '张新', '77f515eeecc472abbb808d0fc4d5d46e138ae79a17d3df8b', '张新', 'zhangxin', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:00');
INSERT INTO `tbl_user` VALUES ('Mj6fy2', 'zhangdongxiao', '0450b5d29b9d907ab485c363376d1f983d759efe70063275', '张东晓', 'zhangdongxiao', null, null, '集团科环部', '', '', '', '', '', '', '1', '2014-02-17 09:15:55');
INSERT INTO `tbl_user` VALUES ('mM3Qvu', 'dengjianling', '885cd311e875452f63fa3598d53eba176e48824122135de6', '邓建玲', 'dengjianling', null, null, '集团公司领导', '', '', '', '', '', '', '1', '2014-01-26 11:11:57');
INSERT INTO `tbl_user` VALUES ('MrIjUj', '孙丽丽', 'f32aa12ffa784b187df70de5b09384f72f65223ce75fe1f7', '孙丽丽', 'sunlili', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:06');
INSERT INTO `tbl_user` VALUES ('n22qy2', '冉志军', '011afabd40a5d61be22a453990eded1b3d06bc821a08b2b1', '冉志军', 'ranzhijun', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:10');
INSERT INTO `tbl_user` VALUES ('n2Azqu', '孙海峰', 'ac735ac2e36c6a6c6cfd570b6cdfe2be6571e784d0b166cc', '孙海峰', 'sunhaifeng', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:14');
INSERT INTO `tbl_user` VALUES ('n2YV7r', '何佳', '09f0dd8bfbd1f72e8de55103acb20c0db59f7362d3218003', '何佳', 'hejia', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:16');
INSERT INTO `tbl_user` VALUES ('NB32aq', '陈宗法', 'b03b02ef40c4a6a01370a8b7650072dd5940750e4b18ac8b', '陈宗法', 'chenzongfa', null, null, '集团公司政法部', '', '', '', '8356 6733', '18601086366', 'zongfa-chen@chd.com.cn', '1', '2013-12-24 16:15:06');
INSERT INTO `tbl_user` VALUES ('nE7fmu', '武文扬', '9ee60de9b37320989c2ffc96fa577237aa16bdfdc8f32628', '武文扬', 'wuwenyang', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:19');
INSERT INTO `tbl_user` VALUES ('NZ36ny', '陈耀斌', '2489fffc1ec36e7839e6e2f55e41cff343570841661628e3', '陈耀斌', 'chenyaobin', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:22');
INSERT INTO `tbl_user` VALUES ('Q3Ib6f', '吴建辉', '62148f025e7ebe2df047deadecc0e5532f71b96aa987b7c5e58bbff20e998228', '吴健辉', 'wujianhui', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:26');
INSERT INTO `tbl_user` VALUES ('qIFB7r', '彭敏', '23537c5081f2ca4495e6f64042f2408cd1af4dd6245e0eb29c6cc338de58f0c4fe1aa091319350f4', '彭敏', 'pengmin', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:29');
INSERT INTO `tbl_user` VALUES ('qmUFVr', '郭永凯', '60b76047a2ccb280a3905d67757efedf0bdaf7b558922586', '郭永凯', 'guoyongkai', null, null, '集团公司政法部', '', '', '', '8356 6771', '18601086585', 'yongkai-guo@chd.com.cn', '1', '2013-12-24 16:13:38');
INSERT INTO `tbl_user` VALUES ('QVjaye', '孙爱荣', '2baeebfa945cc887cd21c8c6b51eb836fe499231c21188ef', '孙爱荣', 'sunairong', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:33');
INSERT INTO `tbl_user` VALUES ('QZNRFn', '郭南南', 'feb732f9b4b10e835e7c300a7f04a95686f6d05eda96419b011481090c02a188', '郭南南', 'guonannan', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:35');
INSERT INTO `tbl_user` VALUES ('ramUv2', 'huangxiang', '764bc3636e0a2a85c49b9545fbade37babfdbb4588f492c4', '黄湘', 'huangxiang', null, null, '华电工程领导', '', '', '', '', '', '', '1', '2014-01-26 11:21:49');
INSERT INTO `tbl_user` VALUES ('RfQnqm', '马跃龙', '940ad50e74c0c8d7e95616f3f6a192a75f61e720134b709b', '马跃龙', 'mayuelong', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:48');
INSERT INTO `tbl_user` VALUES ('rQVz6f', '何冬梅', 'a8c3bc13e7a30de1808979223c2412e4c011cab9597b913a', '何冬梅', 'hedongmei', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:50');
INSERT INTO `tbl_user` VALUES ('RRZNf2', '邹重恩', '67ed31fb38c1e8c86689e568dec0ab287657485efe25c69c3f37e9ad4dd2d160', '邹重恩', 'zouchongen', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:13:54');
INSERT INTO `tbl_user` VALUES ('uArmQ3', '徐波', '0dac5930cc0cc7d37dc37c3109574446ee6fddbb8cd39658c4712b2c82202b8b', '徐波', 'xubo', null, null, '煤炭清洁技术利用研发中心', '', '', '', '59216260', '18612186088', 'bo-xu@chdi.ac.cn', '1', '2014-03-12 12:57:08');
INSERT INTO `tbl_user` VALUES ('uEbERz', '刘清侠', 'dc0fbf513137a069a2c454fb9e8c1c003f2b8d71efbf9ffb', '刘清侠', 'liuqingxia', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:33');
INSERT INTO `tbl_user` VALUES ('UJzaIr', '李义强', 'f4aca5c1a3d1ab7cb0af4cc6073be927e06e39013e24fda5d1ac46c6ec258545', '李义强', 'liyiqiang', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:31');
INSERT INTO `tbl_user` VALUES ('ummeAj', 'jiangjiaren', 'b26c1f21217f96a34fd954cafdd6efac28ff0e9aa2fe7c8d', '姜家仁', 'jiangjiaren', null, null, '集团公司领导', '', '', '', '', '', '', '1', '2014-01-26 11:15:11');
INSERT INTO `tbl_user` VALUES ('UNrEZr', '姜宝益', '5e50c8c80754cab832f9a71787110ca0ae91bb32872e4861', '姜宝益', 'jiangbaoyi', null, null, '', '', '', '', '', '', '', '1', '2014-02-17 14:22:33');
INSERT INTO `tbl_user` VALUES ('UrEZzq', '孙利', 'b3fb07b6ce48d565a60a6127ef85d867613d56c5d7089aa2', '孙利', 'sunli', null, null, '', '', '', '', '', '', '', '1', '2014-02-18 10:52:48');
INSERT INTO `tbl_user` VALUES ('uu2q2a', '熊晓霞', '26363b73599743677d1fb9440fb10f2353aa4d281474e44e', '熊晓霞', 'xiongxiaoxia', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:22');
INSERT INTO `tbl_user` VALUES ('uU3UZr', '李鹏云', '766d26ab861ed9b5392f99467d27babd118bb32ad3744199', '李鹏云', 'lipengyun', null, null, '集团公司政法部', '', '', '', '8356 6735', '18601086188', 'pengyun-li@chd.com.cn', '1', '2013-12-24 16:09:54');
INSERT INTO `tbl_user` VALUES ('uyayyq', '张宇龙', '2281fcc24798e1b78de83dcaa46dfeeb43800ff1678eaea0', '张宇龙', 'zhangyulong', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:20');
INSERT INTO `tbl_user` VALUES ('vENrau', '张锋', '7efedc45c767b943826e6adf1a0a06be5412fbfda23c5d0465b0f50277d7427c', '张锋', 'zhangfeng', null, null, '华电科研总院', '', '', '', '010-591 6201', '18911803600', 'zhangfengvipchina@163.com', '1', '2014-04-03 22:26:37');
INSERT INTO `tbl_user` VALUES ('vyEzUb', '孔令莹', 'f29f5ba4185cc5bab33289c4dbc968046a6aca405de72933', '孔令莹', 'konglingying', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:17');
INSERT INTO `tbl_user` VALUES ('Vzq6Jz', '姚小强', '07f4ad8d3e4f8b96dbbef68f9c9053fd1ca27cb4c3899698', '姚小强', 'yaoxiaoqiang', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:14');
INSERT INTO `tbl_user` VALUES ('YbAvey', 'zhangtao', '76cdc87f93db79fa4f4cf4a57f2059cd8820d5abde916d38', '张涛', 'zhangtao', null, null, '集团公司领导', '', '', '', '', '', '', '1', '2014-01-26 11:14:27');
INSERT INTO `tbl_user` VALUES ('YFzIFn', '王潇彤', '1767e3e04aec7b168325d0f947dcfb78fee049f576223568', '王潇彤', 'wangxiaotong', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:12');
INSERT INTO `tbl_user` VALUES ('YNzMba', '柳冠青', '26b2cae06ce54cd8ac6e167dc9cd3c7d98438c4e9a09a252', '柳冠青', 'liuguanqing', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:09');
INSERT INTO `tbl_user` VALUES ('yueIRz', '车建炜', 'f539c93abb58aa2d9014c715288c532ed122fb16e00d21f7', '车建炜', 'chejianwei', null, null, '华电工程油气公司', '', '', '', '', '', '', '1', '2014-03-05 12:41:21');
INSERT INTO `tbl_user` VALUES ('z6ZJBn', 'zgy', '92d9450e5505eab9b00185836c1dd87d7091b32a1e66dfefaf3e638873418231', '张国远', 'zhangguoyuan', null, null, '华电科研总院', '综合管理部', null, null, '', '', 'guoyuan-zhang@chdi.ac.cn', '1', '2014-01-07 08:44:07');
INSERT INTO `tbl_user` VALUES ('ZBRRn2', '王恒涛', 'aa884178e6b57698b8d4b5464b4fc39061db01be3a016460', '王恒涛', 'wanghengtao', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:07');
INSERT INTO `tbl_user` VALUES ('ZjmMre', '张智勇', '836526933cb742214fd17bc41ee311d91a0fc8fe9cf45687', '张智勇', 'zhangzhiyong', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:04');
INSERT INTO `tbl_user` VALUES ('zQZVBn', '郭妍', 'e3c1f5a78772247fa20ec0205f2a41bcf3165636e43cc0a0', '郭妍', 'guoyan', null, null, '集团公司政法部', '', '', '', '8356 6772', '18601086012', 'yan-guo@chd.com.cn', '1', '2013-12-24 16:14:43');
INSERT INTO `tbl_user` VALUES ('ZZj6Rj', '于博', 'cf2aa45c8bc5d5d494fe1b8ec813d70e83977ee2f9f4cf54', '于博', 'yubo', null, null, null, null, null, null, null, null, null, '1', '2013-09-16 23:14:01');

-- ----------------------------
-- Table structure for `tbl_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_role`;
CREATE TABLE `tbl_user_role` (
  `user_id_fk` varchar(32) default NULL COMMENT '用户UID',
  `role_id_fk` varchar(32) default NULL COMMENT '角色ID',
  KEY `idx_userrole_uid` (`user_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user_role
-- ----------------------------
INSERT INTO `tbl_user_role` VALUES ('2UNNNn', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('2yueeq', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('3IBVba', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('3Q7rey', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('3QruUf', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('6VfaEr', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('7BFnA3', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('7RzQVz', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('AfuU7n', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('Bv6RBn', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('Bz63Qr', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('eYZvui', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('fEbMjq', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('fiu6Rf', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('fiYz22', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('Fjeaqa', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('FJzyum', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('FVfIJr', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('i2mIZj', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('iauemi', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('J7ZBvi', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('jaEzQn', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('jANvuq', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('jEbAba', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('MrIjUj', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('n22qy2', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('n2Azqu', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('n2YV7r', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('nE7fmu', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('NZ36ny', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('Q3Ib6f', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('qIFB7r', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('QVjaye', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('QZNRFn', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('RfQnqm', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('rQVz6f', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('RRZNf2', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('uEbERz', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('UJzaIr', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('uu2q2a', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('uyayyq', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('vyEzUb', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('Vzq6Jz', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('YFzIFn', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('YNzMba', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('ZBRRn2', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('ZjmMre', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('ZZj6Rj', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('biymau', 'zA3eem');
INSERT INTO `tbl_user_role` VALUES ('3QJFvu', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('3QJFvu', 'fUJ7Jr');
INSERT INTO `tbl_user_role` VALUES ('FRJbM3', 'zu2q2q');
INSERT INTO `tbl_user_role` VALUES ('FRJbM3', 'fUJ7Jr');
INSERT INTO `tbl_user_role` VALUES ('6NBrMn', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('bAZnUj', 'yIZ732');
INSERT INTO `tbl_user_role` VALUES ('uU3UZr', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('fUzMBj', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('2iqQJr', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('qmUFVr', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('zQZVBn', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('NB32aq', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('z6ZJBn', 'yIZ732');
INSERT INTO `tbl_user_role` VALUES ('vENrau', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('vENrau', 'Q7nyY3');
INSERT INTO `tbl_user_role` VALUES ('IVfU32', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('7BN7Ff', 'yIZ732');
INSERT INTO `tbl_user_role` VALUES ('mM3Qvu', 'zu2q2q');
INSERT INTO `tbl_user_role` VALUES ('YbAvey', 'zu2q2q');
INSERT INTO `tbl_user_role` VALUES ('ummeAj', 'zu2q2q');
INSERT INTO `tbl_user_role` VALUES ('I7RjYb', 'jeuuqu');
INSERT INTO `tbl_user_role` VALUES ('7nAbUb', 'NbiiQv');
INSERT INTO `tbl_user_role` VALUES ('ramUv2', 'NbiiQv');
INSERT INTO `tbl_user_role` VALUES ('f6bYje', 'NbiiQv');
INSERT INTO `tbl_user_role` VALUES ('2YVVZz', 'NbiiQv');
INSERT INTO `tbl_user_role` VALUES ('J7vMz2', 'NbiiQv');
INSERT INTO `tbl_user_role` VALUES ('7FJRvy', 'NbiiQv');
INSERT INTO `tbl_user_role` VALUES ('Mj6fy2', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('amem6f', 'M3MFBv');
INSERT INTO `tbl_user_role` VALUES ('UNrEZr', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('FNNNvy', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('UrEZzq', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('yueIRz', '6beyqy');
INSERT INTO `tbl_user_role` VALUES ('Eryy6n', 'NbiiQv');
INSERT INTO `tbl_user_role` VALUES ('IzIb6j', 'yIZ732');
INSERT INTO `tbl_user_role` VALUES ('fyeuEb', 'yIZ732');
INSERT INTO `tbl_user_role` VALUES ('byQnEv', 'yIZ732');
INSERT INTO `tbl_user_role` VALUES ('fE3AFf', 'mQbMJv');
INSERT INTO `tbl_user_role` VALUES ('uArmQ3', 'mQbMJv');
