/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.BBSReply;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.BBSReplyQuery;
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
                    "insert into tbl_bbs_post(id,category_id_fk,post_id_fk,user_id_fk,publish_time,update_time,content) " +
                            " values(?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, info.getCategoryId());
                            pstmt.setString(++i, info.getPostId());
                            pstmt.setString(++i, info.getUserId());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, info.getContent());

                        }
                    });
            if (count > 0) {
                bbsPostDao.updateReplyCount(info.getPostId(), true);
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
                    "update tbl_bbs_post set post_id_fk = ? ,user_id_fk = ? ,publish_time = ? ,update_time = ? ,content = ?  where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, info.getPostId());
                            pstmt.setString(++i, info.getUserId());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, info.getContent());
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
    public boolean deleteById(final String replyId) {
        logger.info("[BBSReplyDao] #delete#" + replyId);
        try {
            String sql[] = new String[1];
            sql[1] = "delete from tbl_bbs_reply where id = " + replyId;

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
                sql.append(" and (title like ? or content like ? ) ");


            sql.append(" order by update_time desc ");

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
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }


                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                            System.out.println(preparedstatement.toString());
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
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_bbs_post where 1=1 ");

            if (StringUtils.isNotBlank(query.getPostId())) {
                sql.append(" and post_id_fk = ? ");
                params.add(query.getPostId());
            }

            if (StringUtils.isNotBlank(query.getUserId())) {
                sql.append(" and user_id_fk = ? ");
                params.add(query.getUserId());
            }

            if (StringUtils.isNotBlank(query.getKw())) {
                sql.append(" and (title like ? or content like ? ) ");
                params.add(query.getKw());
                params.add(query.getKw());
            }

            sql.append(" order by update_time desc ");

            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[BBSReplyDao] #getCountByQuery# error! query=" + query, e);
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

            info.setPostId(rs.getString("post_id_fk"));
            return info;
        }
    }
}