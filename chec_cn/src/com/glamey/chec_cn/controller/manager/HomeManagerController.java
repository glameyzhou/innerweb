/**
 *
 */
package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

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
    /**
     * 后台管理系统首页
     */
    @RequestMapping(value = "/home.do", method = RequestMethod.GET)
    public ModelAndView managerHome(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
    	ModelAndView mav = new ModelAndView("mg/home/index");
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        mav.addObject("userInfo", userInfo);

        /*当前权限*/
        //权限List
        List<String> rightsList = userInfo.getRightsList();
        mav.addObject("rightsList", rightsList);
        /**
         * 公司介绍
         */
        Category categoryIntroduce = categoryDao.getByAliasName(CategoryConstants.CATEGORY_INTRODUCE);
        List<Category> categoryList_introduce = categoryDao.getByParentId(categoryIntroduce.getId(),categoryIntroduce.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryIntroduce",categoryIntroduce);
        mav.addObject("categoryList_introduce",categoryList_introduce);

        /**
         * 公司新闻
         */
        Category categoryNews = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NEWS);
        List<Category> categoryList_news = categoryDao.getByParentId(categoryNews.getId(),categoryNews.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryNews",categoryNews);
        mav.addObject("categoryList_news",categoryList_news);

        /**
         * 监察审计
         */
        Category categoryJcsj = categoryDao.getByAliasName(CategoryConstants.CATEGORY_JCSJ);
        List<Category> categoryList_jcsj = categoryDao.getByParentId(categoryJcsj.getId(),categoryJcsj.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryJcsj",categoryJcsj);
        mav.addObject("categoryList_jcsj",categoryList_jcsj);

        /**
         * 业务概况
         */
        Category categoryBusiness = categoryDao.getByAliasName(CategoryConstants.CATEGORY_BUSINESS);
        List<Category> categoryList_business = categoryDao.getByParentId(categoryBusiness.getId(),categoryBusiness.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryBusiness",categoryBusiness);
        mav.addObject("categoryList_business",categoryList_business);

        /**
         * 公司业绩
         */
        Category categoryPerformance = categoryDao.getByAliasName(CategoryConstants.CATEGORY_PERFORMANCE);
        List<Category> categoryList_performance = categoryDao.getByParentId(categoryPerformance.getId(),categoryPerformance.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryPerformance",categoryPerformance);
        mav.addObject("categoryList_performance",categoryList_performance);

        /**
         * 企业文化
         */
        Category categoryCulture = categoryDao.getByAliasName(CategoryConstants.CATEGORY_CULTURE);
        List<Category> categoryList_culture = categoryDao.getByParentId(categoryCulture.getId(),categoryCulture.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryCulture",categoryCulture);
        mav.addObject("categoryList_culture",categoryList_culture);

        /**
         * 人力资源
         */
        Category categoryHr = categoryDao.getByAliasName(CategoryConstants.CATEGORY_HR);
        List<Category> categoryList_hr = categoryDao.getByParentId(categoryHr.getId(),categoryHr.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryHr",categoryHr);
        mav.addObject("categoryList_hr",categoryList_hr);
        /**
         * 招聘部门
         */
        Category categoryDept = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        mav.addObject("categoryDept",categoryDept);


        /**
         * 链接
         */
        Category categoryLinks = categoryDao.getByAliasName(CategoryConstants.CATEGORY_LINKS);
        List<Category> categoryList_links = categoryDao.getByParentId(categoryLinks.getId(),categoryLinks.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryLinks",categoryLinks);
        mav.addObject("categoryList_links",categoryList_links);


        return mav ;
    }
    /*默认页面*/
    @RequestMapping(value = "/home/webInfo.do", method = RequestMethod.GET)
    public ModelAndView manageTop(HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("mg/home/webInfo");
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        mav.addObject("userInfo", userInfo);
        return mav;
    }


    /**
     * 用户角色权限
     */
    @RequestMapping(value = "/home/role.do")
    public ModelAndView role(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/home/role");
        //用户内容
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        mav.addObject("userInfo",userInfo);
        //权限List
        List<String> rightsList = userInfo.getRightsList();
        mav.addObject("rightsList",rightsList);


        /**
         * 公司介绍
         */
        Category categoryIntroduce = categoryDao.getByAliasName(CategoryConstants.CATEGORY_INTRODUCE);
        List<Category> categoryList_introduce = categoryDao.getByParentId(categoryIntroduce.getId(),categoryIntroduce.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryIntroduce",categoryIntroduce);
        mav.addObject("categoryList_introduce",categoryList_introduce);

        /**
         * 公司新闻
         */
        Category categoryNews = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NEWS);
        List<Category> categoryList_news = categoryDao.getByParentId(categoryNews.getId(),categoryNews.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryNews",categoryNews);
        mav.addObject("categoryList_news",categoryList_news);

        /**
         * 业务概况
         */
        Category categoryBusiness = categoryDao.getByAliasName(CategoryConstants.CATEGORY_BUSINESS);
        List<Category> categoryList_business = categoryDao.getByParentId(categoryBusiness.getId(),categoryBusiness.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryBusiness",categoryBusiness);
        mav.addObject("categoryList_business",categoryList_business);

        /**
         * 公司业绩
         */
        Category categoryPerformance = categoryDao.getByAliasName(CategoryConstants.CATEGORY_PERFORMANCE);
        List<Category> categoryList_performance = categoryDao.getByParentId(categoryPerformance.getId(),categoryPerformance.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryPerformance",categoryPerformance);
        mav.addObject("categoryList_performance",categoryList_performance);

        /**
         * 企业文化
         */
        Category categoryCulture = categoryDao.getByAliasName(CategoryConstants.CATEGORY_CULTURE);
        List<Category> categoryList_culture = categoryDao.getByParentId(categoryCulture.getId(),categoryCulture.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryCulture",categoryCulture);
        mav.addObject("categoryList_culture",categoryList_culture);

        /**
         * 人力资源
         */
        Category categoryHr = categoryDao.getByAliasName(CategoryConstants.CATEGORY_HR);
        List<Category> categoryList_hr = categoryDao.getByParentId(categoryHr.getId(),categoryHr.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryHr",categoryHr);
        mav.addObject("categoryList_hr",categoryList_hr);
        /**
         * 招聘部门
         */
        Category categoryDept = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        mav.addObject("categoryDept",categoryDept);


        /**
         * 链接
         */
        Category categoryLinks = categoryDao.getByAliasName(CategoryConstants.CATEGORY_LINKS);
        List<Category> categoryList_links = categoryDao.getByParentId(categoryLinks.getId(),categoryLinks.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryLinks",categoryLinks);
        mav.addObject("categoryList_links",categoryList_links);

        return mav ;
    }
}
