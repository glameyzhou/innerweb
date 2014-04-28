package com.glamey.chec_cn.controller.front;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.*;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.MetaInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class MetaFrontController extends BaseController {

    @Autowired
    private UserInfoDao userInfoDao;
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private LinksDao linksDao;
    @Autowired
    private MetaInfoDao metaInfoDao;

    @RequestMapping(value = {"/meta-{metaKey}.htm"}, method = RequestMethod.GET)
    public ModelAndView metaInfo(
            @PathVariable String metaKey,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/meta/meta");
        if (StringUtils.isBlank(metaKey)){
            return pageNotFound(request,response);
        }
        MetaInfo metaInfo = metaInfoDao.getByName(metaKey);
        mav.addObject("metaInfo",metaInfo);
        return mav;
    }

    @RequestMapping(value = {"/meta-website.htm"}, method = RequestMethod.GET)
    public ModelAndView website(
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/meta/website");
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

        /**
         * 监察审计
         */
        Category categoryJcsj = categoryDao.getByAliasName(CategoryConstants.CATEGORY_JCSJ);
        List<Category> categoryList_jcsj = categoryDao.getByParentId(categoryJcsj.getId(),categoryJcsj.getCategoryType(),0,Integer.MAX_VALUE);
        mav.addObject("categoryJcsj",categoryJcsj);
        mav.addObject("categoryList_jcsj",categoryList_jcsj);
        return mav;
    }
}
