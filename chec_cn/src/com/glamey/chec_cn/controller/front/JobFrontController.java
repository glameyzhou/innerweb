package com.glamey.chec_cn.controller.front;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.JobInfoDao;
import com.glamey.chec_cn.dao.PostDao;
import com.glamey.chec_cn.dao.ResumeDao;
import com.glamey.chec_cn.model.domain.*;
import com.glamey.chec_cn.model.dto.JobInfoQuery;
import com.glamey.chec_cn.util.UploadType;
import com.glamey.chec_cn.util.WebUploadUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by zy
 */
@Controller
public class JobFrontController extends BaseController {

    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private JobInfoDao jobInfoDao;
    @Autowired
    private ResumeDao resumeDao;
    @Autowired
    private WebUploadUtils uploadUtils;

    @RequestMapping(value = "/jobs.htm", method = RequestMethod.GET)
    public ModelAndView jobList(HttpServletRequest request, HttpSession session,ModelMap modelMap) {
        ModelAndView mav = new ModelAndView("front/hr/jobs");
        mav.addAllObjects(includeHr(modelMap));

        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean(Constants.rowsPerPageFront);
        pageBean.setCurPage(curPage);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        JobInfoQuery query = new JobInfoQuery();
        query.setCategoryId(categoryId);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<JobInfo> jobList = jobInfoDao.getByQuery(query);
        pageBean.setMaxRowCount(jobInfoDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("jobList", jobList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        return mav;
    }

    @RequestMapping(value = "/jobs-{jobId}.htm", method = RequestMethod.GET)
    public ModelAndView jobDetail(
            @PathVariable String jobId,
            HttpServletRequest request, HttpServletResponse response,ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("front/hr/jobs-detail");
        mav.addAllObjects(includeHr(modelMap));
        if (StringUtils.isBlank(jobId)) {
            return pageNotFound(request, response);
        }

        JobInfo jobInfo = jobInfoDao.getById(jobId);
        mav.addObject("jobInfo", jobInfo);
        return mav;
    }

    @RequestMapping(value = "/jobs-apply-{jobId}.htm", method = RequestMethod.GET)
    public ModelAndView jobApplyShow(
            @PathVariable String jobId,
            HttpServletRequest request, HttpServletResponse response,ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("front/hr/jobs-apply-show");
        mav.addAllObjects(includeHr(modelMap));

        if (StringUtils.isBlank(jobId)) {
            return pageNotFound(request, response);
        }

        JobInfo jobInfo = jobInfoDao.getById(jobId);

        mav.addObject("jobInfo", jobInfo);
        return mav;
    }

    @RequestMapping(value = "/jobs-doapply-{jobId}.htm", method = RequestMethod.POST)
    public ModelAndView jobApplyManager(
            @PathVariable String jobId,
            HttpServletRequest request, HttpServletResponse response,ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("front/hr/jobs-apply-result");
        mav.addAllObjects(includeHr(modelMap));
        if (StringUtils.isBlank(jobId)) {
            return pageNotFound(request, response);
        }

        StringBuffer message = new StringBuffer();
        message.append("<br/>");
        boolean result = false;

        ResumeInfo resume = new ResumeInfo();

        // TODO 图片上传
        UploadInfo ui = uploadUtils.doUpload(request, response, UploadType.IMAGE,"image");
        if (StringUtils.isNotBlank(ui.getFilePath()))
            resume.setImage(ui.getFilePath());

        String resumeId = UUID.randomUUID().toString().replaceAll("-", "");
        String name = WebUtils.getRequestParameterAsStringEscape(request, "name");
        if (StringUtils.isBlank(name)) {
            message.append("姓名不能为空.<br/>");
        }
        String birthday = WebUtils.getRequestParameterAsStringEscape(request, "birthday");
        if (StringUtils.isBlank(birthday)) {
            message.append("出生日期不能为空.<br/>");
        }
        String gender = WebUtils.getRequestParameterAsStringEscape(request, "gender");
        if (StringUtils.isBlank(gender)) {
            message.append("性别不能为空.<br/>");
        }
        gender = StringUtils.isNotBlank(gender) ? gender : "1";
        String politicsStatus = WebUtils.getRequestParameterAsStringEscape(request, "politicsStatus");
        if (StringUtils.isBlank(politicsStatus)) {
            message.append("政治面貌不能为空.<br/>");
        }
        politicsStatus = StringUtils.isNotBlank(politicsStatus) ? politicsStatus : "1";
        String nation = WebUtils.getRequestParameterAsStringEscape(request, "nation");
        if (StringUtils.isBlank(nation)) {
            message.append("民族不能为空.<br/>");
        }
        String marriageStatus = WebUtils.getRequestParameterAsStringEscape(request, "marriageStatus");
        if (StringUtils.isBlank(marriageStatus)) {
            message.append("婚姻状况不能为空.<br/>");
        }
        marriageStatus = StringUtils.isNotBlank(marriageStatus) ? marriageStatus : "0";
        String bearStatus = WebUtils.getRequestParameterAsStringEscape(request, "bearStatus");
        if (StringUtils.isBlank(bearStatus)) {
            message.append("生育状况不能为空.<br/>");
        }
        String height = WebUtils.getRequestParameterAsStringEscape(request, "height");
        height = StringUtils.isNotBlank(height) ? height : "0";
        String email = WebUtils.getRequestParameterAsStringEscape(request, "email");
        if (StringUtils.isBlank(email)) {
            message.append("电子 邮箱不能为空.<br/>");
        }
        String areaCode = WebUtils.getRequestParameterAsStringEscape(request, "areaCode");
        String telephone = WebUtils.getRequestParameterAsStringEscape(request, "telephone");
        if (StringUtils.isBlank(bearStatus)) {
            message.append("固定电话不能为空.<br/>");
        }

        resume.setJobId(jobId);
        resume.setResumeId(resumeId);
        resume.setName(name);
        resume.setBirthday(birthday);
        resume.setGender(Integer.parseInt(gender));
        resume.setPoliticsStatus(Integer.parseInt(politicsStatus));
        resume.setNation(nation);
        resume.setMarriageStatus(Integer.parseInt(marriageStatus));
        resume.setBearStatus(bearStatus);
        resume.setHeight(!height.matches("\\d+") ? 0 : Integer.parseInt(height));
        resume.setEmail(email);
        resume.setAreaCode(areaCode);
        resume.setTelephone(telephone);


        //教育经历
        String edStarts[] = request.getParameterValues("edStart");
        String edEnds[] = request.getParameterValues("edEnd");
        String edSchools[] = request.getParameterValues("edSchool");
        String edProfessions[] = request.getParameterValues("edProfession");
        String edBackgrounds[] = request.getParameterValues("edBackground");
        String edEgrees[] = request.getParameterValues("edEgree");
        String edCategorys[] = request.getParameterValues("edCategory");
        int edLen = edStarts != null ? edStarts.length : 0;
        List<ResumeEducationInfo> edList = new ArrayList<ResumeEducationInfo>();
        for (int i = 0; i < edLen; i++) {
            ResumeEducationInfo ed = new ResumeEducationInfo();
            if (StringUtils.isNotBlank(edStarts[i]) || StringUtils.isNotBlank(edEnds[i]) || StringUtils.isNotBlank(edSchools[i])
                    || StringUtils.isNotBlank(edProfessions[i]) || StringUtils.isNotBlank(edBackgrounds[i]) || StringUtils.isNotBlank(edEgrees[i])
                    || StringUtils.isNotBlank(edCategorys[i])) {

                ed.setStart(edStarts[i]);
                ed.setEnd(edEnds[i]);
                ed.setSchool(edSchools[i]);
                ed.setProfession(edProfessions[i]);
                ed.setBackground(edBackgrounds[i]);
                ed.setEgree(edEgrees[i]);
                ed.setCategory(edCategorys[i]);
                ed.setResumeId(resumeId);
                edList.add(ed);
            }
        }
        resume.setResumeEducationList(edList);

        if (edList == null || edList.size() == 0) {
            message.append("教育经历不能为空.<br/>");
        }

        //工作经历
        String wkStarts[] = request.getParameterValues("wkStart");
        String wkEnds[] = request.getParameterValues("wkEnd");
        String wkCompanys[] = request.getParameterValues("wkCompany");
        String wkStations[] = request.getParameterValues("wkStation");
        String wkProvePersons[] = request.getParameterValues("wkProvePerson");
        String wkContacts[] = request.getParameterValues("wkContact");
        String wkResponsibilitys[] = request.getParameterValues("wkResponsibility");
        String wkLeaveReasons[] = request.getParameterValues("wkLeaveReason");

        int wkLen = wkStarts != null ? wkStarts.length : 0;
        List<ResumeWorkInfo> wkList = new ArrayList<ResumeWorkInfo>();
        for (int i = 0; i < wkLen; i++) {
            ResumeWorkInfo wk = new ResumeWorkInfo();
            if (StringUtils.isNotBlank(wkStarts[i]) || StringUtils.isNotBlank(wkEnds[i]) || StringUtils.isNotBlank(wkCompanys[i])
                    || StringUtils.isNotBlank(wkStations[i]) || StringUtils.isNotBlank(wkProvePersons[i]) || StringUtils.isNotBlank(wkContacts[i])
                    || StringUtils.isNotBlank(wkResponsibilitys[i]) || StringUtils.isNotBlank(wkLeaveReasons[i])) {

                wk.setStart(wkStarts[i]);
                wk.setEnd(wkEnds[i]);
                wk.setCompany(wkCompanys[i]);
                wk.setStation(wkStations[i]);
                wk.setProvePerson(wkProvePersons[i]);
                wk.setContact(wkContacts[i]);
                wk.setResponsibility(wkResponsibilitys[i]);
                wk.setLeaveReason(wkLeaveReasons[i]);
                wk.setResumeId(resumeId);
                wkList.add(wk);
            }
        }
        resume.setResumeWorkList(wkList);
        if (wkList == null || wkList.size() == 0) {
            message.append("工作经历不能为空.<br/>");
        }
        //证书
        String cfTimes[] = request.getParameterValues("cfTime");
        String cfCompanys[] = request.getParameterValues("cfCompany");
        String cfNames[] = request.getParameterValues("cfName");

        int cfLen = cfTimes != null ? cfTimes.length : 0;
        List<ResumeCertificateInfo> cfList = new ArrayList<ResumeCertificateInfo>();
        for (int i = 0; i < cfLen; i++) {
            ResumeCertificateInfo cf = new ResumeCertificateInfo();
            if (StringUtils.isNotBlank(cfTimes[i]) || StringUtils.isNotBlank(cfCompanys[i]) || StringUtils.isNotBlank(cfNames[i])) {
                cf.setTime(cfTimes[i]);
                cf.setCompany(cfCompanys[i]);
                cf.setName(cfNames[i]);
                cf.setResumeId(resumeId);
                cfList.add(cf);
            }
        }
        resume.setResumeCertificaeList(cfList);

        //培训机构
        String trStarts[] = request.getParameterValues("trStart");
        String trEnds[] = request.getParameterValues("trEnd");
        String trCompanys[] = request.getParameterValues("trCompany");
        String trContents[] = request.getParameterValues("trContent");

        int trLen = trStarts != null ? trStarts.length : 0;
        List<ResumeTrainInfo> trList = new ArrayList<ResumeTrainInfo>();
        for (int i = 0; i < trLen; i++) {
            ResumeTrainInfo tr = new ResumeTrainInfo();
            if (StringUtils.isNotBlank(trStarts[i]) || StringUtils.isNotBlank(trEnds[i])
                    || StringUtils.isNotBlank(trCompanys[i]) || StringUtils.isNotBlank(trContents[i])) {
                tr.setStart(trStarts[i]);
                tr.setEnd(trEnds[i]);
                tr.setCompany(trCompanys[i]);
                tr.setContent(trContents[i]);
                tr.setResumeId(resumeId);
                trList.add(tr);
            }
        }
        resume.setResumeTrainList(trList);

        //家庭情况
        String faNames[] = request.getParameterValues("faName");
        String faRelations[] = request.getParameterValues("faRelation");
        String faCompanys[] = request.getParameterValues("faCompany");
        String faStations[] = request.getParameterValues("faStation");

        int faLen = faNames != null ? faNames.length : 0;
        List<ResumeFamilyInfo> faList = new ArrayList<ResumeFamilyInfo>();
        for (int i = 0; i < faLen; i++) {
            ResumeFamilyInfo fa = new ResumeFamilyInfo();
            if (StringUtils.isNotBlank(faNames[i]) || StringUtils.isNotBlank(faRelations[i])
                    || StringUtils.isNotBlank(faCompanys[i]) || StringUtils.isNotBlank(faStations[i])) {
                fa.setName(faNames[i]);
                fa.setRelation(faRelations[i]);
                fa.setCompany(faCompanys[i]);
                fa.setStation(faStations[i]);
                fa.setResumeId(resumeId);
                faList.add(fa);
            }
        }
        resume.setResumeFamilyList(faList);

        //业绩
        String performance = WebUtils.getRequestParameterAsStringEscape(request, "performance");
        //奖罚经历
        String rewardsPunishment = WebUtils.getRequestParameterAsStringEscape(request, "rewardsPunishment");
        //未处理事项
        String unHandleThing = WebUtils.getRequestParameterAsStringEscape(request, "unHandleThing");
        //职业生涯规划
        String careerPlanning = WebUtils.getRequestParameterAsStringEscape(request, "careerPlanning");
        //个人简介
        String personalHobbies = WebUtils.getRequestParameterAsStringEscape(request, "personalHobbies");

        resume.setPerformance(performance);
        resume.setRewardsPunishment(rewardsPunishment);
        resume.setUnHandleThing(StringUtils.isNotBlank(unHandleThing) ? Integer.parseInt(unHandleThing) : 0);
        resume.setCareerPlanning(careerPlanning);
        resume.setPersonalHobbies(personalHobbies);


        if (message.length() > 5) {
            mav.addObject("resumeResult", message);
            return mav;
        }

        String createId = resumeDao.createReturnId(resume);
        mav.addObject("createId", createId);
        return mav;
    }

    private ModelMap includeHr(ModelMap modelMap){
        Category rootCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_HR);
        List<Category> categoryList = categoryDao.getByParentId(1, rootCategory.getId(), rootCategory.getCategoryType(), 0, Integer.MAX_VALUE);

        Category rootDept = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        List<Category> deptList = categoryDao.getByParentId(rootDept.getId(), CategoryConstants.CATEGORY_DEPT, 0, Integer.MAX_VALUE);

        modelMap.put("rootCategory",rootCategory);
        modelMap.put("categoryList",categoryList);
        modelMap.put("deptList",deptList);

        return modelMap;
    }

}
