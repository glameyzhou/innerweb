/**
 *
 */
package com.glamey.chec_cn.model.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 简历
 *
 * @author zy
 */
public class ResumeInfo implements Serializable {
    private static final long serialVersionUID = 1498860988186815500L;
    private String jobId;
    private JobInfo jobInfo;
    private String resumeId;
    private Date resumeTime;
    /**
     * 姓名
     */
    private String name;
    /**
     * 出生年月日
     */
    private String birthday;
    /**
     * 性别
     * 1=男性
     * 2=女性
     */
    private int gender;
    /**
     * 政治面貌
     * 1=群众
     * 2=党员
     */
    private int politicsStatus;
    /**
     * 民族
     */
    private String nation;
    /**
     * 婚姻状况
     * 1=已婚
     * 0=未婚
     */
    private int marriageStatus;
    /**
     * 生育状况
     */
    private String bearStatus;
    /**
     * 身高CM
     */
    private int height;
    /**
     * 头像
     */
    private String image;
    /**
     * Email
     */
    private String email;
    /**
     * 固话--区号
     */
    private String areaCode;
    /**
     * 固话--号码
     */
    private String telephone;

    /**
     * 教育经历
     */
    private List<ResumeEducationInfo> resumeEducationList;
    /**
     * 工作经历
     */
    private List<ResumeWorkInfo> resumeWorkList;
    /**
     * 证书
     */
    private List<ResumeCertificateInfo> resumeCertificaeList;

    /**
     * 培训
     */
    private List<ResumeTrainInfo> resumeTrainList;

    /**
     * 家庭
     */
    private List<ResumeFamilyInfo> resumeFamilyList;
    /**
     * 工作业绩
     */
    private String performance;

    /**
     * 奖惩
     */
    private String rewardsPunishment;

    /**
     * 未处理事项表
     * 1=劳动合同
     * 2=保密协议
     * 3=培训费用补偿
     */
    private int unHandleThing;
    /**
     * 职业规划
     */
    private String careerPlanning;
    /**
     * 个人爱好
     */
    private String personalHobbies;

    public JobInfo getJobInfo() {
        return jobInfo;
    }

    public void setJobInfo(JobInfo jobInfo) {
        this.jobInfo = jobInfo;
    }

    public String getJobId() {
        return jobId;
    }

    public void setJobId(String jobId) {
        this.jobId = jobId;
    }

    public String getResumeId() {
        return resumeId;
    }

    public void setResumeId(String resumeId) {
        this.resumeId = resumeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public int getPoliticsStatus() {
        return politicsStatus;
    }

    public void setPoliticsStatus(int politicsStatus) {
        this.politicsStatus = politicsStatus;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public int getMarriageStatus() {
        return marriageStatus;
    }

    public void setMarriageStatus(int marriageStatus) {
        this.marriageStatus = marriageStatus;
    }

    public String getBearStatus() {
        return bearStatus;
    }

    public void setBearStatus(String bearStatus) {
        this.bearStatus = bearStatus;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public List<ResumeEducationInfo> getResumeEducationList() {
        return resumeEducationList;
    }

    public void setResumeEducationList(List<ResumeEducationInfo> resumeEducationList) {
        this.resumeEducationList = resumeEducationList;
    }

    public List<ResumeWorkInfo> getResumeWorkList() {
        return resumeWorkList;
    }

    public void setResumeWorkList(List<ResumeWorkInfo> resumeWorkList) {
        this.resumeWorkList = resumeWorkList;
    }

    public List<ResumeCertificateInfo> getResumeCertificaeList() {
        return resumeCertificaeList;
    }

    public void setResumeCertificaeList(
            List<ResumeCertificateInfo> resumeCertificaeList) {
        this.resumeCertificaeList = resumeCertificaeList;
    }

    public List<ResumeTrainInfo> getResumeTrainList() {
        return resumeTrainList;
    }

    public void setResumeTrainList(List<ResumeTrainInfo> resumeTrainList) {
        this.resumeTrainList = resumeTrainList;
    }

    public List<ResumeFamilyInfo> getResumeFamilyList() {
        return resumeFamilyList;
    }

    public void setResumeFamilyList(List<ResumeFamilyInfo> resumeFamilyList) {
        this.resumeFamilyList = resumeFamilyList;
    }

    public String getPerformance() {
        return performance;
    }

    public void setPerformance(String performance) {
        this.performance = performance;
    }

    public String getRewardsPunishment() {
        return rewardsPunishment;
    }

    public void setRewardsPunishment(String rewardsPunishment) {
        this.rewardsPunishment = rewardsPunishment;
    }

    public int getUnHandleThing() {
        return unHandleThing;
    }

    public void setUnHandleThing(int unHandleThing) {
        this.unHandleThing = unHandleThing;
    }

    public String getCareerPlanning() {
        return careerPlanning;
    }

    public void setCareerPlanning(String careerPlanning) {
        this.careerPlanning = careerPlanning;
    }

    public String getPersonalHobbies() {
        return personalHobbies;
    }

    public void setPersonalHobbies(String personalHobbies) {
        this.personalHobbies = personalHobbies;
    }

    public Date getResumeTime() {
        return resumeTime;
    }

    public void setResumeTime(Date resumeTime) {
        this.resumeTime = resumeTime;
    }
}
