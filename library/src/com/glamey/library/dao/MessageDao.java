/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.Message;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.MessageQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
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
 * 站内信
 *
 * @author zy
 */
@Repository
public class MessageDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(MessageDao.class);

    @Resource
    private UserInfoDao userInfoDao ;
    /**
     * @param msg
     * @return
     */
    public boolean create(final Message msg) {
        logger.info("[MessageDao] #create# " + msg);
        try {
            int count[] = jdbcTemplate.batchUpdate(
                    "insert into tbl_message(msg_id,msg_from,msg_to,msg_title,msg_content,msg_time,msg_flag) values(?,?,?,?,?,?,?)",
                    new BatchPreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt, int j) throws SQLException {
                            int i = 0;
                            String to = msg.getTos()[j];
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, msg.getFrom());
                            pstmt.setString(++i, to);
                            pstmt.setString(++i, msg.getTitle());
                            pstmt.setString(++i, msg.getContent());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setInt(++i, msg.getFlag());
                        }

                        @Override
                        public int getBatchSize() {
                            return msg.getTos().length;
                        }
                    });

            return count.length > 0;
        } catch (Exception e) {
            logger.error("[MessageDao] #create# error " + msg, e);
            return false;
        }
    }

    public List<Message> getMessageList(final MessageQuery query) {
        logger.info("[MessageDao] #getMessageList# query=" + query);
        List<Message> list = new ArrayList<Message>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_message where 1=1 ");

            //关键字
            if (StringUtils.isNotBlank(query.getKeyword()))
                sql.append(" and (msg_title like ? or msg_content like ?) ");

            //是否已读
            if (query.getFlag() > -1)
                sql.append(" and msg_flag = ? ");

            //发件人
            if (StringUtils.isNotBlank(query.getFrom()))
                sql.append(" and msg_from = ? ");

            //收件人
            if (StringUtils.isNotBlank(query.getTo()))
                sql.append(" and msg_to = ? ");

            sql.append(" order by msg_time desc limit ?,? ");

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
                            }

                            //是否已读
                            if (query.getFlag() > -1)
                                preparedstatement.setInt(++i, query.getFlag());

                            //发件人
                            if (StringUtils.isNotBlank(query.getFrom()))
                                preparedstatement.setString(++i, query.getFrom());

                            //收件人
                            if (StringUtils.isNotBlank(query.getTo()))
                                preparedstatement.setString(++i, query.getTo());

                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new MessageRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[MessageDao] #getMessageList# error! query=" + query, e);
        }
        return null;
    }

    public int getCountMessageList(final MessageQuery query) {
        logger.info("[MessageDao] #getCountMessageList# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_message where 1=1 ");
            //关键字
            if (StringUtils.isNotBlank(query.getKeyword())) {
                sql.append(" and (msg_title like ? or msg_content like ?) ");
                params.add("%" + query.getKeyword() + "%");
                params.add("%" + query.getKeyword() + "%");
            }
            //是否已读
            if (query.getFlag() > -1) {
                sql.append(" and msg_flag = ? ");
                params.add(query.getFlag());
            }
            //发件人
            if (StringUtils.isNotBlank(query.getFrom())) {
                sql.append(" and msg_from = ? ");
                params.add(query.getFrom());
            }

            //收件人
            if (StringUtils.isNotBlank(query.getTo())) {
                sql.append(" and msg_to = ? ");
                params.add(query.getTo());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[MessageDao] #getCountMessageList# error! query=" + query, e);
        }
        return count;
    }

    /**
     * 通过ID获取具体的详情
     *
     * @param messageId
     * @return
     */
    public Message getMessageById(final String messageId) {
        logger.info(String.format("[MessageDao] #getMessageById# messageId=%s", messageId));
        try {
            String sql = "select * from tbl_message where msg_id = ?";
            List<Message> messageList = jdbcTemplate.query(sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, messageId);
                        }
                    },
                    new MessageRowMapper());
            return messageList != null && messageList.size() > 0 ? messageList.get(0) : null;
        } catch (DataAccessException e) {
            logger.error(String.format("[MessageDao] #getMessageById# error, messageId=%s", messageId));
        }
        return null;
    }

    public boolean del(final String messageId) {
        try {
            int count = jdbcTemplate.update("delete from tbl_message where msg_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, messageId);
                        }
                    }
            );
            return count > 0;
        } catch (DataAccessException e) {
            logger.error("[MessageDao] #del# error! messageId=" + messageId);
            return false;
        }
    }

    public boolean setRead(final String messageId) {
        try {
            int count = jdbcTemplate.update("update tbl_message set msg_flag = 3 where msg_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, messageId);
                        }
                    }
            );
            return count > 0;
        } catch (DataAccessException e) {
            logger.error("[MessageDao] #setRead# error! messageId=" + messageId);
            return false;
        }
    }

    public boolean setNotRead(final String messageId) {
        try {
            int count = jdbcTemplate.update("update tbl_message set msg_flag = 2 where msg_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, messageId);
                        }
                    }
            );
            return count > 0;
        } catch (DataAccessException e) {
            logger.error("[MessageDao] #setNotRead# error! messageId=" + messageId);
            return false;
        }
    }

    class MessageRowMapper implements RowMapper {
        @Override
        public Message mapRow(ResultSet rs, int i) throws SQLException {
            Message msg = new Message();
            msg.setId(rs.getString("msg_id"));
            msg.setFrom(rs.getString("msg_from"));
            msg.setTo(rs.getString("msg_to"));
            msg.setTitle(rs.getString("msg_title"));
            msg.setContent(rs.getString("msg_content"));
            msg.setTime(rs.getTimestamp("msg_time"));
            msg.setFlag(rs.getInt("msg_flag"));

            UserInfo userInfo = userInfoDao.getUserById(msg.getFrom());
            msg.setFromUserInfo(userInfo);
            return msg;
        }
    }
}
