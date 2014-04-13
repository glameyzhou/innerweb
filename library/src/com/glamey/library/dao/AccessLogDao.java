/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.constants.Constants;
import com.glamey.library.model.domain.AccessLog;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.AccessLogQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 系统日志访问
 *
 * @author zy
 */
@Repository
public class AccessLogDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(AccessLogDao.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private UserInfoDao userInfoDao;

    /**
     * @param info
     * @return
     */
    public boolean create(final AccessLog info) {
        logger.info("[AccessLogDao] #create# " + info);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_access_log(id,user_id_fk,access_time,page_url,page_title,page_category_id) " +
                            " values(?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, info.getUserId());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, info.getPageUrl());
                            pstmt.setString(++i, info.getPageTitle());
                            pstmt.setString(++i, info.getCategoryId());
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[AccessLogDao] #create# error " + info, e);
            return false;
        }
    }

    public void save(final String userId, final String pageUrl, final String pageTitle, final String categoryId) {
        AccessLog log = new AccessLog();
        log.setUserId(userId);
        log.setPageUrl(pageUrl);
        log.setCategoryId(categoryId);
        create(log);
    }
    public void save(final String pageUrl, final String pageTitle, final String categoryId, HttpSession session) {
        AccessLog log = new AccessLog();
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        if (obj != null) {
            UserInfo userInfo = (UserInfo) obj;
            log.setUserId(userInfo.getUserId());
        }
        log.setPageUrl(pageUrl);
        log.setPageTitle(pageTitle);
        log.setCategoryId(categoryId);
        create(log);
    }

    /**
     * @param logId
     * @return
     */
    public AccessLog getLogById(final String logId) {
        logger.info("[AccessLogDao] #getLogById#" + logId);
        try {
            List<AccessLog> list = jdbcTemplate.query("select * from tbl_access_log where id = ? ",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(
                                PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, logId);
                        }
                    },
                    new AccessLogRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[AccessLogDao] #getLogById# error " + logId, e);
        }
        return null;
    }

    public List<AccessLog> getByQuery(final AccessLogQuery query) {
        logger.info("[AccessLogDao] #getByQuery# query=" + query);
        List<AccessLog> list = new ArrayList<AccessLog>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_access_log where (user_id_fk <> '') ");

            if (StringUtils.isNotBlank(query.getCategoryId()))
                sql.append(" and page_category_id = ? ");

            if (StringUtils.isNotBlank(query.getUserId()))
                sql.append(" and user_id_fk = ? ");

            if (StringUtils.isNotBlank(query.getAccessStartTime()))
                sql.append(" and access_time >= ? ");

            if (StringUtils.isNotBlank(query.getAccessEndTime()))
                sql.append(" and access_time <= ? ");

            sql.append(" order by access_time desc ");

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

                            if (StringUtils.isNotBlank(query.getAccessStartTime()))
                                preparedstatement.setString(++i, query.getAccessStartTime());

                            if (StringUtils.isNotBlank(query.getAccessEndTime()))
                                preparedstatement.setString(++i, query.getAccessEndTime());

                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                        }
                    },
                    new AccessLogRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[AccessLogDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final AccessLogQuery query) {
        logger.info("[AccessLogDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_access_log where (user_id_fk <> '') ");

            if (StringUtils.isNotBlank(query.getCategoryId())) {
                sql.append(" and page_category_id = ? ");
                params.add(query.getCategoryId());
            }

            if (StringUtils.isNotBlank(query.getUserId())) {
                sql.append(" and user_id_fk = ? ");
                params.add(query.getUserId());
            }

            if (StringUtils.isNotBlank(query.getAccessStartTime())) {
                sql.append(" and access_time >= ? ");
                params.add(query.getAccessStartTime());
            }

            if (StringUtils.isNotBlank(query.getAccessEndTime())) {
                sql.append(" and access_time <= ? ");
                params.add(query.getAccessEndTime());
            }

            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[AccessLogDao] #getCountByQuery# error! query=" + query, e);
        }
        return count;
    }


    /**
     * @return
     */
    class AccessLogRowMapper implements RowMapper<AccessLog> {
        @Override
        public AccessLog mapRow(ResultSet rs, int i) throws SQLException {
            AccessLog info = new AccessLog();
            info.setId(rs.getString("id"));

            info.setUserId(rs.getString("user_id_fk"));
            UserInfo userInfo = userInfoDao.getUserSimpleById(info.getUserId());
            info.setUserInfo(userInfo);

            info.setPageUrl(rs.getString("page_url"));
            info.setPageTitle(rs.getString("page_title"));

            info.setCategoryId(rs.getString("page_category_id"));
            Category category = categoryDao.getById(info.getCategoryId());
            info.setCategory(category);


            info.setAccessTime(rs.getTimestamp("access_time"));
            return info;
        }
    }
}
