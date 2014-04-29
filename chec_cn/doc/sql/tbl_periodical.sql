/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50022
Source Host           : localhost:3306
Source Database       : chec_cn

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2014-04-29 08:18:47
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
INSERT INTO `tbl_periodical` VALUES ('6b6zm2', '2009年第4期 总第47期', null, '/upload/images/20107/20107231643185628572.jpg', '2009', '4', '47', '/upload/accessory/20107/20107221146331568875.pdf', '20107221146331568875.pdf', '201984000', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('6ZBvUn', '2008年第1期 总第38期', null, '/upload/images/20107/2010723102522811249.jpg', '2008', '1', '38', '/upload/accessory/20107/201071691141687522.pdf', '201071691141687522.pdf', '47124480', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('AzaIne', '2010年第3期 总第52期', null, '/upload/images/20107/20107231052506876536.jpg', '2010', '3', '52', '/upload/accessory/20107/2010723105250703124.pdf', '2010723105250703124.pdf', '28579840', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('B7FFra', '2012年第4期 总第65期', null, '/upload/images/201211/20121119163341155984.jpg', '2012', '4', '65', '/upload/accessory/201211/20121119163341155984.pdf', '20121119163341155984.pdf', '40704000', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('BfEbuq', '2011年第1期 总第56期', null, '/upload/images/20117/20117693638909901.jpg', '2011', '1', '56', '/upload/accessory/20117/20117693638909901.pdf', '20117693638909901.pdf', '25763840', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('bmimMr', '2013年第1期 总第68期', null, '/upload/images/20137/20137101127285785295.jpg', '20131', '1', '68', '/upload/accessory/20137/20137101127286097247.pdf', '20137101127286097247.pdf', '12369920', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('Br6zmq', '2008年第3期 总第40期', null, '/upload/images/20107/20107231025358591221.jpg', '2008', '3', '40', '/upload/accessory/20107/20107221014574069670.pdf', '20107221014574069670.pdf', '37120000', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('BV3iai', '2008年第4期 总第41期', null, '/upload/images/20107/2010723102554781889.jpg', '2008', '4', '40', '/upload/accessory/20107/201072210226156809.pdf', '201072210226156809.pdf', '39331840', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('EBRvUb', '2010年第1期 总第50期', null, '/upload/images/20107/20107231042171872171.jpg', '2010', '1', '50', '/upload/accessory/20107/20107231042171872171.pdf', '20107231042171872171.pdf', '45936640', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('ENZbYf', '2011年第4期 总第59期', null, '/upload/images/201111/2011111784389215712.jpg', '2011', '4', '59', '/upload/accessory/201111/2011111784389215712.pdf', '2011111784389215712.pdf', '51046400', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('eUB3ii', '2011年第2期 总第57期', null, '/upload/images/20117/201176937541562173.jpg', '2011', '2', '57', '/upload/accessory/20117/201176937541562173.pdf', '201176937541562173.pdf', '40816640', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('FFVfqi', '2012年第6期 总第67期', null, '/upload/images/20131/20131101115506409916.jpg', '2012', '6', '67', '/upload/accessory/20131/20131101115506409916.pdf', '20131101115506409916.pdf', '51169280', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('FVNN3m', '2013年第5期 总第72期', null, '/upload/images/201311/201311228436250625.jpg', '2013', '5', '72', '/upload/accessory/201311/201311228436250625.pdf', '201311228436250625.pdf', '15697920', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('ieqUv2', '2012年第2期 总第63期', null, '/upload/images/20125/201251015921931307.jpg', '2012', '2', '63', '/upload/accessory/20125/201251015921931307.pdf', '201251015921931307.pdf', '36751360', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('jMR7Fr', '2009年第1期 总第44期', null, '/upload/images/20107/20107231026481569050.jpg', '2009', '1', '44', '/upload/accessory/20107/20107221042229533755.pdf', '20107221042229533755.pdf', '51855360', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('jyEJ3m', '2010年第5期 总第54期', null, '/upload/images/20117/2011711149366716781.jpg', '2010', '5', '54', '/upload/accessory/20115/2011512925417967010.pdf', '2011512925417967010.pdf', '10987520', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('JzUVRn', '2010年第4期 总第53期', null, '/upload/images/20117/2011711148179063258.jpg', '2010', '4', '53', '/upload/accessory/201012/201012301147565468188.pdf', '201012301147565468188.pdf', '9758720', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('MZZnim', '2013年第4期 总第71期', null, '/upload/images/201311/20131122842239683978.jpg', '2013', '4', '71', '/upload/accessory/201311/20131122842239683978.pdf', '20131122842239683978.pdf', '21145600', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('NBbaAv', '2009年第5期 总第48期', null, '/upload/images/20107/20107231030541565323.jpg', '2009', '5', '48', '/upload/accessory/20107/20107231030541565323.pdf', '20107231030541565323.pdf', '16005120', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('ne2Iz2', '2008年第6期 总第43期', null, '/upload/images/20107/20107231026257504434.jpg', '2008', '6', '43', '/upload/accessory/20107/20107221036102033396.pdf', '20107221036102033396.pdf', '36792320', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('nQRZRr', '2009年第2期 总第45期', null, '/upload/images/20107/20107231027498591142.jpg', '2009', '2', '45', '/upload/accessory/20107/2010722116278286513.pdf', '2010722116278286513.pdf', '197867520', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('u2muUv', '2008年第2期 总第39期', null, '/upload/images/20107/20107231025205155505.jpg', '2008', '2', '39', '/upload/accessory/20107/2010722101014628888.pdf', '2010722101014628888.pdf', '38400000', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('U77j6r', '2009年第6期 总第49期', null, '/upload/images/20107/2010723103575786003.jpg', '2009', '6', '49', '/upload/accessory/20107/2010723103575939591.pdf', '2010723103575939591.pdf', '37713920', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('uamauu', '2009年第3期 总第46期', null, '/upload/images/20107/20107231027266874748.jpg', '2009', '3', '46', '/upload/accessory/20107/20107221110455153857.pdf', '20107221110455153857.pdf', '35184640', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('UNfqMv', '2010年第6期 总第55期', null, '/upload/images/20117/2011711149189681828.jpg', '2010', '6', '55', '/upload/accessory/20115/2011512105473592173.pdf', '2011512105473592173.pdf', '545884160', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('uUBRJb', '2011年第5期 总第60期', null, '/upload/images/201111/20111117844301092376.jpg', '2011', '5', '60', '/upload/accessory/201111/20111117844301092376.pdf', '20111117844301092376.pdf', '38420480', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('uYfimy', '2013年第6期 总第73期', null, '/upload/images/20141/201412115296788177.jpg', '2013', '6', '73', '/upload/accessory/20141/201412115296788177.pdf', '201412115296788177.pdf', '151715840', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('v6ryum', '2012年第1期 总第62期', null, '/upload/images/20122/20122241326423436303.jpg', '2012', '1', '62', '/upload/accessory/20122/20122241326423436303.pdf', '20122241326423436303.pdf', '50452480', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('VfUJVz', '2010年第2期 总第51期', null, '/upload/images/20107/20107231047519212546.jpg', '2010', '2', '51', '/upload/accessory/20107/2010723104751937910.pdf', '2010723104751937910.pdf', '40652800', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('vQNjUn', '2011年第3期 总第58期', null, '/upload/images/20117/20117111417297342421.jpg', '2011', '3', '58', '/upload/accessory/20117/20117111417297342421.pdf', '20117111417297342421.pdf', '39280640', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('VrMrqa', '2013年第3期 总第70期', null, '/upload/images/20137/20137101129111568734.jpg', '2013', '3', '70', '/upload/accessory/20137/20137101129111568734.pdf', '20137101129111568734.pdf', '11018240', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('vuAVJ3', '2013年第2期 总第69期', null, '/upload/images/20137/20137101128172188192.jpg', '2013', '2', '69', '/upload/accessory/20137/20137101128172188192.pdf', '20137101128172188192.pdf', '36648960', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('yAvQNb', '2012年第3期 总第64期', null, '/upload/images/20127/20127101611253124605.jpg', '2012', '3', '64', '/upload/accessory/20127/20127101611253282968.pdf', '20127101611253282968.pdf', '39925760', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('YvmM7n', '2012年第5期 总第66期', null, '/upload/images/201211/20121119163448439487.jpg', '2012', '5', '66', '/upload/accessory/201211/20121119163448597851.pdf', '20121119163448597851.pdf', '46725120', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('ZB3Qze', '2011年第6期 总第61期', null, '/upload/images/20122/20122241323266562654.jpg', '2011', '6', '61', '/upload/accessory/20122/20122241323266562654.pdf', '20122241323266562654.pdf', '41850880', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('zEFzmy', '2008年第5期 总第42期', null, '/upload/images/20107/2010723102696718892.jpg', '2008', '5', '42', '/upload/accessory/20107/2010722102972653445.pdf', '2010722102972653445.pdf', '37468160', '2014-04-29 08:18:35');
INSERT INTO `tbl_periodical` VALUES ('zimQNv', '2014年第1期 总第74期', null, '/upload/images/20143/201431285973122447.jpg', '2014', '1', '74', '/upload/accessory/20143/201431285973122447.pdf', '201431285973122447.pdf', '54077440', '2014-04-29 08:18:35');
