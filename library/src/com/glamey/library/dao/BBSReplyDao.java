/**
 *
 */
package com.glamey.library.dao;

import com.glamey.library.model.domain.BBSPost;
import com.glamey.library.model.domain.BBSPostReplyRef;
import com.glamey.library.model.domain.BBSReply;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.BBSReplyQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * 论坛主帖--回复
 *
 * @author zy
 */
@Repository
public class BBSReplyDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(BBSReplyDao.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private UserInfoDao userInfoDao;
    @Resource
    private BBSPostDao bbsPostDao;

    /**
     * @param info
     * @return
     */
    public boolean create(final BBSReply info) {
        logger.info("[BBSReplyDao] #create# " + info);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_bbs_reply(id,category_id_fk,post_id_fk,user_id_fk,publish_time,update_time,content) " +
                            " values(?,?,?,?,now(),now(),?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, info.getId());
                            pstmt.setString(++i, info.getCategoryId());
                            pstmt.setString(++i, info.getPostId());
                            pstmt.setString(++i, info.getUserId());
                            pstmt.setString(++i, info.getContent());

                        }
                    });
            if (count > 0) {
                bbsPostDao.updateReplyCount(info.getPostId(), true);
                final BBSPostReplyRef postReplyRef = info.getPostReplyRef();
                if (postReplyRef != null) {
                    jdbcTemplate.update(
                            "insert into tbl_bbs_post_reply_ref(post_id_fk,reply_id_fk,reply_floor,reply_user_id_fk,cur_reply_id_fk,cur_reply_user_id_fk,reply_time) " +
                                    "values(?,?,?,?,?,?,now())",
                            new PreparedStatementSetter() {
                                @Override
                                public void setValues(PreparedStatement preparedStatement) throws SQLException {
                                    int i = 0 ;
                                    preparedStatement.setString(++i,postReplyRef.getPostId());
                                    preparedStatement.setString(++i,postReplyRef.getReplyId());
                                    preparedStatement.setInt(++i,postReplyRef.getReplyFloor());
                                    preparedStatement.setString(++i,postReplyRef.getReplyUserId());

                                    preparedStatement.setString(++i,postReplyRef.getCurReplyId());
                                    preparedStatement.setString(++i,postReplyRef.getCurReplyUserId());

                                }
                            }
                    );
                }
            }
            return true;
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #create# error " + info, e);
            return false;
        }
    }

    /**
     * @param info
     * @return
     */
    public boolean update(final BBSReply info) {
        logger.info("[BBSReplyDao] #update# " + info);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_bbs_reply set post_id_fk = ? ,user_id_fk = ? ,publish_time = ? ,update_time = ? ,content = ?,lasted_update_userid=? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, info.getPostId());
                            pstmt.setString(++i, info.getUserId());
                            pstmt.setTimestamp(++i, new Timestamp(info.getPublishTime().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(info.getUpdateTime().getTime()));
                            pstmt.setString(++i, info.getContent());
                            pstmt.setString(++i, info.getLastedUpdateUserId());
                            pstmt.setString(++i, info.getId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #update# error " + info, e);
            return false;
        }
    }

    /**
     * 删除回帖
     *
     * @param replyId
     * @return
     */
    public boolean deleteById(final String replyId,final String postId) {
        logger.info("[BBSReplyDao] #delete#" + replyId);
        try {
            String sql[] = new String[2];
//            sql[0] = "delete from tbl_bbs_reply where id = '" + replyId + "'";
            sql[0] = "update tbl_bbs_reply set is_delete = 1 where id = '" + replyId + "'";
            sql[1] = "update tbl_bbs_post set reply_count = reply_count -1 where id = '" + postId + "'";

            int count[] = jdbcTemplate.batchUpdate(sql);
            return count.length > 0;
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #delete# error " + replyId, e);
        }
        return false;
    }

    /**
     * @param replyId
     * @return
     */
    public BBSReply getReplyById(final String replyId) {
        logger.info("[BBSReplyDao] #getReplyById#" + replyId);
        try {
            List<BBSReply> list = jdbcTemplate.query("select * from tbl_bbs_reply where id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, replyId);
                        }
                    },
                    new BBSReplyRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #getReplyById# error " + replyId, e);
        }
        return null;
    }

    public List<BBSReply> getByQuery(final BBSReplyQuery query) {
        logger.info("[BBSReplyDao] #getByQuery# query=" + query);
        List<BBSReply> list = new ArrayList<BBSReply>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_bbs_reply where 1=1 ");

            if (StringUtils.isNotBlank(query.getPostId()))
                sql.append(" and post_id_fk = ? ");

            if (StringUtils.isNotBlank(query.getUserId()))
                sql.append(" and user_id_fk = ? ");

            if (StringUtils.isNotBlank(query.getKw()))
                sql.append(" and  content like ? ");

            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                sql.append(" and  publish_time >= ? ");
            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                sql.append(" and  publish_time <= ? ");
            if (StringUtils.isNotBlank(query.getUpdateStartTime()))
                sql.append(" and  update_time >= ? ");
            if (StringUtils.isNotBlank(query.getUpdateEndTime()))
                sql.append(" and  update_time <= ? ");


            if (query.getIsDelete() > -1)
                sql.append(" and is_delete = ? ");

            if (StringUtils.isNotBlank(query.getOrderColumn()) && StringUtils.isNotBlank(query.getOrderType())) {
                sql.append(" order by ").append(query.getOrderColumn()).append(" ").append(query.getOrderType());
            }else {
                sql.append(" order by publish_time asc ");
            }

            sql.append(" limit ?,? ");


            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;

                            if (StringUtils.isNotBlank(query.getPostId()))
                                preparedstatement.setString(++i, query.getPostId());

                            if (StringUtils.isNotBlank(query.getUserId()))
                                preparedstatement.setString(++i, query.getUserId());

                            if (StringUtils.isNotBlank(query.getKw())) {
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }
                            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                                preparedstatement.setString(++i, query.getPublishStartTime());
                            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                                preparedstatement.setString(++i, query.getPublishEndTime());
                            if (StringUtils.isNotBlank(query.getUpdateStartTime()))
                                preparedstatement.setString(++i, query.getUpdateStartTime());
                            if (StringUtils.isNotBlank(query.getUpdateEndTime()))
                                preparedstatement.setString(++i, query.getUpdateEndTime());
                            if (query.getIsDelete() > -1)
                                preparedstatement.setInt(++i, query.getIsDelete());
                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                        }
                    },
                    new BBSReplyRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final BBSReplyQuery query) {
        logger.info("[BBSReplyDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_bbs_reply where 1=1 ");

            if (StringUtils.isNotBlank(query.getPostId())) {
                sql.append(" and post_id_fk = ? ");
                params.add(query.getPostId());
            }

            if (StringUtils.isNotBlank(query.getUserId())) {
                sql.append(" and user_id_fk = ? ");
                params.add(query.getUserId());
            }

            if (StringUtils.isNotBlank(query.getKw())) {
                sql.append(" and content like ? ");
                params.add(query.getKw());
            }

            if (StringUtils.isNotBlank(query.getPublishStartTime())) {
                sql.append(" and  publish_time >= ? ");
                params.add(query.getPublishStartTime());
            }
            if (StringUtils.isNotBlank(query.getPublishEndTime())) {
                sql.append(" and  publish_time <= ? ");
                params.add(query.getPublishEndTime());
            }
            if (StringUtils.isNotBlank(query.getUpdateStartTime())) {
                sql.append(" and  update_time >= ? ");
                params.add(query.getUpdateStartTime());
            }
            if (StringUtils.isNotBlank(query.getUpdateEndTime())) {
                sql.append(" and  update_time <= ? ");
                params.add(query.getUpdateEndTime());
            }
            if (query.getIsDelete() > -1) {
                sql.append(" and is_delete = ? ");
                params.add(query.getIsDelete());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #getCountByQuery# error! query=" + query, e);
        }
        return count;
    }


    public List<BBSReply> getPersonalByQuery(final BBSReplyQuery query) {
        logger.info("[BBSReplyDao] #getPersonalByQuery# query=" + query);
        List<BBSReply> list = new ArrayList<BBSReply>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_bbs_reply where 1=1 ");

            if (StringUtils.isNotBlank(query.getUserId()))
                sql.append(" and user_id_fk = ? ");

            if (StringUtils.isNotBlank(query.getKw()))
                sql.append(" and  content like ? ");

            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                sql.append(" and  publish_time >= ? ");
            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                sql.append(" and  publish_time <= ? ");
            if (StringUtils.isNotBlank(query.getUpdateStartTime()))
                sql.append(" and  update_time >= ? ");
            if (StringUtils.isNotBlank(query.getUpdateEndTime()))
                sql.append(" and  update_time <= ? ");


            if (query.getIsDelete() > -1)
                sql.append(" and is_delete = ? ");

            /*if (StringUtils.isNotBlank(query.getOrderColumn()) && StringUtils.isNotBlank(query.getOrderType())) {
                sql.append(" order by ").append(query.getOrderColumn()).append(" ").append(query.getOrderType());
            }else {
                sql.append(" order by publish_time asc ");
            }*/
            sql.append(" order by publish_time desc ");


            sql.append(" limit ?,? ");


            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;

                            if (StringUtils.isNotBlank(query.getUserId()))
                                preparedstatement.setString(++i, query.getUserId());

                            if (StringUtils.isNotBlank(query.getKw())) {
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }
                            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                                preparedstatement.setString(++i, query.getPublishStartTime());
                            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                                preparedstatement.setString(++i, query.getPublishEndTime());
                            if (StringUtils.isNotBlank(query.getUpdateStartTime()))
                                preparedstatement.setString(++i, query.getUpdateStartTime());
                            if (StringUtils.isNotBlank(query.getUpdateEndTime()))
                                preparedstatement.setString(++i, query.getUpdateEndTime());
                            if (query.getIsDelete() > -1)
                                preparedstatement.setInt(++i, query.getIsDelete());
                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                        }
                    },
                    new BBSReplySimpleRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getPersonalCountByQuery(final BBSReplyQuery query) {
        logger.info("[BBSReplyDao] #getCountPersonalByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_bbs_reply where 1=1 ");

            if (StringUtils.isNotBlank(query.getUserId())) {
                sql.append(" and user_id_fk = ? ");
                params.add(query.getUserId());
            }

            if (StringUtils.isNotBlank(query.getKw())) {
                sql.append(" and content like ? ");
                params.add(query.getKw());
            }

            if (StringUtils.isNotBlank(query.getPublishStartTime())) {
                sql.append(" and  publish_time >= ? ");
                params.add(query.getPublishStartTime());
            }
            if (StringUtils.isNotBlank(query.getPublishEndTime())) {
                sql.append(" and  publish_time <= ? ");
                params.add(query.getPublishEndTime());
            }
            if (StringUtils.isNotBlank(query.getUpdateStartTime())) {
                sql.append(" and  update_time >= ? ");
                params.add(query.getUpdateStartTime());
            }
            if (StringUtils.isNotBlank(query.getUpdateEndTime())) {
                sql.append(" and  update_time <= ? ");
                params.add(query.getUpdateEndTime());
            }
            if (query.getIsDelete() > -1) {
                sql.append(" and is_delete = ? ");
                params.add(query.getIsDelete());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #getCountPersonalByQuery# error! query=" + query, e);
        }
        return count;
    }

    /**
     * @return
     */
    class BBSReplyRowMapper implements RowMapper<BBSReply> {
        @Override
        public BBSReply mapRow(ResultSet rs, int i) throws SQLException {
            BBSReply info = new BBSReply();
            info.setId(rs.getString("id"));
            info.setCategoryId(rs.getString("category_id_fk"));

            info.setUserId(rs.getString("user_id_fk"));
            UserInfo userInfo = userInfoDao.getUserSimpleById(info.getUserId());
            info.setUserInfo(userInfo);

            info.setPublishTime(rs.getTimestamp("publish_time"));
            info.setUpdateTime(rs.getTimestamp("update_time"));
            info.setContent(rs.getString("content"));
            info.setIsDelete(rs.getInt("is_delete"));
            info.setPostId(rs.getString("post_id_fk"));

            info.setLastedUpdateUserId(rs.getString("lasted_update_userid"));
            if (StringUtils.isNotBlank(info.getLastedUpdateUserId())) {
                UserInfo lastedUpdateUserInfo = userInfoDao.getUserSimpleById(info.getLastedUpdateUserId());
                info.setLastedUpdateUserInfo(lastedUpdateUserInfo);
            }

            //此回复是否还有回复的内容
            info.setPostReplyRef(getPostRelyRef(info.getPostId(),info.getId()));
            return info;
        }
    }

    class BBSReplySimpleRowMapper implements RowMapper<BBSReply> {
        @Override
        public BBSReply mapRow(ResultSet rs, int i) throws SQLException {
            BBSReply info = new BBSReply();
            info.setId(rs.getString("id"));
            info.setCategoryId(rs.getString("category_id_fk"));

            info.setUserId(rs.getString("user_id_fk"));
            UserInfo userInfo = userInfoDao.getUserSimpleById(info.getUserId());
            info.setUserInfo(userInfo);

            info.setPublishTime(rs.getTimestamp("publish_time"));
            info.setUpdateTime(rs.getTimestamp("update_time"));
            info.setContent(rs.getString("content"));
            info.setIsDelete(rs.getInt("is_delete"));
            info.setPostId(rs.getString("post_id_fk"));
            info.setLastedUpdateUserId(rs.getString("lasted_update_userid"));

            BBSPost post = bbsPostDao.getPostSimpleById(info.getPostId());
            if (post != null && StringUtils.isNotBlank(post.getTitle())) {
                info.setPostTitle(post.getTitle());
                info.setPostUserName(post.getUserInfo().getNickname());
                info.setPostType(post.getPostType());
            }
            return info;
        }
    }


    public BBSPostReplyRef getPostRelyRef(final String postId, final String replyId) {
        List<BBSPostReplyRef> list = new ArrayList<BBSPostReplyRef>();
        try {
            String sql = "select * from tbl_bbs_post_reply_ref where post_id_fk = ? and cur_reply_id_fk = ? limit 1";
            list = this.jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0 ;
                            preparedStatement.setString(++i, postId);
                            preparedStatement.setString(++i, replyId);
                        }
                    },
                    new RowMapper<BBSPostReplyRef>() {
                        @Override
                        public BBSPostReplyRef mapRow(ResultSet resultSet, int i) throws SQLException {
                            BBSPostReplyRef ref = new BBSPostReplyRef();
                            ref.setPostId(resultSet.getString("post_id_fk"));
                            ref.setReplyId(resultSet.getString("reply_id_fk"));
                            ref.setReplyFloor(resultSet.getInt("reply_floor"));
                            ref.setReplyUserId(resultSet.getString("reply_user_id_fk"));
                            ref.setCurReplyId(resultSet.getString("cur_reply_id_fk"));
                            ref.setCurReplyUserId(resultSet.getString("cur_reply_user_id_fk"));

                            if (StringUtils.isNotBlank(ref.getReplyUserId())) {
                                ref.setReplyUserInfo(userInfoDao.getUserSimpleById(ref.getReplyUserId()));
                            }
                            ref.setReplyTime(resultSet.getTimestamp("reply_time"));
                            return ref;
                        }
                    }
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return CollectionUtils.isEmpty(list) ? null : list.get(0);
    }
}
