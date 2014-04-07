package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.dto.CategoryQuery;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * 分类管理
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class CategoryDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(CategoryDao.class);

    /**
     * 新增节点
     *
     * @param category
     * @return
     */
    public String createReturnId(final Category category) {
        logger.info("[CategoryDao] #create# " + category);
        try {
            final String id = StringTools.getUniqueId();
            int count = jdbcTemplate.update(
                    "insert into tbl_category(id,cate_pid,cate_type,cate_order,cate_is_show,cate_is_list,cate_has_children,cate_name,cate_alias_name,cate_img,cate_flv,cate_desc) " +
                            "alues(?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, id);
                            pstmt.setString(++i, category.getName());
                            pstmt.setString(++i, category.getPid());
                            pstmt.setString(++i, category.getType());
                            pstmt.setInt(++i, category.getOrder());
                            pstmt.setInt(++i, category.getIsShow());
                            pstmt.setInt(++i, category.getIsList());
                            pstmt.setInt(++i, category.getHasChildren());
                            pstmt.setString(++i, category.getName());
                            pstmt.setString(++i, category.getAliasName());
                            pstmt.setString(++i, category.getImage());
                            pstmt.setString(++i, category.getFlv());
                            pstmt.setString(++i, category.getDesc());
                        }
                    });

            //如果父分类ID非"0"(根结点)
            if (!StringUtils.equals(category.getPid(), "0")) {
                jdbcTemplate.update("update tbl_category set hasChild = 1 where id=?", new PreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement preparedStatement) throws SQLException {
                        preparedStatement.setString(1, category.getPid());
                    }
                });
            }
            return count > 0 ? id : null;
        } catch (Exception e) {
            logger.error("[CategoryDao] #create# error " + category, e);
            return null;
        }
    }

    /**
     * updat the category
     *
     * @param category
     * @return
     */
    public boolean update(final Category category) {
        logger.info("[CategoryDao] #update# " + category);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_category set cate_pid = ?,cate_type = ?,cate_order = ?,cate_is_show = ?,cate_is_list = ?,cate_has_children = ?,cate_name = ?,cate_alias_name = ?,cate_img = ?,cate_flv = ?,cate_desc = ? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, category.getName());
                            pstmt.setString(++i, category.getPid());
                            pstmt.setString(++i, category.getType());
                            pstmt.setInt(++i, category.getOrder());
                            pstmt.setInt(++i, category.getIsShow());
                            pstmt.setInt(++i, category.getIsList());
                            pstmt.setInt(++i, category.getHasChildren());
                            pstmt.setString(++i, category.getName());
                            pstmt.setString(++i, category.getAliasName());
                            pstmt.setString(++i, category.getImage());
                            pstmt.setString(++i, category.getFlv());
                            pstmt.setString(++i, category.getDesc());
                            pstmt.setString(++i, category.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[CategoryDao] #create# error " + category, e);
            return false;
        }
    }

    /**
     * get category by id
     *
     * @param id
     * @return
     */
    public Category getById(final String id) {
        logger.info("[CategoryDao] #getById#" + id);
        try {
            List<Category> list = jdbcTemplate.query("select * from tbl_category where id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, id);
                        }
                    },
                    new CategoryRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[CategoryDao] #getById# error " + id, e);
        }
        return null;
    }

    /**
     * delete the category by cateId
     * @param id
     * @return
     */
    public boolean delete(final String id) {
        logger.info("[CategoryDao] #delete#" + id);
        try {
            int count = jdbcTemplate.update("delete from tbl_category where id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, id);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[CategoryDao] #delete# error " + id, e);
        }
        return false;
    }

    /**
     * get the category list by query filter
     *
     * @param query
     * @return
     */
    public List<Category> getListByQuery(final CategoryQuery query) {
        logger.info("[CategoryDao] #getListByQuery#" + query);
        List<Category> list = new ArrayList<Category>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_category where 1=1 ");
            if (StringUtils.isNotBlank(query.getType())) {
                sql.append(" and cate_type = ? ");
            }
            if (StringUtils.isNotBlank(query.getPid())) {
                sql.append(" and cate_pid = ? ");
            }

            if (!CollectionUtils.isEmpty(query.getIdList())) {
                int size = query.getIdList().size();
                String psql = "";
                for (int i = 0; i < size; i++) {
                    psql += ",?";
                }
                psql = StringUtils.isNotBlank(psql) ? psql.substring(1) : "";
                sql.append(" and id in (" + psql + ") ");
            }
            sql.append(" order by cate_order desc limit ?,?");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement) throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getType())) {
                                preparedstatement.setString(++i, query.getType());
                            }
                            if (StringUtils.isNotBlank(query.getPid())) {
                                preparedstatement.setString(++i, query.getPid());
                            }

                            if (!CollectionUtils.isEmpty(query.getIdList())) {
                                for (String cateId : query.getIdList()) {
                                    preparedstatement.setString(++i, cateId);
                                }
                            }
                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new CategoryRowMapper());
        } catch (Exception e) {
            logger.error("[CategoryDao] #getListByQuery# error " + query, e);
        }
        return list;
    }

    /**
     * get count by query filter
     *
     * @param query
     * @return
     */
    public int getCountByQuery(final CategoryQuery query) {
        logger.info("[CategoryDao] #getCountByQuery#" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select * from tbl_category where 1=1 ");
            if (StringUtils.isNotBlank(query.getType())) {
                sql.append(" and cate_type = ? ");
                params.add(query.getType());
            }
            if (StringUtils.isNotBlank(query.getPid())) {
                sql.append(" and cate_pid = ? ");
                params.add(query.getPid());
            }

            if (!CollectionUtils.isEmpty(query.getIdList())) {
                int size = query.getIdList().size();
                String psql = "";
                for (int i = 0; i < size; i++) {
                    psql += ",?";
                    params.add(query.getIdList().get(i));
                }
                psql = StringUtils.isNotBlank(psql) ? psql.substring(1) : "";
                sql.append(" and id in (" + psql + ") ");
            }

            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[CategoryDao] #getCountByQuery# error " + query, e);
        }
        return count;
    }

    class CategoryRowMapper implements RowMapper<Category> {
        @Override
        public Category mapRow(ResultSet rs, int i) throws SQLException {
            Category category = new Category();
            category.setId(rs.getString("id"));
            category.setPid(rs.getString("cate_pid"));
            category.setType(rs.getString("cate_type"));
            category.setOrder(rs.getInt("cate_order"));
            category.setIsShow(rs.getInt("cate_is_show"));
            category.setIsList(rs.getInt("cate_is_list"));
            category.setHasChildren(rs.getInt("cate_has_children"));
            category.setName(rs.getString("cate_name"));
            category.setAliasName(rs.getString("cate_alias_name"));
            category.setImage(rs.getString("cate_img"));
            category.setFlv(rs.getString("cate_flv"));
            category.setDesc(rs.getString("cate_desc"));
            //父类ID
            if (!StringUtils.equals(category.getPid(), "0")) {
                Category categoryParent = getById(category.getPid());
                category.setCategoryPid(categoryParent);
            }
            return category;
        }
    }
}
