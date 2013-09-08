/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.Post;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.PostQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * 正文内容DAO
 *
 * @author zy
 */
@Repository
public class PostDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(PostDao.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private MetaInfoDao metaInfoDao;
    @Resource
    private UserInfoDao userInfoDao;

    public boolean create(final Post post) {
        logger.info("[PostDao] #create# " + post);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_post(id,post_title,post_author,post_source,post_time,post_summary,post_image,post_content,post_isvalid)" +
                            " values(?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getAuthor());
                            pstmt.setString(++i, post.getSource());
                            pstmt.setString(++i, post.getTime());
                            pstmt.setString(++i, post.getSummary());
                            pstmt.setString(++i, post.getImage());
                            pstmt.setString(++i, post.getContent());
                            pstmt.setInt(++i, post.getIsValid());
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
     *
     * @param post
     * @return
     */
    public boolean update(final Post post) {
        logger.info("[PostDao] #update# " + post);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_post set post_title=?,post_author=?,post_source=?,post_time=?,post_summary=?,post_image=?,post_content=?,post_isvalid=? where id=?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getAuthor());
                            pstmt.setString(++i, post.getSource());
                            pstmt.setString(++i, post.getTime());
                            pstmt.setString(++i, post.getSummary());
                            pstmt.setString(++i, post.getImage());
                            pstmt.setString(++i, post.getContent());
                            pstmt.setInt(++i, post.getIsValid());
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
     *
     * @param postId
     * @return
     */
    public Post getByPostId(final String postId) {
        logger.info("[PostDao] #getByPostId# postId=" + postId);
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
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[PostDao] #getByPostId# postId=" + postId + " error!", e);
        }
        return null;
    }

    public List<Post> getPostList(final PostQuery query) {
        logger.info("[PostDao] #getPostList# query=" + query);
        List<Post> list = new ArrayList<Post>();
        try {

            StringBuffer sql = new StringBuffer("select * from tbl_post where 1=1 ");
            if (StringUtils.isNotBlank(query.getKeyword()))
                sql.append(" and (post_title like ? or post_summary like ? or post_content = ? )");
            if (query.getIsValid() > -1)
                sql.append(" and post_isvalid = ? ");
            if (StringUtils.isNotBlank(query.getStartTime()))
                sql.append(" and post_time >= ? ");
            if (StringUtils.isNotBlank(query.getEndTime()))
                sql.append(" and post_time <= ? ");
            sql.append(" order by post_time desc limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement) throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getKeyword())) {
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                            }
                            if (query.getIsValid() > -1)
                                preparedstatement.setInt(++i, query.getIsValid());

                            if (StringUtils.isNotBlank(query.getStartTime()))
                                preparedstatement.setString(++i, query.getStartTime());

                            if (StringUtils.isNotBlank(query.getEndTime()))
                                preparedstatement.setString(++i, query.getEndTime());

                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new PostRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[PostDao] #getPostList# query=" + query + " error!", e);
        }
        return null;
    }

    public int getCountPostList(final PostQuery query) {
        logger.info("[PostDao] #getCountPostList# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_post where 1=1 ");
            if (StringUtils.isNotBlank(query.getKeyword())) {
                sql.append(" and (post_title like ? or post_summary like ? or post_content = ? )");
                params.add("%" + query.getKeyword() + "%");
                params.add("%" + query.getKeyword() + "%");
                params.add("%" + query.getKeyword() + "%");
            }

            if (query.getIsValid() > -1) {
                sql.append(" and post_isvalid = ? ");
                params.add(query.getIsValid());
            }
            if (StringUtils.isNotBlank(query.getStartTime())) {
                sql.append(" and post_time >= ? ");
                params.add(query.getStartTime());
            }
            if (StringUtils.isNotBlank(query.getEndTime())) {
                sql.append(" and post_time <= ? ");
                params.add(query.getEndTime());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[PostDao] #getCountPostList# query=" + query + " error!", e);
        }
        return count;
    }

    class PostRowMapper implements RowMapper<Post> {
        @Override
        public Post mapRow(ResultSet rs, int i) throws SQLException {
            Post post = new Post();
            post.setId(rs.getString("id"));
            post.setTitle(rs.getString("post_title"));
            post.setAuthor(rs.getString("post_author"));
            UserInfo userInfo = userInfoDao.getUserById(post.getAuthor());
            post.setUserInfo(userInfo);
            post.setSource(rs.getString("post_source"));
            post.setTime(rs.getString("post_time"));
            post.setSummary(rs.getString("post_summary"));
            post.setImage(rs.getString("post_image"));
            post.setContent(rs.getString("post_content"));
            post.setIsValid(rs.getInt("post_isvalid"));
            return post;
        }
    }
}
