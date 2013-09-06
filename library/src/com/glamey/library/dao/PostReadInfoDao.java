package com.glamey.library.dao;

import com.glamey.library.model.domain.PostReadInfo;
import com.glamey.library.model.domain.UserInfo;
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
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class PostReadInfoDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(PostReadInfoDao.class);

    @Resource
    private UserInfoDao userInfoDao;

    /**
     * 已经阅读过的进行记录
     *
     * @param readInfo
     * @return
     */
    public boolean create(final PostReadInfo readInfo) {
        logger.info("[PostReadInfoDao] #create# " + readInfo);
        try {
            if(hasRead(readInfo.getPostId(),readInfo.getUserId())){
                return true ;
            }
            String sql = "insert into tbl_post_read(post_id,post_user_id,post_read_time) values(?,?,?)";
            int count = jdbcTemplate.update(sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            preparedStatement.setString(++i, readInfo.getPostId());
                            preparedStatement.setString(++i, readInfo.getUserId());
                            preparedStatement.setTimestamp(++i, new Timestamp(new Date().getTime()));
                        }
                    });
            return count > 0;
        } catch (DataAccessException e) {
            logger.error("[PostReadInfoDao] #create# error! " + readInfo,e);
            return false;
        }
    }


    public boolean hasRead(final String postId,final String userId){
        logger.info("[PostReadInfoDao] #hasRead# postId=" + postId + " userId=" + userId);
        try {
            String sql = "select count(1) from tbl_post_read where post_id=? and post_user_id = ?";
            int count = jdbcTemplate.queryForInt(sql,postId,userId);
            return count > 0;
        } catch (DataAccessException e) {
            logger.error("[PostReadInfoDao] #hasRead# error postId=" + postId + " userId=" + userId,e);
            return false;
        }
    }
    /**
     * 通过内容ID查询那些用户阅读过此文章
     *
     * @param postId
     * @return
     */
    public List<UserInfo> getUserListByPostId(final String postId) {
        logger.info("[PostReadInfoDao] #getUserListByPostId# " + postId);
        List<UserInfo> userInfoList = new ArrayList<UserInfo>();
        try {
            String sql = "select post_user_id from tbl_post_read where post_id = ? ";
            userInfoList = jdbcTemplate.query(sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, postId);
                        }
                    },
                    new RowMapper<UserInfo>() {
                        @Override
                        public UserInfo mapRow(ResultSet resultSet, int i) throws SQLException {
                            String userId = resultSet.getString("post_user_id");
                            UserInfo userInfo = userInfoDao.getUserById(userId);
                            return userInfo;
                        }
                    }
            );
            return userInfoList ;
        } catch (DataAccessException e) {
            logger.error("[PostReadInfoDao] #getUserListByPostId# error " + postId,e);
            return Collections.emptyList();
        }
    }
}
