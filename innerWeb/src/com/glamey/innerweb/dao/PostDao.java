/**
 *
 */
package com.glamey.innerweb.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.glamey.framework.utils.StringTools;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Post;

/**
 *	正文内容DAO
 *
 * @author zy
 */
@Repository
public class PostDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(PostDao.class);

    @Resource
    private CategoryDao categoryDao ;
    
    public boolean create(final Post post) {
        logger.info("[PostDao] #create# " + post);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_post(id,post_category_type,post_category_id,post_title,post_author,post_source,post_time,post_showindex,post_showlist," +
                    "post_apply,post_focusimage,post_hot,post_summary,post_image,post_content)" +
                    " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, post.getCategoryType());
                            pstmt.setString(++i, post.getCategoryId());
                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getAuthor());
                            pstmt.setString(++i, post.getSource());
                            pstmt.setString(++i, post.getTime());
                            pstmt.setInt(++i, post.getShowIndex());
                            pstmt.setInt(++i, post.getShowList());
                            pstmt.setInt(++i, post.getApply());
                            pstmt.setInt(++i, post.getFocusImage());
                            pstmt.setInt(++i, post.getHot());
                            pstmt.setString(++i, post.getSummary());
                            pstmt.setString(++i, post.getImage());
                            pstmt.setString(++i, post.getContent());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[PostDao] #create# error " + post, e);
            return false;
        }
    }
    /**
     * update Post
     * @param post
     * @return
     */
    public boolean update(final Post post) {
        logger.info("[PostDao] #update# " + post);
        try {
            int count = jdbcTemplate.update(
            		"update tbl_post set post_category_type=?,post_category_id=?,post_title=?,post_author=?,post_source=?,post_time=?," +
            		"post_showindex=?,post_showlist=?,post_apply=?,post_focusimage=?,post_hot=?,post_summary=?,post_image=?,post_content=? where id=?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, post.getCategoryType());
                            pstmt.setString(++i, post.getCategoryId());
                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getAuthor());
                            pstmt.setString(++i, post.getSource());
                            pstmt.setString(++i, post.getTime());
                            pstmt.setInt(++i, post.getShowIndex());
                            pstmt.setInt(++i, post.getShowList());
                            pstmt.setInt(++i, post.getApply());
                            pstmt.setInt(++i, post.getFocusImage());
                            pstmt.setInt(++i, post.getHot());
                            pstmt.setString(++i, post.getSummary());
                            pstmt.setString(++i, post.getImage());
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

    /**
     * delete post by id
     *
     * @param id
     * @return
     */
    public boolean deleteById(final String id) {
        logger.info("[PostDao] #delete#" + id);
        try {
            int count = jdbcTemplate.update("delete from tbl_post where id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, id);
                }
            });
            return count > 0;
        } catch (Exception e) {
            logger.error("[PostDao] #deleteById# id=" + id + " error ", e);
        }
        return false;
    }


    /**
     * 通过ID获取对应的文章内容
     * @param postId
     * @return
     */
    public Post getByPostId(final String postId) {
        logger.info("[PostDao] #getByPostId# postId=" + postId );
        try {
        	List<Post> list = jdbcTemplate.query("select * from tbl_post where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, postId);
                        }
                    },
                    new PostRowMapper());
            if(list != null && list.size() > 0){
            	return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[PostDao] #getByPostId# postId=" + postId + " error!", e);
        }
        return null;
    }

    /**
     * 获取指定分类下的所有文章
     * @param categoryType
     * @param categoryId
     * @param start
     * @param num
     * @return
     */
    public List<Post> getByCategoryId(final String categoryType, final String categoryId, final int start, final int num) {
        logger.info("[PostDao] #getByCategoryId# categoryType=" + categoryType + " categoryId=" + categoryId);
        List<Post> list = new ArrayList<Post>();
        try {
            list = jdbcTemplate.query("select * from tbl_post where post_category_type = ? and post_category_id = ? order by post_time desc limit ?,? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, categoryType);
                            preparedstatement.setString(2, categoryId);
                            preparedstatement.setInt(3, start);
                            preparedstatement.setInt(4, num);
                        }
                    },
                    new PostRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[PostDao] #getByCategoryId# categoryType=" + categoryType + " categoryId=" + categoryId + " error!", e);
        }
        return null;
    }

    /**
     * 获取指定分类下的所有文章总数
     * @param categoryType
     * @param categoryId
     * @return
     */
    public int getCountByCategoryId(final String categoryType, final String categoryId) {
        logger.info("[PostDao] #getCountByCategoryId# categoryType=" + categoryType + " categoryId=" + categoryId);
        int count = 0;
        try {
            count = jdbcTemplate.queryForInt("select count(1) as total from tbl_post where post_category_type = ? and post_category_id = ? ",
                    new Object[]{categoryType, categoryId});
        } catch (Exception e) {
            logger.error("[PostDao] #getCountByCategoryId# categoryType=" + categoryType + " categoryId=" + categoryId + " error!", e);
        }
        return count;
    }

    class PostRowMapper implements RowMapper<Post> {
        @Override
        public Post mapRow(ResultSet rs, int i) throws SQLException {
        	Post post = new Post();
        	post.setId(rs.getString("id"));
        	post.setCategoryType(rs.getString("post_category_type"));
        	post.setCategoryId(rs.getString("post_category_id"));
        	Category category = categoryDao.getById(post.getCategoryId());
        	post.setCategory(category);

        	post.setTitle(rs.getString("post_title"));
        	//TODO 针对author设置对象填充
        	post.setAuthor(rs.getString("post_author"));
        	post.setSource(rs.getString("post_source"));
        	post.setTime(rs.getString("post_time"));
        	post.setShowIndex(rs.getInt("post_showindex"));
        	post.setShowList(rs.getInt("post_showlist"));
        	post.setApply(rs.getInt("post_apply"));
        	post.setFocusImage(rs.getInt("post_focusimage"));
        	post.setHot(rs.getInt("post_hot"));
        	post.setSummary(rs.getString("post_summary"));
        	post.setImage(rs.getString("post_image"));
        	post.setContent(rs.getString("post_content"));
        	
            return post;
        }
    }
}
