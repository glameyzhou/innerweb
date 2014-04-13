package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.JobInfoDao;
import com.glamey.chec_cn.dao.PostDao;
import com.glamey.chec_cn.dao.ResumeDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.JobInfo;
import com.glamey.chec_cn.model.domain.ResumeInfo;
import com.glamey.chec_cn.model.domain.UserInfo;
import com.glamey.chec_cn.model.dto.JobInfoQuery;
import com.glamey.chec_cn.model.dto.ResumeQuery;
import com.glamey.chec_cn.util.DateUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/mg/job")
public class JobInfoManagerContoller extends BaseController {
    public static final Logger logger = Logger.getLogger(JobInfoManagerContoller.class);

    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private JobInfoDao jobInfoDao;
    @Autowired
    private ResumeDao resumeDao;

    @RequestMapping(value = "/job-list.do", method = RequestMethod.GET)
    public ModelAndView jobList(HttpServletRequest request, HttpSession session) {
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        ModelAndView mav = new ModelAndView();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean(2);
        pageBean.setCurPage(curPage);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String keyword = WebUtils.getRequestParameterAsString(request, "kw");
        keyword = StringTools.converISO2UTF8(keyword);
        JobInfoQuery query = new JobInfoQuery();
        query.setKw(keyword);
        query.setPublishStartTime(WebUtils.getRequestParameterAsString(request, "startTime"));
        query.setPublishEndTime(WebUtils.getRequestParameterAsString(request, "endTime"));
        query.setCategoryId(categoryId);

        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<JobInfo> jobList = jobInfoDao.getByQuery(query);
        pageBean.setMaxRowCount(jobInfoDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        Category rootDept = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        List<Category> deptList = categoryDao.getByParentId(rootDept.getId(), CategoryConstants.CATEGORY_DEPT, 0, Integer.MAX_VALUE);

        mav.addObject("jobList", jobList);
        mav.addObject("deptList", deptList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.setViewName("mg/job/job-list");
        return mav;
    }

    @RequestMapping(value = "/job-show.do", method = RequestMethod.GET)
    public ModelAndView jobShow(HttpServletRequest request, HttpSession session) {
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        ModelAndView mav = new ModelAndView("mg/job/job-show");
        Category rootDept = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        List<Category> deptList = categoryDao.getByParentId(rootDept.getId(), CategoryConstants.CATEGORY_DEPT, 0, Integer.MAX_VALUE);

        String opt = "create";
        JobInfo job = new JobInfo();
        job.setPublishTime(new Date());
        String jobId = WebUtils.getRequestParameterAsString(request, "jobId");
        if (StringUtils.isNotBlank(jobId)) {
            job = jobInfoDao.getById(jobId);
            opt = "update";
        }
        mav.addObject("opt", opt);
        mav.addObject("job", job);
        mav.addObject("deptList", deptList);
        return mav;
    }

    @RequestMapping(value = "/job-create.do", method = RequestMethod.POST)
    public ModelAndView jobCreate(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        JobInfo job = new JobInfo();
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String title = WebUtils.getRequestParameterAsString(request, "title");
        int person = WebUtils.getRequestParameterAsInt(request, "person", 1);
        String address = WebUtils.getRequestParameterAsString(request, "address");
        String contact = WebUtils.getRequestParameterAsString(request, "contact");
        String responsibility = WebUtils.getRequestParameterAsString(request, "responsibility");
        String requirement = WebUtils.getRequestParameterAsString(request, "requirement");
        String publishTime = WebUtils.getRequestParameterAsString(request, "publishTime");

        job.setCategoryId(categoryId);
        job.setTitle(title);
        job.setPerson(person);
        job.setAddress(address);
        job.setContact(contact);
        job.setResponsibility(responsibility);
        job.setRequirement(requirement);
        job.setPublishTime(StringUtils.isNotBlank(publishTime) ? new Date() : DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));

        String returnId = jobInfoDao.createReturnId(job);
        if (StringUtils.isBlank(returnId)) {
            message = "招聘岗位创建失败,请稍后重试!";
        } else {
            message = "招聘岗位创建成功";
            mav.addObject("href", "mg/job/job-list.do");
        }
        mav.addObject("message", message);
        return mav;
    }

    @RequestMapping(value = "/job-update.do", method = RequestMethod.POST)
    public ModelAndView jobUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        JobInfo job;
        String jobId = WebUtils.getRequestParameterAsString(request, "jobId");
        if (StringUtils.isBlank(jobId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        job = jobInfoDao.getById(jobId);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String title = WebUtils.getRequestParameterAsString(request, "title");
        int person = WebUtils.getRequestParameterAsInt(request, "person", 1);
        String address = WebUtils.getRequestParameterAsString(request, "address");
        String contact = WebUtils.getRequestParameterAsString(request, "contact");
        String responsibility = WebUtils.getRequestParameterAsString(request, "responsibility");
        String requirement = WebUtils.getRequestParameterAsString(request, "requirement");
        String publishTime = WebUtils.getRequestParameterAsString(request, "publishTime");

        job.setCategoryId(categoryId);
        job.setTitle(title);
        job.setPerson(person);
        job.setAddress(address);
        job.setContact(contact);
        job.setResponsibility(responsibility);
        job.setRequirement(requirement);
        job.setPublishTime(StringUtils.isNotBlank(publishTime) ? new Date() : DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));

        if (!jobInfoDao.update(job)) {
            message = "招聘岗位更新失败,请稍后重试!";
        } else {
            message = "招聘岗位更新成功";
            mav.addObject("href", "mg/job/job-list.do");
        }
        mav.addObject("message", message);
        return mav;
    }

    @RequestMapping(value = "/job-del.do", method = RequestMethod.POST)
    public ModelAndView jobDel(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        JobInfo job;
        String jobId = WebUtils.getRequestParameterAsString(request, "jobId");
        if (StringUtils.isBlank(jobId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        boolean result = false;
        try {
            String jobIds[] = StringUtils.split(jobId, ",");
            for (String id : jobIds) {
                jobInfoDao.deleteById(id);
            }
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!result) {
            message = "招聘岗位删除失败,请稍后重试!";
        } else {
            message = "招聘岗位删除成功";
            mav.addObject("href", "mg/job/job-list.do");
        }
        mav.addObject("message", message);
        return mav;
    }


    /***********************************************************简历管理*************************************************************************/
    @RequestMapping(value = "/resume-list.do", method = RequestMethod.GET)
    public ModelAndView resumeList(HttpServletRequest request, HttpSession session) {
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        ModelAndView mav = new ModelAndView();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean(2);
        pageBean.setCurPage(curPage);
        String keyword = WebUtils.getRequestParameterAsString(request, "kw");
        keyword = StringTools.converISO2UTF8(keyword);
        ResumeQuery query = new ResumeQuery();
        query.setKw(keyword);
        query.setStartTime(WebUtils.getRequestParameterAsString(request, "startTime"));
        query.setEndTime(WebUtils.getRequestParameterAsString(request, "endTime"));

        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<ResumeInfo> resumeInfoList = resumeDao.getByQuery(query);
        pageBean.setMaxRowCount(resumeDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("resumeInfoList", resumeInfoList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.setViewName("mg/job/resume-list");
        return mav;
    }


    @RequestMapping(value = "/resume-del.do", method = RequestMethod.POST)
    public ModelAndView resumeDel(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String resumeId = WebUtils.getRequestParameterAsString(request, "resumeId");
        if (StringUtils.isBlank(resumeId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        boolean result = false;
        try {
            String ids[] = StringUtils.split(resumeId, ",");
            for (String id : ids) {
                resumeDao.deleteById(id);
            }
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!result) {
            message = "简历删除失败,请稍后重试!";
        } else {
            message = "招聘岗位删除成功";
            mav.addObject("href", "mg/job/resume-list.do");
        }
        mav.addObject("message", message);
        return mav;
    }

    //简历--预览
    @RequestMapping(value = "/resume-preview.do")
    public ModelAndView resumePreview(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("mg/job/resume-preview");
        String resumeId = WebUtils.getRequestParameterAsString(request, "resumeId", "0");
        ResumeInfo resume = resumeDao.getResumeById(resumeId);
        mav.addObject("resume",resume);
        return mav;
    }
}
