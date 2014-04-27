package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Post;
import com.glamey.chec_cn.model.dto.LuceneEntry;
import com.glamey.chec_cn.model.dto.PostQuery;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 正文内容操作
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class PostDao extends BaseDao {
    public static final Logger logger = Logger.getLogger(PostDao.class);

    @Autowired
    private CategoryDao categoryDao;

    /**
     * create the post ,and return the postId;
     *
     * @param post
     * @return
     */
    public String createReturnId(final Post post) {
        logger.info("[PostDao] #createReturnId# " + post);
        final String postId = StringTools.getUniqueId();
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_post" +
                            "(id,post_category_id_fk,post_category_type,post_title,post_author,post_source,post_publish_time,post_update_time,post_summary,post_content," +
                            "post_user_id_fk,post_show_index,post_show_list,post_show_focusimage,post_focusimage,post_order,post_show_top,post_toporder)" +
                            " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, postId);
                            pstmt.setString(++i, post.getCategoryId());
                            pstmt.setString(++i, post.getCategoryType());

                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getAuthor());
                            pstmt.setString(++i, post.getSource());
                            pstmt.setTimestamp(++i, new Timestamp(post.getPublishTime().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(post.getPublishTime().getTime()));
                            pstmt.setString(++i, post.getSummary());
                            pstmt.setString(++i, post.getContent());
                            pstmt.setString(++i, post.getUserId());

                            pstmt.setInt(++i, post.getShowIndex());
                            pstmt.setInt(++i, post.getShowList());
                            pstmt.setInt(++i, post.getShowFocusImage());
                            pstmt.setString(++i, post.getFocusImage());
                            pstmt.setInt(++i, post.getPostOrder());
                            pstmt.setInt(++i, post.getShowTop());
                            pstmt.setInt(++i, post.getTopOrder());
                        }
                    }
            );
            return postId;
        } catch (Exception e) {
            logger.error("[PostDao] #createReturnId# error " + post, e);
            return null;
        }
    }

    /**
     * update the post info by postId
     *
     * @param post
     * @return
     */
    public boolean update(final Post post) {
        logger.info("[PostDao] #update# " + post);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_post set post_category_id_fk = ?,post_category_type = ?,post_title = ?,post_author = ?,post_source = ?,post_publish_time = ?,post_update_time = now()," +
                            "post_summary = ?,post_content = ?,post_user_id_fk = ?,post_show_index = ?,post_show_list = ?,post_show_focusimage = ?,post_focusimage = ?," +
                            "post_order = ?,post_show_top = ?,post_toporder = ? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, post.getCategoryId());
                            pstmt.setString(++i, post.getCategoryType());

                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getAuthor());
                            pstmt.setString(++i, post.getSource());
                            pstmt.setTimestamp(++i, new Timestamp(post.getPublishTime().getTime()));
                            pstmt.setString(++i, post.getSummary());
                            pstmt.setString(++i, post.getContent());
                            pstmt.setString(++i, post.getUserId());

                            pstmt.setInt(++i, post.getShowIndex());
                            pstmt.setInt(++i, post.getShowList());
                            pstmt.setInt(++i, post.getShowFocusImage());
                            pstmt.setString(++i, post.getFocusImage());
                            pstmt.setInt(++i, post.getPostOrder());
                            pstmt.setInt(++i, post.getShowTop());
                            pstmt.setInt(++i, post.getTopOrder());
                            pstmt.setString(++i, post.getId());
                        }
                    }
            );
            return count > 0;
        } catch (Exception e) {
            logger.error("[PostDao] #update# error " + post, e);
            return false;
        }
    }

    /**
     * delete the post by postId
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
     * delete the post by postId
     *
     * @param categoryId
     * @return
     */
    public boolean deleteByCategoryId(final String categoryId) {
        logger.info("[PostDao] #deleteByCategoryId#" + categoryId);
        try {
            int count = jdbcTemplate.update("update tbl_post set post_category_id_fk = '-1' where post_category_id_fk = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, categoryId);
                }
            });
            return count >= 0;
        } catch (Exception e) {
            logger.error("[PostDao] #deleteByCategoryId# id=" + categoryId + " error ", e);
        }
        return false;
    }

    /**
     * get post by postId
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
                    new PostRowMapper()
            );
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[PostDao] #getByPostId# postId=" + postId + " error!", e);
        }
        return null;
    }

    public List<Post> getByQuery(final PostQuery query) {
        logger.info("[PostDao] #getByQuery# query=" + query);
        List<Post> list = new ArrayList<Post>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_post where 1=1 ");

            if (StringUtils.isNotBlank(query.getCategoryType()))
                sql.append(" and post_category_type = ? ");

            if (StringUtils.isNotBlank(query.getCategoryId()))
                sql.append(" and post_category_id_fk = ? ");

            if (query.getCategoryIds() != null && query.getCategoryIds().size() > 0) {
                int size = query.getCategoryIds().size();
                String psql = "";
                for (int i = 0; i < size; i++) {
                    psql += "," + "?";
                }
                psql = StringUtils.isNotBlank(psql) ? psql.substring(1) : "";
                sql.append(" and post_category_id_fk in (" + psql + ") ");
            }

            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                sql.append(" and post_publish_time >= ? ");
            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                sql.append(" and post_publish_time <= ? ");

            if (StringUtils.isNotBlank(query.getKw()))
                sql.append(" and (post_title like ? or post_summary like ? or post_content like ? ) ");

            if (query.getShowIndex() > -1)
                sql.append(" and post_show_index = ? ");

            if (query.getShowList() > -1)
                sql.append(" and post_show_list = ? ");

            if (query.getShowFocusImage() > -1)
                sql.append(" and post_show_focusimage = ? ");

            if (query.getShowTop() > -1)
                sql.append(" and post_show_top = ? ");

            LinkedHashMap<String, String> orderMap = query.getOrderMap();
            if (orderMap != null && orderMap.size() > 0) {
                StringBuffer subSql = new StringBuffer(20);
                subSql.append(" order by ");
                for (Map.Entry<String, String> entry : orderMap.entrySet()) {
                    subSql.append(entry.getKey()).append(" ").append(entry.getValue()).append(",");
                }

                sql.append(StringUtils.removeEnd(subSql.toString(), ","));
            }

            sql.append(" limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getCategoryType()))
                                preparedstatement.setString(++i, query.getCategoryType());

                            if (StringUtils.isNotBlank(query.getCategoryId()))
                                preparedstatement.setString(++i, query.getCategoryId());

                            if (query.getCategoryIds() != null && query.getCategoryIds().size() > 0) {
                                for (String p : query.getCategoryIds()) {
                                    preparedstatement.setString(++i, p);
                                }
                            }

                            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                                preparedstatement.setString(++i, query.getPublishStartTime());

                            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                                preparedstatement.setString(++i, query.getPublishEndTime());

                            if (StringUtils.isNotBlank(query.getKw())) {
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }

                            if (query.getShowIndex() > -1)
                                preparedstatement.setInt(++i, query.getShowIndex());

                            if (query.getShowList() > -1)
                                preparedstatement.setInt(++i, query.getShowList());

                            if (query.getShowFocusImage() > -1)
                                preparedstatement.setInt(++i, query.getShowFocusImage());

                            if (query.getShowTop() > -1)
                                preparedstatement.setInt(++i, query.getShowTop());


                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                            System.out.println(preparedstatement.toString());
                        }
                    },
                    new PostRowMapper()
            );
            return list;
        } catch (Exception e) {
            logger.error("[PostDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final PostQuery query) {
        logger.info("[PostDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_post where 1=1 ");

            if (StringUtils.isNotBlank(query.getCategoryType())) {
                sql.append(" and post_category_type = ? ");
                params.add(query.getCategoryType());
            }

            if (StringUtils.isNotBlank(query.getCategoryId())) {
                sql.append(" and post_category_id_fk = ? ");
                params.add(query.getCategoryId());
            }

            if (query.getCategoryIds() != null && query.getCategoryIds().size() > 0) {
                int size = query.getCategoryIds().size();
                String psql = "";
                for (int i = 0; i < size; i++) {
                    psql += "," + "?";
                    params.add(query.getCategoryIds().get(i));
                }
                psql = StringUtils.isNotBlank(psql) ? psql.substring(1) : "";
                sql.append(" and post_category_id_fk in (" + psql + ") ");
            }

            if (StringUtils.isNotBlank(query.getPublishStartTime())) {
                sql.append(" and post_publish_time >= ? ");
                params.add(query.getPublishStartTime());
            }
            if (StringUtils.isNotBlank(query.getPublishEndTime())) {
                sql.append(" and post_publish_time <= ? ");
                params.add(query.getPublishEndTime());
            }

            if (StringUtils.isNotBlank(query.getKw())) {
                sql.append(" and (post_title like ? or post_summary like ? or post_content like ? ) ");
                params.add(query.getKw());
                params.add(query.getKw());
                params.add(query.getKw());
            }

            if (query.getShowIndex() > -1) {
                sql.append(" and post_show_index = ? ");
                params.add(query.getShowIndex());
            }

            if (query.getShowList() > -1) {
                sql.append(" and post_show_list = ? ");
                params.add(query.getShowList());
            }

            if (query.getShowFocusImage() > -1) {
                sql.append(" and post_show_focusimage = ? ");
                params.add(query.getShowFocusImage());
            }

            if (query.getShowTop() > -1) {
                sql.append(" and post_show_top = ? ");
                params.add(query.getShowTop());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[PostDao] #getCountByQuery# error! query=" + query, e);
        }
        return count;
    }

    public List<LuceneEntry> getPostLuceneEntry() {
        List<LuceneEntry> entries = new ArrayList<LuceneEntry>(1000);
        try {
            LuceneEntry entry = null;
            List<Post> postList = new ArrayList<Post>(1000);
            String sql = "select id,post_category_id_fk,post_category_type,post_title,post_publish_time,post_summary,post_content from tbl_post where post_category_type = '" + CategoryConstants.CATEGORY_NEWS + "'";
            postList = jdbcTemplate.query(sql,
                    new RowMapper<Post>() {
                        @Override
                        public Post mapRow(ResultSet resultSet, int i) throws SQLException {
                            Post post = new Post();
                            post.setId(resultSet.getString("id"));
                            post.setCategoryId(resultSet.getString("post_category_id_fk"));
                            post.setCategoryType(resultSet.getString("post_category_type"));
                            post.setTitle(resultSet.getString("post_title"));
                            post.setPublishTime(resultSet.getTimestamp("post_publish_time"));
                            post.setSummary(resultSet.getString("post_summary"));
                            post.setContent(resultSet.getString("post_content"));
                            return post;
                        }
                    }
            );
            for (Post obj : postList) {
                entry = new LuceneEntry();
                entry.setId(obj.getId());
                entry.setHref("post-" + obj.getCategoryType() + "-" + obj.getCategoryId() + "-" + entry.getId() + ".htm");
                entry.setTitle(obj.getTitle());
                entry.setContent(obj.getContent());
                entry.setTime(DateFormatUtils.format(obj.getPublishTime(),"yyyy-MM-dd HH:mm:ss"));
                entry.setModel(obj.getCategoryId());
                entry.setModelName(obj.getCategoryType());
                entries.add(entry);
            }
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return entries;
    }

    class PostRowMapper implements RowMapper<Post> {
        @Override
        public Post mapRow(ResultSet rs, int i) throws SQLException {
            Post post = new Post();
            post.setId(rs.getString("id"));
            post.setCategoryId(rs.getString("post_category_id_fk"));
            post.setCategoryType(rs.getString("post_category_type"));
            if (StringUtils.isNotBlank(post.getCategoryId())) {
                Category category = categoryDao.getBySmpleId(post.getCategoryId());
                post.setCategory(category);
            }

            post.setTitle(rs.getString("post_title"));
            post.setAuthor(rs.getString("post_author"));
            post.setSource(rs.getString("post_source"));
            post.setPublishTime(rs.getTimestamp("post_publish_time"));
            post.setUpdateTime(rs.getTimestamp("post_update_time"));
            post.setSummary(rs.getString("post_summary"));
            post.setContent(rs.getString("post_content"));

            post.setUserId(rs.getString("post_user_id_fk"));

            post.setShowIndex(rs.getInt("post_show_index"));
            post.setShowList(rs.getInt("post_show_list"));
            post.setShowFocusImage(rs.getInt("post_show_focusimage"));
            post.setFocusImage(rs.getString("post_focusimage"));
            post.setPostOrder(rs.getInt("post_order"));
            post.setShowTop(rs.getInt("post_show_top"));
            post.setTopOrder(rs.getInt("post_toporder"));
            return post;
        }
    }

}
