/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.FeedBackInfo;
import com.glamey.library.model.dto.FeedBackQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
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

@Repository
public class FeedBackInfoDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(FeedBackInfoDao.class);
    /**
     * @param fb
     * @return
     */
    public boolean create(final FeedBackInfo fb) {
        logger.info("[FeedBackInfoDao] #create# " + fb);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_feedback(fb_id,fb_username_fk,fb_email,fb_content,fb_time) values(?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            preparedStatement.setString(++i, StringTools.getUniqueId());
                            preparedStatement.setString(++i, fb.getFbUsername());
                            preparedStatement.setString(++i, fb.getFbEmail());
                            preparedStatement.setString(++i, fb.getFbContent());
                            preparedStatement.setTimestamp(++i, new Timestamp(new Date().getTime()));
                        }
                    });

            return count > 0;
        } catch (Exception e) {
            logger.error("[FeedBackInfoDao] #create# error " + fb, e);
            return false;
        }
    }

    public List<FeedBackInfo> getList(final FeedBackQuery query) {
        logger.info("[FeedBackInfoDao] #getList# query=" + query);
        List<FeedBackInfo> list = new ArrayList<FeedBackInfo>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_feedback where 1=1 ");

            //关键字
            if (StringUtils.isNotBlank(query.getKeyword()))
                sql.append(" and (fb_content like ? or fb_email like ? or fb_username_fk like ?) ");
            if (StringUtils.isNotBlank(query.getStartTime()))
                sql.append(" and fb_time >= ? ");
            if (StringUtils.isNotBlank(query.getEndTime()))
                sql.append(" and fb_time <= ? ");
            sql.append(" order by fb_time desc limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;
                            //关键字
                            if (StringUtils.isNotBlank(query.getKeyword())) {
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                            }
                            if (StringUtils.isNotBlank(query.getStartTime()))
                                preparedstatement.setString(++i, query.getStartTime());

                            if (StringUtils.isNotBlank(query.getEndTime()))
                                preparedstatement.setString(++i, query.getEndTime());

                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new FeedbackInfoMapper());
            return list;
        } catch (Exception e) {
            logger.error("[FeedBackInfoDao] #getList# error! query=" + query, e);
        }
        return null;
    }

    public int getCount(final FeedBackQuery query) {
        logger.info("[FeedBackInfoDao] #getCountMessageList# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_feedback where 1=1 ");
            if (StringUtils.isNotBlank(query.getKeyword())) {
                sql.append(" and (fb_content like ? or fb_email like ? or fb_username_fk like ?) ");
                params.add("%" + query.getKeyword() + "%");
                params.add("%" + query.getKeyword() + "%");
                params.add("%" + query.getKeyword() + "%");
            }
            if (StringUtils.isNotBlank(query.getStartTime())) {
                sql.append(" and fb_time >= ? ");
                params.add(query.getStartTime());
            }
            if (StringUtils.isNotBlank(query.getEndTime())) {
                sql.append(" and fb_time <= ? ");
                params.add(query.getEndTime());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[FeedBackInfoDao] #getCount# error! query=" + query, e);
        }
        return count;
    }

    /**
     * @param fbId
     * @return
     */
    public FeedBackInfo getById(final String fbId) {
        logger.info(String.format("[FeedBackInfoDao] #getById# fbId=%s", fbId));
        try {
            String sql = "select * from tbl_feedback where fb_id = ?";
            List<FeedBackInfo> messageList = jdbcTemplate.query(sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, fbId);
                        }
                    },
                    new FeedbackInfoMapper());
            return messageList != null && messageList.size() > 0 ? messageList.get(0) : null;
        } catch (DataAccessException e) {
            logger.error(String.format("[FeedBackInfoDao] #getById# error, fbid=%s", fbId));
        }
        return null;
    }

    public boolean del(final String fbId) {
        try {
            int count = jdbcTemplate.update("delete from tbl_feedback where fb_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, fbId);
                        }
                    }
            );
            return count > 0;
        } catch (DataAccessException e) {
            logger.error("[FeedBackInfoDao] #del# error! fbId=" + fbId);
            return false;
        }
    }

    class FeedbackInfoMapper implements RowMapper {
        @Override
        public FeedBackInfo mapRow(ResultSet rs, int i) throws SQLException {
            FeedBackInfo fb = new FeedBackInfo();
            fb.setFbId(rs.getString("fb_id"));
            fb.setFbUsername(rs.getString("fb_username_fk"));
            fb.setFbEmail(rs.getString("fb_email"));
            fb.setFbContent(rs.getString("fb_content"));
            fb.setFbTime(rs.getTimestamp("fb_time"));
            return fb;
        }
    }
}
