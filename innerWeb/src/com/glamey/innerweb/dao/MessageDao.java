/**
 *
 */
package com.glamey.innerweb.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Repository;

import com.glamey.framework.utils.StringTools;
import com.glamey.innerweb.model.domain.Message;

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
            int count = jdbcTemplate.update(
                    "insert into tbl_message(id,msg_from,msg_to,msg_content,msg_time,msg_flag) " +
                            " values(?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, msg.getFrom());
                            pstmt.setString(++i, msg.getTo());
                            pstmt.setString(++i, msg.getContent());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setInt(++i, msg.getFlag());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[MessageDao] #create# error " + msg, e);
            return false;
        }
    }
}
