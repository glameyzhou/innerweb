/**
 *
 */
package com.glamey.innerweb.controller.manager;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.dao.UserInfoDao;
import com.glamey.innerweb.model.domain.RoleInfo;
import com.glamey.innerweb.model.domain.UserInfo;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.model.domain.Category;

/**
 * 后台管理系统--首页内容
 *
 * @author zy
 */
@Controller
@RequestMapping(value = "/mg")
public class HomeManagerController extends BaseController {

    @Autowired
    private CategoryDao categoryDao ;
    @Resource
    private UserInfoDao userInfoDao;
    /**
     * 后台管理系统首页
     */
    @RequestMapping(value = "/home.htm", method = RequestMethod.GET)
    public ModelAndView managerHome(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
    	String opt = WebUtils.getRequestParameterAsString(request, "opt");
    	ModelAndView mav = new ModelAndView("mg/home");
    	mav.addObject("opt", opt);
        return mav ;
    }
    /*头部信息*/
    @RequestMapping(value = "/home/top.htm", method = RequestMethod.GET)
    public String manageTop(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        return "mg/home/top";
    }

    /**
     * 首页
     */
    @RequestMapping(value = "/home/content.htm", method = RequestMethod.GET)
    public ModelAndView homeContent(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
    	ModelAndView mav = new ModelAndView("mg/home/content");
    	String opt = WebUtils.getRequestParameterAsString(request, "opt");
    	//默认首页
    	String defaultPage = "mg/home/webInfo.htm" ;
    	if(StringUtils.equals(opt, "message")){
    		defaultPage = "mg/message/message-list.htm" ;
    	}
    	if(StringUtils.equals(opt, "contact")){
    		defaultPage = "mg/user/contact.htm" ;
    	}
    	mav.addObject("defaultPage", defaultPage);
        return mav ;
    }

    /**
     * 用户角色权限
     */
    @RequestMapping(value = "/home/role.htm")
    public ModelAndView role(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/home/role");
        //用户内容
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        UserInfo userInfo = new UserInfo() ;
        if(obj != null){
            userInfo = (UserInfo)obj ;
        }
        mav.addObject("userInfo",userInfo);

        //系统角色
        List<RoleInfo>  roleInfoList = userInfoDao.getRoleList(null,0,Integer.MAX_VALUE);
        mav.addObject("roleInfoList",roleInfoList);

        /*新闻分类管理*/
        Category categoryNews = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NEWS);
        List<Category> categoryNewsList = categoryDao.getByParentId(categoryNews.getId(), categoryNews.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryNews",categoryNews);
        mav.addObject("categoryNewsList",categoryNewsList);

        /*通知通告分类管理*/
        Category categoryNotices = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NOTICES);
        List<Category> categoryNoticesList = categoryDao.getByParentId(categoryNotices.getId(),categoryNotices.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryNotices",categoryNotices);
        mav.addObject("categoryNoticesList",categoryNoticesList);

        //快捷入口管理
        Category outLinksCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_OUTFASTENTRANCE);
        Category inLinksCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_INFASTENTRANCE);
        mav.addObject("outLinksCategory",outLinksCategory);
        mav.addObject("inLinksCategory",inLinksCategory);

        /*友情链接分类管理*/
        Category categoryFriendlyLinks = categoryDao.getByAliasName(CategoryConstants.CATEOGRY_FRIENDLYLINKS);
        List<Category> categoryFriendlyLinksList = categoryDao.getByParentId(categoryFriendlyLinks.getId(),categoryFriendlyLinks.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryFriendlyLinks",categoryFriendlyLinks);
        mav.addObject("categoryFriendlyLinksList",categoryFriendlyLinksList);

        /*常用链接分类管理*/
        Category categoryOfenLinks = categoryDao.getByAliasName(CategoryConstants.CATEGORY_OFENLINKS);
        List<Category> categoryOfenLinksList = categoryDao.getByParentId(categoryOfenLinks.getId(),categoryOfenLinks.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryOfenLinks",categoryOfenLinks);
        mav.addObject("categoryOfenLinksList",categoryOfenLinksList);


        return mav ;
    }

    /**
     * 首页--网站信息
     */
    @RequestMapping(value = "/home/webInfo.htm")
    public String webInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        return "mg/home/webInfo";
    }
}
