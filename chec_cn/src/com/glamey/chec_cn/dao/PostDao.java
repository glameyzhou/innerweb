package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Post;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class PostDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(PostDao.class);

    /**
     * create the post,and return the postId
     * @param post
     * @return
     */
    public String createReturnId(final Post post) {
        logger.info("[PostDao] #createReturnId# " + post);
        try {
            final String id = StringTools.getUniqueId();
            int count = jdbcTemplate.update(
                    "insert into tbl_post(id,cate_id_fk,cate_type_fk,title,author,source,publish_time,update_time,out_link,post_order,is_show_index,is_show_list,is_valid,is_foucs,foucs_img,summary,content) " +
                            "alues(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, id);
                            pstmt.setString(++i, post.getCateId());
                            pstmt.setString(++i, post.getCateType());
                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getAuthor());
                            pstmt.setString(++i, post.getSource());
                            pstmt.setTimestamp(++i, new Timestamp(post.getPublishTime().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(post.getUpdateTime().getTime()));
                            pstmt.setString(++i, post.getOutLink());
                            pstmt.setInt(++i, post.getOrder());
                            pstmt.setInt(++i, post.getShowIndex());
                            pstmt.setInt(++i, post.getShowList());
                            pstmt.setInt(++i, post.getIsValid());
                            pstmt.setInt(++i, post.getIsFoucs());
                            pstmt.setString(++i, post.getFoucsImg());
                            pstmt.setString(++i, post.getSummary());
                            pstmt.setString(++i, post.getContent());

                        }
                    });
            return count > 0 ? id : null;
        } catch (Exception e) {
            logger.error("[PostDao] #createReturnId# error " + post, e);
            return null;
        }
    }


    public boolean update(final Post post) {
        logger.info("[PostDao] #update# " + post);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_post set cate_id_fk = ?,cate_type_fk = ?,title = ?,author = ?,source = ?,publish_time = ?,update_time = ?,out_link = ?,post_order = ?,is_show_index = ?,is_show_list = ?,is_valid = ?,is_foucs = ?,foucs_img = ?,summary = ?,content = ? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, post.getCateId());
                            pstmt.setString(++i, post.getCateType());
                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getAuthor());
                            pstmt.setString(++i, post.getSource());
                            pstmt.setTimestamp(++i, new Timestamp(post.getPublishTime().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(post.getUpdateTime().getTime()));
                            pstmt.setString(++i, post.getOutLink());
                            pstmt.setInt(++i, post.getOrder());
                            pstmt.setInt(++i, post.getShowIndex());
                            pstmt.setInt(++i, post.getShowList());
                            pstmt.setInt(++i, post.getIsValid());
                            pstmt.setInt(++i, post.getIsFoucs());
                            pstmt.setString(++i, post.getFoucsImg());
                            pstmt.setString(++i, post.getSummary());
                            pstmt.setString(++i, post.getContent());
                            pstmt.setString(++i, post.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[PostDao] #update# error " + post, e);
            return false;
        }
    }
}
