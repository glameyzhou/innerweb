/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.BBSPost;
import com.glamey.library.model.domain.BBSPostVote;
import com.glamey.library.model.domain.BBSVotePerson;
import com.glamey.library.model.domain.BBSVoteProperty;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
                    "insert into tbl_bbs_post(id,category_id_fk,title,user_id_fk,publish_time,update_time,content,view_count,reply_count,show_top,show_great,show_popular,post_type) " +
                            " values(?,?,?,?,?,?,?,?,?,?,?,?,1)",
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
                    "insert into tbl_bbs_post_vote(vote_id,post_id_fk,vote_end_date,is_multi_vote,multi_vote_size,see_after_vote,vote_person_out)" +
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
                            preparedStatement.setString(++m, voteProperty.getPropertyName());
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

    public BBSPostVote getPostVote(final String postId){
        String sql = "select vote_id,post_id_fk,vote_end_date,is_multi_vote,multi_vote_size,see_after_vote,vote_person_out from tbl_bbs_post_vote where post_id_fk = ? ";
        try {
            List<BBSPostVote> postVoteList = jdbcTemplate.query(
                            sql,
                            new PreparedStatementSetter() {
                                @Override
                                public void setValues(PreparedStatement preparedStatement) throws SQLException {
                                    preparedStatement.setString(1, postId);
                                }
                            },
                            new BBSPostVoteRowMapper()
                    );
            return CollectionUtils.isEmpty(postVoteList) ? null : postVoteList.get(0);
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<BBSVoteProperty> getVoteProperties(final String voteId){
        String sql = "select vote_id_fk,property_id,vote_property_name,vote_value,property_order from tbl_bbs_post_vote_property where vote_id_fk = ? order by property_order asc";
        try {
            List<BBSVoteProperty> votePropertyList = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, voteId);
                        }
                    },
                    new BBSVotePropertyRowMapper()
            );
            return votePropertyList;
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return null;
    }

    public BBSVoteProperty getVoteProperty(final String voteId,final String propertyId){
        String sql = "select vote_id_fk,property_id,vote_property_name,vote_value,property_order from tbl_bbs_post_vote_property where vote_id_fk = ? and property_id = ?";
        try {
            List<BBSVoteProperty> votePropertyList = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, voteId);
                            preparedStatement.setString(2, propertyId);
                        }
                    },
                    new BBSVotePropertyRowMapper()
            );
            return CollectionUtils.isEmpty(votePropertyList) ? null : votePropertyList.get(0);
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<BBSVotePerson> getVotePersonList(final String voteId,final String propertyId){
        String sql = "select vote_id_fk,vote_property_id_fk,vote_user_id_fk,vote_time from tbl_bbs_post_vote_person where vote_id_fk = ? and vote_property_id_fk = ? order by vote_time desc";
        try {
            List<BBSVotePerson> votePersonList = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, voteId);
                            preparedStatement.setString(2, propertyId);
                        }
                    },
                    new BBSVotePersonRowMapper()
            );
            return votePersonList;
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return null;
    }
    /**
     * 记录投票人、更新投票总量、更新主题的最后更新时间和回复总量（回复总量相当于投票总量）
     * @param votePersonList
     * @param postId
     * @return
     */
    public boolean recordVote(final List<BBSVotePerson> votePersonList, final String postId) {
        try {
            //插入投票人 tbl_bbs_post_vote_person
            String insertVotePerson = "insert into tbl_bbs_post_vote_person(vote_id_fk,vote_property_id_fk,vote_user_id_fk,vote_time) values(?,?,?,now())";
            int insertVotePersonRows[] = this.jdbcTemplate.batchUpdate(
                    insertVotePerson,
                    new BatchPreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
                            BBSVotePerson votePerson = votePersonList.get(i);
                            int j = 0;
                            preparedStatement.setString(++j, votePerson.getVoteId());
                            preparedStatement.setString(++j, votePerson.getPropertyId());
                            preparedStatement.setString(++j, votePerson.getVoteUserId());
                        }

                        @Override
                        public int getBatchSize() {
                            return votePersonList.size();
                        }
                    }
            );
            //更新投票总量 tbl_bbs_post_vote_property
            String updateVoteCount = "update tbl_bbs_post_vote_property set vote_value = vote_value + 1 where property_id = ? and vote_id_fk = ? ";
            int updateVoteCountRows [] = this.jdbcTemplate.batchUpdate(
                    updateVoteCount,
                    new BatchPreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
                            BBSVotePerson votePerson = votePersonList.get(i);
                            int j = 0;
                            preparedStatement.setString(++j, votePerson.getPropertyId());
                            preparedStatement.setString(++j, votePerson.getVoteId());
                        }

                        @Override
                        public int getBatchSize() {
                            return votePersonList.size();
                        }
                    }
            );
            //更新主帖 tbl_bbs_post
            String updateBbsPost = "update tbl_bbs_post set reply_count = reply_count + 1,update_time = now() where id = ?";
            int updateBbsPostRows = this.jdbcTemplate.update(
                    updateBbsPost,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, postId);
                        }
                    }
            );
            return insertVotePersonRows.length > 0 && updateVoteCountRows.length > 0 && updateBbsPostRows > 0;
        } catch (DataAccessException e) {
            logger.error(String.format("[bbs] #recordVote# postId=%s,votePerson=%s",postId,votePersonList),e);
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 此人是否针对这个帖子投过票
     * @param userId
     * @param voteId
     * @return
     */
    public boolean isVote(final String userId,final String voteId) {
        int voteCount = 0;
        try {
            String count = "select count(1) from tbl_bbs_post_vote_person where vote_id_fk = ? and vote_user_id_fk = ?";
            voteCount = this.jdbcTemplate.queryForInt(
                    count,
                    new Object[]{voteId, userId}
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return voteCount > 0;
    }
    public int getVoteToal(final String voteId) {
        int voteCount = 0;
        try {
            String count = "select count(1) from tbl_bbs_post_vote_person where vote_id_fk = ?";
            voteCount = this.jdbcTemplate.queryForInt(
                    count,
                    new Object[]{voteId}
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return voteCount;
    }

    public int getVotePersonToal(final String voteId) {
        int votePersonCount = 0;
        try {
            String count = "select count(distinct(vote_user_id_fk)) from tbl_bbs_post_vote_person where vote_id_fk = ?";
            votePersonCount = this.jdbcTemplate.queryForInt(
                    count,
                    new Object[]{voteId}
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return votePersonCount;
    }

    class BBSPostVoteRowMapper implements RowMapper<BBSPostVote>    {
        @Override
        public BBSPostVote mapRow(ResultSet resultSet, int i) throws SQLException {
            BBSPostVote postVote = new BBSPostVote();
            postVote.setVoteId(resultSet.getString("vote_id"));
            postVote.setPostId(resultSet.getString("post_id_fk"));
            postVote.setVoteEndDate(resultSet.getString("vote_end_date"));
            postVote.setIsMultiVote(resultSet.getInt("is_multi_vote"));
            postVote.setMultiVoteSize(resultSet.getInt("multi_vote_size"));
            postVote.setSeeAfterVote(resultSet.getInt("see_after_vote"));
            postVote.setVotePersonOut(resultSet.getInt("vote_person_out"));
            return postVote;
        }
    }

    class BBSVotePropertyRowMapper implements RowMapper<BBSVoteProperty> {

        @Override
        public BBSVoteProperty mapRow(ResultSet resultSet, int i) throws SQLException {
            BBSVoteProperty property = new BBSVoteProperty();
            property.setVoteId(resultSet.getString("vote_id_fk"));
            property.setPropertyId(resultSet.getString("property_id"));
            property.setPropertyName(resultSet.getString("vote_property_name"));
            property.setPropertyValue(resultSet.getInt("vote_value"));
            property.setProperOrder(resultSet.getInt("property_order"));
            return property;
        }
    }

    class BBSVotePersonRowMapper implements RowMapper<BBSVotePerson> {

        @Override
        public BBSVotePerson mapRow(ResultSet resultSet, int i) throws SQLException {
            BBSVotePerson person = new BBSVotePerson();
            person.setVoteId(resultSet.getString("vote_id_fk"));
            person.setPropertyId(resultSet.getString("vote_property_id_fk"));
            person.setVoteUserId(resultSet.getString("vote_user_id_fk"));
            person.setUserInfo(userInfoDao.getUserSimpleById(person.getVoteUserId()));
            person.setVoteTime(resultSet.getTimestamp("vote_time"));
            return person;
        }
    }
}
