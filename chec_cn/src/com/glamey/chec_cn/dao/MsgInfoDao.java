package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.ContentInfo;
import com.glamey.chec_cn.model.domain.MsgInfo;
import com.glamey.chec_cn.model.domain.WebsiteInfo;
import com.glamey.chec_cn.model.dto.AnalyzerInfo;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Repository
public class MsgInfoDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(MsgInfoDao.class);
    @Autowired
    private WebsiteInfoDao websiteInfoDao;
    @Autowired
    private ContentInfoDao contentInfoDao;

    public boolean synchMsg(final MsgInfo msg) {
        try {
            String sql = "insert into tbl_msg (msg_id,msg_from,msg_to,msg_contentid_fk,msg_time,msg_status,status_time,is_read,read_time,is_used,used_time) values(?,?,?,?,?,?,?,?,?,?,?)";

            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUUID());
                            pstmt.setInt(++i, msg.getMsgFrom());
                            pstmt.setInt(++i, msg.getMsgTo());
                            pstmt.setString(++i, msg.getContentId());
                            pstmt.setString(++i, msg.getMsgTime());
                            pstmt.setInt(++i, msg.getMsgStatus());
                            pstmt.setString(++i, msg.getStatusTime());
                            pstmt.setInt(++i, msg.getIsRead());
                            pstmt.setString(++i, msg.getReadTime());
                            pstmt.setInt(++i, msg.getIsUsed());
                            pstmt.setString(++i, msg.getUsedTime());
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error("[MsgInfoDao] synchMsg error,msg=" + msg, e);
        }
        return false;
    }

    public List<MsgInfo> getSubList(final MsgInfo query, final int start, final int num) {
        List<MsgInfo> list = new ArrayList<MsgInfo>();
        try {
            String sql = "select * from tbl_msg where 1=1 ";
            if (query.getMsgFrom() > 0) {
                sql += " and msg_from = ? ";
            }
            if (query.getMsgTo() > 0) {
                sql += " and msg_to = ? ";
            }
            if (query.getMsgStatus() > 0) {
                sql += " and msg_status = ? ";
            }
            if (query.getIsRead() > -1) {
                sql += " and is_read = ? ";
            }
            if (query.getIsUsed() > -1) {
                sql += " and is_used = ? ";
            }
            sql += " order by msg_time desc limit ? , ? ";

            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            if (query.getMsgFrom() > 0) {
                                preparedStatement.setInt(++i, query.getMsgFrom());
                            }
                            if (query.getMsgTo() > 0) {
                                preparedStatement.setInt(++i, query.getMsgTo());
                            }
                            if (query.getMsgStatus() > 0) {
                                preparedStatement.setInt(++i, query.getMsgStatus());
                            }
                            if (query.getIsRead() > -1) {
                                preparedStatement.setInt(++i, query.getIsRead());
                            }
                            if (query.getIsUsed() > -1) {
                                preparedStatement.setInt(++i, query.getIsUsed());
                            }
                            preparedStatement.setInt(++i, start);
                            preparedStatement.setInt(++i, num);
                        }
                    },
                    new MsgInfoRowMapper()
            );
            return list;
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] getCount error,query=%s,start=%d,num=%d", query, start, num), e);
        }
        return Collections.emptyList();
    }

    public int getCount(final MsgInfo query) {
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            String sql = "select count(1) as total from tbl_msg where 1=1 ";
            if (query.getMsgFrom() > 0) {
                sql += " and msg_from = ? ";
                params.add(query.getMsgFrom());
            }
            if (query.getMsgTo() > 0) {
                sql += " and msg_to = ? ";
                params.add(query.getMsgTo());
            }
            if (query.getMsgStatus() > 0) {
                sql += " and msg_status = ? ";
                params.add(query.getMsgStatus());
            }
            if (query.getIsRead() > -1) {
                sql += " and is_read = ? ";
                params.add(query.getIsRead());
            }
            if (query.getIsUsed() > -1) {
                sql += " and is_used = ? ";
                params.add(query.getIsUsed());
            }
            return count = jdbcTemplate.queryForInt(sql, params.toArray());
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] getCount error,query=%s", query), e);
        }
        return 0;
    }


    public boolean del(final String msgId) {
        try {
            String sql = "delete from tbl_msg where msg_id = ? ";
            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, msgId);
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] del error,msgId=%s", msgId), e);
        }
        return false;
    }

    public List<AnalyzerInfo> getAnalyzerList(final MsgInfo query) {
        List<AnalyzerInfo> list = new ArrayList<AnalyzerInfo>();
        try {
            List<WebsiteInfo> websiteInfoList = websiteInfoDao.getSubList(null, 0, Integer.MAX_VALUE);

            if (query.getWebsiteId() == 0) {
                AnalyzerInfo analyzer = null;
                for (WebsiteInfo website : websiteInfoList) {
                    analyzer = new AnalyzerInfo();
                    analyzer.setWebsiteId(website.getId());
                    analyzer.setWebsiteInfo(website);
                    query.setWebsiteId(website.getId());
                    analyzer.setSendCount(getMsgAnalyzerDetailCount(1, query));
                    analyzer.setRevCount(getMsgAnalyzerDetailCount(2, query));
                    analyzer.setReadCount(getMsgAnalyzerDetailCount(3, query));
                    analyzer.setUsedCount(getMsgAnalyzerDetailCount(4, query));
                    list.add(analyzer);
                }
            } else {
                AnalyzerInfo analyzer = new AnalyzerInfo();
                analyzer.setWebsiteId(query.getWebsiteId());
                analyzer.setWebsiteInfo(websiteInfoDao.getWebsite(query.getWebsiteId()));
                analyzer.setSendCount(getMsgAnalyzerDetailCount(1, query));
                analyzer.setRevCount(getMsgAnalyzerDetailCount(2, query));
                analyzer.setReadCount(getMsgAnalyzerDetailCount(3, query));
                analyzer.setUsedCount(getMsgAnalyzerDetailCount(4, query));
                list.add(analyzer);
            }
            return list;
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] getAnalyzerList error,query=%s", query), e);
        }
        return Collections.emptyList();
    }

    public int getMsgAnalyzerDetailCount(int type, MsgInfo query) {
        int total = 0;
        try {
            String sql = "select count(1) as total from  tbl_msg  where msg_from = ? and status_time >= ? and status_time <= ?  ";
            switch (type) {
                case 1:
                    sql = "select count(1) as total from  tbl_msg  where msg_from = ? and status_time >= ? and status_time <= ?  ";
                    break;
                case 2:
                    sql = "select count(1) as total from  tbl_msg  where msg_to = ? and status_time >= ? and status_time <= ?  ";
                    break;
                case 3:
                    sql = "select count(1) as total from  tbl_msg  where msg_from = ? and is_read = 1 and read_time >= ? and read_time <= ?  ";
                    break;
                case 4:
                    sql = "select count(1) as total from  tbl_msg  where msg_from = ? and is_used = 1 and used_time >= ? and used_time <= ?  ";
                    break;
                default:
                    sql = "select count(1) as total from  tbl_msg  where msg_from = ? and status_time >= ? and status_time <= ?  ";
            }
            List<Object> params = new ArrayList<Object>();
            params.add(query.getWebsiteId());
            params.add(query.getStartTime());
            params.add(query.getEndTime());

            total = jdbcTemplate.queryForInt(sql, params.toArray());
            return total;
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] getMsgAnalyzerDetailList error,type=%d,query=%s", type, query), e);
        }
        return total;
    }

    public List<MsgInfo> getMsgAnalyzerDetailList(int type, final MsgInfo query, final int start, final int num) {
        List<MsgInfo> list = new ArrayList<MsgInfo>();
        try {
            String sql = "select * from  tbl_msg  where msg_from = ? and status_time >= ? and status_time <= ? limit ? ,? ";
            switch (type) {
                case 1:
                    sql = "select * from  tbl_msg  where msg_from = ? and status_time >= ? and status_time <= ? limit ? ,? ";
                    break;
                case 2:
                    sql = "select * from  tbl_msg  where msg_to = ? and status_time >= ? and status_time <= ? limit ? ,? ";
                    break;
                case 3:
                    sql = "select * from  tbl_msg  where msg_from = ? and is_read = 1 and read_time >= ? and read_time <= ? limit ? ,? ";
                    break;
                case 4:
                    sql = "select * from  tbl_msg  where msg_from = ? and is_used = 1 and used_time >= ? and used_time <= ? limit ? ,? ";
                    break;
                default:
                    sql = "select * from  tbl_msg  where msg_from = ? and status_time >= ? and status_time <= ? limit ? ,? ";
            }

            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            preparedStatement.setInt(++i, query.getWebsiteId());
                            preparedStatement.setString(++i, query.getStartTime());
                            preparedStatement.setString(++i, query.getEndTime());
                            preparedStatement.setInt(++i, start);
                            preparedStatement.setInt(++i, num);
                        }
                    },
                    new MsgInfoRowMapper()
            );
            return list;
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] getMsgAnalyzerDetailList error,type=%d,query=%s,start=%d,num=%d", type, query, start, num), e);
        }
        return Collections.emptyList();
    }

    public boolean isAlwaysRead(final int websiteId, final String contentId) {
        try {
            String sql = "update tbl_msg set is_read = 1 , read_time = ? where msg_from = ? and msg_contentid_fk = ? ";
            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            preparedStatement.setString(++i, DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
                            preparedStatement.setInt(++i, websiteId);
                            preparedStatement.setString(++i, contentId);
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] isAlwaysRead error,websiteId=%d,contentId=%s", websiteId, contentId), e);
        }
        return false;
    }

    public boolean isAlwaysRead(final String msgId) {
        try {
            String sql = "update tbl_msg set is_read = 1 , read_time = ? where msg_id = ? ";
            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            preparedStatement.setString(++i, DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
                            preparedStatement.setString(++i, msgId);
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] isAlwaysRead error,msgId=%s", msgId), e);
        }
        return false;
    }

    public boolean isAlwaysUsed(final int websiteId, final String contentId) {
        try {
            String sql = "update tbl_msg set is_used = 1 , used_time = ? where msg_from = ? and msg_contentid_fk = ? ";
            int rows = jdbcTemplate.update(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            int i = 0;
                            preparedStatement.setString(++i, DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
                            preparedStatement.setInt(++i, websiteId);
                            preparedStatement.setString(++i, contentId);
                        }
                    }
            );
            return rows > 0;
        } catch (Exception e) {
            logger.error(String.format("[MsgInfoDao] isAlwaysUsed error,websiteId=%d,contentId=%s", websiteId, contentId), e);
        }
        return false;
    }

    public MsgInfo getMsgInfoByMsgId(final String msgId) {
        try {
            String sql = "select * from tbl_msg where msg_id = ?";

            List<MsgInfo> list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, msgId);
                        }
                    },
                    new MsgInfoRowMapper()
            );
            return CollectionUtils.isEmpty(list) ? new MsgInfo() : list.get(0);
        } catch (Exception e) {
            logger.error("[MsgInfoDao] getMsgInfoByMsgId error,msgId=" + msgId, e);
        }
        return new MsgInfo();
    }

    class MsgInfoRowMapper implements RowMapper<MsgInfo> {
        @Override
        public MsgInfo mapRow(ResultSet rs, int i) throws SQLException {
            MsgInfo msg = new MsgInfo();
            msg.setMsgId(rs.getString("msg_id"));
            msg.setMsgFrom(rs.getInt("msg_from"));
            msg.setMsgTo(rs.getInt("msg_to"));
            msg.setContentId(rs.getString("msg_contentid_fk"));
            msg.setMsgTime(rs.getString("msg_time"));

            msg.setMsgStatus(rs.getInt("msg_status"));
            msg.setStatusTime(rs.getString("status_time"));

            msg.setIsRead(rs.getInt("is_read"));
            msg.setReadTime(rs.getString("read_time"));

            msg.setIsUsed(rs.getInt("is_used"));
            msg.setReadTime(rs.getString("used_time"));

            WebsiteInfo websiteFrom = websiteInfoDao.getWebsite(msg.getMsgFrom());
            WebsiteInfo websiteTo = websiteInfoDao.getWebsite(msg.getMsgTo());
            ContentInfo contentInfo = contentInfoDao.getContentById(msg.getContentId());
            msg.setWebsiteFrom(websiteFrom);
            msg.setWebsiteTo(websiteTo);
            msg.setContentInfo(contentInfo);
            return msg;
        }
    }
}