#20140214
#post表添加栏目分类ID外键
ALTER TABLE tbl_post
ADD COLUMN post_category_id_fk  varchar(32) NULL COMMENT '分类ID tbl_category' AFTER post_isvalid;
ALTER TABLE tbl_post
ADD INDEX idx_post_category (post_category_id_fk);

#添加栏目分类：通知公告、行业资讯
INSERT INTO tbl_category VALUES ('QbINfy', '通知公告', '通知公告', '', '', '0', '0', '1', '0', '0', '0', 'news', null, '0', '2013-05-29 09:19:44');
INSERT INTO tbl_category VALUES ('73aANz', '行业资讯', '行业资讯', '', '', '0', '0', '1', '0', '0', '0', 'news', null, '0', '2013-05-29 09:19:44');
update tbl_post set post_category_id_fk = 'QbINfy';

#20140214
INSERT INTO tbl_category VALUES ('VvAnyy', '煤炭清洁利用', 'BBS_煤炭清洁利用', '', '', '0', '0', '1', '0', '0', '0', 'bbs', null, '0', '2013-05-29 09:19:44');
INSERT INTO tbl_category VALUES ('Evmqey', '区域能源', 'BBS_区域能源', '', '', '0', '0', '1', '0', '0', '0', 'bbs', null, '0', '2013-05-29 09:19:44');

