/**
 *
 */
package com.glamey.innerweb.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Post;
import com.glamey.innerweb.model.dto.PostQuery;
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
     *
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

    /**
     * 获取指定分类下的所有文章
     *
     * @param query
     * @return
     */
    public List<Post> getByCategoryId(final PostQuery query) {
        logger.info("[PostDao] #getByCategoryId# query=" + query);
        List<Post> list = new ArrayList<Post>();
        try {

            StringBuffer sql = new StringBuffer("select * from tbl_post where 1=1 ");
            if (StringUtils.isNotBlank(query.getCategoryType()))
                sql.append(" and post_category_type = ? ");

            if (StringUtils.isNotBlank(query.getCategoryId()))
                sql.append(" and post_category_id = ? ");

            if (query.getShowIndex() > -1)
                sql.append(" and post_showindex = ? ");

            if (query.getShowList() > -1)
                sql.append(" and post_showlist = ? ");

            if (query.getApply() > -1)
                sql.append(" and post_apply = ? ");

            if (query.getFocusImage() > -1)
                sql.append(" and post_focusimag = ? ");

            if (StringUtils.isNotBlank(query.getKeyword()))
                sql.append(" and (post_content = ? or post_summary like ?)");

            if(StringUtils.isNotBlank(query.getStartTime()))
                sql.append(" and (post_time >= ? and post_time <= ?) ") ;

            sql.append(" order by post_time desc limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement) throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getCategoryType()))
                                preparedstatement.setString(++i, query.getCategoryType());

                            if (StringUtils.isNotBlank(query.getCategoryId()))
                                preparedstatement.setString(++i, query.getCategoryId());

                            if (query.getShowIndex() > -1)
                                preparedstatement.setInt(++i, query.getShowIndex());

                            if (query.getShowList() > -1)
                                preparedstatement.setInt(++i, query.getShowList());

                            if (query.getApply() > -1)
                                preparedstatement.setInt(++i, query.getApply());

                            if (query.getFocusImage() > -1)
                                preparedstatement.setInt(++i, query.getFocusImage());

                            if (StringUtils.isNotBlank(query.getKeyword())) {
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                            }
                            if(StringUtils.isNotBlank(query.getStartTime())){
                                preparedstatement.setString(++i,query.getStartTime());
                                preparedstatement.setString(++i,query.getEndTime());
                            }
                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new PostRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[PostDao] #getByCategoryId# query=" + query + " error!", e);
        }
        return null;
    }

    /**
     * 获取指定分类下的所有文章总数
     *
     * @param query
     * @return
     */
    public int getCountByCategoryId(final PostQuery query) {
        logger.info("[PostDao] #getCountByCategoryId# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_post where 1=1 ");
            if (StringUtils.isNotBlank(query.getCategoryType())) {
                sql.append(" and post_category_type = ? ");
                params.add(query.getCategoryType());
            }

            if (StringUtils.isNotBlank(query.getCategoryId())) {
                sql.append(" and post_category_id = ? ");
                params.add(query.getCategoryId());
            }
            if (query.getShowIndex() > -1) {
                sql.append(" and post_showindex = ? ");
                params.add(query.getShowIndex());
            }
            if (query.getShowList() > -1) {
                sql.append(" and post_showlist = ? ");
                params.add(query.getShowList());
            }
            if (query.getApply() > -1) {
                sql.append(" and post_apply = ? ");
                params.add(query.getApply());
            }
            if (query.getFocusImage() > -1) {
                sql.append(" and post_focusimag = ? ");
                params.add(query.getFocusImage());
            }
            if (StringUtils.isNotBlank(query.getKeyword())) {
                sql.append(" and (post_content = ? or post_summary like ?)");
                params.add(query.getKeyword());
                params.add(query.getKeyword());
            }
            if(StringUtils.isNotBlank(query.getStartTime())){
                sql.append(" and (post_time >= ? and post_time <= ?) ") ;
                params.add(query.getStartTime());
                params.add(query.getEndTime());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[PostDao] #getCountByCategoryId# query=" + query + " error!", e);
        }
        return count;
    }

    public boolean pageOperate(final String postId, final String type, final String flag) {
        logger.info("[PostDao] #pageOperate# postId=" + postId + " type=" + type + " flag=" + flag);
        try {
            StringBuilder sql = new StringBuilder("update tbl_post ");
            if (StringUtils.equals(type, "2")) {
                sql.append(" set post_showindex = ? ");
            }
            if (StringUtils.equals(type, "3")) {
                sql.append(" set post_showlist = ? ");
            }
            if (StringUtils.equals(type, "4")) {
                sql.append(" set post_apply = ? ");
            }
            if (StringUtils.equals(type, "5")) {
                sql.append(" set post_focusimage = ? ");
            }
            sql.append(" where id = ?");
            int count = jdbcTemplate.update(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, flag);
                            preparedstatement.setString(2, postId);
                        }
                    });

            //删除使用
            if (StringUtils.equals(type, "1")) {
                return deleteById(postId);
            }

            return count > 0;
        } catch (Exception e) {
            logger.error("[PostDao] #pageOperate# postId=" + postId + " type=" + type + " flag=" + flag + " error!", e);
        }
        return false;
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
