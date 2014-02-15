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





