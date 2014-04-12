/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : chec_cn

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2014-04-12 21:17:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_access_log`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_access_log`;
CREATE TABLE `tbl_access_log` (
  `id` varchar(32) default NULL,
  `user_id_fk` varchar(32) default NULL COMMENT '访问人',
  `access_time` datetime default NULL COMMENT '访问时间',
  `page_url` varchar(500) default NULL COMMENT '访问页面URL',
  `page_title` varchar(1000) default NULL COMMENT '访问页面标题（如果非正文的话，默认为空）',
  `page_category_id` varchar(32) default NULL COMMENT '如果是图书、文章的话，记录对应的内容分类ID',
  KEY `idx_access_log_user_id` (`user_id_fk`),
  KEY `idx_access_log_time` (`access_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统访问日志';

-- ----------------------------
-- Records of tbl_access_log
-- ----------------------------

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
INSERT INTO `tbl_category` VALUES ('6ZBZRj', '公司新闻', '公司新闻', 'GONGSIXINWEN', '公司新闻', '0', '1', '1', '0', '2', 'yQBjMz', 'NEWS', null, null, '0', '2014-04-12 18:54:24');
INSERT INTO `tbl_category` VALUES ('beYjum', '资质荣誉', '资质荣誉', 'ZIZHIRONGYU', '资质荣誉', '1', '1', '1', '0', '5', 'n6vMje', 'INTRODUCE', null, null, '1', '2014-04-12 18:21:53');
INSERT INTO `tbl_category` VALUES ('bEzInu', '业务概况', '业务概况', 'BUSINESS', '业务概况', '0', '1', '1', '0', '0', '0', 'BUSINESS', null, null, '1', '2014-04-12 18:55:48');
INSERT INTO `tbl_category` VALUES ('BfAR7j', '公司业绩', '公司业绩', 'PERFORMANCE', '公司业绩', '0', '1', '1', '0', '0', '0', 'PERFORMANCE', null, null, '1', '2014-04-12 19:03:10');
INSERT INTO `tbl_category` VALUES ('BZnInm', '环保水务', '环保水务', 'HUANBAOSHUIWU', '环保水务', '1', '1', '1', '0', '2', 'bEzInu', 'BUSINESS', null, null, '1', '2014-04-12 18:59:18');
INSERT INTO `tbl_category` VALUES ('FnQNjm', '要闻快递', '要闻快递', 'YAOWENKUAIDI', '要闻快递', '0', '1', '1', '0', '1', 'yQBjMz', 'NEWS', null, null, '0', '2014-04-12 18:54:14');
INSERT INTO `tbl_category` VALUES ('fYjAza', '公司领导', '公司领导', 'GONGSILINGDAO', '公司领导', '1', '1', '1', '0', '2', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:15:55');
INSERT INTO `tbl_category` VALUES ('iiuaue', '国内主要业绩', '国内主要业绩', 'GUONEIZHUYAOYEJI', '国内主要业绩', '0', '1', '1', '0', '1', 'BfAR7j', 'PERFORMANCE', null, null, '0', '2014-04-12 19:05:46');
INSERT INTO `tbl_category` VALUES ('iuMreq', '能源技术研究与服务', '能源技术研究与服务', 'NENGYUANJISHUYANJIUYUFUWU', '能源技术研究与服务', '0', '1', '1', '0', '5', 'bEzInu', 'BUSINESS', null, null, '0', '2014-04-12 19:00:28');
INSERT INTO `tbl_category` VALUES ('jmEZZ3', '工程总承包', '工程总承包', 'GONGCHENGZONGCHENGBAO', '工程总承包', '0', '1', '1', '0', '4', 'bEzInu', 'BUSINESS', null, null, '0', '2014-04-12 18:59:55');
INSERT INTO `tbl_category` VALUES ('m6v2Iv', '华电集团简介', '华电集团简介', 'HUADIANJITUANJIANJIE', '华电集团简介', '1', '1', '1', '0', '8', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:23:10');
INSERT INTO `tbl_category` VALUES ('n6vMje', '公司简介', '公司简介', 'INTRODUCE', '公司简介', '0', '1', '1', '0', '0', '0', 'INTRODUCE', null, null, '1', '2013-05-29 09:19:44');
INSERT INTO `tbl_category` VALUES ('nMjQBz', '组织结构', '组织结构', 'ZUZHIJIEGOU', '组织结构', '1', '1', '1', '0', '3', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:20:55');
INSERT INTO `tbl_category` VALUES ('r2AnMz', '主要经营范围', '主要经营范围', 'ZHUYAOJINGYINGFANWEI', '主要经营范围', '1', '1', '1', '0', '7', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:22:54');
INSERT INTO `tbl_category` VALUES ('raY7fe', '水务', '水务', 'SHUIWU', '水务', '1', '1', '1', '0', '2', 'BZnInm', 'BUSINESS', null, null, '0', '2014-04-12 19:01:26');
INSERT INTO `tbl_category` VALUES ('rUvARv', '首页', '首页', 'SHOUYE', '首页', '0', '1', '1', '0', '0', '0', 'INDEX', null, null, '0', '2013-05-29 09:19:44');
INSERT INTO `tbl_category` VALUES ('UJrAf2', '华电重工', '华电重工', 'HUADIANZHONGGONG', '华电重工', '1', '1', '1', '0', '1', 'bEzInu', 'BUSINESS', null, null, '0', '2014-04-12 18:58:29');
INSERT INTO `tbl_category` VALUES ('UnMFny', '国外主要业绩', '国外主要业绩', 'GUOWAIZHUYAOYEJI', '国外主要业绩', '1', '1', '1', '0', '2', 'BfAR7j', 'PERFORMANCE', null, null, '0', '2014-04-12 19:06:00');
INSERT INTO `tbl_category` VALUES ('V7VVre', '公司资质', '公司资质', 'GONGSIZIZHI', '公司资质', '0', '1', '1', '0', '1', 'beYjum', 'INTRODUCE', null, null, '0', '2014-04-12 18:31:47');
INSERT INTO `tbl_category` VALUES ('VBvABv', '公司介绍', '公司介绍', 'GONGSIJIESHAO', '公司介绍', '1', '1', '1', '0', '1', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:11:41');
INSERT INTO `tbl_category` VALUES ('yQBjMz', '公司新闻', '公司新闻', 'NEWS', '公司新闻', '0', '1', '1', '0', '0', '0', 'NEWS', null, null, '1', '2013-05-07 08:14:55');
INSERT INTO `tbl_category` VALUES ('yyMNj2', '公司荣誉', '公司荣誉', 'GONGSIRONGYU', '公司荣誉', '0', '1', '1', '0', '2', 'beYjum', 'INTRODUCE', null, null, '0', '2014-04-12 18:31:59');
INSERT INTO `tbl_category` VALUES ('Z3eeMf', '环保', '环保', 'HUANBAO', '环保', '1', '1', '1', '0', '1', 'BZnInm', 'BUSINESS', null, null, '0', '2014-04-12 19:01:15');
INSERT INTO `tbl_category` VALUES ('ZjMb22', '发展战略', '发展战略', 'FAZHANZHANLVE', '发展战略', '1', '1', '1', '0', '4', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:21:26');
INSERT INTO `tbl_category` VALUES ('ZV3Aby', '发展历程', '发展历程', 'FAZHANLICHENG', '发展历程', '1', '1', '1', '0', '6', 'n6vMje', 'INTRODUCE', null, null, '0', '2014-04-12 18:22:38');

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
  PRIMARY KEY  (`id`),
  KEY `idx_links_cate_id` (`links_category_id`),
  KEY `idx_links_cate_type` (`links_category_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='链接管理';

-- ----------------------------
-- Records of tbl_links
-- ----------------------------
INSERT INTO `tbl_links` VALUES ('22YJJ3', '中科院广州能源所', 'http://www.giec.cas.cn/', 'YnyAv2', 'friendlyLinks', null, '6', '1', '2013-12-25 13:27:31');
INSERT INTO `tbl_links` VALUES ('2EZbQj', '大唐技经院', 'http://www.cdt-eri.com/', 'YnyAv2', 'friendlyLinks', null, '80', '1', '2013-12-25 13:21:16');
INSERT INTO `tbl_links` VALUES ('2iuQZz', '国家核电', 'http://www.snptc.com.cn', 'fIBrmm', 'friendlyLinks', null, '14', '1', '2013-05-30 13:21:03');
INSERT INTO `tbl_links` VALUES ('2MvQny', '常用网站', '#', 'beu6Nv', 'ofenLinks', null, '0', '1', '2014-02-15 16:02:41');
INSERT INTO `tbl_links` VALUES ('2qARVr', '国家电力信息网', 'http://www.sp.com.cn/', 'NJNzQ3', 'friendlyLinks', null, '5', '1', '2013-06-03 14:04:57');
INSERT INTO `tbl_links` VALUES ('3Mfqeq', '中国金融网', 'http://www.zgjrw.com/', 'BfqeYz', 'friendlyLinks', null, '18', '1', '2013-06-03 13:28:38');
INSERT INTO `tbl_links` VALUES ('3yMRJj', '国电科学技术研究院', 'http://www.nepri.com/', 'YnyAv2', 'friendlyLinks', null, '70', '1', '2013-12-25 13:21:21');
INSERT INTO `tbl_links` VALUES ('3yyiAb', '中国企业新闻网', 'http://www.chinacenn.com/', 'BfqeYz', 'friendlyLinks', null, '25', '1', '2013-06-03 13:32:03');
INSERT INTO `tbl_links` VALUES ('6BnuMb', '中国电力网', 'http://www.chinapower.com.cn/', 'NJNzQ3', 'friendlyLinks', null, '2', '1', '2013-12-25 12:04:55');
INSERT INTO `tbl_links` VALUES ('6feIZf', '中国科学院', 'http://www.cas.cn/', 'YnyAv2', 'friendlyLinks', null, '0', '1', '2013-12-25 13:22:18');
INSERT INTO `tbl_links` VALUES ('6FRfEv', '华能清洁能源研究院', 'http://www.hnceri.com/', 'YnyAv2', 'friendlyLinks', null, '60', '1', '2013-12-25 13:21:28');
INSERT INTO `tbl_links` VALUES ('6jERfy', '中国南方航空公司', 'http://www.csair.com', 'beu6Nv', 'ofenLinks', null, '2', '1', '2013-05-30 11:21:39');
INSERT INTO `tbl_links` VALUES ('6Rz2qe', '国家环保部', 'http://www.zhb.gov.cn', 'INjERr', 'friendlyLinks', null, '10', '1', '2013-06-03 13:37:46');
INSERT INTO `tbl_links` VALUES ('6vIR3m', '中国能源研究会', 'http://www.cers.org.cn/', 'muIvme', 'ofenLinks', null, '106', '1', '2014-02-19 13:48:15');
INSERT INTO `tbl_links` VALUES ('6z6Jzq', '现代储能网', 'http://www.mdes.com.cn/', 'AvmeEf', 'friendlyLinks', null, '22', '1', '2013-06-03 15:25:38');
INSERT INTO `tbl_links` VALUES ('736v6b', '石油大学（北京）', 'http://www.cup.edu.cn/', 'INJV3i', 'friendlyLinks', null, '4', '1', '2013-05-30 14:06:21');
INSERT INTO `tbl_links` VALUES ('7BVnEz', '浙江大学', 'http://www.zju.edu.cn/', 'INJV3i', 'friendlyLinks', null, '14', '1', '2013-06-03 15:05:23');
INSERT INTO `tbl_links` VALUES ('7FzYBf', 'rere', 're', '2meuyy', 'friendlyLinks', null, '0', '1', '2013-05-28 22:00:19');
INSERT INTO `tbl_links` VALUES ('a6beAz', '国网电科院', 'http://www.sgepri.sgcc.com.cn', 'YnyAv2', 'friendlyLinks', null, '40', '1', '2013-12-25 13:21:44');
INSERT INTO `tbl_links` VALUES ('AbUNJz', '国家财政部', 'http://www.mof.gov.cn/', 'INjERr', 'friendlyLinks', null, '14', '1', '2013-06-03 13:39:16');
INSERT INTO `tbl_links` VALUES ('AbURNz', '国网能源研究院', 'http://www.sgeri.sgcc.com.cn/', 'muIvme', 'ofenLinks', null, '50', '1', '2014-02-19 13:46:21');
INSERT INTO `tbl_links` VALUES ('ABZJra', '中国能建', 'http://www.ceec.net.cn', 'fIBrmm', 'friendlyLinks', null, '11', '1', '2013-06-03 13:50:08');
INSERT INTO `tbl_links` VALUES ('aEbu6n', '中国产业研究报告网', 'http://www.chinairr.org/', 'ZZRJne', 'friendlyLinks', null, '30', '1', '2013-12-25 12:28:31');
INSERT INTO `tbl_links` VALUES ('aEN3Qv', '国家水利部', 'http://www.mwr.gov.cn/', 'INjERr', 'friendlyLinks', null, '9', '1', '2013-06-03 13:37:38');
INSERT INTO `tbl_links` VALUES ('AfYZfy', '国家石油和化工网', 'http://www.cpcia.org.cn/', 'NJNzQ3', 'friendlyLinks', null, '10', '1', '2013-06-03 14:11:16');
INSERT INTO `tbl_links` VALUES ('aiQfYz', '中国能源网', 'http://www.china5e.com', 'NJNzQ3', 'friendlyLinks', null, '1', '1', '2013-12-25 12:05:56');
INSERT INTO `tbl_links` VALUES ('ANfQN3', '人民网', 'http://www.people.com.cn', 'BfqeYz', 'friendlyLinks', null, '2', '1', '2013-05-30 13:31:12');
INSERT INTO `tbl_links` VALUES ('Anuu2q', '中国工程院', 'http://www.cae.cn/', 'muIvme', 'ofenLinks', null, '110', '1', '2014-02-19 13:20:18');
INSERT INTO `tbl_links` VALUES ('auMzYz', '中国新能源汽车', 'http://www.zgxnyqc.roboo.com/', 'AvmeEf', 'friendlyLinks', null, '35', '1', '2013-12-26 14:50:01');
INSERT INTO `tbl_links` VALUES ('auyqYn', '中国能源报', 'http://www.cnenergy.org', 'NJNzQ3', 'friendlyLinks', null, '23', '1', '2013-06-03 14:10:22');
INSERT INTO `tbl_links` VALUES ('AVvYV3', '中国储能网', 'http://www.escn.com.cn', 'AvmeEf', 'friendlyLinks', null, '2', '1', '2013-06-03 15:13:13');
INSERT INTO `tbl_links` VALUES ('ayuQvi', 'solar阳光网', 'http://www.solarf.net/', 'AvmeEf', 'friendlyLinks', null, '14', '1', '2013-06-05 16:23:45');
INSERT INTO `tbl_links` VALUES ('AZjIJj', '国核电力规划院', 'http://www.snpdri.com/', 'YnyAv2', 'friendlyLinks', null, '280', '1', '2013-12-25 13:20:44');
INSERT INTO `tbl_links` VALUES ('bAbIny', '中国经济新闻网', 'http://www.cet.com.cn/', 'BfqeYz', 'friendlyLinks', null, '15', '1', '2013-06-03 13:24:49');
INSERT INTO `tbl_links` VALUES ('baErue', '国家知识产权局', 'http://www.sipo.gov.cn', 'INjERr', 'friendlyLinks', null, '7', '1', '2013-06-03 13:15:35');
INSERT INTO `tbl_links` VALUES ('BFJ7Fj', '中国国际航空公司', 'http://www.airchina.com.cn', 'beu6Nv', 'ofenLinks', null, '1', '1', '2013-05-30 11:21:30');
INSERT INTO `tbl_links` VALUES ('BfyQFj', '华北电力大学', 'http://www.ncepu.edu.cn/', 'INJV3i', 'friendlyLinks', null, '3', '1', '2013-06-03 15:00:35');
INSERT INTO `tbl_links` VALUES ('bIFFbu', '中国财经网', 'http://www.fecn.net/', 'BfqeYz', 'friendlyLinks', null, '22', '1', '2013-06-03 13:31:24');
INSERT INTO `tbl_links` VALUES ('bIJnua', '中国科技大学', 'http://www.ustc.edu.cn/', 'INJV3i', 'friendlyLinks', null, '10', '1', '2013-06-03 15:04:35');
INSERT INTO `tbl_links` VALUES ('BjUZbu', '中国分布式能源网', 'http://www.fbsnyw.com/', 'AvmeEf', 'friendlyLinks', null, '3', '1', '2013-06-03 15:13:21');
INSERT INTO `tbl_links` VALUES ('bMNbyy', '煤炭科工煤科总院', 'http://www.ccri.com.cn/', 'YnyAv2', 'friendlyLinks', null, '140', '1', '2013-12-25 13:21:04');
INSERT INTO `tbl_links` VALUES ('bmUVZv', '华夏新兴产业网', 'http://www.huaxiawind.cn', 'AvmeEf', 'friendlyLinks', null, '46', '1', '2013-06-05 17:06:12');
INSERT INTO `tbl_links` VALUES ('Bn6B3a', '安全管理系统', 'safe.htm', 'NnEvIb', 'outfastentrance', null, '8', '1', '2013-06-09 15:17:07');
INSERT INTO `tbl_links` VALUES ('BNFVzi', '长江三峡集团', 'http://www.ctgpc.com.cn', 'fIBrmm', 'friendlyLinks', null, '13', '1', '2013-06-03 13:50:41');
INSERT INTO `tbl_links` VALUES ('bq6Nnu', '太阳能光热网', 'http://www.solarheat.cn/', 'AvmeEf', 'friendlyLinks', null, '17', '1', '2013-06-05 16:27:39');
INSERT INTO `tbl_links` VALUES ('buaUBf', '中国油气网', 'http://www.sinooilgas.com/', 'AvmeEf', 'friendlyLinks', null, '20', '1', '2013-06-03 15:25:28');
INSERT INTO `tbl_links` VALUES ('Bzyuaq', '华电煤业', 'http://www.chdmy.com.cn', 'NJ7r2y', 'ofenLinks', null, '2', '1', '2013-05-30 11:22:38');
INSERT INTO `tbl_links` VALUES ('BZZvie', '西安交大', 'http://www.xjtu.edu.cn/', 'INJV3i', 'friendlyLinks', null, '8', '1', '2013-06-03 15:03:18');
INSERT INTO `tbl_links` VALUES ('E3yUZr', '西安热工院', 'http://www.tpri.com.cn/', 'YnyAv2', 'friendlyLinks', null, '50', '1', '2013-12-25 13:21:36');
INSERT INTO `tbl_links` VALUES ('EbMbUb', '清华大学', 'http://www.tsinghua.edu.cn', 'INJV3i', 'friendlyLinks', null, '1', '1', '2013-05-30 14:04:36');
INSERT INTO `tbl_links` VALUES ('EBnQbm', '金融网', 'http://www.financeun.com/', 'BfqeYz', 'friendlyLinks', null, '17', '1', '2013-06-03 13:28:12');
INSERT INTO `tbl_links` VALUES ('eieaUn', '火力发电网', 'http://www.hlfdw.com/', 'AvmeEf', 'friendlyLinks', null, '32', '1', '2013-06-05 16:28:52');
INSERT INTO `tbl_links` VALUES ('ENJFje', '邮件系统', 'http://mail.chdi.ac.cn/', 'NnEvIb', 'outfastentrance', null, '1', '1', '2013-05-29 18:04:50');
INSERT INTO `tbl_links` VALUES ('eqQbay', '国家人社部', 'http://www.mohrss.gov.cn/', 'INjERr', 'friendlyLinks', null, '17', '1', '2013-06-03 13:42:16');
INSERT INTO `tbl_links` VALUES ('eQVvii', '国家信息中心', 'http://www.sic.gov.cn/', 'muIvme', 'ofenLinks', null, '102', '1', '2014-02-19 13:47:00');
INSERT INTO `tbl_links` VALUES ('eYfU32', '中国风能网', 'http://www.windpower.cn/', 'AvmeEf', 'friendlyLinks', null, '12', '1', '2013-06-05 16:17:26');
INSERT INTO `tbl_links` VALUES ('eymArm', '中国新能源产业研究网', 'http://ne.ciedr.com/', 'ZZRJne', 'friendlyLinks', null, '60', '1', '2013-12-25 13:15:14');
INSERT INTO `tbl_links` VALUES ('Eze6Bv', '中国社会科学院世界经济与政治研究所', 'http://www.iwep.org.cn/', 'muIvme', 'ofenLinks', null, '108', '1', '2014-02-19 13:48:34');
INSERT INTO `tbl_links` VALUES ('EZvANf', '华中科技大学', 'http://www.hust.edu.cn/', 'INJV3i', 'friendlyLinks', null, '12', '1', '2013-06-03 15:05:03');
INSERT INTO `tbl_links` VALUES ('F3UZBn', '科技成果发布(在建)', '#', 'NnEvIb', 'outfastentrance', null, '6', '1', '2013-06-08 16:54:04');
INSERT INTO `tbl_links` VALUES ('F7bI7f', '资源综合利用协会', 'http://www.carcu.org/', 'NVZZRr', 'friendlyLinks', null, '15', '1', '2013-06-05 15:42:48');
INSERT INTO `tbl_links` VALUES ('fARBFf', '国家工信部', 'http://www.miit.gov.cn', 'INjERr', 'friendlyLinks', null, '11', '1', '2013-06-03 13:37:58');
INSERT INTO `tbl_links` VALUES ('FB7N7r', 'zfbm1', 'http://emial.com', '2meuyy', 'friendlyLinks', null, '1', '1', '2013-05-16 19:14:02');
INSERT INTO `tbl_links` VALUES ('FBFjIn', '中海油', 'http://www.cnooc.com.cn', 'fIBrmm', 'friendlyLinks', null, '19', '1', '2013-05-30 13:25:51');
INSERT INTO `tbl_links` VALUES ('fIBJBj', '视频会议系统(在建)', '#', 'NnEvIb', 'outfastentrance', null, '3', '1', '2013-05-21 09:06:42');
INSERT INTO `tbl_links` VALUES ('FjyaAr', '北极星电力网', 'http://www.bjx.com.cn/', 'NJNzQ3', 'friendlyLinks', null, '3', '1', '2013-06-03 14:04:25');
INSERT INTO `tbl_links` VALUES ('FRNjMn', '中国人民大学国际能源战略研究中心', 'http://sis.ruc.edu.cn/cieess/', 'muIvme', 'ofenLinks', null, '20', '1', '2014-02-19 13:45:12');
INSERT INTO `tbl_links` VALUES ('fUVzIf', '中电联', 'http://www.cec.org.cn', 'NVZZRr', 'friendlyLinks', null, '1', '1', '2013-05-30 13:48:55');
INSERT INTO `tbl_links` VALUES ('Fz2UZj', '新浪网', 'http://www.sina.com.cn', 'BfqeYz', 'friendlyLinks', null, '7', '1', '2013-06-03 13:23:37');
INSERT INTO `tbl_links` VALUES ('I3UjIj', '国资委', 'http://www.sasac.gov.cn', 'INjERr', 'friendlyLinks', null, '2', '1', '2013-06-03 13:13:13');
INSERT INTO `tbl_links` VALUES ('iamQfi', '中国能源协会', 'http://www.zhnx.org.cn/', 'NVZZRr', 'friendlyLinks', null, '9', '1', '2013-06-03 14:26:44');
INSERT INTO `tbl_links` VALUES ('iaUVNj', '中科院热物理所', 'http://www.iet.cas.cn/', 'YnyAv2', 'friendlyLinks', null, '4', '1', '2013-12-25 13:23:31');
INSERT INTO `tbl_links` VALUES ('IBjyMj', '国家能源网', 'http://www.ocpe.com.cn/', 'muIvme', 'ofenLinks', 'userfiles/upload/user-images/2013/11/07/20131107172715.jpg', '6', '1', '2014-02-19 13:12:37');
INSERT INTO `tbl_links` VALUES ('iE7rYj', '新能源科技协会', 'http://www.netc.org.cn/', 'NVZZRr', 'friendlyLinks', null, '14', '1', '2013-06-03 14:23:07');
INSERT INTO `tbl_links` VALUES ('iEJRzm', '能源网', 'http://www.nengyuan.com/', 'NJNzQ3', 'friendlyLinks', null, '13', '1', '2013-06-03 14:11:28');
INSERT INTO `tbl_links` VALUES ('iER3ea', '神华集团', 'http://www.shenhuagroup.com.cn', 'fIBrmm', 'friendlyLinks', null, '7', '1', '2013-06-03 13:48:58');
INSERT INTO `tbl_links` VALUES ('IF3mMb', '中国液化天然气网', 'http://www.cnlng.com/', 'AvmeEf', 'friendlyLinks', null, '11', '1', '2013-06-03 15:24:36');
INSERT INTO `tbl_links` VALUES ('IFr2Yz', '可再生能源协会', 'http://www.chnreia.org/', 'NVZZRr', 'friendlyLinks', null, '10', '1', '2013-06-03 14:21:53');
INSERT INTO `tbl_links` VALUES ('iINvMf', '档案管理系统(在建)', '#', 'NnEvIb', 'outfastentrance', null, '5', '1', '2013-05-21 09:07:11');
INSERT INTO `tbl_links` VALUES ('IjyYbq', '厦门大学', 'http://www.xmu.edu.cn', 'INJV3i', 'friendlyLinks', null, '6', '1', '2013-05-30 14:05:25');
INSERT INTO `tbl_links` VALUES ('iMFzme', '中国电动车网', 'http://www.ddc.net.cn/', 'AvmeEf', 'friendlyLinks', null, '26', '1', '2013-06-05 16:20:54');
INSERT INTO `tbl_links` VALUES ('imQ7ju', '国家电网', 'http://www.sgcc.com.cn', 'fIBrmm', 'friendlyLinks', null, '5', '1', '2013-05-30 13:03:51');
INSERT INTO `tbl_links` VALUES ('iQ7bey', '国家科技部      ', 'http://www.most.gov.cn', 'INjERr', 'friendlyLinks', null, '6', '1', '2013-06-03 13:14:02');
INSERT INTO `tbl_links` VALUES ('iqmARb', '中国石油', 'http://www.cnpc.com.cn', 'fIBrmm', 'friendlyLinks', null, '17', '1', '2013-05-30 13:24:21');
INSERT INTO `tbl_links` VALUES ('iqyuA3', 'tre', 'tr', '2meuyy', 'friendlyLinks', null, '0', '1', '2013-05-28 22:04:05');
INSERT INTO `tbl_links` VALUES ('iUBzqa', '中国核能行业协会', 'http://www.china-nea.cn/', 'NVZZRr', 'friendlyLinks', null, '30', '1', '2013-06-05 16:09:39');
INSERT INTO `tbl_links` VALUES ('Ivq2Mr', '集团通讯录', 'http://uc.chd.com.cn:9081/coa/main.jsp', 'QZbM7n', 'infastentrance', null, '0', '1', '2013-05-29 09:31:29');
INSERT INTO `tbl_links` VALUES ('iYv6zi', '中国能源网', 'http://www.china5e.com/', 'muIvme', 'ofenLinks', 'userfiles/upload/user-images/2013/11/07/20131107172241.jpg', '2', '1', '2013-11-07 17:26:13');
INSERT INTO `tbl_links` VALUES ('J3eu6n', '厦门大学中国能源经济研究中心', 'http://cceer.xmu.edu.cn/', 'muIvme', 'ofenLinks', 'userfiles/upload/user-images/2013/11/07/20131107173143.jpg', '8', '1', '2013-11-07 17:31:43');
INSERT INTO `tbl_links` VALUES ('J3ymIb', '中科院山西煤化所', 'http://www.sxicc.cas.cn/', 'YnyAv2', 'friendlyLinks', null, '8', '1', '2013-12-25 13:24:58');
INSERT INTO `tbl_links` VALUES ('jaENfm', '中国投资研究网', 'http://www.chnir.com/', 'ZZRJne', 'friendlyLinks', null, '40', '1', '2013-12-25 12:28:37');
INSERT INTO `tbl_links` VALUES ('jaqEvm', '后勤服务', 'pl-news-rUFz2e.htm', 'NnEvIb', 'outfastentrance', null, '15', '1', '2013-06-09 15:12:25');
INSERT INTO `tbl_links` VALUES ('JBb6Rr', '中国煤炭工业网', 'http://www.cec1979.org.cn/', 'NJNzQ3', 'friendlyLinks', null, '9', '1', '2013-06-03 14:11:05');
INSERT INTO `tbl_links` VALUES ('Jbqi2i', '国务院发展研究中心', 'http://www.drc.gov.cn/', 'muIvme', 'ofenLinks', null, '100', '1', '2014-02-19 13:14:08');
INSERT INTO `tbl_links` VALUES ('JfmqIz', '中国石油经济技术研究院', 'http://etri.cnpc.com.cn/etri/', 'muIvme', 'ofenLinks', null, '60', '1', '2014-02-19 13:39:06');
INSERT INTO `tbl_links` VALUES ('jiAzqm', '葛洲坝集团', 'http://www.cggc.cn', 'fIBrmm', 'friendlyLinks', null, '12', '1', '2013-05-30 13:20:31');
INSERT INTO `tbl_links` VALUES ('JN3QNz', '中石油经济技术院', 'http://www.cnpc.com.cn/etri/', 'YnyAv2', 'friendlyLinks', null, '120', '1', '2013-12-25 13:21:09');
INSERT INTO `tbl_links` VALUES ('JNBrEb', '中国石化', 'http://www.sinopecgroup.com', 'fIBrmm', 'friendlyLinks', null, '18', '1', '2013-05-30 13:24:46');
INSERT INTO `tbl_links` VALUES ('jQvU3u', '机构网站', '#', 'muIvme', 'ofenLinks', null, '0', '1', '2014-02-15 16:03:01');
INSERT INTO `tbl_links` VALUES ('Jv2Y3e', '全球电动车网', 'http://www.qqddc.com/', 'AvmeEf', 'friendlyLinks', null, '28', '1', '2013-06-05 16:21:03');
INSERT INTO `tbl_links` VALUES ('jyURju', '中华生物质能网', 'http://www.china-bioenergy.cn/', 'AvmeEf', 'friendlyLinks', null, '15', '1', '2013-06-05 16:29:42');
INSERT INTO `tbl_links` VALUES ('Jzm67r', '国家质检总局', 'http://www.aqsiq.gov.cn', 'INjERr', 'friendlyLinks', null, '18', '1', '2013-06-03 13:38:08');
INSERT INTO `tbl_links` VALUES ('MbAjAb', '地质大学（北京）', 'http://www.cugb.edu.cn/', 'INJV3i', 'friendlyLinks', null, '5', '1', '2013-06-03 14:59:30');
INSERT INTO `tbl_links` VALUES ('MFrMVv', '新华网', 'http://www.xinhuanet.com', 'BfqeYz', 'friendlyLinks', null, '1', '1', '2013-05-30 13:30:21');
INSERT INTO `tbl_links` VALUES ('mMf2Ib', '中国非常规油气网', 'http://www.shalegas.cn/', 'AvmeEf', 'friendlyLinks', null, '4', '1', '2013-06-03 15:13:28');
INSERT INTO `tbl_links` VALUES ('Mn26Br', '电力建设企业协会', 'http://www.cepca.org.cn/', 'NVZZRr', 'friendlyLinks', null, '26', '1', '2013-06-05 16:08:14');
INSERT INTO `tbl_links` VALUES ('MR3iam', '中国国电', 'http://www.cgdc.com.cn', 'fIBrmm', 'friendlyLinks', null, '3', '1', '2013-06-03 14:44:39');
INSERT INTO `tbl_links` VALUES ('NBju6r', '中石化科学研究院', 'http://www.ripp-sinopec.com/', 'YnyAv2', 'friendlyLinks', null, '240', '1', '2013-12-25 13:20:56');
INSERT INTO `tbl_links` VALUES ('NfmEbm', '中国商业联合会', 'http://www.cgcc.org.cn/', 'NVZZRr', 'friendlyLinks', null, '40', '1', '2013-06-05 16:08:37');
INSERT INTO `tbl_links` VALUES ('NjYFBr', '能源观察网', 'http://www.chinaero.com.cn/', 'NJNzQ3', 'friendlyLinks', null, '7', '1', '2013-06-03 14:12:02');
INSERT INTO `tbl_links` VALUES ('Nnuu6b', '中国电建', 'http://www.zhongguodianjian.com', 'fIBrmm', 'friendlyLinks', null, '10', '1', '2013-06-03 13:49:48');
INSERT INTO `tbl_links` VALUES ('NremUv', '国促会电委会', 'http://www.ccpit-ep.org/', 'NJNzQ3', 'friendlyLinks', null, '12', '1', '2013-06-05 13:00:44');
INSERT INTO `tbl_links` VALUES ('NrmUNn', '中国铁路客服中心', 'http://www.12306.cn', 'beu6Nv', 'ofenLinks', null, '5', '1', '2013-05-30 11:22:10');
INSERT INTO `tbl_links` VALUES ('nuauai', '搜狐网', 'http://www.sohu.com', 'BfqeYz', 'friendlyLinks', null, '8', '1', '2013-06-03 13:23:49');
INSERT INTO `tbl_links` VALUES ('nYrMnm', '海南航空', 'http://www.hnair.com', 'beu6Nv', 'ofenLinks', null, '4', '1', '2013-05-30 11:21:57');
INSERT INTO `tbl_links` VALUES ('Q3YJv2', '中国产业竞争情报网', 'http://www.chinacir.com.cn/', 'ZZRJne', 'friendlyLinks', null, '50', '1', '2013-12-25 12:29:32');
INSERT INTO `tbl_links` VALUES ('q6Zzmu', '中电投', 'http://www.zdt.com.cn', 'fIBrmm', 'friendlyLinks', null, '4', '1', '2013-05-30 11:32:19');
INSERT INTO `tbl_links` VALUES ('Qbuei2', '中国华能', 'http://www.chng.com.cn', 'fIBrmm', 'friendlyLinks', null, '1', '1', '2013-06-03 13:48:26');
INSERT INTO `tbl_links` VALUES ('qEbQRr', '国土资源部', 'http://www.mlr.gov.cn/', 'INjERr', 'friendlyLinks', null, '8', '1', '2013-06-03 13:37:15');
INSERT INTO `tbl_links` VALUES ('QFviMn', '华电福新能源', 'http://www.hdfx.com.cn', 'NJ7r2y', 'ofenLinks', null, '4', '1', '2013-05-30 11:22:52');
INSERT INTO `tbl_links` VALUES ('qI3aA3', '太阳能光伏网', 'http://www.solar-pv.cn/', 'AvmeEf', 'friendlyLinks', null, '16', '1', '2013-06-05 16:23:19');
INSERT INTO `tbl_links` VALUES ('qIFjIr', '水电水利规划设计总院', 'http://www.sdghzy.cn/', 'muIvme', 'ofenLinks', null, '200', '1', '2014-02-19 13:37:22');
INSERT INTO `tbl_links` VALUES ('QnUram', '中科院兰州油气中心', 'http://www.lig.cas.cn/', 'YnyAv2', 'friendlyLinks', null, '10', '1', '2013-12-25 13:25:57');
INSERT INTO `tbl_links` VALUES ('qYV7Zv', '集团信息门户', 'http://portal.chd.com.cn/por/wps/portal/', 'QZbM7n', 'infastentrance', null, '1', '1', '2013-05-29 09:33:50');
INSERT INTO `tbl_links` VALUES ('QZZ3Ib', '中国煤炭网', 'http://www.ccoalnews.com', 'NJNzQ3', 'friendlyLinks', null, '8', '1', '2013-06-03 14:12:12');
INSERT INTO `tbl_links` VALUES ('R3quQ3', '集团系统网站', '#', 'NJ7r2y', 'ofenLinks', null, '0', '1', '2014-02-15 16:01:13');
INSERT INTO `tbl_links` VALUES ('R3Yfeu', '中国新能源汽车网', 'http://www.chinanev.net/', 'AvmeEf', 'friendlyLinks', null, '40', '1', '2013-12-26 14:59:32');
INSERT INTO `tbl_links` VALUES ('RB3aQ3', '中国华电集团', 'http://www.chd.com.cn/', 'NJ7r2y', 'ofenLinks', null, '1', '1', '2014-02-15 16:01:21');
INSERT INTO `tbl_links` VALUES ('Rfi2U3', '国家住建部', 'http://www.mohurd.gov.cn/', 'INjERr', 'friendlyLinks', null, '16', '1', '2013-06-03 13:41:09');
INSERT INTO `tbl_links` VALUES ('RfU3Ev', '国家统计局', 'http://www.stats.gov.cn/', 'INjERr', 'friendlyLinks', null, '22', '1', '2013-06-03 13:45:56');
INSERT INTO `tbl_links` VALUES ('RjEVrm', '中国能源法律网', 'http://www.energylaw.org.cn/', 'NJNzQ3', 'friendlyLinks', null, '40', '1', '2013-06-03 14:07:23');
INSERT INTO `tbl_links` VALUES ('rm2iQr', '      国家能源局', 'http://www.nea.gov.cn', 'INjERr', 'friendlyLinks', null, '3', '1', '2013-06-03 13:13:26');
INSERT INTO `tbl_links` VALUES ('rmUvQj', '南方电网', 'http://www.csg.cn', 'fIBrmm', 'friendlyLinks', null, '6', '1', '2013-05-30 13:04:49');
INSERT INTO `tbl_links` VALUES ('RN3Er2', '国际能源网', 'http://www.in-en.com', 'NJNzQ3', 'friendlyLinks', null, '14', '1', '2013-06-03 14:12:28');
INSERT INTO `tbl_links` VALUES ('RNRz2y', '中石化勘探研究院', 'http://www.pepris.com/', 'YnyAv2', 'friendlyLinks', null, '250', '1', '2013-12-25 13:20:50');
INSERT INTO `tbl_links` VALUES ('RnYb6n', '通讯录', 'mg/home.htm?opt=contact', 'NnEvIb', 'outfastentrance', null, '0', '1', '2013-05-25 10:16:41');
INSERT INTO `tbl_links` VALUES ('RRJRj2', '能源经济网', 'http://www.inengyuan.com/', 'muIvme', 'ofenLinks', 'userfiles/upload/user-images/2013/11/07/20131107172056.jpg', '1', '1', '2014-02-15 16:02:51');
INSERT INTO `tbl_links` VALUES ('RRVZBb', '国开投', 'http://www.sdic.com.cn', 'fIBrmm', 'friendlyLinks', null, '15', '1', '2013-06-03 13:50:59');
INSERT INTO `tbl_links` VALUES ('rU3q6f', '中国经济网', 'http://www.ce.cn/', 'BfqeYz', 'friendlyLinks', null, '6', '1', '2013-05-30 13:32:48');
INSERT INTO `tbl_links` VALUES ('rUbUfi', '中国科协', 'http://www.cast.org.cn/', 'NVZZRr', 'friendlyLinks', null, '3', '1', '2013-06-03 14:25:29');
INSERT INTO `tbl_links` VALUES ('rUrYNf', '中国大唐', 'http://www.china-cdt.com', 'fIBrmm', 'friendlyLinks', null, '2', '1', '2013-06-03 14:44:31');
INSERT INTO `tbl_links` VALUES ('Rv2A7f', '中国企业联合会', 'http://www.cec1979.org.cn/', 'NVZZRr', 'friendlyLinks', null, '5', '1', '2013-06-03 14:26:12');
INSERT INTO `tbl_links` VALUES ('U3qyay', '21CN', 'http://www.21cn.com', 'BfqeYz', 'friendlyLinks', null, '11', '1', '2013-06-03 13:21:20');
INSERT INTO `tbl_links` VALUES ('U7ZrM3', '中煤能源', 'http://www.chinacoal.com', 'fIBrmm', 'friendlyLinks', null, '20', '1', '2013-05-30 13:27:28');
INSERT INTO `tbl_links` VALUES ('uEzeEb', '能源经济网', 'http://www.inengyuan.com/', 'NJNzQ3', 'friendlyLinks', null, '0', '1', '2013-12-25 12:06:40');
INSERT INTO `tbl_links` VALUES ('UJFjme', '中国电力报', 'http://www.zgdlcm.com/', 'NJNzQ3', 'friendlyLinks', null, '24', '1', '2013-06-03 14:10:33');
INSERT INTO `tbl_links` VALUES ('UJZjaq', '中国节能网', 'http://www.jnmaimai.com/', 'AvmeEf', 'friendlyLinks', null, '30', '1', '2013-06-05 16:28:26');
INSERT INTO `tbl_links` VALUES ('uqAn2a', '中国东方航空公司', 'http://www.ceair.com/', 'beu6Nv', 'ofenLinks', null, '6', '1', '2014-02-15 16:02:26');
INSERT INTO `tbl_links` VALUES ('uqMbq2', '华电工程', 'http://www.chec.com.cn/', 'NJ7r2y', 'ofenLinks', null, '6', '1', '2014-02-15 16:01:49');
INSERT INTO `tbl_links` VALUES ('V36nea', '北京理工大学能源与环境政策研究中心', 'http://www.ceep.net.cn/index1.asp', 'muIvme', 'ofenLinks', 'userfiles/upload/user-images/2013/11/07/20131107173243.jpg', '10', '1', '2013-11-07 17:32:43');
INSERT INTO `tbl_links` VALUES ('v6FnM3', '国家商务部', 'http://www.mofcom.gov.cn/', 'INjERr', 'friendlyLinks', null, '15', '1', '2013-06-03 13:39:58');
INSERT INTO `tbl_links` VALUES ('VbM7nm', '科研项目管理系统(在建)', '#', 'NnEvIb', 'outfastentrance', null, '4', '1', '2013-05-21 09:06:59');
INSERT INTO `tbl_links` VALUES ('VBRfmi', '华电国际', 'http://www.hdpi.cn', 'NJ7r2y', 'ofenLinks', null, '3', '1', '2014-02-15 16:01:32');
INSERT INTO `tbl_links` VALUES ('vMbQVb', '电力规划设计总院', 'http://www.eppei.com/', 'muIvme', 'ofenLinks', null, '180', '1', '2014-02-19 13:30:13');
INSERT INTO `tbl_links` VALUES ('VraAfy', '中国石化经济技术研究院', 'http://www.sinopecgroup.com/gsjs/shwq/Pages/jjjsyjy.aspx', 'muIvme', 'ofenLinks', null, '80', '1', '2014-02-19 13:41:50');
INSERT INTO `tbl_links` VALUES ('VrYJJn', '国家安监总局', 'http://www.chinasafety.gov.cn', 'INjERr', 'friendlyLinks', null, '19', '1', '2013-06-03 13:38:21');
INSERT INTO `tbl_links` VALUES ('vyEBNz', '中国产业研究网', 'http://www.chinacyyj.com/', 'ZZRJne', 'friendlyLinks', null, '55', '1', '2013-12-25 12:35:18');
INSERT INTO `tbl_links` VALUES ('Vzqmui', '中国LNG汽车网', 'http://www.lngche.com/', 'AvmeEf', 'friendlyLinks', null, '24', '1', '2013-06-05 16:20:42');
INSERT INTO `tbl_links` VALUES ('YbMN3e', '中青在线', 'http://www.cyol.net/', 'BfqeYz', 'friendlyLinks', null, '20', '1', '2013-06-03 13:30:31');
INSERT INTO `tbl_links` VALUES ('ye2yUv', '中国电力新闻网', 'http://www.cpnn.com.cn', 'NJNzQ3', 'friendlyLinks', null, '4', '1', '2013-06-03 14:08:13');
INSERT INTO `tbl_links` VALUES ('yIBNZr', '中国社会科学院法学研究所', 'http://www.iolaw.org.cn/', 'muIvme', 'ofenLinks', null, '150', '1', '2014-02-19 13:26:45');
INSERT INTO `tbl_links` VALUES ('yIFvIv', '凤凰网', 'http://www.ifeng.com/', 'BfqeYz', 'friendlyLinks', null, '10', '1', '2013-06-03 13:20:39');
INSERT INTO `tbl_links` VALUES ('yiUBN3', '电力规划设计协会', 'http://www.ceppea.net/', 'NVZZRr', 'friendlyLinks', null, '28', '1', '2013-06-05 16:08:26');
INSERT INTO `tbl_links` VALUES ('YNnEBz', '携程网', 'http://www.ctrip.com/', 'beu6Nv', 'ofenLinks', null, '3', '1', '2014-02-15 16:02:12');
INSERT INTO `tbl_links` VALUES ('yqMruy', '中科院电工所', 'http://www.iee.cas.cn/', 'YnyAv2', 'friendlyLinks', null, '2', '1', '2013-12-25 13:22:58');
INSERT INTO `tbl_links` VALUES ('yUBRna', '国家发展和改革委员会能源研究所', 'http://www.eri.org.cn/', 'muIvme', 'ofenLinks', null, '104', '1', '2014-02-19 13:47:31');
INSERT INTO `tbl_links` VALUES ('yuqUZr', '中国页岩气网', 'http://www.csgcn.com.cn/', 'AvmeEf', 'friendlyLinks', null, '5', '1', '2013-06-03 15:20:48');
INSERT INTO `tbl_links` VALUES ('yy2AZv', '东南大学', 'http://www.seu.edu.cn/', 'INJV3i', 'friendlyLinks', null, '7', '1', '2013-06-03 15:02:35');
INSERT INTO `tbl_links` VALUES ('YZ7vEz', '中国煤化网', 'http://www.chinacoalchem.com/', 'AvmeEf', 'friendlyLinks', null, '6', '1', '2013-06-03 15:14:27');
INSERT INTO `tbl_links` VALUES ('z6B3Qz', '中投顾问', 'http://www.ocn.com.cn/us/', 'ZZRJne', 'friendlyLinks', null, '20', '1', '2013-12-25 12:28:21');
INSERT INTO `tbl_links` VALUES ('Z7Vjai', '国电南自', 'http://www.sac-china.com', 'NJ7r2y', 'ofenLinks', null, '5', '1', '2013-05-30 11:23:00');
INSERT INTO `tbl_links` VALUES ('Z7vUju', 'rer', 're', '2meuyy', 'friendlyLinks', 'userfiles/upload/user-images/2013/05/28/20130528215946.jpg', '0', '1', '2013-05-28 21:59:46');
INSERT INTO `tbl_links` VALUES ('Zb2aMv', '中广核', 'http://www.stats.gov.cn/', 'fIBrmm', 'friendlyLinks', null, '25', '1', '2013-06-03 13:54:43');
INSERT INTO `tbl_links` VALUES ('ZbAB7z', '华润集团', 'http://www.crc.com.hk', 'fIBrmm', 'friendlyLinks', null, '8', '1', '2013-06-03 13:49:34');
INSERT INTO `tbl_links` VALUES ('zeAZFn', '国家电监会', 'http://www.serc.gov.cn', 'INjERr', 'friendlyLinks', null, '5', '1', '2013-06-03 13:13:40');
INSERT INTO `tbl_links` VALUES ('zIfaAr', 'OA办公系统', 'http://oa.chdi.ac.cn/', 'NnEvIb', 'outfastentrance', null, '2', '1', '2013-05-29 18:04:41');
INSERT INTO `tbl_links` VALUES ('zINR3i', '央视国际', 'http://www.cntv.cn', 'BfqeYz', 'friendlyLinks', null, '5', '1', '2013-05-30 13:32:13');
INSERT INTO `tbl_links` VALUES ('zIZrEj', '光明网', 'http://www.gmw.cn/', 'BfqeYz', 'friendlyLinks', null, '14', '1', '2013-06-03 13:25:39');
INSERT INTO `tbl_links` VALUES ('zq2q6v', '中国电科院', 'http://www.epri.sgcc.com.cn', 'YnyAv2', 'friendlyLinks', null, '30', '1', '2013-12-25 13:21:53');
INSERT INTO `tbl_links` VALUES ('zuQjUv', '全国工商联', 'http://www.acfic.org.cn/', 'NVZZRr', 'friendlyLinks', null, '4', '1', '2013-06-03 14:16:34');
INSERT INTO `tbl_links` VALUES ('zuQNne', '中国国际工程咨询公司', 'http://www.ciecc.com.cn/', 'muIvme', 'ofenLinks', null, '170', '1', '2014-02-19 13:29:18');
INSERT INTO `tbl_links` VALUES ('ZvEfE3', '中国石油勘探开发研究院', 'http://riped.cnpc.com.cn/riped/', 'muIvme', 'ofenLinks', null, '70', '1', '2014-02-19 13:40:11');
INSERT INTO `tbl_links` VALUES ('ZVVJva', '国家发改委&nbsp;&nbsp;', 'http://www.sdpc.gov.cn', 'INjERr', 'friendlyLinks', null, '1', '1', '2013-06-13 07:00:42');
INSERT INTO `tbl_links` VALUES ('zyqEru', '兄弟部门1', 'http://www.google.com.hk1', '2meuyy', 'friendlyLinks', null, '41', '0', '2013-05-17 08:19:00');
INSERT INTO `tbl_links` VALUES ('Zzi6Zj', '中国产业研究院', 'http://www.chinacyyj.com/', 'ZZRJne', 'friendlyLinks', null, '1', '1', '2013-12-25 12:28:09');

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
INSERT INTO `tbl_meta` VALUES ('page_foot', '<div class=\"footer\">\r\n    <center>\r\n        <table width=\"650\" border=\"0\" cellspacing=\"0\" align=\"center\">\r\n            <tr>\r\n                <td rowspan=\"3\" width=\"75\"><img src=\"http://library.chdi.ac.cn/res/front/library/images/footer.jpg\" /></td>\r\n                <td>中国华电集团科学技术研究总院 版权所有 京ICP备05084797号 邮编：100077 传真：010-59216299</td>\r\n            </tr>\r\n            <tr>\r\n                <td>地址：北京市东城区永定门西滨河路8号院7号楼中海地产广场东塔11层 电话：010-59216201</td>\r\n            </tr>\r\n            <tr>\r\n                <td>\r\n建议使用IE6.0以上版本浏览器1024*768分辨率浏览本网站。   网站被访问 <script src=\"http://www.svrsec.com/cfstat/cf.php?username=chdtsg\"></script> 次\r\n               </td>\r\n            </tr>\r\n                     </table>           \r\n    </center>\r\n</div>');
INSERT INTO `tbl_meta` VALUES ('library_title', '华电迷你图书馆——您身边的能源行业情报秘书');
INSERT INTO `tbl_meta` VALUES ('library_content', '<ul>\r\n	<li class=\"libIntroduct\">\r\n		<b><span style=\"line-height:1.5;\">主管：中国华电集团公司</span></b>\r\n	</li>\r\n	<li class=\"libIntroduct\">\r\n		<b><span style=\"line-height:1.5;\">主办：中国华电集团科学技术研究总院&nbsp;</span></b> \r\n	</li>\r\n	<li class=\"libIntroduct\">\r\n		<br />\r\n	</li>\r\n</ul>\r\n<ul>\r\n	<li class=\"libIntroduct\">\r\n		<b><span style=\"line-height:1.5;\">阅读须知：</span></b><span style=\"line-height:1.5;\">如需深度阅读馆藏资料，请在本站首页进行注册。</span> \r\n	</li>\r\n	<li class=\"libIntroduct\">\r\n		<b><span style=\"line-height:1.5;\">资料复制：</span></b><span style=\"line-height:1.5;\">如需下载复制本站有关资料，请按下面联系方式联系。</span> \r\n	</li>\r\n	<li class=\"libIntroduct\">\r\n		<b><span style=\"line-height:1.5;\">委托订阅：</span></b><span style=\"line-height:1.5;\">如需委托订阅能源行业信息情报资料，请按下面联系方式联系。</span> \r\n	</li>\r\n	<li class=\"libIntroduct\">\r\n		<b><span style=\"line-height:1.5;\">联系</span></b><b><span style=\"line-height:1.5;\">电话：</span></b><span style=\"line-height:1.5;\">010-5921 6201；189 1180 3600；&nbsp;联系人：</span><span style=\"line-height:1.5;\">张锋；&nbsp;</span><span style=\"line-height:1.5;\">&nbsp;</span> \r\n	</li>\r\n	<li class=\"libIntroduct\">\r\n		<b><span style=\"line-height:1.5;\">E-mail</span><span><span style=\"line-height:1.5;\">：</span><span id=\"__kindeditor_bookmark_end_17__\"></span></span></b><a href=\"mailto:feng-zhang@chdi.ac.cn\"><span style=\"line-height:1.5;\">feng-zhang@chdi.ac.cn</span></a><span style=\"line-height:1.5;\">；</span><a href=\"mailto:zhangfengvipchina@163.com\"><span style=\"line-height:1.5;\">zhangfengvipchina@163.com</span></a><span style=\"line-height:1.5;\">。</span> \r\n	</li>\r\n</ul>');
INSERT INTO `tbl_meta` VALUES ('contact_us', '<span>中国华电集团科学技术研究总院</span><span style=\"line-height:1.5;\"></span><br />\r\n<p>\r\n	<span style=\"color:#000000;\">邮编：100077；传真：010 - 5921 6299</span>；<span>电话：010 - 5921 6298</span> \r\n</p>\r\n<p>\r\n	<span>地址：北京市东城区永定门西滨河路8号院7号楼中海地产广场东塔11层</span> \r\n</p>\r\n<p>\r\n	<iframe src=\"http://library.chdi.ac.cn/kindeditor/plugins/baidumap/index.html?center=116.396417%2C39.876149&zoom=19&width=558&height=360&markers=116.396417%2C39.876149&markerStyles=l%2CA\" frameborder=\"0\" style=\"width:560px;height:362px;\">\r\n	</iframe>\r\n</p>');

-- ----------------------------
-- Table structure for `tbl_post`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_post`;
CREATE TABLE `tbl_post` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `post_category_id_fk` varchar(32) default NULL COMMENT '分类ID tbl_category',
  `post_category_type` varchar(32) default NULL COMMENT '分类类型',
  `post_title` varchar(1000) default NULL COMMENT '标题',
  `post_author` varchar(100) default NULL COMMENT '发布人',
  `post_source` varchar(100) default NULL COMMENT '内容来源',
  `post_publish_time` datetime default NULL COMMENT '发布时间',
  `post_update_time` datetime default NULL COMMENT '更新时间',
  `post_summary` text COMMENT '摘要',
  `post_content` text,
  `post_user_id_fk` varchar(255) default NULL COMMENT '发布人，暂时没用,关联用户表',
  `post_show_index` tinyint(4) default '1' COMMENT '是否首页显示 1=是 0=否',
  `post_show_list` tinyint(4) default '1' COMMENT '是否列表显示 1=是',
  `post_show_focusimage` tinyint(4) default '0' COMMENT '是否焦点图显示',
  `post_focusimage` varchar(500) default NULL COMMENT '图片',
  `post_order` int(11) default '0' COMMENT '排序，越大越靠前',
  `post_show_top` tinyint(4) default '0' COMMENT '是否置顶 1=置顶 0=否',
  `post_toporder` int(11) default '0' COMMENT '置顶排序，越大越靠前',
  PRIMARY KEY  (`id`),
  KEY `idx_post_id` (`id`),
  KEY `idx_post_category` (`post_category_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主体内容';

-- ----------------------------
-- Records of tbl_post
-- ----------------------------
INSERT INTO `tbl_post` VALUES ('AJBJzy', 'VBvABv', 'INTRODUCE', '公司介绍', '周杨', '公司介绍', '2014-04-12 20:50:10', '2014-04-12 20:50:10', '公司介绍', '<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;中国华电工程（集团）有限公司（简称华电工程，英文缩写CHEC）是中国华电集团公司下属的全资企业，是中国华电集团公司工程技术产业板块的重要组成部分和发展平台。\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n&nbsp;&nbsp;&nbsp; 在中国华电集团公司总体发展战略统领下，华电工程坚持以科学发展为指导，以科技创新为支撑，以用户需求为导向，不断深化企业改革取得了骄人的业绩,已经发展成为以高新技术产品研发与制造、工程设计与总承包、能源技术研究与服务为核心业务，以安全、质量、顾客满意、经济效益为核心业绩的国有大型企业集团，业务遍及海内外。主要从事<strong>重工、环保水务、工程总承包、清洁能源、能源服务</strong>五大板块业务。产品和服务涵盖电力、化工、港口、冶金、矿业、市政、新能源、进出口服务等领域。华电工程拥有国家级企业技术中心，博士后科研工作站，国家分布式能源技术中心等多个科研机构，连续多年获得行业优秀企业和首都文明单位荣誉称号。\r\n</p>\r\n<p align=\"center\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;\r\n</p>\r\n<p align=\"center\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<img alt=\"\" width=\"600\" height=\"75\" src=\"http://www.chec.com.cn/upload/fckeditor/%E7%BD%91%E7%BB%9C%E7%94%A8_%E5%89%AF%E6%9C%AC1.jpg\" /> \r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;&nbsp;&nbsp;\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;&nbsp;&nbsp; 华电工程奉行“<strong>拼搏进取、追求卓越</strong>”的企业精神，坚持“<strong>务实、创新、高效、和谐</strong>”的核心价值观，以建设具有国际竞争力的一流科工集团为使命，坚持实践科学发展，坚持走市场化、产业化、国际化、集团化的道路，积极为国家能源工程和新兴工业发展提供优质产品和技术服务，努力打造“华电科工”品牌。\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n&nbsp;&nbsp;&nbsp; 公司到2015年要达到的发展目标（“5228”）<br />\r\n&nbsp;&nbsp;&nbsp; ——形成五个核心业务板块&nbsp;<br />\r\n&nbsp;&nbsp;&nbsp; ——销售收入200亿元<br />\r\n&nbsp;&nbsp;&nbsp; ——实现利润20亿元<br />\r\n&nbsp;&nbsp;&nbsp; ——资产负债率不超过80%\r\n</p>', null, '1', '1', '0', null, '0', '0', '0');
INSERT INTO `tbl_post` VALUES ('bA3equ', 'nMjQBz', 'INTRODUCE', '组织结构', '周杨', '组织结构', '2014-04-12 20:58:44', '2014-04-12 20:58:44', '组织结构', '<div class=\"__kindeditor_paste__\">\r\n	<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n		<br />\r\n	</p>\r\n	<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n		<br />\r\n	</p>\r\n	<table border=\"0\" cellspacing=\"2\" cellpadding=\"2\" width=\"500\" align=\"center\" style=\"color:#616065;font-family:simsun;font-size:12px;background-color:#FFFFFF;\" class=\"ke-zeroborder\">\r\n		<tbody>\r\n			<tr>\r\n				<td colspan=\"3\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"40%\" align=\"center\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#b92b2b\" align=\"center\">\r\n									<strong><span>董 事 会</span></strong> \r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"4\" align=\"center\">\r\n					<p align=\"center\">\r\n						<br />\r\n					</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"3\" align=\"center\">\r\n					<div align=\"center\">\r\n						<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"260\" align=\"center\" class=\"ke-zeroborder\">\r\n							<tbody>\r\n								<tr>\r\n									<td bgcolor=\"#fedbb4\" align=\"center\">\r\n										　公 司 领 导 班 子\r\n									</td>\r\n								</tr>\r\n							</tbody>\r\n						</table>\r\n					</div>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"2\" align=\"right\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"80%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>职 能 部 门</span></strong> \r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td align=\"left\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"80%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>专 业 公 司</span></strong> \r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td valign=\"top\" width=\"245\" colspan=\"2\" align=\"right\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"80%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　办 &nbsp;&nbsp; 公&nbsp;&nbsp;&nbsp; 室\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　人 力 资 源 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　市 场 营 销 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　工 程 管 理 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									&nbsp;&nbsp;安&nbsp;全 生 产 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　财&nbsp;&nbsp;&nbsp;&nbsp;务&nbsp;&nbsp;&nbsp;&nbsp;部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　政 治 工 作 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　监 察 审 计 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　计 划 发 展 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　科 技 管 理 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<p>\r\n										　资 产 管 理 部\r\n									</p>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td valign=\"top\" width=\"241\" align=\"left\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"80%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										华电重工股份有限公司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										<div align=\"center\">\r\n											环 境 保 护 分 公 司\r\n										</div>\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										水 处 理 分 公 司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										总 承 包 分 公 司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										海 外 工 程 分 公 司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										华电新能源技术开发公司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<p>\r\n										华电分布式能源工程公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									油 气 开 发 分 公 司\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									国 际 贸 易 分 公 司\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										华 电 工 程 设 计 院\r\n									</div>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"3\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"60%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>全 资 公 司</span></strong> \r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"3\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"55%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										　华电电力科学研究院\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电郑州机械设计研究院有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										厦门克利尔能源工程有限公司　\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										　华电环保系统工程有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										电力工业产品质量标准研究所\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电水处理技术工程有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										北京华电中光新能源技术有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										北京中电恒基能源技术有限公司　\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电水务投资有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电水务工程有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电工程集团创业投资有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										北京华电万方管理体系认证中心\r\n									</p>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"2\" align=\"right\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"98%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>控 股 公 司</span></strong> \r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td align=\"left\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"98%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>参 股 公 司</span></strong> \r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td height=\"243\" valign=\"top\" colspan=\"2\" align=\"right\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"98%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										华电工程资产管理有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										华电钢结构有限责任公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										北京华电工程设计有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　北京华电工程有限公司　\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										印尼贝拉乌古圣杰拉尔有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										中国华电工程印度尼西亚有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										印尼巴厘通用能源有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										湖南省页岩气开发有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										山东华电节能技术有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										华电青岛环保技术有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										湖北省页岩气开发有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td valign=\"top\" align=\"left\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"98%\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										中国华电集团科学技术研究总院有限公司　\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										贵州黔能页岩气开发有限责任公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										江西新能页岩气开发有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　华信保险经纪有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　北京华信保险公估有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　中国华电集团财务有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　浙江杭钻机械制造股份有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　华电置业有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　福斯特惠动力机械有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　豪顿华工程有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　西门子高压开关有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　厦门ABB高压开关有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　天津港散货物流有限责任公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										华电福新能源股份有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										北京悦宏达有限责任公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										上海华滨投资有限公司\r\n									</p>\r\n									<div>\r\n										<br />\r\n									</div>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>', null, '1', '1', '0', null, '0', '0', '0');
INSERT INTO `tbl_post` VALUES ('biUJ7n', 'fYjAza', 'INTRODUCE', '公司领导', '周杨', '公司领导', '2014-04-12 20:57:58', '2014-04-12 20:57:58', '公司领导', '<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<img width=\"600\" height=\"363\" alt=\"\" src=\"http://www.chec.com.cn/upload/fckeditor/%E8%80%81%E6%80%BB%E5%90%88%E5%BD%B1%E4%BD%BF%E7%94%A8%E8%83%8C%E6%99%AF_%E5%89%AF%E6%9C%AC.jpg\" /> \r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	董事长、党组书记：孙青松&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总经理：杨&nbsp; 勇&nbsp;&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	副总经理：谢春旺&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;副总经理：马骏彪&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	总工程师：黄 湘&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 副总经理：姜学寿\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	副总经理：彭刚平&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;纪检组长：侯佳伟\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	党组成员：王汝贵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;副总经理：李林威\r\n</p>', null, '1', '1', '0', null, '0', '0', '0');
INSERT INTO `tbl_post` VALUES ('mMBrmu', 'iiuaue', 'PERFORMANCE', '工程咨询', '管理员', '华电工程集团', '2010-07-13 21:03:17', '2014-04-12 21:03:59', '工程咨询', '<p style=\"text-align:justify;color:#333333;font-family:simsun;background-color:#FFFFFF;\">\r\n	■ 新疆电力公司DBQ400Ⅲ型专用塔机咨询\r\n</p>\r\n<p style=\"text-align:justify;color:#333333;font-family:simsun;background-color:#FFFFFF;\">\r\n	■ 南京大吉铁塔厂工程咨询\r\n</p>\r\n<p style=\"text-align:justify;color:#333333;font-family:simsun;background-color:#FFFFFF;\">\r\n	■ 牟平风电一期工程项目可研技术咨询\r\n</p>\r\n<p style=\"text-align:justify;color:#333333;font-family:simsun;background-color:#FFFFFF;\">\r\n	■ 天津港东疆港区公共电源及供电系统专项规划\r\n</p>', null, '1', '1', '0', null, '0', '0', '0');
INSERT INTO `tbl_post` VALUES ('qqENjm', 'fYjAza', 'INTRODUCE', '公司领导', '周杨', '公司领导', '2014-04-12 20:57:38', '2014-04-12 20:57:38', '公司领导', '<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<img width=\"600\" height=\"363\" alt=\"\" src=\"http://www.chec.com.cn/upload/fckeditor/%E8%80%81%E6%80%BB%E5%90%88%E5%BD%B1%E4%BD%BF%E7%94%A8%E8%83%8C%E6%99%AF_%E5%89%AF%E6%9C%AC.jpg\" />\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	董事长、党组书记：孙青松&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总经理：杨&nbsp; 勇&nbsp;&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	副总经理：谢春旺&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;副总经理：马骏彪&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	总工程师：黄 湘&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 副总经理：姜学寿\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	副总经理：彭刚平&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;纪检组长：侯佳伟\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;\r\n</p>\r\n<p align=\"left\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	党组成员：王汝贵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;副总经理：李林威\r\n</p>', null, '1', '1', '0', null, '0', '0', '0');
INSERT INTO `tbl_post` VALUES ('RNnqqq', 'VBvABv', 'INTRODUCE', '公司介绍', '周杨', '公司介绍', '2014-04-12 20:57:09', '2014-04-12 20:57:09', '公司介绍', '<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;中国华电工程（集团）有限公司（简称华电工程，英文缩写CHEC）是中国华电集团公司下属的全资企业，是中国华电集团公司工程技术产业板块的重要组成部分和发展平台。\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n&nbsp;&nbsp;&nbsp; 在中国华电集团公司总体发展战略统领下，华电工程坚持以科学发展为指导，以科技创新为支撑，以用户需求为导向，不断深化企业改革取得了骄人的业绩,已经发展成为以高新技术产品研发与制造、工程设计与总承包、能源技术研究与服务为核心业务，以安全、质量、顾客满意、经济效益为核心业绩的国有大型企业集团，业务遍及海内外。主要从事<strong>重工、环保水务、工程总承包、清洁能源、能源服务</strong>五大板块业务。产品和服务涵盖电力、化工、港口、冶金、矿业、市政、新能源、进出口服务等领域。华电工程拥有国家级企业技术中心，博士后科研工作站，国家分布式能源技术中心等多个科研机构，连续多年获得行业优秀企业和首都文明单位荣誉称号。\r\n</p>\r\n<p align=\"center\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p align=\"center\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<img alt=\"\" width=\"600\" height=\"75\" src=\"http://www.chec.com.cn/upload/fckeditor/%E7%BD%91%E7%BB%9C%E7%94%A8_%E5%89%AF%E6%9C%AC1.jpg\" /> \r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;&nbsp;&nbsp; 华电工程奉行“<strong>拼搏进取、追求卓越</strong>”的企业精神，坚持“<strong>务实、创新、高效、和谐</strong>”的核心价值观，以建设具有国际竞争力的一流科工集团为使命，坚持实践科学发展，坚持走市场化、产业化、国际化、集团化的道路，积极为国家能源工程和新兴工业发展提供优质产品和技术服务，努力打造“华电科工”品牌。\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n&nbsp;&nbsp;&nbsp; 公司到2015年要达到的发展目标（“5228”）<br />\r\n&nbsp;&nbsp;&nbsp; ——形成五个核心业务板块&nbsp;<br />\r\n&nbsp;&nbsp;&nbsp; ——销售收入200亿元<br />\r\n&nbsp;&nbsp;&nbsp; ——实现利润20亿元<br />\r\n&nbsp;&nbsp;&nbsp; ——资产负债率不超过80%\r\n</p>', null, '1', '1', '0', null, '0', '0', '0');
INSERT INTO `tbl_post` VALUES ('vaaeeq', 'nMjQBz', 'INTRODUCE', '组织结构', '周杨', '组织结构', '2014-04-12 20:58:37', '2014-04-12 20:58:37', '组织结构', '<div class=\"__kindeditor_paste__\">\r\n	<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n		&nbsp;\r\n	</p>\r\n	<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n		&nbsp;\r\n	</p>\r\n	<table border=\"0\" cellspacing=\"2\" cellpadding=\"2\" width=\"500\" align=\"center\" style=\"color:#616065;font-family:simsun;font-size:12px;background-color:#FFFFFF;\">\r\n		<tbody>\r\n			<tr>\r\n				<td colspan=\"3\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"40%\" align=\"center\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#b92b2b\" align=\"center\">\r\n									<strong><span>董 事 会</span></strong>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"4\" align=\"center\">\r\n					<p align=\"center\">\r\n						&nbsp;\r\n					</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"3\" align=\"center\">\r\n					<div align=\"center\">\r\n						<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"260\" align=\"center\">\r\n							<tbody>\r\n								<tr>\r\n									<td bgcolor=\"#fedbb4\" align=\"center\">\r\n										　公 司 领 导 班 子\r\n									</td>\r\n								</tr>\r\n							</tbody>\r\n						</table>\r\n					</div>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"2\" align=\"right\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"80%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>职 能 部 门</span></strong>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td align=\"left\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"80%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>专 业 公 司</span></strong>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td valign=\"top\" width=\"245\" colspan=\"2\" align=\"right\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"80%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　办 &nbsp;&nbsp; 公&nbsp;&nbsp;&nbsp; 室\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　人 力 资 源 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　市 场 营 销 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　工 程 管 理 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									&nbsp;&nbsp;安&nbsp;全 生 产 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　财&nbsp;&nbsp;&nbsp;&nbsp;务&nbsp;&nbsp;&nbsp;&nbsp;部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　政 治 工 作 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　监 察 审 计 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　计 划 发 展 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									　科 技 管 理 部\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<p>\r\n										　资 产 管 理 部\r\n									</p>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td valign=\"top\" width=\"241\" align=\"left\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"80%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										华电重工股份有限公司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										<div align=\"center\">\r\n											环 境 保 护 分 公 司\r\n										</div>\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										水 处 理 分 公 司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										总 承 包 分 公 司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										海 外 工 程 分 公 司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										华电新能源技术开发公司\r\n									</div>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<p>\r\n										华电分布式能源工程公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									油 气 开 发 分 公 司\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									国 际 贸 易 分 公 司\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\" align=\"center\">\r\n									<div align=\"center\">\r\n										华 电 工 程 设 计 院\r\n									</div>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"3\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"60%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>全 资 公 司</span></strong>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"3\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"55%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										　华电电力科学研究院\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电郑州机械设计研究院有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										厦门克利尔能源工程有限公司　\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										　华电环保系统工程有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										电力工业产品质量标准研究所\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电水处理技术工程有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										北京华电中光新能源技术有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										北京中电恒基能源技术有限公司　\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电水务投资有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电水务工程有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										华电工程集团创业投资有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#fcecc2\">\r\n									<p align=\"center\">\r\n										北京华电万方管理体系认证中心\r\n									</p>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"2\" align=\"right\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"98%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>控 股 公 司</span></strong>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td align=\"left\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"98%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#ccccff\" align=\"center\">\r\n									<strong><span>参 股 公 司</span></strong>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td height=\"243\" valign=\"top\" colspan=\"2\" align=\"right\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"98%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										华电工程资产管理有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										华电钢结构有限责任公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										北京华电工程设计有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　北京华电工程有限公司　\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										印尼贝拉乌古圣杰拉尔有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										中国华电工程印度尼西亚有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										印尼巴厘通用能源有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										湖南省页岩气开发有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										山东华电节能技术有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										华电青岛环保技术有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										湖北省页岩气开发有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td valign=\"top\" align=\"left\">\r\n					<table border=\"0\" cellspacing=\"2\" cellpadding=\"0\" width=\"98%\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										中国华电集团科学技术研究总院有限公司　\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										贵州黔能页岩气开发有限责任公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										江西新能页岩气开发有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　华信保险经纪有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　北京华信保险公估有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　中国华电集团财务有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　浙江杭钻机械制造股份有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　华电置业有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　福斯特惠动力机械有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　豪顿华工程有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　西门子高压开关有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　厦门ABB高压开关有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										　天津港散货物流有限责任公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										华电福新能源股份有限公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										北京悦宏达有限责任公司\r\n									</p>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td bgcolor=\"#e3fcc2\">\r\n									<p align=\"center\">\r\n										上海华滨投资有限公司\r\n									</p>\r\n									<div>\r\n										<br />\r\n									</div>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>', null, '1', '1', '0', null, '0', '0', '0');
INSERT INTO `tbl_post` VALUES ('vMzeMn', 'VBvABv', 'INTRODUCE', '公司介绍', '周杨', '公司介绍', '2014-04-12 20:57:06', '2014-04-12 20:57:06', '公司介绍', '<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;中国华电工程（集团）有限公司（简称华电工程，英文缩写CHEC）是中国华电集团公司下属的全资企业，是中国华电集团公司工程技术产业板块的重要组成部分和发展平台。\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n&nbsp;&nbsp;&nbsp; 在中国华电集团公司总体发展战略统领下，华电工程坚持以科学发展为指导，以科技创新为支撑，以用户需求为导向，不断深化企业改革取得了骄人的业绩,已经发展成为以高新技术产品研发与制造、工程设计与总承包、能源技术研究与服务为核心业务，以安全、质量、顾客满意、经济效益为核心业绩的国有大型企业集团，业务遍及海内外。主要从事<strong>重工、环保水务、工程总承包、清洁能源、能源服务</strong>五大板块业务。产品和服务涵盖电力、化工、港口、冶金、矿业、市政、新能源、进出口服务等领域。华电工程拥有国家级企业技术中心，博士后科研工作站，国家分布式能源技术中心等多个科研机构，连续多年获得行业优秀企业和首都文明单位荣誉称号。\r\n</p>\r\n<p align=\"center\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p align=\"center\" style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<img alt=\"\" width=\"600\" height=\"75\" src=\"http://www.chec.com.cn/upload/fckeditor/%E7%BD%91%E7%BB%9C%E7%94%A8_%E5%89%AF%E6%9C%AC1.jpg\" /> \r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	&nbsp;&nbsp;&nbsp; 华电工程奉行“<strong>拼搏进取、追求卓越</strong>”的企业精神，坚持“<strong>务实、创新、高效、和谐</strong>”的核心价值观，以建设具有国际竞争力的一流科工集团为使命，坚持实践科学发展，坚持走市场化、产业化、国际化、集团化的道路，积极为国家能源工程和新兴工业发展提供优质产品和技术服务，努力打造“华电科工”品牌。\r\n</p>\r\n<p style=\"color:#616065;font-family:simsun;background-color:#FFFFFF;\">\r\n	<br />\r\n&nbsp;&nbsp;&nbsp; 公司到2015年要达到的发展目标（“5228”）<br />\r\n&nbsp;&nbsp;&nbsp; ——形成五个核心业务板块&nbsp;<br />\r\n&nbsp;&nbsp;&nbsp; ——销售收入200亿元<br />\r\n&nbsp;&nbsp;&nbsp; ——实现利润20亿元<br />\r\n&nbsp;&nbsp;&nbsp; ——资产负债率不超过80%\r\n</p>', null, '1', '1', '1', null, '0', '0', '0');

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
INSERT INTO `tbl_role` VALUES ('zA3eem', '超级管理员', '超级管理员', '00,01,02,08,09,03,04,05_category_move,05_category_manage,05_ARBrEr,05_yEJRF3,05_mUnqii,05_QRZrUb,05_mMN7Vz,05_ZjYZR3,05_eaAr6j,05_RrEvqi,05_bamMBf,05_BbeYfq,05_FBRvYf,05_beqiMn,05_Z3M7Rz,05_fEV7vu,05_j2imAr,05_RjIV7n,05_JBRbEv,06,07,11,12,13,14_FbeYFv,14_AzErIb,14_veumEn,14_7VNb2q', '2014-04-11 18:12:40');
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
INSERT INTO `tbl_user` VALUES ('6NBrMn', '曹文广', '53c5e0e05b04967de1fd8b868756ab2e19280ff28a84bdd3ce57339e3e1cfae3', '曹文广', 'caowenguang', null, null, '', '', '', '', '', '', '', '1', '2013-09-17 10:23:14');
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
INSERT INTO `tbl_user` VALUES ('vENrau', '张锋', '0a6438d57eaa4b4e4f5c7d8a10ce03779ec574445edf0ba44f0f45fe709e88d6', '张锋', 'zhangfeng', null, null, '华电科研总院', '', '', '', '010-591 6201', '18911803600', 'zhangfengvipchina@163.com', '1', '2014-04-11 18:57:26');
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
