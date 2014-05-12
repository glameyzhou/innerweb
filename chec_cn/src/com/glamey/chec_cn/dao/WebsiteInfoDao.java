package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.WebsiteInfo;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
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
public class WebsiteInfoDao extends BaseDao {
    protected static final Logger logger = Logger.getLogger(WebsiteInfoDao.class);

    public boolean insert(final WebsiteInfo websiteInfo) {
        try {
            String sql = "insert into tbl_website (website_name,website_desc,website_url,website_sign,website_isself) values(?,?,?,?,?)";

            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, websiteInfo.getName());
                            pstmt.setString(++i, websiteInfo.getDesc());
                            pstmt.setString(++i, websiteInfo.getUrl());
                            pstmt.setString(++i, websiteInfo.getSign());
                            pstmt.setInt(++i, websiteInfo.getIsSelf());
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error("[WebsiteInfoDao] insert into error,websiteInfo=" + websiteInfo, e);
        }
        return false;
    }

    public List<WebsiteInfo> getSubList(final WebsiteInfo websiteInfo, final int start, final int num) {
        List<WebsiteInfo> list = new ArrayList<WebsiteInfo>();
        try {
            String sql = "select * from tbl_website  ";
            if (StringUtils.isNotBlank(websiteInfo.getKw())) {
                sql += " where (website_name like ? or website_desc like ?) ";
            }
            sql += " limit ? , ?";

            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(websiteInfo.getKw())) {
                                preparedStatement.setString(++i, "%" + websiteInfo.getKw() + "%");
                                preparedStatement.setString(++i, "%" + websiteInfo.getKw() + "%");
                            }
                            preparedStatement.setInt(++i, start);
                            preparedStatement.setInt(++i, num);
                        }
                    },
                    new WebsiteInfoRowMapper()
            );
            return list;
        } catch (Exception e) {
            logger.error("[WebsiteInfoDao] getSubList error,kw=" + websiteInfo.getKw(), e);
        }
        return Collections.emptyList();
    }

    public int getCount(final WebsiteInfo websiteInfo) {
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            String sql = "select count(1) as total from tbl_website  ";
            if (StringUtils.isNotBlank(websiteInfo.getKw())) {
                sql += " where (website_name like ? or website_desc like ?) ";
                params.add("%" + websiteInfo.getKw() + "%");
                params.add("%" + websiteInfo.getKw() + "%");
            }

            count = jdbcTemplate.queryForInt(
                    sql,
                    params.toArray()
            );
            return count;
        } catch (Exception e) {
            logger.error("[WebsiteInfoDao] getCount error,kw=" + websiteInfo.getKw(), e);
        }
        return 0;
    }

    public WebsiteInfo getWebsite(final int id) {
        try {
            String sql = "select * from tbl_website where website_id = ? ";
            List<WebsiteInfo> list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setInt(1, id);
                        }
                    },
                    new WebsiteInfoRowMapper()
            );
            return CollectionUtils.isEmpty(list) ? new WebsiteInfo() : list.get(0);
        } catch (Exception e) {
            logger.error("[WebsiteInfoDao] getWebsite error,id=" + id, e);
        }
        return new WebsiteInfo();
    }

    public boolean update(final WebsiteInfo website) {
        try {
            String sql = "update tbl_website set website_name = ? , website_desc = ? , website_url = ? , website_sign = ?, website_isself=? where website_id = ? ";

            int rows = jdbcTemplate.update(

                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, website.getName());
                            pstmt.setString(++i, website.getDesc());
                            pstmt.setString(++i, website.getUrl());
                            pstmt.setString(++i, website.getSign());
                            pstmt.setInt(++i, website.getIsSelf());
                            pstmt.setInt(++i, website.getId());
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error("[WebsiteInfoDao] update error,website=" + website, e);
        }
        return false;
    }

    public boolean del(final int id) {
        try {
            String sql = "delete from  tbl_website where website_id = ? ";
            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setInt(1, id);
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error("[WebsiteInfoDao] del error,id=" + id, e);
        }
        return false;
    }

    class WebsiteInfoRowMapper implements RowMapper<WebsiteInfo> {
        @Override
        public WebsiteInfo mapRow(ResultSet rs, int i) throws SQLException {
            WebsiteInfo website = new WebsiteInfo();
            website.setId(rs.getInt("website_id"));
            website.setName(rs.getString("website_name"));
            website.setDesc(rs.getString("website_desc"));
            website.setUrl(rs.getString("website_url"));
            website.setSign(rs.getString("website_sign"));
            website.setIsSelf(rs.getInt("website_isself"));
            return website;
        }
    }

    public boolean batchInsert(final List<WebsiteInfo> websites) {
        try {
            jdbcTemplate.update("truncate table tbl_website");

            String sql = "insert into tbl_website (website_id,website_name,website_desc,website_url,website_sign,website_isself) values(?,?,?,?,?,?)";

            int rows[] = jdbcTemplate.batchUpdate(
                    sql,
                    new BatchPreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt, int j) throws SQLException {
                            WebsiteInfo websiteInfo = websites.get(j);
                            int i = 0;
                            pstmt.setInt(++i, websiteInfo.getId());
                            pstmt.setString(++i, websiteInfo.getName());
                            pstmt.setString(++i, websiteInfo.getDesc());
                            pstmt.setString(++i, websiteInfo.getUrl());
                            pstmt.setString(++i, websiteInfo.getSign());
                            pstmt.setInt(++i, websiteInfo.getIsSelf());
                        }

                        @Override
                        public int getBatchSize() {
                            return websites.size();
                        }
                    }
            );
            return rows.length > 0;
        } catch (Exception e) {
            logger.error("[WebsiteInfoDao] batchInsert error,websites=" + websites, e);
        }
        return false;
    }

    public WebsiteInfo getWebsiteSelf() {
        try {
            String sql = "select * from tbl_website where website_isself = 1 limit 0 , 1";
            List<WebsiteInfo> list = jdbcTemplate.query(
                    sql,
                    new WebsiteInfoRowMapper()
            );
            return CollectionUtils.isEmpty(list) ? new WebsiteInfo() : list.get(0);
        } catch (Exception e) {
            logger.error("[WebsiteInfoDao] getWebsiteSelf error", e);
        }
        return new WebsiteInfo();
    }
}