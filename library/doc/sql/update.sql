#post表添加栏目分类ID外键
ALTER TABLE tbl_post
ADD COLUMN post_category_id_fk  varchar(32) NULL COMMENT '分类ID tbl_category' AFTER post_isvalid;


#添加栏目分类：通知公告、行业资讯
INSERT INTO tbl_category VALUES ('QbINfy', '通知公告', '通知公告', '', '', '0', '0', '1', '0', '0', '0', 'news', null, '0', '2013-05-29 09:19:44');
INSERT INTO tbl_category VALUES ('73aANz', '行业资讯', '行业资讯', '', '', '0', '0', '1', '0', '0', '0', 'news', null, '0', '2013-05-29 09:19:44');





