package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.JobInfo;
import com.glamey.chec_cn.model.dto.JobInfoQuery;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class JobInfoDao extends BaseDao {

    protected static final Logger logger = Logger.getLogger(JobInfoDao.class);

    @Autowired
    private CategoryDao categoryDao;

    public String createReturnId(final JobInfo job) {
        logger.info("[JobInfoDao] #createReturnId# " + job);
        final String jobId = StringTools.getUniqueId();
        try {
            int count = jdbcTemplate.update(
                    "insert into tbl_job" +
                            "(job_id,job_cate_id_fk,job_title,job_person,job_address,job_contact,job_responsibility,job_requirement,job_publishdate)" +
                            " values(?,?,?,?,?,?,?,?,now())",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, jobId);
                            pstmt.setString(++i, job.getCategoryId());
                            pstmt.setString(++i, job.getTitle());
                            pstmt.setInt(++i, job.getPerson());
                            pstmt.setString(++i, job.getAddress());
                            pstmt.setString(++i, job.getContact());
                            pstmt.setString(++i, job.getResponsibility());
                            pstmt.setString(++i, job.getRequirement());
                        }
                    });
            return jobId;
        } catch (Exception e) {
            logger.error("[JobInfoDao] #createReturnId# error " + job, e);
            return null;
        }
    }

    public boolean update(final JobInfo job) {
        logger.info("[JobInfoDao] #update# " + job);
        try {
            int count = jdbcTemplate.update(
                    "update tbl_job set job_cate_id_fk = ?,job_title = ?,job_person = ?,job_address = ?,job_contact = ?,job_responsibility = ?,job_requirement = ? where job_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, job.getCategoryId());
                            pstmt.setString(++i, job.getTitle());
                            pstmt.setInt(++i, job.getPerson());
                            pstmt.setString(++i, job.getAddress());
                            pstmt.setString(++i, job.getContact());
                            pstmt.setString(++i, job.getResponsibility());
                            pstmt.setString(++i, job.getRequirement());
                            pstmt.setString(++i, job.getJobId());

                        }
                    });
            return count > 0;
        } catch (Exception e) {
            logger.error("[JobInfoDao] #update# error " + job, e);
            return false;
        }
    }

    public boolean deleteById(final String id) {
        logger.info("[JobInfoDao] #deleteById#" + id);
        try {
            int count = jdbcTemplate.update("delete from tbl_job where job_id = ?", new PreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement preparedstatement)
                        throws SQLException {
                    preparedstatement.setString(1, id);
                }
            });
            return count > 0;
        } catch (Exception e) {
            logger.error("[JobInfoDao] #deleteById# id=" + id + " error ", e);
        }
        return false;
    }

    public JobInfo getById(final String jobId) {
        logger.info("[JobInfoDao] #getById# jobId=" + jobId);
        try {
            List<JobInfo> list = jdbcTemplate.query("select * from tbl_job where job_id = ?",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            preparedstatement.setString(1, jobId);
                        }
                    },
                    new JobInfoRowMapper());
            if (list != null && list.size() > 0) {
                return list.get(0);
            }
        } catch (Exception e) {
            logger.error("[JobInfoDao] #getById# jobId=" + jobId + " error!", e);
        }
        return null;
    }


    public List<JobInfo> getByQuery(final JobInfoQuery query) {
        logger.info("[JobInfoDao] #getByQuery# query=" + query);
        List<JobInfo> list = new ArrayList<JobInfo>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_job where 1=1 ");

            if (StringUtils.isNotBlank(query.getCategoryId()))
                sql.append(" and job_cate_id_fk = ? ");

            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                sql.append(" and job_publishdate >= ? ");
            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                sql.append(" and job_publishdate <= ? ");

            if (StringUtils.isNotBlank(query.getKw()))
                sql.append(" and (job_title like ? or job_responsibility like ? or job_requirement like ? ) ");

            sql.append(" order by job_publishdate desc limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;

                            if (StringUtils.isNotBlank(query.getCategoryId()))
                                preparedstatement.setString(++i, query.getCategoryId());

                            if (StringUtils.isNotBlank(query.getPublishStartTime()))
                                preparedstatement.setString(++i, query.getPublishStartTime());

                            if (StringUtils.isNotBlank(query.getPublishEndTime()))
                                preparedstatement.setString(++i, query.getPublishEndTime());

                            if (StringUtils.isNotBlank(query.getKw())) {
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                                preparedstatement.setString(++i, "%" + query.getKw() + "%");
                            }

                            preparedstatement.setInt(++i, query.getStart());
                            preparedstatement.setInt(++i, query.getNum());

                            System.out.println(preparedstatement.toString());
                        }
                    },
                    new JobInfoRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[JobInfoDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final JobInfoQuery query) {
        logger.info("[PostDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_job where 1=1 ");

            if (StringUtils.isNotBlank(query.getCategoryId())) {
                sql.append(" and job_cate_id_fk = ? ");
                params.add(query.getCategoryId());
            }

            if (StringUtils.isNotBlank(query.getPublishStartTime())) {
                sql.append(" and job_publishdate >= ? ");
                params.add(query.getPublishStartTime());
            }
            if (StringUtils.isNotBlank(query.getPublishEndTime())) {
                sql.append(" and job_publishdate <= ? ");
                params.add(query.getPublishEndTime());
            }

            if (StringUtils.isNotBlank(query.getKw())) {
                sql.append(" and (job_title like ? or job_responsibility like ? or job_requirement like ? ) ");
                params.add(query.getKw());
                params.add(query.getKw());
                params.add(query.getKw());
            }
            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[JobInfoDao] #getCountByQuery# error! query=" + query, e);
        }
        return count;
    }

    class JobInfoRowMapper implements RowMapper<JobInfo> {
        @Override
        public JobInfo mapRow(ResultSet rs, int i) throws SQLException {
            JobInfo job = new JobInfo();
            job.setJobId(rs.getString("job_id"));
            job.setCategoryId(rs.getString("job_cate_id_fk"));
            if (StringUtils.isNotBlank(job.getCategoryId())) {
                Category category = categoryDao.getBySmpleId(job.getCategoryId());
                job.setCategory(category);
            }
            job.setTitle(rs.getString("job_title"));
            job.setPerson(rs.getInt("job_person"));
            job.setAddress(rs.getString("job_address"));
            job.setContact(rs.getString("job_contact"));
            job.setResponsibility(rs.getString("job_responsibility"));
            job.setRequirement(rs.getString("job_requirement"));
            job.setPublishTime(rs.getTimestamp("job_publishdate"));
            return job;
        }
    }
}
