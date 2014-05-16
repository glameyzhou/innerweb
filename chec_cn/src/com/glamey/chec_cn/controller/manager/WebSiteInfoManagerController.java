package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.ContentInfoDao;
import com.glamey.chec_cn.dao.MsgInfoDao;
import com.glamey.chec_cn.dao.UserInfoDao;
import com.glamey.chec_cn.dao.WebsiteInfoDao;
import com.glamey.chec_cn.model.domain.ContentInfo;
import com.glamey.chec_cn.model.domain.UserInfo;
import com.glamey.chec_cn.model.domain.WebsiteInfo;
import com.glamey.chec_cn.model.dto.UserQuery;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by zy
 */
@Controller
@RequestMapping(value = "/mg/websiteInfo")
public class WebSiteInfoManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(WebSiteInfoManagerController.class);
    @Autowired
    private WebsiteInfoDao websiteInfoDao;
    @Autowired
    private ContentInfoDao contentInfoDao;
    @Autowired
    private MsgInfoDao msgInfoDao;
    @Autowired
    private UserInfoDao userInfoDao;


    /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++[站点信息管理--开始]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
    //站点管理--列举所有的栏目
    @RequestMapping(value = "/website/list.do", method = RequestMethod.GET)
    public ModelAndView navigateList(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("mg/websiteInfo/website-list");
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);
        List<WebsiteInfo> websiteList = websiteInfoDao.getSubList(new WebsiteInfo(null), pageBean.getStart(), pageBean.getRowsPerPage());
        pageBean.setMaxRowCount(this.websiteInfoDao.getCount(new WebsiteInfo(null)));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("websiteList", websiteList);
        mav.addObject("pageBean", pageBean);
        return mav;
    }

    //站点管理--站点新增、修改页面
    @RequestMapping(value = "/website/show.do")
    public ModelAndView websiteShow(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("mg/websiteInfo/website-show");
        int websiteId = WebUtils.getRequestParameterAsInt(request, "websiteId", 0);
        WebsiteInfo website = new WebsiteInfo();
        String opt = "create";
        if (websiteId > 0) {
            website = websiteInfoDao.getWebsite(websiteId);
            opt = "update";
        }
        mav.addObject("website", website);
        mav.addObject("opt", opt);
        return mav;
    }

    //站点管理--站点更新
    @RequestMapping(value = "/website/update.do", method = RequestMethod.POST)
    public ModelAndView navigateUpdate(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");
        String message;
        int id = WebUtils.getRequestParameterAsInt(request, "id", 0);
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String desc = WebUtils.getRequestParameterAsString(request, "desc");
        String sign = WebUtils.getRequestParameterAsString(request, "sign");
        WebsiteInfo website = this.websiteInfoDao.getWebsite(id);
        website.setName(name);
        website.setDesc(desc);
        website.setSign(sign);

        if (websiteInfoDao.update(website)) {
            message = "分站信息更新完毕,请进行分站信息同步!";
        } else {
            message = "分站信息更新失败!";
        }
        mav.addObject("message", message);
        return mav;
    }
    /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++[站点信息管理--结束]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/


    /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++[消息管理--开始]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
    //内容管理--内容--列举所有
    @RequestMapping(value = "/content/list.do")
    public ModelAndView contentList(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("mg/websiteInfo/content-list");
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        String kw = WebUtils.getRequestParameterAsString(request, "kw");
        kw = StringTools.converISO2UTF8(kw);
        int websiteId = WebUtils.getRequestParameterAsInt(request, "websiteId", 0);
        int userId = WebUtils.getRequestParameterAsInt(request, "userId", 0);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);
        ContentInfo query = new ContentInfo();
        query.setKw(kw);
        query.setWebsiteId(websiteId);
        query.setUserId(userId);
        List<ContentInfo> contentInfoList = contentInfoDao.getSubList(query, pageBean.getStart(), pageBean.getRowsPerPage());
        pageBean.setMaxRowCount(contentInfoDao.getCount(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        UserQuery userQuery = new UserQuery();
        userQuery.setIsLive(1);
        userQuery.setStart(0);
        userQuery.setNum(Integer.MAX_VALUE);
        List<UserInfo> userInfoList = userInfoDao.getUserList(userQuery);
        List<WebsiteInfo> websiteInfoList = websiteInfoDao.getSubList(new WebsiteInfo(), 0, Integer.MAX_VALUE);
        mav.addObject("contentInfoList", contentInfoList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("content", query);
        mav.addObject("userInfoList", userInfoList);
        mav.addObject("websiteInfoList", websiteInfoList);
        return mav;

    }

    //内容管理--内容新增、修改页面
    @RequestMapping(value = "/content/show.do")
    public ModelAndView contentShow(HttpServletRequest request, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("mg/websiteInfo/content-show");
        ContentInfo content = new ContentInfo();
        content.setPublishTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
        String contentId = WebUtils.getRequestParameterAsString(request, "contentId");
        String opt = "create";
        if (StringUtils.isNotBlank(contentId)) {
            content = contentInfoDao.getContentById(contentId);
            opt = "update";
        }
        List<WebsiteInfo> websiteInfoList = websiteInfoDao.getSubList(new WebsiteInfo(), 0, Integer.MAX_VALUE);
        UserQuery userQuery = new UserQuery();
        userQuery.setIsLive(1);
        userQuery.setStart(0);
        userQuery.setNum(Integer.MAX_VALUE);
        List<UserInfo> userInfoList = userInfoDao.getUserList(userQuery);
        mav.addObject("opt", opt);
        mav.addObject("content", content);
        mav.addObject("websiteInfoList", websiteInfoList);
        mav.addObject("userInfoList", userInfoList);
        mav.addObject("userId", ((UserInfo) session.getAttribute(Constants.SESSIN_USERID)).getUserId());
        return mav;
    }

    //内容管理--内容新增
    @RequestMapping(value = "/content/create.do")
    public ModelAndView contentCreate(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("common/message");
        String message = "";

        String contentId = StringTools.getUUID();
        String title = WebUtils.getRequestParameterAsString(request, "title");
        int websiteId = 0;
        List<WebsiteInfo> websiteInfoList = websiteInfoDao.getSubList(new WebsiteInfo(), 0, Integer.MAX_VALUE);
        for (WebsiteInfo website : websiteInfoList) {
            if (website.getIsSelf() == 1) {
                websiteId = website.getId();
            }
        }
        String text = WebUtils.getRequestParameterAsString(request, "text");
        String publishTime = WebUtils.getRequestParameterAsString(request, "publishTime");
        int userId = WebUtils.getRequestParameterAsInt(request, "userId", 0);

        if (StringUtils.isBlank(text)) {
            mav.addObject("message", "内容不能为空!");
            return mav;
        }

        ContentInfo content = new ContentInfo();
        content.setContentId(contentId);
        content.setTitle(title);
        content.setWebsiteId(websiteId);
        content.setText(text);
        content.setPublishTime(publishTime);
        content.setUserId(userId);
        boolean flag = contentInfoDao.insert(content);
        if (flag)
            message = "信息添加完毕!";
        else {
            message = "信息添加失败!";
        }
        mav.addObject("message", message);
        return mav;
    }

    //内容管理--内容修改
    @RequestMapping(value = "/content/update.do")
    public ModelAndView contentUpdate(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");
        String message = "";
        String contentId = WebUtils.getRequestParameterAsString(request, "contentId");
        String title = WebUtils.getRequestParameterAsString(request, "title");
        int websiteId = 0;
        List<WebsiteInfo> websiteInfoList = websiteInfoDao.getSubList(new WebsiteInfo(), 0, Integer.MAX_VALUE);
        for (WebsiteInfo website : websiteInfoList) {
            if (website.getIsSelf() == 1) {
                websiteId = website.getId();
            }
        }
        String text = WebUtils.getRequestParameterAsString(request, "text");
        String publishTime = WebUtils.getRequestParameterAsString(request, "publishTime");
        int userId = WebUtils.getRequestParameterAsInt(request, "userId", 0);

        if (StringUtils.isBlank(text)) {
            mav.addObject("message", "内容不能为空!");
            return mav;
        }

        ContentInfo content = contentInfoDao.getContentById(contentId);
        content.setTitle(title);
        content.setWebsiteId(websiteId);
        content.setText(text);
        content.setPublishTime(publishTime);
        content.setUserId(userId);

        boolean flag = contentInfoDao.update(content);
        if (flag)
            message = "信息更新完毕!";
        else {
            message = "信息更新失败!";
        }
        mav.addObject("message", message);
        return mav;
    }

    //内容管理--内容删除
    @RequestMapping(value = "/content/del.do")
    public ModelAndView contentDel(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");
        String message = "内容删除成功!";
        String contentIds = WebUtils.getRequestParameterAsString(request, "contentId");
        String[] idArr = StringUtils.split(contentIds, ",");
        try {
            for (String contentId : idArr) {
                contentInfoDao.del(contentId);
            }
            message = "信息删除完毕!";
        } catch (Exception e) {
            message = "信息删除失败!";
            logger.error("信息删除失败! ids=" + contentIds, e);
        }
        mav.addObject("message", message);
        return mav;
    }

    @RequestMapping(value = "/content/showSynch.do")
    public ModelAndView showContentSynch(HttpServletRequest request)throws Exception {
        ModelAndView mav = new ModelAndView("mg/websiteInfo/content-show-synch");
        String contentIds = WebUtils.getRequestParameterAsString(request, "contentId");
        if (StringUtils.isBlank(contentIds)) {
            mav.addObject("message", "请选择要同步的文章!");
            mav.setViewName("common/message");
            return mav;
        }
        List<ContentInfo> contentInfoList = new ArrayList<ContentInfo>();
        String[] ids = contentIds.split(",");
        ContentInfo content = null;
        for (String contentId : ids) {
            content = contentInfoDao.getContentById(contentId);
            contentInfoList.add(content);
        }
        List<WebsiteInfo> websiteInfoList = websiteInfoDao.getSubList(new WebsiteInfo(), 0, Integer.MAX_VALUE);
        mav.addObject("websiteInfoList", websiteInfoList);
        mav.addObject("contentInfoList", contentInfoList);
        return mav;
    }
    /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++[消息管理--结束]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
}
