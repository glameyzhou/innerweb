package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.Category;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * 分类管理
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class CategoryDao extends BaseDao{
    private static final Logger logger = Logger.getLogger(CategoryDao.class);

    /**
     * 新增节点
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
            if(!StringUtils.equals(category.getPid(), "0")){
                jdbcTemplate.update("update tbl_category set hasChild = 1 where id=?",new PreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement preparedStatement) throws SQLException {
                        preparedStatement.setString(1,category.getPid());
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
     * @param category
     * @return
     */
    public boolean update(final Category category) {
        logger.info("[CategoryDao] #update# " + category);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_category cate_pid = ?,cate_type = ?,cate_order = ?,cate_is_show = ?,cate_is_list = ?,cate_has_children = ?,cate_name = ?,cate_alias_name = ?,cate_img = ?,cate_flv = ?,cate_desc = ? where id = ?",
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
}
