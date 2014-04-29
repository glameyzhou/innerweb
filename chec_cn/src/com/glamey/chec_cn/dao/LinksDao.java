/**
 *
 */
package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Links;
import com.glamey.chec_cn.model.dto.LinksQuery;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
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

    @Resource
    private CategoryDao categoryDao;

    /**
     * @param links
     * @return
     */
    public boolean create(final Links links) {
        logger.info("[LinksDao] #create# " + links);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_links(id,links_name,links_url,links_category_id_fk,links_image,links_order,links_publishtime) " +
                            " values(?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, links.getName());
                            pstmt.setString(++i, links.getUrl());
                            pstmt.setString(++i, links.getCategoryId());
                            pstmt.setString(++i, links.getImage());
                            pstmt.setInt(++i, links.getOrder());
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
                    "update tbl_links set links_name=?,links_url=?,links_category_id_fk=?,links_image=?,links_order=? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, links.getName());
                            pstmt.setString(++i, links.getUrl());
                            pstmt.setString(++i, links.getCategoryId());
                            pstmt.setString(++i, links.getImage());
                            pstmt.setInt(++i, links.getOrder());
                            pstmt.setString(++i, links.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LinksDao] #update# error " + links, e);
            return false;
        }
    }

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

    public List<Links> getByQuery(final LinksQuery query) {
        logger.info("[LinksDao] #getByQuery# query=" + query);
        List<Links> list = new ArrayList<Links>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_links where 1=1 ");
            if (StringUtils.isNotBlank(query.getCategoryId()))
                sql.append(" and links_category_id_fk = ? ");

            if (StringUtils.isNotBlank(query.getKw()))
                sql.append(" and (links_name like ? or links_url like ? ) ");

            sql.append(" order by links_order desc limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getCategoryId()))
                                preparedstatement.setString(++i, query.getCategoryId());

                            if (StringUtils.isNotBlank(query.getKw())) {
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }
                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new LinksRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[LinksDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final LinksQuery query) {
        logger.info("[LinksDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_links where 1=1 ");

            if (StringUtils.isNotBlank(query.getCategoryId())) {
                sql.append(" and links_category_id_fk = ? ");
                params.add(query.getCategoryId());
            }

            if (StringUtils.isNotBlank(query.getKw())) {
                sql.append(" and (links_name like ? or links_url like ? ) ");
                params.add("%" + query.getKw() + "%");
                params.add("%" + query.getKw() + "%");
            }

            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[LinksDao] #getCountByQuery# error! query=" + query, e);
        }
        return count;
    }

    public boolean deleteImage(final String linksId) {
        logger.info("[LinksDao] #delete-image#" + linksId);
        try {
            int count = jdbcTemplate.update("update tbl_links set links_image = ?  where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, "");
                            preparedstatement.setString(2, linksId);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LinksDao] #delete-image# error!" + linksId, e);
        }
        return false;
    }

    class LinksRowMapper implements RowMapper<Links> {
        @Override
        public Links mapRow(ResultSet rs, int i) throws SQLException {
            Links links = new Links();
            links.setId(rs.getString("id"));
            links.setName(rs.getString("links_name"));
            links.setUrl(rs.getString("links_url"));
            links.setImage(rs.getString("links_image"));
            links.setOrder(rs.getInt("links_order"));
            links.setPublishTime(rs.getTimestamp("links_publishtime"));

            links.setCategoryId(rs.getString("links_category_id_fk"));
            Category category = categoryDao.getBySmpleId(links.getCategoryId());
            links.setCategory(category);

            return links;
        }
    }
}
