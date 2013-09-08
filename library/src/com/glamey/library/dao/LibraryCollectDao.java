/**
 *
 */
package com.glamey.library.dao;

import com.glamey.framework.utils.StringTools;
import com.glamey.library.model.domain.LibraryCollect;
import com.glamey.library.model.dto.LibraryCollectQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
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
 * 图书收藏
 *
 * @author zy
 */
@Repository
public class LibraryCollectDao extends BaseDao {
    private static final Logger logger = Logger.getLogger(LibraryCollectDao.class);

    @Resource
    private UserInfoDao userInfoDao;
    @Resource
    private LibraryInfoDao libraryInfoDao;

    /**
     * @return
     */
    public boolean create(final LibraryCollect collect) {
        logger.info("[LibraryCollectDao] #create# " + collect);
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_library_collect(collect_id,user_id_fk,lib_id_fk,collect_time) values(?,?,?,?)",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, StringTools.getUniqueId());
                            pstmt.setString(++i, collect.getUserId());
                            pstmt.setString(++i, collect.getLibId());
                            pstmt.setTimestamp(++i, new Timestamp(new Date().getTime()));
                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LibraryCollectDao] #create# error " + collect, e);
            return false;
        }
    }

    public boolean deleteById(final String collectId) {
        logger.info("[LibraryCollectDao] #delete#" + collectId);
        try {
            int count = jdbcTemplate.update("delete from tbl_library_collect where collect_id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, collectId);
                }
            });
            return count > 0;
        } catch (Exception e) {
            logger.error("[LibraryCollectDao] #delete# error " + collectId, e);
        }
        return false;
    }

    public List<LibraryCollect> getList(final LibraryCollectQuery query) {
        logger.info("[LibraryCollectDao] #getList# query=" + query);
        List<LibraryCollect> list = new ArrayList<LibraryCollect>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_library_collect where 1=1 ");

            if (StringUtils.isNotBlank(query.getUserId())) {
                sql.append(" and user_id_fk = ? ");
            }

            if (StringUtils.isNotBlank(query.getLibId())) {
                sql.append(" and lib_id_fk = ? ");
            }

            if (StringUtils.isNotBlank(query.getStartTime())) {
                sql.append(" and collect_time >= ? ");
            }

            if (StringUtils.isNotBlank(query.getEndTime())) {
                sql.append(" and collect_time <= ? ");
            }

            sql.append(" order by collect_time desc limit ? ,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {

                            int i = 0;
                            if (StringUtils.isNotBlank(query.getUserId())) {
                                preparedstatement.setString(++i, query.getUserId());
                            }

                            if (StringUtils.isNotBlank(query.getLibId())) {
                                preparedstatement.setString(++i, query.getLibId());
                            }

                            if (StringUtils.isNotBlank(query.getStartTime())) {
                                preparedstatement.setString(++i, query.getStartTime());
                            }

                            if (StringUtils.isNotBlank(query.getEndTime())) {
                                preparedstatement.setString(++i, query.getEndTime());
                            }

                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());
                        }
                    },
                    new LibraryCollectRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[LibraryCollectDao] #getList# error", e);
        }
        return null;
    }


    public int getCountList(LibraryCollectQuery query) {
        logger.info("[LibraryCollectDao] #getCountList# query=" + query);
        List<String> paras = new ArrayList<String>();
        StringBuffer sql = new StringBuffer("select count(1) as total from tbl_library_collect where 1=1 ");

        int count = 0;
        try {
            if (StringUtils.isNotBlank(query.getUserId())) {
                sql.append(" and user_id_fk = ? ");
                paras.add(query.getUserId());
            }

            if (StringUtils.isNotBlank(query.getLibId())) {
                sql.append(" and lib_id_fk = ? ");
                paras.add(query.getLibId());
            }

            if (StringUtils.isNotBlank(query.getStartTime())) {
                sql.append(" and collect_time >= ? ");
                paras.add(query.getStartTime());
            }

            if (StringUtils.isNotBlank(query.getEndTime())) {
                sql.append(" and collect_time <= ? ");
                paras.add(query.getEndTime());
            }
            count = jdbcTemplate.queryForInt(sql.toString(),
                    paras.toArray());

        } catch (Exception e) {
            logger.error("[LibraryCollectDao] #getCountList# error query=" + query, e);
        }
        return count;
    }


    public boolean exist(final String libId){
        logger.info("[LibraryCollectDao] #exist# libId=" + libId);
        List<String> paras = new ArrayList<String>();
        StringBuffer sql = new StringBuffer("select count(1) as total from tbl_library_collect where lib_id_fk=? ");
        int count = 0 ;
        try {
            paras.add(libId);
            count = jdbcTemplate.queryForInt(sql.toString(),
                    paras.toArray());
            return count > 0 ;
        } catch (Exception e) {
            logger.error("[LibraryCollectDao] #exist# libId=" + libId,e);
        }
        return false ;
    }
    class LibraryCollectRowMapper implements RowMapper<LibraryCollect> {
        @Override
        public LibraryCollect mapRow(ResultSet rs, int i) throws SQLException {
            LibraryCollect collect = new LibraryCollect();
            collect.setCollectId(rs.getString("collect_id"));
            collect.setUserId(rs.getString("user_id_fk"));
            collect.setUserInfo(userInfoDao.getUserById(collect.getUserId()));
            collect.setLibId(rs.getString("lib_id_fk"));
            collect.setLibraryInfo(libraryInfoDao.getById(collect.getLibId()));
            collect.setTime(rs.getTimestamp("collect_time"));
            return collect;
        }
    }
}
