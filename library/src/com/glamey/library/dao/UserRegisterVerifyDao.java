/**
 *
 */
package com.glamey.library.dao;

import com.glamey.library.model.domain.UserRegisterVerify;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 全局变量数据库操作操作
 *
 * @author zy
 */
@Repository
public class UserRegisterVerifyDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(UserRegisterVerifyDao.class);

    /**
     * @param verify
     * @return 0=成功  1=失败 2=已存在
     */
    public int create(final UserRegisterVerify verify) {
        logger.info("[UserRegisterVerifyDao] #create# " + verify);
        try {
            AtomicInteger count = new AtomicInteger(jdbcTemplate.update(
                    "insert into tbl_registerverify(username_fk,verifycode,expiredate,registerdate,status) values(?,?,?,?,?) ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, verify.getUsername());
                            pstmt.setString(++i, verify.getVerifycode());
                            pstmt.setTimestamp(++i, new Timestamp(verify.getExpireDate().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(verify.getRegisterDate().getTime()));
                            pstmt.setInt(++i, verify.getStatus());
                        }
                    }));
            return 0;
        } catch (Exception e) {
            logger.error("[UserRegisterVerifyDao] #create# error " + verify, e);
            return 1;
        }
    }

    public boolean update(final UserRegisterVerify verify) {
        logger.info("[UserRegisterVerifyDao] #update# " + verify);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_registerverify set verifycode = ? ,expiredate = ? ,registerdate = ? ,status = ? where username_fk = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, verify.getVerifycode());
                            pstmt.setTimestamp(++i, new Timestamp(verify.getExpireDate().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(verify.getRegisterDate().getTime()));
                            pstmt.setInt(++i, verify.getStatus());
                            pstmt.setString(++i, verify.getUsername());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[UserRegisterVerifyDao] #update# error! " + verify, e);
            return false;
        }
    }

    public UserRegisterVerify getVerifycode(final String verifycode) {
        List<UserRegisterVerify> registerVerifies = new ArrayList<UserRegisterVerify>();
        UserRegisterVerify verify = null;
        try {
            registerVerifies = jdbcTemplate.query(
                    "select * from tbl_registerverify where verifycode = ? and status = 1",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, verifycode);
                        }
                    }, new UserRegisterVerifyMapper());
            verify = registerVerifies != null && registerVerifies.size() > 0 ? registerVerifies.get(0) : null;
        } catch (DataAccessException e) {
            logger.error("#getVerifycode# error " + verifycode, e);
        }
        return verify;
    }

    public UserRegisterVerify getByUsername(final String username) {
        List<UserRegisterVerify> registerVerifies = new ArrayList<UserRegisterVerify>();
        UserRegisterVerify verify = null;
        try {
            registerVerifies = jdbcTemplate.query(
                    "select * from tbl_registerverify where username_fk = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, username);
                        }
                    }, new UserRegisterVerifyMapper());
            verify = registerVerifies != null && registerVerifies.size() > 0 ? registerVerifies.get(0) : null;
        } catch (DataAccessException e) {
            logger.error("#getVerifycode# error " + username, e);
        }
        return verify;
    }

    /**
     * @return
     */
    class UserRegisterVerifyMapper implements RowMapper<UserRegisterVerify> {
        @Override
        public UserRegisterVerify mapRow(ResultSet rs, int i) throws SQLException {
            UserRegisterVerify verify = new UserRegisterVerify();
            verify.setUsername(rs.getString("username_fk"));
            verify.setVerifycode(rs.getString("verifycode"));
            verify.setExpireDate(rs.getTimestamp("expiredate"));
            verify.setRegisterDate(rs.getTimestamp("registerdate"));
            verify.setStatus(rs.getInt("status"));
            return verify;
        }
    }
}
