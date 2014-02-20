/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.BBSPost;
import com.glamey.library.model.domain.BBSReply;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.BBSAnalyzer;
import com.glamey.library.model.dto.BBSPostDTO;
import com.glamey.library.model.dto.BBSPostQuery;
import com.glamey.library.model.dto.BBSReplyQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;
import sun.util.resources.TimeZoneNames_sv;

import javax.annotation.Resource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 论坛主帖
 *
 * @author zy
 */
@Repository
public class BBSPostDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(BBSPostDao.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private UserInfoDao userInfoDao;
    @Resource
    private BBSReplyDao bbsReplyDao;

    /**
     * @param info
     * @return
     */
    public String create(final BBSPost info) {
        logger.info("[BBSPostDao] #create# " + info);
        try {
            final String postId = StringTools.getUniqueId();
            int count = jdbcTemplate.update(
                    "insert into tbl_bbs_post(id,category_id_fk,title,user_id_fk,publish_time,update_time,content,view_count,reply_count,show_top,show_great,show_popular) " +
                            " values(?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, postId);
                            pstmt.setString(++i, info.getCategoryId());
                            pstmt.setString(++i, info.getTitle());
                            pstmt.setString(++i, info.getUserId());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, info.getContent());
                            pstmt.setInt(++i, info.getViewCount());
                            pstmt.setInt(++i, info.getReplyCount());
                            pstmt.setInt(++i, info.getShowTop());
                            pstmt.setInt(++i, info.getShowGreat());
                            pstmt.setInt(++i, info.getShowPopular());

                        }
                    });
            return count > 0 ? postId : null;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #create# error " + info, e);
            return null;
        }
    }

    /**
     * @param info
     * @return
     */
    public boolean update(final BBSPost info) {
        logger.info("[BBSPostDao] #update# " + info);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_bbs_post set category_id_fk=?,title=?,user_id_fk=?,publish_time=?,update_time=?,content=?,view_count=?,reply_count=?,show_top=?,show_great=?,show_popular=? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, info.getCategoryId());
                            pstmt.setString(++i, info.getTitle());
                            pstmt.setString(++i, info.getUserId());
                            pstmt.setTimestamp(++i, new Timestamp(info.getPublishTime().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, info.getContent());
                            pstmt.setInt(++i, info.getViewCount());
                            pstmt.setInt(++i, info.getReplyCount());
                            pstmt.setInt(++i, info.getShowTop());
                            pstmt.setInt(++i, info.getShowGreat());
                            pstmt.setInt(++i, info.getShowPopular());
                            pstmt.setString(++i, info.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #update# error " + info, e);
            return false;
        }
    }

    public boolean addViewCount(final String postId) {
        logger.info("[BBSPostDao] #addViewCount# postId=" + postId);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_bbs_post set view_count= view_count + 1 where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, postId);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #addViewCount# error,postId=" + postId, e);
            return false;
        }
    }

    public boolean updateReplyCount(final String postId, boolean addCount) {
        logger.info("[BBSPostDao] #updateReplyCount# postId=" + postId + " addCount=" + addCount);
        try {
            String sql;
            if (addCount)
                sql = "update tbl_bbs_post set reply_count = viw_count + 1 where id = ?";
            else
                sql = "update tbl_bbs_post set reply_count = viw_count - 1 where id = ?";

            int count = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, postId);
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #updateReplyCount# error,postId=" + postId + " addCount=" + addCount, e);
            return false;
        }
    }

    /**
     * 帖子属性设置
     *
     * @param postIdList
     * @param type
     * @param itemValue
     * @return
     */
    public boolean update(final List<String> postIdList, final String type, final int itemValue) {
        logger.info("[BBSPostDao] #update# " + postIdList);
        try {
            String sql = "";
            if (StringUtils.equals(type, "showTop")) {
                sql = "update tbl_bbs_post set show_top = ?, update_time = now() where id = ?";
            }
            if (StringUtils.equals(type, "showGreat")) {
                sql = "update tbl_bbs_post set show_great = ?, update_time = now() where id = ?";
            }
            if (StringUtils.equals(type, "showPopular")) {
                sql = "update tbl_bbs_post set show_popular = ?, update_time = now() where id = ?";
            }
            if (StringUtils.isNotBlank(sql) && !CollectionUtils.isEmpty(postIdList))
                jdbcTemplate.batchUpdate(
                        sql,
                        new BatchPreparedStatementSetter() {
                            @Override
                            public void setValues(PreparedStatement pstmt, int i) throws SQLException {
                                String postId = postIdList.get(i);
                                int j = 0;
                                pstmt.setInt(++j, itemValue);
                                pstmt.setString(++j, postId);
                            }

                            @Override
                            public int getBatchSize() {
                                return postIdList.size();
                            }
                        }
                );
            return true;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #update# error", e);
            return false;
        }
    }

    /**
     * 删除内容，同时会删除所有的回帖内容
     *
     * @param postId
     * @return
     */
    public boolean deleteById(final String postId) {
        logger.info("[BBSPostDao] #delete#" + postId);
        try {
            String sql[] = new String[2];
            sql[0] = "delete from tbl_bbs_post where id = '" + postId + "'";
            sql[1] = "delete from tbl_bbs_reply where post_id = '" + postId + "'";;

            int count[] = jdbcTemplate.batchUpdate(sql);
            return count.length > 0;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #delete# error " + postId, e);
        }
        return false;
    }

    /**
     * @param postId
     * @return
     */
    public BBSPost getPostById(final String postId) {
        logger.info("[BBSPostDao] #getPostById#" + postId);
        try {
            List<BBSPost> list = jdbcTemplate.query("select * from tbl_bbs_post where id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, postId);
                        }
                    },
                    new BBSPostRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[BBSPostDao] #getPostById# error " + postId, e);
        }
        return null;
    }

    public List<BBSPost> getByQuery(final BBSPostQuery query) {
        logger.info("[BBSPostDao] #getByQuery# query=" + query);
        List<BBSPost> list = new ArrayList<BBSPost>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_bbs_post where 1=1 ");

            if (StringUtils.isNotBlank(query.getCategoryId()))
                sql.append(" and category_id_fk = ? ");

            if (StringUtils.isNotBlank(query.getUserId()))
                sql.append(" and user_id_fk = ? ");

            if (query.getShowTop() > -1)
                sql.append(" and show_top = ? ");

            if (query.getShowGreat() > -1)
                sql.append(" and show_great = ? ");

            if (query.getShowPopular() > -1)
                sql.append(" and show_popular = ? ");

            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                    sql.append(" and publish_time >= ? ");
            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                    sql.append(" and publish_time <= ? ");
            if (StringUtils.isNotBlank(query.getUpdateStartTime()))
                    sql.append(" and update_time >= ? ");
            if (StringUtils.isNotBlank(query.getUpdateEndTime()))
                    sql.append(" and update_time <= ? ");

            if (StringUtils.isNotBlank(query.getKw()))
                sql.append(" and (title like ? or content like ? ) ");


            sql.append(" order by update_time desc ");

            sql.append(" limit ?,? ");


            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;

                            if (StringUtils.isNotBlank(query.getCategoryId()))
                                preparedstatement.setString(++i, query.getCategoryId());

                            if (StringUtils.isNotBlank(query.getUserId()))
                                preparedstatement.setString(++i, query.getUserId());

                            if (query.getShowTop() > -1)
                                preparedstatement.setInt(++i, query.getShowTop());

                            if (query.getShowGreat() > -1)
                                preparedstatement.setInt(++i, query.getShowGreat());

                            if (query.getShowPopular() > -1)
                                preparedstatement.setInt(++i, query.getShowPopular());

                            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                                preparedstatement.setString(++i, query.getPublishStartTime());
                            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                                preparedstatement.setString(++i, query.getPublishEndTime());
                            if (StringUtils.isNotBlank(query.getUpdateStartTime()))
                                preparedstatement.setString(++i, query.getUpdateStartTime());
                            if (StringUtils.isNotBlank(query.getUpdateEndTime()))
                                preparedstatement.setString(++i, query.getUpdateEndTime());


                            if (StringUtils.isNotBlank(query.getKw())) {
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }


                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                            System.out.println(preparedstatement.toString());
                        }
                    },
                    new BBSPostRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final BBSPostQuery query) {
        logger.info("[BBSPostDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_bbs_post where 1=1 ");

            if (StringUtils.isNotBlank(query.getCategoryId())) {
                sql.append(" and category_id_fk = ? ");
                params.add(query.getCategoryId());
            }

            if (StringUtils.isNotBlank(query.getUserId())) {
                sql.append(" and user_id_fk = ? ");
                params.add(query.getUserId());
            }

            if (query.getShowTop() > -1) {
                sql.append(" and show_top = ? ");
                params.add(query.getShowTop());
            }
            if (query.getShowGreat() > -1) {
                sql.append(" and show_great = ? ");
                params.add(query.getShowGreat());
            }
            if (query.getShowPopular() > -1) {
                sql.append(" and show_popular = ? ");
                params.add(query.getShowPopular());
            }
            if (StringUtils.isNotBlank(query.getPublishStartTime())) {
                sql.append(" and publish_time >= ? ");
                params.add(query.getPublishStartTime());
            }
            if (StringUtils.isNotBlank(query.getPublishEndTime())) {
                sql.append(" and publish_time <= ? ");
                params.add(query.getPublishEndTime());
            }
            if (StringUtils.isNotBlank(query.getUpdateStartTime())) {
                sql.append(" and update_time >= ? ");
                params.add(query.getUpdateStartTime());
            }
            if (StringUtils.isNotBlank(query.getUpdateEndTime())) {
                sql.append(" and update_time <= ? ");
                params.add(query.getUpdateEndTime());
            }

            if (StringUtils.isNotBlank(query.getKw())) {
                sql.append(" and (title like ? or content like ? ) ");
                params.add(query.getKw());
                params.add(query.getKw());
            }

            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[BBSPostDao] #getCountByQuery# error! query=" + query, e);
        }
        return count;
    }

    public List<BBSPostDTO> getPostDTOListByQuery(final BBSPostQuery query) {
        logger.info("[BBSPostDao] #getPostDTOByQuery# query=" + query);
        List<BBSPostDTO> list = new ArrayList<BBSPostDTO>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_bbs_post where 1=1 ");

            if (StringUtils.isNotBlank(query.getCategoryId()))
                sql.append(" and category_id_fk = ? ");

            if (StringUtils.isNotBlank(query.getUserId()))
                sql.append(" and user_id_fk = ? ");

            if (query.getShowTop() > -1)
                sql.append(" and show_top = ? ");

            if (query.getShowGreat() > -1)
                sql.append(" and show_great = ? ");

            if (query.getShowPopular() > -1)
                sql.append(" and show_popular = ? ");

            if (StringUtils.isNotBlank(query.getKw()))
                sql.append(" and (title like ? or content like ? ) ");


            sql.append(" order by update_time desc ");

            sql.append(" limit ?,? ");


            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;

                            if (StringUtils.isNotBlank(query.getCategoryId()))
                                preparedstatement.setString(++i, query.getCategoryId());

                            if (StringUtils.isNotBlank(query.getUserId()))
                                preparedstatement.setString(++i, query.getUserId());

                            if (query.getShowTop() > -1)
                                preparedstatement.setInt(++i, query.getShowTop());

                            if (query.getShowGreat() > -1)
                                preparedstatement.setInt(++i, query.getShowGreat());

                            if (query.getShowPopular() > -1)
                                preparedstatement.setInt(++i, query.getShowPopular());

                            if (StringUtils.isNotBlank(query.getKw())) {
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }


                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                            System.out.println(preparedstatement.toString());
                        }
                    },
                    new BBSPostDTORowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public BBSAnalyzer getAnalyzer(final String categoryId) {
        logger.info("[BBSPostDao] #getAnalyzer#" + categoryId);
        BBSAnalyzer analyzer = new BBSAnalyzer();
        analyzer.setCategoryId(categoryId);
        try {
            //发帖量
            String postSql = "select count(1) from tbl_bbs_post where category_id_fk = ?";
            int postCount = jdbcTemplate.queryForInt(postSql, new String[]{categoryId});
            analyzer.setPostCount(postCount);

            //发帖量+回帖量
            String replySql = "select count(1) from tbl_bbs_reply where category_id_fk = ? ";
            int replyCount = jdbcTemplate.queryForInt(replySql, new String[]{categoryId});
            analyzer.setPostReplyCount(postCount + replyCount);

            //发帖量+回帖量 (当天总量)
            String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
            String postTodaySql = "select count(1) from tbl_bbs_post where category_id_fk = ? and publish_time >= ? and  publish_time <= ? ";
            int postTodayCount = jdbcTemplate.queryForInt(postTodaySql, new String[]{categoryId, today + " 00:00:00", today + "23:59:59"});

            String replyTodaySql = "select count(1) from tbl_bbs_reply where post_id_fk = ? and publish_time >= ? and  publish_time <= ?";
            int replyTodayCount = jdbcTemplate.queryForInt(replyTodaySql, new String[]{categoryId, today + " 00:00:00", today + "23:59:59"});
            analyzer.setPostReplyCount(postTodayCount + replyTodayCount);

        } catch (Exception e) {
            logger.error("[BBSPostDao] #getAnalyzer# error " + categoryId, e);
        }
        return analyzer;
    }

    public UserInfo getBBSManager(final String categoryId) {
        logger.info("[BBSPostDao] #getBBSManager#" + categoryId);
        try {
            List<UserInfo> list = jdbcTemplate.query("select user_id_fk from tbl_bbs_manager where category_id_fk = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, categoryId);
                        }
                    },
                    new RowMapper<UserInfo>() {
                        @Override
                        public UserInfo mapRow(ResultSet resultSet, int i) throws SQLException {
                            UserInfo userInfo = new UserInfo();
                            userInfo.setUserId(resultSet.getString("user_id_fk"));
                            userInfo = userInfoDao.getUserSimpleById(userInfo.getUserId());
                            return userInfo;
                        }
                    });
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[BBSPostDao] #getBBSManager# error " + categoryId, e);
        }
        return null;
    }

    public boolean setBBSManager(final String categoryId, final String userId) {
        logger.info("[BBSPostDao] #setBBSManager# categoryId=" + categoryId + " userId=" + userId);
        try {
            int i = jdbcTemplate.update(
                        "update tbl_bbs_manager set user_id_fk = ? where category_id_fk = ? ",
                        new PreparedStatementSetter() {
                            @Override
                            public void setValues(PreparedStatement preparedStatement) throws SQLException {
                                preparedStatement.setString(1,userId);
                                preparedStatement.setString(2,categoryId);
                            }
                });
            return i > 0;
        } catch (Exception e) {
            logger.error("[BBSPostDao] #setBBSManager# error categoryId=" + categoryId + " userId=" + userId, e);
        }
        return false;
    }

    /**
     * @return
     */
    class BBSPostRowMapper implements RowMapper<BBSPost> {
        @Override
        public BBSPost mapRow(ResultSet rs, int i) throws SQLException {
            BBSPost info = new BBSPost();
            info.setId(rs.getString("id"));

            info.setCategoryId(rs.getString("category_id_fk"));
            Category category = categoryDao.getById(info.getCategoryId());
            info.setCategory(category);

            info.setTitle(rs.getString("title"));

            info.setUserId(rs.getString("user_id_fk"));
            UserInfo userInfo = userInfoDao.getUserSimpleById(info.getUserId());
            info.setUserInfo(userInfo);

            info.setPublishTime(rs.getTimestamp("publish_time"));
            info.setUpdateTime(rs.getTimestamp("update_time"));
            info.setContent(rs.getString("content"));
            info.setViewCount(rs.getInt("view_count"));
            info.setReplyCount(rs.getInt("reply_count"));
            info.setShowTop(rs.getInt("show_top"));
            info.setShowGreat(rs.getInt("show_great"));
            info.setShowPopular(rs.getInt("show_popular"));

            return info;
        }
    }

    class BBSPostDTORowMapper implements RowMapper<BBSPostDTO> {
        @Override
        public BBSPostDTO mapRow(ResultSet rs, int i) throws SQLException {
            BBSPostDTO info = new BBSPostDTO();

            info.setPostId(rs.getString("id"));
            info.setTitle(rs.getString("title"));
            info.setUserId(rs.getString("user_id_fk"));
            UserInfo userInfo = userInfoDao.getUserSimpleById(info.getUserId());
            info.setUserInfo(userInfo);
            info.setShowTop(rs.getInt("show_top"));
            info.setShowGreat(rs.getInt("show_great"));
            info.setShowPopular(rs.getInt("show_popular"));
            info.setPostUpdateTime(rs.getTimestamp("update_time"));
            info.setViewCount(rs.getInt("view_count"));
            info.setReplyCount(rs.getInt("reply_count"));

            //最后一条回复记录
            BBSReplyQuery query = new BBSReplyQuery();
            query.setPostId(info.getPostId());
            query.setStart(0);
            query.setNum(1);
            List<BBSReply> bbsReplyList = bbsReplyDao.getByQuery(query);
            if (!CollectionUtils.isEmpty(bbsReplyList)) {
                BBSReply reply = bbsReplyList.get(0);
                info.setLastReplyUserId(reply.getUserId());
                info.setLastReplyUserInfo(reply.getUserInfo());
                info.setLastReplyUpdateTime(reply.getUpdateTime());
            }
            return info;
        }
    }
}