CREATE TABLE `tbl_bbs_manager` (
  `category_id_fk` varchar(32) default NULL,
  `user_id_fk` varchar(32) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BBS栏目版主';

CREATE TABLE `tbl_bbs_post` (
  `id` varchar(32) default NULL,
  `category_id_fk` varchar(32) default NULL COMMENT '分类ID',
  `title` varchar(1000) default NULL COMMENT '主贴标题',
  `user_id_fk` varchar(32) default NULL COMMENT '发帖人',
  `publish_time` datetime default NULL COMMENT '发帖时间',
  `update_time` datetime default NULL COMMENT '更新时间',
  `content` text COMMENT '发帖内容',
  `view_count` int(11) default NULL COMMENT '查看次数',
  `reply_count` int(11) default NULL COMMENT '回复次数',
  `show_top` tinyint(4) default '0' COMMENT '是否置顶 1=是 0=否，默认为0',
  `show_great` tinyint(4) default '0' COMMENT '是否为精华帖1=是 0=否，默认为0',
  `show_popular` tinyint(4) default '0' COMMENT '是否为火贴（超时10个回复） 1=是 0=否',
  KEY `idx_bbs_id` (`id`),
  KEY `idx_bbs_category` (`category_id_fk`),
  KEY `idx_bbs_top` (`show_top`),
  KEY `idx_bbs_great` (`show_great`),
  KEY `idx_bbs_popular` (`show_popular`),
  KEY `idx_bbs_publish` (`publish_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛主题内容';

CREATE TABLE `tbl_bbs_reply` (
  `id` varchar(32) default NULL,
  `category_id_fk` varchar(32) default NULL COMMENT '回帖分类（多余字段，方便统计使用）',
  `post_id_fk` varchar(32) default NULL COMMENT '主贴ID',
  `user_id_fk` varchar(32) default NULL,
  `publish_time` datetime default NULL,
  `update_time` datetime default NULL,
  `content` text,
  KEY `idx_bbs_reply_cate` USING BTREE (`category_id_fk`),
  KEY `idx_bbs_reply_post` (`post_id_fk`),
  KEY `idx_bbs_reply_publish` (`publish_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛-主题回复内容';

#20140216
ALTER TABLE `tbl_bbs_post`
ADD PRIMARY KEY (`id`);

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

INSERT INTO `tbl_bbs_manager` VALUES ('VvAnyy', '6NBrMn');
INSERT INTO `tbl_bbs_manager` VALUES ('Evmqey', 'NZ36ny');


#20140217
#图书表中添加发布人、来源两个非必须项目
ALTER TABLE tbl_library
ADD COLUMN lib_author  varchar(200) NULL COMMENT '图书发布人,与tbl_user无关' AFTER lib_name;
ALTER TABLE tbl_library
ADD COLUMN lib_source  varchar(200) NULL COMMENT '图书来源' AFTER lib_author;

#将tbl_post中的行业资讯模块，放在了图书管理中，同时把数据导入到tbl_library表中
INSERT INTO `tbl_library` (`lib_id`, `lib_category_id`, `lib_type`, `lib_name`, `lib_author`, `lib_source`, `lib_focusimage`, `lib_url`, `lib_content`, `lib_image`, `lib_time`, `lib_order`, `lib_showindex`, `lib_showlist`, `lib_sugguest`, `lib_update_time`) VALUES ('jyiEje', 'EnQnii', 2, '致密油勘探应关注三个科学问题', '张锋', '中国石化报油气周刊', 0, NULL, '<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">致密油是继页岩气之后全球非常规油气勘探开发的又一热点。西北大学王震亮教授在调研国内外大量文献的基础上，对我国致密油的发展趋势，提出了独到的见解。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">致密油主要赋存空间分为两种类型：一是源岩内部的碳酸盐岩或碎屑岩夹层中；二是为紧邻源岩的致密层中，且未经过大规模、长距离运移。国际能源署（IEA）从工程学角度对致密油的界定是，可利用水平钻井和多段水力压裂技术从页岩或其他低渗透性储层中开采出来的石油。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">随着油气工业的发展，在有待勘探开发的油气资源中，常规油气所占比例越来越少，非常规油气逐渐成为重点。油气勘探开发领域从常规油气向非常规油气转移，是石油工业发展的必然趋势。在非常规油气中，致密油处于重要地位，2003年～2008年，我国主要沉积盆地的新增石油储量中，低、特低渗石油所占比例从69.1%提至87%。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">美国是全球致密油勘探开发最成功的国家，其主要致密油区带为巴肯、鹰福特、奈厄布拉勒、尤蒂卡、沃夫坎等。美国能源信息署（EIA）统计显示，截至2012年6月，美国致密油日产量达100万桶，是2009年初日产量25万桶的4倍，其中84%的致密油来自巴肯和鹰福特页岩区。2013年10月，能源咨询公司伍德麦肯锡预测称，2020年美国的致密油产量有望达到每日400万桶，巴肯和鹰福特仍是产量增长的主力区。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">2008年，我国低渗透原油产量为0.71亿吨（包括致密油、页岩油、低渗透稠油），占全国总产量的37.6%。</span><a href=\"http://www.mlr.gov.cn/\" target=\"_blank\" class=\"keylink\"><span style=\"line-height:2;\">国土资源部</span></a><span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">新一轮油气资源评价显示，在我国的可采石油资源中，致密油占2/5。地质学家采用资源丰度类比法进行的预测和初步评价认为，我国主要盆地致密油地质资源总量为106.7亿吨～111.5亿吨，可采资源量为13亿吨～14亿吨。鄂尔多斯、准噶尔、松辽、渤海湾、四川等盆地的致密油资源丰富，是未来勘探开发的重点区域。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">王震亮教授认为，目前在非常规致密油领域，仍存在一些国际性的科学难题，主要表现以下几个方面：一是如何评价储层致密化构造、沉积和成岩控制因素；二是对不同级别孔隙和孔隙结构的识别，在大、中、小三个级别孔隙共存（但比例变化很大）条件下，油气是否一定富集于最小的纳米级孔隙内；三是在高有机质含量的烃源岩及其上、下相邻的致密储层内，油气的赋存状态（游离态、吸附态、分子扩散）及其富集规律，是否一定不会发生较长距离的运移；四是在成岩演化序列下，在储层致密化过程中，流体动力与输导性能的联合作用，怎样影响油气运移和成藏；五是致密油的富集规律是否全部为连续性聚集，是否存在其他的聚集类型。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">对上述难题的科学解析，对丰富致密油富集和成藏理论、探寻更为合理的勘探开采方法具有重要意义。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">王震亮教授指出，在今后的致密油研究中，应重点关注岩石致密化过程和微米-纳米级孔喉的形成分布、致密油的赋存状态和运移成藏机理及其资源潜力评价指标三个关键科学问题。</span> \r\n</p>', NULL, '2014-2-17 15:41:56', 0, 1, 1, 1, '2014-2-17 15:44:12');
INSERT INTO `tbl_library` (`lib_id`, `lib_category_id`, `lib_type`, `lib_name`, `lib_author`, `lib_source`, `lib_focusimage`, `lib_url`, `lib_content`, `lib_image`, `lib_time`, `lib_order`, `lib_showindex`, `lib_showlist`, `lib_sugguest`, `lib_update_time`) VALUES ('b6Zvye', 'EnQnii', 2, '国产生物航煤获得适航批准', '张锋', '北京商报', 0, NULL, '<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">航油成本居高不下以及节能减排压力让航空业加速研发生物燃料。2月12日，以“地沟油”为主要生产原料的生物航空煤油（以下简称“生物航煤”）在我国正式获批商用。根据民航局网站消息，中国民用航空局航空器适航审定司正式向中国石化颁发了1号生物航煤技术标准规定项目批准书，这标志着备受国内外关注的国产 1号生物航煤正式获得适航批准（适合航空飞行），并可投入商业使用。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">民航局相关负责人表示，发展可替代清洁能源，推动国家自主知识产权生物航煤的研发和应用，是基于国家战略发展的要求，是民航在“十二五”期间实现节能减排目标的一大举措，对促进民航可持续发展具有重要意义。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">资料显示，2012年2月28日，民航局适航司成立了1号生物航煤适航审定委员会和审查组，正式开始了适航审定工作。而审定的基础被明确定为不低于国际技术标准。此后，在去年4月，东航成功实施中国首次自主产权1号生物航煤验证飞行，这让该生物航煤项目进入最终评审阶段。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">据了解，生物航煤技术是将棕榈油、餐饮废油（俗称“地沟油”）等变成绿色航空煤油的一项技术，美国、法国、芬兰都已自主生产生物航煤。作为传统航油的替代品，生物燃料不仅可再生，且无需对发动机改装，具有很高的环保优势。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">民航局进一步指出，1号生物航煤获得适航批准，这说明中国生物航煤行业实现了从无到有的突破，中国石化由此成为国内首家拥有自主生物航煤生产技术且具有批量生产能力的企业，成为世界上少数几个掌握生物航煤自主研发生产技术的企业之一。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">“下一步，民航局还将继续完善替代燃料等航油管理规章和程序，逐步推进航空煤油和航空汽油的设计生产适航审定，进一步加强航油适航审定能力建设，完善适航审定体系和生物航煤适航验证平台，鼓励市场对外开放”，民航局透露，“而对于中国石化，取得适航证仅仅是第一步，下一步还将继续进行生物航煤的研发和应用。保证原材料的多元化，并逐步降低生产成本，进一步推动生物航煤的商业应用。”</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">不过，业内普遍认为，价格和原料供给是制约生物燃料大范围商用的两大瓶颈。目前航空生物燃料的价格大约是传统航油价格的1.5-2倍，与此同时，无论是地沟油还是植物种植数量都有限，如何获得持续可靠的原料供给成为一大难题。</span>\r\n</p>', NULL, '2014-2-17 15:44:37', 1, 1, 1, 1, '2014-2-17 15:45:02');
INSERT INTO `tbl_library` (`lib_id`, `lib_category_id`, `lib_type`, `lib_name`, `lib_author`, `lib_source`, `lib_focusimage`, `lib_url`, `lib_content`, `lib_image`, `lib_time`, `lib_order`, `lib_showindex`, `lib_showlist`, `lib_sugguest`, `lib_update_time`) VALUES ('mMjAJf', 'EnQnii', 2, '中国品牌三代核电技术起步 首台机组自主率80%', '张锋', '中国航空报', 0, NULL, '<p style=\"font-size:16px;color:#7D7D7D;font-family:宋体;text-indent:24px;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;line-height:2;\">我国大型先进压水堆核电站重大专项CAP1400核电的初步设计，在北京通过国家能源局审查，其总体技术方案、技术指标和主要参数得以固化并得到国家认可，中国品牌三代核电技术就此起步。</span>\r\n</p>\r\n<p style=\"font-size:16px;color:#7D7D7D;font-family:宋体;text-indent:24px;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;line-height:2;\">&nbsp;&nbsp;&nbsp;&nbsp;国家核电技术公司(简称国核技)负责人介绍，作为核电国家品牌，CAP1400是国核技结合我国核电研发设计和建设运行经验，在引进消化吸收美国AP1000三代非能动核电技术基础上，通过再创新和集成创新，研究开发的具有自主知识产权的三代核电技术，于2006年被列入国家科技重大专项。其中，C代表中国，AP1400是指在美国AP1000电功率1000兆瓦(100万千瓦)基础上增加到1400兆瓦(140万千瓦)，而其实际电功率超过150万千瓦，是目前世界上最大的非能动压水堆核电机组。它沿用了AP1000先进的非能动安全理念，不依赖外部电源，能确保极端事故条件下反应堆安全和余热导出及堆芯衰变热安全排出，事故发生72小时内无需人工干预，72小时后具备补给能力，大量放射性释放到环境的概率小于10-7/堆年，比现有的二代核电技术低1~2个量级;在此基础上，通过多个领域的技术创新，使其安全性、经济性和环境相容性有了进一步提升，满足世界最新核安全标准，达到世界领先水平。</span>\r\n</p>\r\n<p style=\"font-size:16px;color:#7D7D7D;font-family:宋体;text-indent:24px;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;line-height:2;\">&nbsp;&nbsp;&nbsp;&nbsp;国核技方面表示，CAP1400的初步设计通过型号开发与共性技术研究，对消化吸收世界先进技术、全面提升我国核电行业技术水平、带动高端设备国产化、自主化和产业链建设，发挥了重要作用。目前，全国有近百家单位参与CAP1400型号相关工作，其关键设备基本实现了自主化设计、国产化制造，预计首台CAP1400核电机组的设备自主化率将达到80%左右。完成了一批具有世界先进水平的试验台架建设，部分关键试验已完成，所取得的数据有效支撑了CAP1400设计和安全评审。数字化反应堆保护系统、关键设计分析软件开发按计划推进。CAP1400施工设计已完成约60%。</span>\r\n</p>\r\n<p style=\"font-size:16px;color:#7D7D7D;font-family:宋体;text-indent:24px;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;line-height:2;\">&nbsp;&nbsp;&nbsp;&nbsp;国核技透露，CAP1400核电示范机组计划在山东荣成建设两台，国家发改委已于2013年3月批准开展前期工作。目前示范工程建设的各项前期工作正有序推进，具备今年开工建设的条件。</span>\r\n</p>', NULL, '2014-2-17 15:45:39', 2, 1, 1, 1, '2014-2-17 15:46:00');
INSERT INTO `tbl_library` (`lib_id`, `lib_category_id`, `lib_type`, `lib_name`, `lib_author`, `lib_source`, `lib_focusimage`, `lib_url`, `lib_content`, `lib_image`, `lib_time`, `lib_order`, `lib_showindex`, `lib_showlist`, `lib_sugguest`, `lib_update_time`) VALUES ('EJVZ3u', 'EnQnii', 2, '发改委：将建全国碳排放权交易市场', '张锋', '中国经济网', 0, NULL, '<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">国家发展和改革委员会今日表示，我国将从不同地区的实际情况出发，继续组织开展多层次、多样化的试点示范工作，并研究建立全国碳排放权交易市场。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">国家发展改革委介绍说，加快推进低碳发展试点示范，是“十二五”规划纲要确定的一项重要任务，是积极探索符合我国国情的绿色低碳发展道路、推动经济发展方式转变的有效途径，也是加强应对气候变化工作的重要抓手。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">碳排放权交易试点自2011年启动以来，各项工作进展顺利。2013年6月深圳市正式启动上线交易，截至11月份，累计交易量超过13万吨二氧化碳，交易金额超过人民币850万元。上海、北京也于11月启动上线交易。各试点省市都组建专门人才队伍，完成基础体系建设，在企业碳排放盘查基础上，提出了实施方案；结合自身特点和条件，在具体工作中体现出差别和特色，如选择的行业范围、纳入交易的企业、配额分配的方法和标准、允许抵扣的自愿减排指标比例、登记注册系统的设计等，充分体现了“量体裁衣、因地制宜”原则。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">国家发展改革委表示，下一步将会同有关部门，研究制定低碳试点示范评价考核办法，对“十二五”时期低碳省区和低碳城市、碳排放权交易等试点工作目标任务完成情况进行中期评估，及时总结和交流低碳发展经验，并研究建立全国碳排放权交易市场。</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">此外，还将继续推进低碳发展试点示范，研究制定并贯彻落实好重大政策文件，系统提出我国2030及2050年低碳发展路线图；完善低碳发展试点示范政策体系，研究制定并完善支持试点示范的产业、财税、投资、金融、技术、消费等方面配套政策，加大对试点示范工作的支持力度；开展低碳发展试点示范总结评估和经验推广；加强低碳试点示范地区能力建设，加快试点示范地区温室气体排放清单编制及统计核算体系建设，优先建立重点行业企业温室气体排放报告制度。</span> \r\n</p>', NULL, '2014-2-17 15:46:13', 3, 1, 1, 1, '2014-2-17 15:47:24');
INSERT INTO `tbl_library` (`lib_id`, `lib_category_id`, `lib_type`, `lib_name`, `lib_author`, `lib_source`, `lib_focusimage`, `lib_url`, `lib_content`, `lib_image`, `lib_time`, `lib_order`, `lib_showindex`, `lib_showlist`, `lib_sugguest`, `lib_update_time`) VALUES ('N3MZbu', 'EnQnii', 2, 'LPG成为美国“页岩气革命”的排头兵', '张锋', '中国矿业报', 0, NULL, '<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">“页岩气革命”给美国带来了充足的天然气资源，使美国的天然气供应从短缺走向了充裕。廉价的天然气降低了美国能源和化工原料价格，也让美国的能源密集型产业和化工产业迎来了又一个春天。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">然而天然气只是“页岩气革命”的主角之一，页岩气开采中收集到的伴生气也开始以液化石油气(LPG)的形式在世界能源市场上崭露头角。要将美国富余的天然气出口到国际市场尚需时日，但是LPG已经成为美国“页岩气革命”冲击世界能源市场的排头兵。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">与天然气不同的是，LPG的出口没有政策方面的限制，也不需要通过能源部的审批。美国的LPG因其物美价廉已经成功进入了日本市场。目前，日本已经成为美国第三大液化石油气出口目的地，而且日本的贸易地位还将进一步上升。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">虽然美国出口到亚洲市场的LPG数量仅占到了亚洲LPG贸易总量的一小部分，但美国已经撼动了中东国家在亚洲市场上的地位，而且压低了对方的价格。今年沙特销往亚洲的LPG基准价格与往年相比，已出现大幅下滑，降幅接近每吨90美元。这是继2009年金融危机之后，沙特LPG价格的最大降幅。即便如此，日本市场上来自美国的LPG价格还是比沙特低了近60美元/吨。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">曾几何时，美国需要从阿尔及利亚、尼日利亚、沙特和委内瑞拉大规模进口LPG来满足国内需求，正是“页岩气革命”让美国在2012年彻底成为LPG净出口国。美国能源信息署(EIA)预测，美国LPG的净出口态势将一直持续到2040年。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">美国LPG的来源主要有两个：一是天然气田开采中获得的伴生气(也可被称为天然气凝析液)；二是原油(100.33,0.39,0.39%)在炼厂加工过程中得到的炼厂气。以前二者对美国LPG的贡献率都在50%左右，不过随着页岩气的大规模开发，特别是不少企业青睐富含凝析液的湿气井之后，伴生气的产量上涨了35%。而来自天然气田伴生气的LPG也占到了总产量的60%。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">近两年的库存压力导致美国LPG价格走低。美国厂商开始考虑扩建或者新建出口设施，将廉价的LPG出口到包括中国在内的亚洲国家。LPG出口会造成美国国内供应吃紧、气价上涨，但这很可能只是短期现象。一方面，上游厂商对伴生气的开发热情不减；另一方面，美国在修建更多的运输管线，连接墨西哥湾港口与内地LPG主要产区。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">亚太地区是世界LPG贸易增长最快的区域，世界新增LPG需求量的大部分来自这一区域。除了日本之外，中国将是美国的理想贸易对象。中国厂商计划建设17套丙烷脱氢制丙烯(PDH)装置，总产能将达到1000万吨。由于国内丙烷原料质量达不到要求，中国必须从国外采购。因此仅仅为了满足国内PDH原料需求一项，未来中国就将进口1100万吨以上的LPG。目前，已经有中国厂商与美国公司签订了LPG供应合同。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">虽然中东将会和美国一样成为重要的原料来源地，但是航运成本的降低将会进一步提升美国相对中东LPG的价格优势。目前，世界上仅有4艘4万吨级巨型气体货轮(VLGC)可以通过巴拿马运河，其余则需要绕道合恩角、好望角或苏伊士运河。等到巴拿马运河的拓宽工程在2015年完工之后，VLGC从美国到东亚的运输里程将缩短7000英里，时间缩短20天，相应的运费也将下降80美元/吨左右。</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#7D7D7D;font-family:arial, helvetica, clean, sans-serif;text-indent:2em;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;color:#333333;font-family:宋体;line-height:2;\">当世界仍在预测“页岩气革命”将会对全球天然气贸易产生怎样的影响时，页岩气开发的副产品LPG已经在亚太市场与传统能源出口国展开角逐。美国大量出口LPG会给亚太能源消费大国带来福音，也将成为“页岩气革命”世界影响力的又一佐证。</span>\r\n</p>', NULL, '2014-2-17 15:46:47', 4, 1, 1, 1, '2014-2-17 15:47:09');

#20140218#
ALTER TABLE `tbl_library`
ADD COLUMN `lib_recent`  tinyint NULL DEFAULT 0 COMMENT '是否为最近收录 1=是 0=否 ，默认为否' AFTER `lib_showlist`;

update tbl_library b set b.lib_recent = 1;

update tbl_library b set b.lib_recent = 0 where b.lib_category_id = 'EnQnii';


#20140304#
#最后更新的用户ID#
ALTER TABLE `tbl_bbs_post`
ADD COLUMN `lasted_update_userid`  varchar(32) NULL COMMENT '最后更新的人' AFTER `show_popular`;

ALTER TABLE `tbl_bbs_reply`
ADD COLUMN `lasted_update_userid`  varchar(32) NULL COMMENT '最后更新的用户ID' AFTER `content`;

INSERT INTO `tbl_category` VALUES ('FbeYFv', '煤炭清洁利用', '煤炭清洁利用', 'meitanqingjieliyong', '煤炭清洁利用', '0', '1', '1', '0', '1', '0', 'bbs', null, '0', '2014-03-10 22:10:01');
INSERT INTO `tbl_category` VALUES ('AzErIb', '区域能源', '区域能源', 'quyunengyuan', '区域能源', '0', '1', '1', '0', '2', '0', 'bbs', null, '0', '2014-03-10 22:10:14');
INSERT INTO `tbl_category` VALUES ('veumEn', '页岩气、LNG', '页岩气、LNG', 'yeyanqi、LNG', '页岩气、LNG', '0', '1', '1', '0', '3', '0', 'bbs', null, '0', '2014-03-10 22:10:26');
INSERT INTO `tbl_category` VALUES ('3i2Q7v', '专题讨论区', '专题讨论区', 'zhuantitaolunqu', '专题讨论区', '0', '1', '1', '0', '1', '0', 'bbs', null, '1', '2014-03-10 22:10:01');
INSERT INTO `tbl_bbs_manager` VALUES ('FbeYFv', null);
INSERT INTO `tbl_bbs_manager` VALUES ('AzErIb', null);
INSERT INTO `tbl_bbs_manager` VALUES ('veumEn', null);

#20140308#
ALTER TABLE `tbl_bbs_post`
ADD COLUMN `post_type`  tinyint(4) NULL DEFAULT 0 COMMENT '帖子类型 0=标准帖子 1=投票帖子' AFTER `category_id_fk`;

#20140310
DROP TABLE IF EXISTS `tbl_bbs_post_vote`;
CREATE TABLE `tbl_bbs_post_vote` (
  `vote_id` varchar(32) default '投票帖子主键',
  `post_id_fk` varchar(32) default NULL COMMENT '帖子主键',
  `vote_end_date` varchar(255) default NULL COMMENT '投票结束时间',
  `is_multi_vote` tinyint(4) default '0' COMMENT '是否为多选投票 1=是',
  `multi_vote_size` int(11) default NULL COMMENT '如果是多选投票的话，最多 可以选择的项总量',
  `see_after_vote` tinyint(4) default '0' COMMENT '提交投票后结果才可见 1=是',
  `vote_person_out` tinyint(4) default '0' COMMENT '投票人是否可见 1=是',
  KEY `idx_vote_post_id_fk` (`post_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票帖子主题部分';


DROP TABLE IF EXISTS `tbl_bbs_post_vote_person`;
CREATE TABLE `tbl_bbs_post_vote_person` (
  `vote_id_fk` varchar(32) default NULL,
  `vote_property_id_fk` varchar(32) default NULL,
  `vote_user_id_fk` varchar(32) default NULL,
  `vote_time` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票帖子对应的回复详情';

DROP TABLE IF EXISTS `tbl_bbs_post_vote_property`;
CREATE TABLE `tbl_bbs_post_vote_property` (
  `vote_id_fk` varchar(32) default NULL COMMENT '投票主键',
  `property_id` varchar(32) default NULL COMMENT '投票项唯一标识',
  `vote_property_name` varchar(500) default NULL COMMENT '投票项名称',
  `vote_value` int(11) default '0' COMMENT '本条投票项的投票总人数',
  `property_order` int(11) default NULL COMMENT '投票项排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票帖子--对应的投票项目属性';


DROP TABLE IF EXISTS `tbl_bbs_post_reply_ref`;
CREATE TABLE `tbl_bbs_post_reply_ref` (
  `post_id_fk` varchar(32) default NULL,
  `reply_id_fk` varchar(32) default NULL,
  `post_user_id_fk` varchar(32) default NULL,
  `reply_user_id_fk` varchar(32) default NULL,
  `reply_time` datetime default NULL,
  KEY `idx_post_reply_ref_fk` (`post_id_fk`,`reply_id_fk`,`post_user_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每个楼层的相互会话关系表';

#20140402
ALTER TABLE `tbl_bbs_reply`
ADD COLUMN `is_delete`  tinyint(1) NULL DEFAULT 0 COMMENT '是否已经删除 1=已经删除 0=未删除' AFTER `lasted_update_userid`;

ALTER TABLE `tbl_bbs_post_reply_ref`
ADD COLUMN `reply_floor`  int NULL AFTER `reply_time`;

CREATE TABLE `tbl_bbs_post_reply_ref` (
  `post_id_fk` varchar(32) default NULL,
  `reply_id_fk` varchar(32) default NULL,
  `reply_floor` int(11) default NULL,
  `reply_user_id_fk` varchar(32) default NULL,
  `cur_reply_id_fk` varchar(32) default NULL,
  `cur_reply_user_id_fk` varchar(32) default NULL,
  `reply_time` datetime default NULL,
  KEY `idx_post_reply_ref_fk` USING BTREE (`post_id_fk`,`cur_reply_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每个楼层的相互会话关系表';