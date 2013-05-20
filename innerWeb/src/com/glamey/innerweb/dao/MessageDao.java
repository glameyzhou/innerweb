/**
 *
 */
package com.glamey.innerweb.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.innerweb.model.domain.Message;
import com.glamey.innerweb.model.dto.MessageQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

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

    /**
     * @param msg
     * @return
     */
    public boolean create(final Message msg) {
        logger.info("[MessageDao] #create# " + msg);
        try {
            int count[] = jdbcTemplate.batchUpdate(
                    "insert into tbl_message(id,msg_from,msg_to,msg_title,msg_content,msg_time,msg_flag) values(?,?,?,?,?,?,?)",
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
                            return 0;
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
                            if (StringUtils.isNotBlank(query.getKeyword()))
                                preparedstatement.setString(++i, "%" + query.getKeyword() + "%");
                            preparedstatement.setString(++i, "%" + query.getKeyword() + "%");

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
                params.add(query.getKeyword());
                params.add(query.getKeyword());
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
    public boolean messageOperation(final String opFlag,final String messageId){
        try {
            String sql = "" ;
            int count = 0 ;
            if(StringUtils.equals(opFlag,"1")){
                sql = "delete from tbl_message where msg_id = " + messageId ;
            }
            //设置已读
            else if (StringUtils.equals(opFlag,"2")){
                sql = "update tbl_message set msg_flag = 1 where msg_id = " + messageId ;
            }
            else if (StringUtils.equals(opFlag,"3")){
                sql = "update tbl_message set msg_flag = 0 where msg_id = " + messageId ;
            }
            else    {
                //....
            }
            if(StringUtils.isNotBlank(sql)){
                count = jdbcTemplate.update(sql);
            }
            return count > 0  ;
        } catch (DataAccessException e) {
            logger.error("[MessageDao] #messageOperation# error!" + String.format("opFlag=$s,messagId=%s",opFlag,messageId));
            return false ;
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
            msg.setTime(rs.getTimestamp("msg_content"));
            msg.setFlag(rs.getInt("msg_flag"));
            return msg;
        }
    }
}
