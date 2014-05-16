package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.ContentInfo;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Repository
public class ContentInfoDao extends BaseDao {
    protected static final Logger logger = Logger.getLogger(ContentInfoDao.class);
    @Autowired
    private UserInfoDao userInfoDao;
    @Autowired
    private WebsiteInfoDao websiteInfoDao;

    public boolean insert(final ContentInfo content) {
        try {
            String sql = "insert into tbl_content (content_id,content_title,content_websiteid_fk,content_text,content_publishTime,content_userid_fk) values(?,?,?,?,?,?)";
            jdbcTemplate.update(sql, new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement pstmt) throws SQLException {
                    int i = 0;
                    pstmt.setString(++i, content.getContentId());
                    pstmt.setString(++i, content.getTitle());
                    pstmt.setInt(++i, content.getWebsiteId());
                    pstmt.setString(++i, content.getText());
                    pstmt.setString(++i, content.getPublishTime());
                    pstmt.setInt(++i, content.getUserId());
                }
            });
            return true;
        } catch (Exception e) {
            logger.error("[ContentInfoDao] insert into error,content=" + content, e);
        }
        return false;
    }

    public List<ContentInfo> getSubList(final ContentInfo content, final int start, final int num) {
        List<ContentInfo> list = new ArrayList<ContentInfo>();
        try {
            String sql = "select * from tbl_content  where 1=1 ";
            if (StringUtils.isNotBlank(content.getKw())) {
                sql += " and (content_title like ? or content_text like ?) ";
            }
            if (content.getWebsiteId() > 0) {
                sql += " and content_websiteid_fk = ? ";
            }
            if (content.getUserId() > 0) {
                sql += " and content_userid_fk = ? ";
            }
            sql = sql + " order by content_publishTime desc limit ? , ?";
            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(content.getKw())) {
                                preparedStatement.setString(++i, "%" + content.getKw() + "%");
                                preparedStatement.setString(++i, "%" + content.getKw() + "%");
                            }
                            if (content.getWebsiteId() > 0) {
                                preparedStatement.setInt(++i, content.getWebsiteId());
                            }
                            if (content.getUserId() > 0) {
                                preparedStatement.setInt(++i, content.getUserId());
                            }

                            preparedStatement.setInt(++i, start);
                            preparedStatement.setInt(++i, num);
                        }
                    },
                    new ContentInfoRowMapper()
            );
            return list;
        } catch (Exception e) {
            logger.error("[ContentInfoDao] getSubList error,contentInfo=" + content + " start=" + start + " num=" + num, e);
        }
        return Collections.emptyList();
    }

    public int getCount(ContentInfo content) {
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            String sql = "select count(1) as total from tbl_content  where 1=1 ";
            if (StringUtils.isNotBlank(content.getKw())) {
                sql += " and (content_title like ? or content_text like ?) ";
                params.add(content.getKw());
                params.add(content.getKw());
            }
            if (content.getWebsiteId() > 0) {
                sql += " and content_websiteid_fk = ? ";
                params.add(content.getWebsiteId());

            }
            if (content.getUserId() > 0) {
                sql += " and content_userid_fk = ? ";
                params.add(content.getUserId());
            }

            count = jdbcTemplate.queryForInt(
                    sql,
                    params.toArray()
            );
            return count;
        } catch (Exception e) {
            logger.error("[ContentInfoDao] getCount error,contentInfo=" + content, e);
        }
        return 0;
    }

    public ContentInfo getContentById(final String contentId) {
        try {
            String sql = "select * from tbl_content where content_id = ? ";

            List<ContentInfo> list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, contentId);
                        }
                    },
                    new ContentInfoRowMapper()
            );
            return CollectionUtils.isEmpty(list) ? new ContentInfo() : list.get(0);
        } catch (Exception e) {
            logger.error("[ContentInfoDao] getContentById error,contentId=" + contentId, e);
        }
        return new ContentInfo();
    }

    public boolean update(final ContentInfo content) {
        try {
            String sql = "update tbl_content set content_title = ? , content_websiteid_fk = ? , content_text = ? , content_publishTime = ? ,content_userid_fk = ? where content_id = ? ";

            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, content.getTitle());
                            pstmt.setInt(++i, content.getWebsiteId());
                            pstmt.setString(++i, content.getText());
                            pstmt.setString(++i, content.getPublishTime());
                            pstmt.setInt(++i, content.getUserId());
                            pstmt.setString(++i, content.getContentId());
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error("[ContentInfoDao] update error,content=" + content, e);
        }
        return false;
    }

    public boolean del(final String contentId) {
        try {
            String sql = "delete from  tbl_content where content_id = ? ";
            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, contentId);
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error("[ContentInfoDao] del error,contentId=" + contentId, e);
        }
        return false;
    }

    class ContentInfoRowMapper implements RowMapper<ContentInfo> {
        @Override
        public ContentInfo mapRow(ResultSet rs, int i) throws SQLException {

            ContentInfo content = new ContentInfo();
            content.setContentId(rs.getString("content_id"));
            content.setTitle(rs.getString("content_title"));
            content.setWebsiteId(rs.getInt("content_websiteid_fk"));
            content.setText(rs.getString("content_text"));
            content.setPublishTime(rs.getString("content_publishTime"));
            content.setUserId(rs.getInt("content_userid_fk"));

            content.setWebsiteInfo(websiteInfoDao.getWebsite(content.getWebsiteId()));
            content.setUserInfo(userInfoDao.getUserById(content.getUserId()));
            return content;
        }
    }
}