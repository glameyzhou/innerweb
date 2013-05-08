/**
 *
 */
package com.glamey.innerweb.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.innerweb.model.domain.Links;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 分类数据库操作
 *
 * @author zy
 */
@Repository
public class LinksDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(LinksDao.class);

    /**
     * @param links
     * @return
     */
    public boolean create(final Links links) {
        logger.info("[LinksDao] #create# " + links);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_links(id,links_name,links_url,links_category_id,links_category_type,links_image,links_order,links_latestdate) " +
                            " values(?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, links.getName());
                            pstmt.setString(++i, links.getUrl());
                            pstmt.setString(++i, links.getCategoryId());
                            pstmt.setString(++i, links.getCategoryType());
                            pstmt.setString(++i, links.getImage());
                            pstmt.setInt(++i, 0);
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LinksDao] #create# error " + links, e);
            return false;
        }
    }

    /**
     * @param links
     * @return
     */
    public boolean update(final Links links) {
        logger.info("[LinksDao] #update# " + links);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_links set links_name=?,links_url=?,links_category_id=?,links_category_type=?,links_image=?,links_order=? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, links.getName());
                            pstmt.setString(++i, links.getUrl());
                            pstmt.setString(++i, links.getCategoryId());
                            pstmt.setString(++i, links.getCategoryType());
                            pstmt.setString(++i, links.getImage());
                            pstmt.setInt(++i, 0);
                            pstmt.setString(++i, links.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LinksDao] #update# error " + links, e);
            return false;
        }
    }

    /**
     * 通过ID删除分类
     *
     * @param id
     * @return
     */
    public boolean deleteById(final String id) {
        logger.info("[LinksDao] #delete#" + id);
        try {
            int count = jdbcTemplate.update("delete from tbl_links where id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, id);
                }
            });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LinksDao] #delete# error " + id, e);
        }
        return false;
    }

    /**
     * @param id
     * @return
     */
    public Links getById(final String id) {
        logger.info("[LinksDao] #getById#" + id);
        try {
            List<Links> list = jdbcTemplate.query("select * from tbl_links where id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, id);
                        }
                    },
                    new LinksRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[LinksDao] #getById# error " + id, e);
        }
        return null;
    }

    public List<Links> getByParentId(final String categoryId, final String categoryType, final int start, final int num) {
        logger.info("[LinksDao] #getLinksByParentId# categoryId=" + categoryId + " categoryType=" + categoryType);
        List<Links> list = new ArrayList<Links>();
        try {
            list = jdbcTemplate.query("select * from tbl_links where links_category_id = ? and links_category_type = ? order by links_latestdate desc limit ?,? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, categoryId);
                            preparedstatement.setString(2, categoryType);
                            preparedstatement.setInt(3, start);
                            preparedstatement.setInt(4, num);
                        }
                    },
                    new LinksRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[LinksDao] #getByParentId# error", e);
        }
        return null;
    }

    public int getCountByParentId(String categoryId, String categoryType) {
        logger.info("[LinksDao] #getCountByParentId# categoryId=" + categoryId + " categoryType=" + categoryType);
        int count = 0;
        try {
            count = jdbcTemplate.queryForInt("select count(1) as total from tbl_links where links_category_id = ? and links_category_type = ?  ",
                    new Object[]{categoryId, categoryType});
        } catch (Exception e) {
            logger.error("[LinksDao] #getCountByParentId# error categoryId=" + categoryId + " categoryType=" + categoryType, e);
        }
        return count;
    }

    /**
     * @return
     */
    class LinksRowMapper implements RowMapper<Links> {
        @Override
        public Links mapRow(ResultSet rs, int i) throws SQLException {
            Links links = new Links();
            links.setId(rs.getString("id"));
            links.setName(rs.getString("name"));
            links.setUrl(rs.getString("links_url"));
            links.setCategoryId(rs.getString("links_category_id"));
            links.setCategoryType(rs.getString("links_category_type"));
            links.setImage(rs.getString("links_image"));
            links.setOrder(rs.getInt("links_order"));
            links.setLatestDate(rs.getTimestamp("links_latestdate"));
            return links;
        }
    }
}
