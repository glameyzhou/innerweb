package com.glamey.chec_cn.dao;

import com.glamey.chec_cn.model.domain.*;
import com.glamey.chec_cn.model.dto.ResumeQuery;
import com.glamey.framework.utils.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
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
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class ResumeDao extends BaseDao {

    protected static final Logger logger = Logger.getLogger(ResumeDao.class);

    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private JobInfoDao jobInfoDao;


    public String createReturnId(final ResumeInfo resume) {
        logger.info("[ResumeDao] #createReturnId# " + resume);
        final String jobId = StringTools.getUniqueId();
        try {
            String resumeSQL = "insert into tbl_resume(job_id_fk,resume_id,name,birthday,gender,politicsStatus,nation,marriageStatus,bearStatus,height," +
                    "image,email,areaCode,telephone,performance,rewardsPunishment,unHandleThing,careerPlanning,personalHobbies,resume_time)" +
                    " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            jdbcTemplate.update(
                    "insert into tbl_job" +
                            "(job_id,job_cate_id_fk,job_title,job_person,job_address,job_contact,job_responsibility,job_requirement,job_publishdate)" +
                            " values(?,?,?,?,?,?,?,?,now())",
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement pstmt) throws SQLException {
                            int i = 0;
                            pstmt.setString(++i, resume.getJobId());
                            pstmt.setString(++i, resume.getResumeId());
                            pstmt.setString(++i, resume.getName());
                            pstmt.setString(++i, resume.getBirthday());
                            pstmt.setInt(++i, resume.getGender());
                            pstmt.setInt(++i, resume.getPoliticsStatus());
                            pstmt.setString(++i, resume.getNation());
                            pstmt.setInt(++i, resume.getMarriageStatus());
                            pstmt.setString(++i, resume.getBearStatus());
                            pstmt.setInt(++i, resume.getHeight());

                            pstmt.setString(++i, resume.getImage());
                            pstmt.setString(++i, resume.getEmail());
                            pstmt.setString(++i, resume.getAreaCode());
                            pstmt.setString(++i, resume.getTelephone());
                            pstmt.setString(++i, resume.getPerformance());
                            pstmt.setString(++i, resume.getRewardsPunishment());
                            pstmt.setInt(++i, resume.getUnHandleThing());
                            pstmt.setString(++i, resume.getCareerPlanning());
                            pstmt.setString(++i, resume.getPersonalHobbies());
                            pstmt.setTimestamp(++i, new java.sql.Timestamp(new java.util.Date().getTime()));
                        }
                    });

            final List<ResumeEducationInfo> educationInfoList = resume.getResumeEducationList();
            if (!CollectionUtils.isEmpty(educationInfoList)) {
                String edSQL = "insert into tbl_resume_education(resume_id,start,end,school,profession,Background,egree,category)"
                        + " values(?,?,?,?,?,?,?,?)";
                jdbcTemplate.batchUpdate(edSQL, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement pstmt, int j) throws SQLException {
                        ResumeEducationInfo ed = educationInfoList.get(j);
                        int i = 0;
                        pstmt.setString(++i, ed.getResumeId());
                        pstmt.setString(++i, ed.getStart());
                        pstmt.setString(++i, ed.getEnd());
                        pstmt.setString(++i, ed.getSchool());
                        pstmt.setString(++i, ed.getProfession());
                        pstmt.setString(++i, ed.getBackground());
                        pstmt.setString(++i, ed.getEgree());
                        pstmt.setString(++i, ed.getCategory());
                        pstmt.addBatch();
                    }

                    @Override
                    public int getBatchSize() {
                        return educationInfoList.size();
                    }
                });
            }


            final List<ResumeWorkInfo> resumeWorkInfoList = resume.getResumeWorkList();
            if (!CollectionUtils.isEmpty(resumeWorkInfoList)) {
                String wkSQL = "insert into tbl_resume_work(resume_id,start,end,company,station,provePerson,contact,responsibility,leaveReason)" +
                        " values(?,?,?,?,?,?,?,?,?)";
                jdbcTemplate.batchUpdate(wkSQL, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement pstmt, int j) throws SQLException {
                        ResumeWorkInfo wk = resumeWorkInfoList.get(j);
                        int i = 0;
                        pstmt.setString(++i, wk.getResumeId());
                        pstmt.setString(++i, wk.getStart());
                        pstmt.setString(++i, wk.getEnd());
                        pstmt.setString(++i, wk.getCompany());
                        pstmt.setString(++i, wk.getStation());
                        pstmt.setString(++i, wk.getProvePerson());
                        pstmt.setString(++i, wk.getContact());
                        pstmt.setString(++i, wk.getResponsibility());
                        pstmt.setString(++i, wk.getLeaveReason());
                        pstmt.addBatch();
                    }

                    @Override
                    public int getBatchSize() {
                        return resumeWorkInfoList.size();
                    }
                });
            }

            final List<ResumeCertificateInfo> resumeCertificateInfos = resume.getResumeCertificaeList();
            if (!CollectionUtils.isEmpty(resumeCertificateInfos)) {
                String cfSQL = "insert into tbl_resume_certificate(resume_id,cftime,company,name)" +
                        " values(?,?,?,?)";
                jdbcTemplate.batchUpdate(cfSQL, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement pstmt, int j) throws SQLException {
                        ResumeCertificateInfo cf = resumeCertificateInfos.get(j);
                        int i = 0;
                        pstmt.setString(++i, cf.getResumeId());
                        pstmt.setString(++i, cf.getTime());
                        pstmt.setString(++i, cf.getCompany());
                        pstmt.setString(++i, cf.getName());
                        pstmt.addBatch();
                    }

                    @Override
                    public int getBatchSize() {
                        return resumeCertificateInfos.size();
                    }
                });
            }

            final List<ResumeTrainInfo> resumeTrainInfoList = resume.getResumeTrainList();
            if (!CollectionUtils.isEmpty(resumeTrainInfoList)) {
                String trSQL = "insert into tbl_resume_train(resume_id,start,end,company,content)" +
                        " values(?,?,?,?,?)";
                jdbcTemplate.batchUpdate(trSQL, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement pstmt, int j) throws SQLException {
                        ResumeTrainInfo tr = resumeTrainInfoList.get(j);
                        int i = 0;
                        pstmt.setString(++i, tr.getResumeId());
                        pstmt.setString(++i, tr.getStart());
                        pstmt.setString(++i, tr.getEnd());
                        pstmt.setString(++i, tr.getCompany());
                        pstmt.setString(++i, tr.getContent());
                        pstmt.addBatch();
                    }

                    @Override
                    public int getBatchSize() {
                        return resumeTrainInfoList.size();
                    }
                });
            }

            final List<ResumeFamilyInfo> resumeFamilyInfoList = resume.getResumeFamilyList();
            if (!CollectionUtils.isEmpty(resumeFamilyInfoList)) {
                String faSQL = "insert into tbl_resume_family(resume_id,name,relation,company,station)" +
                        " values(?,?,?,?,?)";
                jdbcTemplate.batchUpdate(faSQL, new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement pstmt, int j) throws SQLException {
                        ResumeFamilyInfo fa = resumeFamilyInfoList.get(j);
                        int i = 0;
                        pstmt.setString(++i, fa.getResumeId());
                        pstmt.setString(++i, fa.getName());
                        pstmt.setString(++i, fa.getRelation());
                        pstmt.setString(++i, fa.getCompany());
                        pstmt.setString(++i, fa.getStation());
                        pstmt.addBatch();
                    }

                    @Override
                    public int getBatchSize() {
                        return resumeFamilyInfoList.size();
                    }
                });
            }

            return jobId;
        } catch (Exception e) {
            logger.error("[ResumeDao] #createReturnId# error " + resume, e);
            return null;
        }
    }

    public boolean deleteById(final String resumeId) {
        logger.info("[ResumeDao] #deleteById#" + resumeId);
        try {
            String sqls[] = new String[6];
            sqls[0] = "delete from  tbl_resume_work where resume_id = '" + resumeId + "'";
            sqls[1] = "delete from  tbl_resume_train where resume_id = '" + resumeId + "'";
            sqls[2] = "delete from  tbl_resume_family where resume_id = '" + resumeId + "'";
            sqls[3] = "delete from  tbl_resume_education where resume_id = '" + resumeId + "'";
            sqls[4] = "delete from  tbl_resume_certificate where resume_id = '" + resumeId + "'";
            sqls[5] = "delete from  tbl_resume where resume_id = '" + resumeId + "'";

            int count[] = jdbcTemplate.batchUpdate(sqls);
            return count.length > 0;
        } catch (Exception e) {
            logger.error("[ResumeDao] #deleteById# id=" + resumeId + " error ", e);
        }
        return false;
    }


    //简历--证书
    public List<ResumeCertificateInfo> getCertificateList(final String resumeId) {
        List<ResumeCertificateInfo> list = new ArrayList<ResumeCertificateInfo>();
        String sql = "select * from tbl_resume_certificate where resume_id = ? order by id desc ";
        try {
            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, resumeId);
                        }
                    },
                    new RowMapper<ResumeCertificateInfo>() {
                        @Override
                        public ResumeCertificateInfo mapRow(ResultSet rs, int i) throws SQLException {
                            ResumeCertificateInfo cf = new ResumeCertificateInfo();
                            cf.setResumeId(rs.getString("resume_id"));
                            cf.setId(rs.getInt("id"));
                            cf.setTime(rs.getString("cftime"));
                            cf.setCompany(rs.getString("company"));
                            cf.setName(rs.getString("name"));
                            return cf;
                        }
                    }
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return list;
    }

    //简历--教育
    public List<ResumeEducationInfo> getEducationList(final String resumeId) {
        List<ResumeEducationInfo> list = new ArrayList<ResumeEducationInfo>();
        String sql = "select * from tbl_resume_education where resume_id = ? order by id desc ";
        try {
            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, resumeId);
                        }
                    },
                    new RowMapper<ResumeEducationInfo>() {
                        @Override
                        public ResumeEducationInfo mapRow(ResultSet rs, int i) throws SQLException {
                            ResumeEducationInfo ed = new ResumeEducationInfo();
                            ed.setResumeId(rs.getString("resume_id"));
                            ed.setId(rs.getInt("id"));
                            ed.setStart(rs.getString("start"));
                            ed.setEnd(rs.getString("end"));
                            ed.setSchool(rs.getString("school"));
                            ed.setProfession(rs.getString("profession"));
                            ed.setBackground(rs.getString("Background"));
                            ed.setEgree(rs.getString("egree"));
                            ed.setCategory(rs.getString("category"));
                            return ed;
                        }
                    }
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return list;
    }


    //简历--家庭
    public List<ResumeFamilyInfo> getFamilyList(final String resumeId) {
        List<ResumeFamilyInfo> list = new ArrayList<ResumeFamilyInfo>();
        String sql = "select * from tbl_resume_family where resume_id = ? order by id desc ";
        try {
            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, resumeId);
                        }
                    },
                    new RowMapper<ResumeFamilyInfo>() {
                        @Override
                        public ResumeFamilyInfo mapRow(ResultSet rs, int i) throws SQLException {
                            ResumeFamilyInfo fa = new ResumeFamilyInfo();
                            fa.setResumeId(rs.getString("resume_id"));
                            fa.setId(rs.getInt("id"));
                            fa.setName(rs.getString("name"));
                            fa.setRelation(rs.getString("relation"));
                            fa.setCompany(rs.getString("company"));
                            fa.setStation(rs.getString("station"));
                            return fa;
                        }
                    }
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return list;
    }

    //简历--培训
    public List<ResumeTrainInfo> getTrainList(final String resumeId) {
        List<ResumeTrainInfo> list = new ArrayList<ResumeTrainInfo>();
        String sql = "select * from tbl_resume_train where resume_id = ? order by id desc ";
        try {
            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, resumeId);
                        }
                    },
                    new RowMapper<ResumeTrainInfo>() {
                        @Override
                        public ResumeTrainInfo mapRow(ResultSet rs, int i) throws SQLException {
                            ResumeTrainInfo fa = new ResumeTrainInfo();
                            fa.setResumeId(rs.getString("resume_id"));
                            fa.setId(rs.getInt("id"));
                            fa.setStart(rs.getString("start"));
                            fa.setEnd(rs.getString("end"));
                            fa.setCompany(rs.getString("company"));
                            fa.setContent(rs.getString("content"));
                            return fa;
                        }
                    }
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return list;
    }

    //简历--工作经历
    public List<ResumeWorkInfo> getWorkList(final String resumeId) {
        List<ResumeWorkInfo> list = new ArrayList<ResumeWorkInfo>();
        String sql = "select * from tbl_resume_work where resume_id = ? order by id desc ";
        try {
            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, resumeId);
                        }
                    },
                    new RowMapper<ResumeWorkInfo>() {
                        @Override
                        public ResumeWorkInfo mapRow(ResultSet rs, int i) throws SQLException {
                            ResumeWorkInfo fa = new ResumeWorkInfo();
                            fa.setResumeId(rs.getString("resume_id"));
                            fa.setId(rs.getInt("id"));
                            fa.setStart(rs.getString("start"));
                            fa.setEnd(rs.getString("end"));
                            fa.setCompany(rs.getString("company"));
                            fa.setStation(rs.getString("station"));
                            fa.setProvePerson(rs.getString("provePerson"));
                            fa.setContact(rs.getString("contact"));
                            fa.setResponsibility(rs.getString("responsibility"));
                            fa.setLeaveReason(rs.getString("leaveReason"));
                            return fa;
                        }
                    }
            );
        } catch (DataAccessException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ResumeInfo getResumeById(final String resumeId) {
        List<ResumeInfo> list = new ArrayList<ResumeInfo>();
        try {
            String sql = "select * from tbl_resume where resume_id = ? ";
            list = jdbcTemplate.query(
                    sql,
                    new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedStatement) throws SQLException {
                            preparedStatement.setString(1, resumeId);
                        }
                    },
                    new ResumeInfoRowMapper()
            );
            return CollectionUtils.isEmpty(list) ? null : list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public List<ResumeInfo> getByQuery(final ResumeQuery query) {
        logger.info("[ResumeInfoDao] #getCountByQuery# query=" + query);
        List<ResumeInfo> list = new ArrayList<ResumeInfo>();
        try {
            StringBuffer sql = new StringBuffer("select * from tbl_resume where 1=1 ");

            if (StringUtils.isNotBlank(query.getStartTime()))
                sql.append(" and resume_time >= ? ");
            if (StringUtils.isNotBlank(query.getStartTime()))
                sql.append(" and resume_time <= ? ");

            sql.append(" order by resume_time desc limit ?,? ");

            list = jdbcTemplate.query(sql.toString(),
                        new PreparedStatementSetter() {
                        @Override
                        public void setValues(PreparedStatement preparedstatement)
                                throws SQLException {
                            int i = 0;
                            if (StringUtils.isNotBlank(query.getStartTime()))
                                preparedstatement.setString(++i, query.getStartTime());

                            if (StringUtils.isNotBlank(query.getEndTime()))
                                preparedstatement.setString(++i, query.getEndTime());

                            preparedstatement.setInt(++i,query.getStart());
                            preparedstatement.setInt(++i,query.getNum());

                        }
                    },
                    new ResumeInfoRowMapper());
            return list;
        } catch (Exception e) {
            logger.error("[ResumeInfoDao] #getByQuery# error! query=" + query, e);
        }
        return null;
    }

    public int getCountByQuery(final ResumeQuery query) {
        logger.info("[ResumeInfoDao] #getCountByQuery# query=" + query);
        int count = 0;
        try {
            List<Object> params = new ArrayList<Object>();
            StringBuffer sql = new StringBuffer("select count(1) as total from tbl_resume where 1=1 ");

            if (StringUtils.isNotBlank(query.getStartTime())) {
                sql.append(" and resume_time >= ? ");
                params.add(query.getStartTime());
            }
            if (StringUtils.isNotBlank(query.getEndTime())) {
                sql.append(" and resume_time <= ? ");
                params.add(query.getEndTime());
            }

            count = jdbcTemplate.queryForInt(sql.toString(), params.toArray());
        } catch (Exception e) {
            logger.error("[ResumeInfoDao] #getCountByQuery# error! query=" + query, e);
        }
        return count;
    }

    class ResumeInfoRowMapper implements RowMapper<ResumeInfo> {
        @Override
        public ResumeInfo mapRow(ResultSet rs, int i) throws SQLException {
            ResumeInfo re = new ResumeInfo();
            re.setJobId(rs.getString("job_id_fk"));
            JobInfo jobInfo = jobInfoDao.getById(re.getJobId());
            re.setJobInfo(jobInfo);

            re.setResumeId(rs.getString("resume_id"));
            re.setName(rs.getString("name"));
            re.setBirthday(rs.getString("birthday"));
            re.setGender(rs.getInt("gender"));
            re.setPoliticsStatus(rs.getInt("politicsStatus"));
            re.setNation(rs.getString("nation"));
            re.setMarriageStatus(rs.getInt("marriageStatus"));
            re.setBearStatus(rs.getString("bearStatus"));
            re.setHeight(rs.getInt("height"));
            re.setImage(rs.getString("image"));
            re.setEmail(rs.getString("email"));
            re.setAreaCode(rs.getString("areaCode"));
            re.setTelephone(rs.getString("telephone"));

            re.setPerformance(rs.getString("performance"));
            re.setRewardsPunishment(rs.getString("rewardsPunishment"));
            re.setUnHandleThing(rs.getInt("unHandleThing"));
            re.setCareerPlanning(rs.getString("careerPlanning"));
            re.setPersonalHobbies(rs.getString("personalHobbies"));

            re.setResumeTime(rs.getTimestamp("resume_time"));

            re.setResumeCertificaeList(getCertificateList(re.getResumeId()));
            re.setResumeEducationList(getEducationList(re.getResumeId()));
            re.setResumeFamilyList(getFamilyList(re.getResumeId()));
            re.setResumeTrainList(getTrainList(re.getResumeId()));
            re.setResumeWorkList(getWorkList(re.getResumeId()));

            return re;
        }
    }
}
