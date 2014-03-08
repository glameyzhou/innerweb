/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.BBSPost;
import com.glamey.library.model.domain.BBSPostVote;
import com.glamey.library.model.domain.BBSVoteProperty;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * 论坛投票
 *
 * @author zy
 */
@Repository
public class BBSVoteDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(BBSVoteDao.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private UserInfoDao userInfoDao;
    @Resource
    private BBSPostDao bbsPostDao;

    /**
     * @param post
     * @param postVote
     * @param votePropertyList
     * @return
     */
    public boolean create(final BBSPost post, final BBSPostVote postVote, final List<BBSVoteProperty> votePropertyList) {
        logger.info(String.format("[bbs] createVote post=%s,postVote=%s,votePropertyList=%s", post, postVote, votePropertyList));
        try {
            //主题内容
            final String postId = post.getId();
            int countPost = jdbcTemplate.update(
                    "insert into tbl_bbs_post(id,category_id_fk,title,user_id_fk,publish_time,update_time,content,view_count,reply_count,show_top,show_great,show_popular) " +
                            " values(?,?,?,?,?,?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, postId);
                            pstmt.setString(++i, post.getCategoryId());
                            pstmt.setString(++i, post.getTitle());
                            pstmt.setString(++i, post.getUserId());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                            pstmt.setString(++i, post.getContent());
                            pstmt.setInt(++i, post.getViewCount());
                            pstmt.setInt(++i, post.getReplyCount());
                            pstmt.setInt(++i, post.getShowTop());
                            pstmt.setInt(++i, post.getShowGreat());
                            pstmt.setInt(++i, post.getShowPopular());
                        }
                    });
            //投票主题
            final String voteId = postVote.getVoteId();
            int countVote = jdbcTemplate.update(
                    "insert into tbl_bbs_post_vote(vote_id,post_id_fk,vote_end_date,is_multi_vote,multi_vote_size,ses_after_vote,vote_person_out)" +
                            " values(?,?,?,?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, voteId);
                            pstmt.setString(++i, postId);
                            pstmt.setString(++i, postVote.getVoteEndDate());
                            pstmt.setInt(++i, postVote.getIsMultiVote());
                            pstmt.setInt(++i, postVote.getMultiVoteSize());
                            pstmt.setInt(++i, postVote.getSeeAfterVote());
                            pstmt.setInt(++i, postVote.getVotePersonOut());
                        }
                    });

            //投票属性
            int countVoteProperty[] = jdbcTemplate.batchUpdate(
                    "insert into tbl_bbs_post_vote_property(vote_id_fk,property_id,vote_property_name,vote_value,property_order)"
                            + " values(?,?,?,?,?)",
                    new BatchPreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
                            BBSVoteProperty voteProperty = votePropertyList.get(i);
                            int m = 0;
                            preparedStatement.setString(++m, voteProperty.getVoteId());
                            preparedStatement.setString(++m, StringTools.getUniqueId());
                            preparedStatement.setInt(++m, voteProperty.getPropertyValue());
                            preparedStatement.setInt(++m, voteProperty.getProperOrder());
                        }

                        @Override
                        public int getBatchSize() {
                            return votePropertyList.size();
                        }
                    }
            );
            return countPost > 0 && countVote > 0 && countVoteProperty.length > 0;
        } catch (Exception e) {
            logger.info(String.format("[bbs] createVote error, post=%s,postVote=%s,votePropertyList=%s", post, postVote, votePropertyList), e);
            return false;
        }
    }
}
