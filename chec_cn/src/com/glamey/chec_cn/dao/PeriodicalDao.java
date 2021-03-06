package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.PeriodicalInfo;
import com.glamey.chec_cn.model.dto.PeriodicalQuery;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * 华电工程 期刊 DB操作
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class PeriodicalDao extends BaseDao {
    public static final Logger logger = Logger.getLogger(PeriodicalDao.class);

    /**
     * @param info
     * @return
     */
    public String createReturnId(final PeriodicalInfo info) {
        logger.info("[PeriodicalDao] #createReturnId# " + info);
        final String id = StringTools.getUniqueId();
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_periodical (id,title,summary,image,years,periodical,periodical_all,filepath,filename,filesize,createtime)" +
                            " values(?,?,?,?,?,?,?,?,?,?,now())",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, id);
                            pstmt.setString(++i, info.getTitle());
                            pstmt.setString(++i, info.getSummary());
                            pstmt.setString(++i, info.getImages());
                            pstmt.setInt(++i, info.getYears());
                            pstmt.setInt(++i, info.getPeriodical());
                            pstmt.setInt(++i, info.getPeriodicalAll());
                            pstmt.setString(++i, info.getFilePath());
                            pstmt.setString(++i, info.getFileName());
                            pstmt.setLong(++i, info.getFileSize());
                        }
                    }
            );
            return id;
        } catch (Exception e) {
            logger.error("[PeriodicalDao] #createReturnId# error " + info, e);
            return null;
        }
    }

    /**
     * @param info
     * @return
     */
    public boolean update(final PeriodicalInfo info) {
        logger.info("[PeriodicalDao] #update# " + info);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_periodical set title = ?,summary = ?,image = ?,years = ?,periodical = ?,periodical_all = ?,filepath = ?,filename = ?,filesize = ? where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, info.getTitle());
                            pstmt.setString(++i, info.getSummary());
                            pstmt.setString(++i, info.getImages());
                            pstmt.setInt(++i, info.getYears());
                            pstmt.setInt(++i, info.getPeriodical());
                            pstmt.setInt(++i, info.getPeriodicalAll());
                            pstmt.setString(++i, info.getFilePath());
                            pstmt.setString(++i, info.getFileName());
                            pstmt.setLong(++i, info.getFileSize());
                            pstmt.setString(++i, info.getId());
                        }
                    }
            );
            return count > 0;
        } catch (Exception e) {
            logger.error("[PeriodicalDao] #update# error " + info, e);
            return false;
        }
    }

    /**
     * delete the post by postId
     *
     * @param id
     * @return
     */
    public boolean deleteById(final String id) {
        logger.info("[PeriodicalDao] #delete#" + id);
        try {
            int count = jdbcTemplate.update("delete from tbl_periodical where id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, id);
                }
            });
            return count > 0;
        } catch (Exception e) {
            logger.error("[PeriodicalDao] #deleteById# id=" + id + " error ", e);
        }
        return false;
    }

    /**
     * get post by postId
     *
     * @param id
     * @return
     */
    public PeriodicalInfo getById(final String id) {
        logger.info("[PeriodicalDao] #getById# id=" + id);
        try {
            List<PeriodicalInfo> list = jdbcTemplate.query("select * from tbl_periodical where id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, id);
                        }
                    },
                    new PeriodicalRowMapper()
            );
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[PeriodicalDao] #getById# id=" + id + " error!", e);
        }
        return null;
    }

    public List<PeriodicalInfo> getByQuery(final PeriodicalQuery query) {
        logger.info("[PeriodicalDao] #getByQuery# query=" + query);
        List<PeriodicalInfo> list = new ArrayList<PeriodicalInfo>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_periodical where 1=1 ");

            if (StringUtils.isNotBlank(query.getKw()))
                sql.append(" and (title like ? or summary like ? ) ");

            if (query.getYearsStart() > -1)
                sql.append(" and years >= ? ");

            if (query.getYearsEnd() >= query.getYearsStart())
                sql.append(" and years <= ? ");

            sql.append(" order by periodical_all desc limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getKw())) {
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }

                            if (query.getYearsStart() > -1)
                                preparedstatement.setInt(++i, query.getYearsStart());

                            if (query.getYearsEnd() >= query.getYearsStart())
                                preparedstatement.setInt(++i, query.getYearsEnd());


                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                        }
                    },
                    new PeriodicalRowMapper()
            );
            return list;
        } catch (Exception e) {
            logger.error("[PeriodicalDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final PeriodicalQuery query) {
        logger.info("[PeriodicalDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_periodical where 1=1 ");

            if (StringUtils.isNotBlank(query.getKw())) {
                sql.append(" and (title like ? or summary like ?) ");
                params.add(query.getKw());
                params.add(query.getKw());
            }

            if (query.getYearsStart() > -1) {
                sql.append(" and years >= ? ");
                params.add(query.getYearsStart());
            }

            if (query.getYearsEnd() >= query.getYearsStart()) {
                sql.append(" and years <= ? ");
                params.add(query.getYearsEnd());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[PeriodicalDao] #getCountByQuery# error! query=" + query, e);
        }
        return count;
    }

    public List<Integer> getYearsList() {
        logger.info("[PeriodicalDao] #getYearsList# ");
        List<Integer> list = new ArrayList<Integer>();
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select distinct(years) as years from tbl_periodical order by years desc");
            list = jdbcTemplate.query(sql.toString(),
                    new RowMapper<Integer>() {
                        @Override
                        public Integer mapRow(ResultSet resultSet, int i) throws SQLException {
                            return resultSet.getInt("years");
                        }
                    }
            );
        } catch (Exception e) {
            logger.error("[PeriodicalDao] #getYearsList# error!", e);
        }
        return list;
    }

    /**
     * 获取期刊默认的"年"、“本年度期刊数”、“总期刊数”
     * @return
     */
    public int[] getMaxPeriodical() {
        logger.info("[PeriodicalDao] #getMaxPeriodical# ");
        try {
            List<PeriodicalInfo> list = jdbcTemplate.query("SELECT * from tbl_periodical order by years desc,createtime desc limit 1",new PeriodicalRowMapper());
            if (CollectionUtils.isEmpty(list)) {
                return new int[3];
            }
            int result  [] = new int[3];
            PeriodicalInfo periodicalInfo = list.get(0);
            int y = periodicalInfo.getYears();
            int p = periodicalInfo.getPeriodical();
            int pa = periodicalInfo.getPeriodicalAll();

            if (p >= 6) {
                result[0] = y + 1;
                result[1] = 1;
                result[2] = pa + 1;
            } else {
                result[0] = y;
                result[1] = p + 1;
                result[2] = pa + 1;
            }
            return result;
        } catch (Exception e) {
            logger.error("[PeriodicalDao] #getYearsList# error!", e);
        }
        return new int[3];
    }

    class PeriodicalRowMapper implements RowMapper<PeriodicalInfo> {
        @Override
        public PeriodicalInfo mapRow(ResultSet rs, int i) throws SQLException {
            PeriodicalInfo info = new PeriodicalInfo();

            info.setId(rs.getString("id"));
            info.setTitle(rs.getString("title"));
            info.setSummary(rs.getString("summary"));
            info.setImages(rs.getString("image"));
            info.setYears(rs.getInt("years"));
            info.setPeriodical(rs.getInt("periodical"));
            info.setPeriodicalAll(rs.getInt("periodical_all"));
            info.setFilePath(rs.getString("filepath"));
            info.setFileName(rs.getString("filename"));
            info.setFileSize(rs.getLong("filesize"));
            info.setCreateTime(rs.getTimestamp("createtime"));
            return info;
        }
    }

}
