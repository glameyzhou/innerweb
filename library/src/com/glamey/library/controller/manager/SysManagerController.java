/**
 *
 */
package com.glamey.library.controller.manager;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.library.dao.UserInfoDao;
import com.glamey.library.model.domain.RoleInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.SystemConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.MetaInfoDao;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.MetaInfo;

/**
 * 后台管理系统--系统设置
 *
 * @author zy
 */
@Controller
@RequestMapping(value = "/mg/sys")
public class SysManagerController extends BaseController {

    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private MetaInfoDao metaInfoDao;
    @Autowired
    private UserInfoDao userInfoDao;

    @RequestMapping(value = "/sys-list.htm", method = RequestMethod.GET)
    public String managerHome(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        return "mg/sys/index";
    }




    /**
     * 首页主体模块设置
     *//*
    @RequestMapping(value = "/area-show.htm", method = RequestMethod.GET)
    public ModelAndView area(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/area-show");
        MetaInfo metaArea1 = metaInfoDao.getByName(SystemConstants.AREA_1);
        MetaInfo meatArea2 = metaInfoDao.getByName(SystemConstants.AREA_2);
        MetaInfo meatArea3 = metaInfoDao.getByName(SystemConstants.AREA_3);
        MetaInfo meatArea4 = metaInfoDao.getByName(SystemConstants.AREA_4);

        List<Category> categoryArea1List = metaInfoDao.getCategoryListByMetaName(metaArea1);
        List<Category> categoryArea2List = metaInfoDao.getCategoryListByMetaName(meatArea2);
        List<Category> categoryArea3List = metaInfoDao.getCategoryListByMetaName(meatArea3);
        List<Category> categoryArea4List = metaInfoDao.getCategoryListByMetaName(meatArea4);

        //所有的新闻、通告模块
        Category cateParentNews = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NEWS);
        List<Category> newsCategoryList = categoryDao.getByParentId(cateParentNews.getId(), cateParentNews.getCategoryType(), 0, Integer.MAX_VALUE);

        Category cateParentNotices = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NOTICES);
        List<Category> noticesCategoryList = categoryDao.getByParentId(cateParentNotices.getId(), cateParentNotices.getCategoryType(), 0, Integer.MAX_VALUE);

        List<Category> categoryList = new ArrayList<Category>();
        categoryList.addAll(newsCategoryList);
        categoryList.addAll(noticesCategoryList);

        mav.addObject("categoryArea1List", categoryArea1List);
        mav.addObject("isEmptyArea1", categoryArea1List.size() == 0);

        mav.addObject("categoryArea2List", categoryArea2List);
        mav.addObject("isEmptyArea2", categoryArea2List.size() == 0);

        mav.addObject("categoryArea3List", categoryArea3List);
        mav.addObject("isEmptyArea3", categoryArea3List.size() == 0);

        mav.addObject("categoryArea4List", categoryArea4List);
        mav.addObject("isEmptyArea4", categoryArea4List.size() == 0);

        mav.addObject("categoryList", categoryList);

        return mav;
    }

    *//**
     * 板块调整
     *//*
    @RequestMapping(value = "/area-update.htm")
    public ModelAndView areaUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/area-show");

        try {
            for (int i = 1; i <= 4; i++) {
                String areas[] = WebUtils.getRequestParameterAsStringArrs(request, "area" + i);
                if (areas == null || areas.length == 0) {
                    mav.addObject("message", message);
                    return mav;
                }
                StringBuffer areaArrays = new StringBuffer();
                for (String area : areas) {
                    areaArrays.append(",").append(area);
                }
                String areaResut = areaArrays.length() > 0 ? areaArrays.substring(1) : "";

                MetaInfo metaInfo = new MetaInfo();
                switch (i) {
                    case 1:
                        metaInfo.setName(SystemConstants.AREA_1);
                        metaInfo.setValue(areaResut);
                        metaInfoDao.update(metaInfo);
                        break;

                    case 2:
                        metaInfo.setName(SystemConstants.AREA_2);
                        metaInfo.setValue(areaResut);
                        metaInfoDao.update(metaInfo);
                        break;

                    case 3:
                        metaInfo.setName(SystemConstants.AREA_3);
                        metaInfo.setValue(areaResut);
                        metaInfoDao.update(metaInfo);
                        break;

                    case 4:
                        metaInfo.setName(SystemConstants.AREA_4);
                        metaInfo.setValue(areaResut);
                        metaInfoDao.update(metaInfo);
                        break;
                }
            }
            mav.addObject("message", "操作成功");

            MetaInfo metaArea1 = metaInfoDao.getByName(SystemConstants.AREA_1);
            MetaInfo meatArea2 = metaInfoDao.getByName(SystemConstants.AREA_2);
            MetaInfo meatArea3 = metaInfoDao.getByName(SystemConstants.AREA_3);
            MetaInfo meatArea4 = metaInfoDao.getByName(SystemConstants.AREA_4);

            List<Category> categoryArea1List = metaInfoDao.getCategoryListByMetaName(metaArea1);
            List<Category> categoryArea2List = metaInfoDao.getCategoryListByMetaName(meatArea2);
            List<Category> categoryArea3List = metaInfoDao.getCategoryListByMetaName(meatArea3);
            List<Category> categoryArea4List = metaInfoDao.getCategoryListByMetaName(meatArea4);

            //所有的新闻、通告模块
            Category cateParentNews = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NEWS);
            List<Category> newsCategoryList = categoryDao.getByParentId(cateParentNews.getId(), cateParentNews.getCategoryType(), 0, Integer.MAX_VALUE);

            Category cateParentNotices = categoryDao.getByAliasName(CategoryConstants.CATEGORY_NOTICES);
            List<Category> noticesCategoryList = categoryDao.getByParentId(cateParentNotices.getId(), cateParentNotices.getCategoryType(), 0, Integer.MAX_VALUE);

            List<Category> categoryList = new ArrayList<Category>();
            categoryList.addAll(newsCategoryList);
            categoryList.addAll(noticesCategoryList);

            mav.addObject("categoryArea1List", categoryArea1List);
            mav.addObject("isEmptyArea1", categoryArea1List.size() == 0);

            mav.addObject("categoryArea2List", categoryArea2List);
            mav.addObject("isEmptyArea2", categoryArea2List.size() == 0);

            mav.addObject("categoryArea3List", categoryArea3List);
            mav.addObject("isEmptyArea3", categoryArea3List.size() == 0);

            mav.addObject("categoryArea4List", categoryArea4List);
            mav.addObject("isEmptyArea4", categoryArea4List.size() == 0);

            mav.addObject("categoryList", categoryList);

        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("message", "操作失败");
        }
        return mav;
    }
*/
    /**
     * 通用的全局配置显示页面
     * mg/sys/meta/popular_Links/meta-show.htm
     */
    @RequestMapping(value = "/meta/{name}/meta-show.htm", method = RequestMethod.GET)
    public ModelAndView metaShow(
            @PathVariable String name,
            HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/meta-show");
        if (StringUtils.isBlank(name)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("common/message");
            return mav;
        }
        MetaInfo metaInfo = metaInfoDao.getByName(name);
        mav.addObject("metaInfo", metaInfo);
        String title = "";
        if (StringUtils.equals(name, "page_foot")) {
            title = "页尾内容";
        }
        if (StringUtils.equals(name, "contact_us")) {
            title = "联系我们" ;
        }
        mav.addObject("title", title);
        return mav;
    }

    /**
     * 系统配置修改
     * mg/sys/meta/popular_Links/meta-show.htm
     */
    @RequestMapping(value = "/meta/{name}/meta-update.htm", method = RequestMethod.POST)
    public ModelAndView metaUpdate(
            @PathVariable String name,
            HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/meta-show");
        String value = WebUtils.getRequestParameterAsString(request, "value");
        if (StringUtils.isBlank(name)) {
            mav.addObject("message", "操作无效");
            return mav;
        }
        MetaInfo metaInfo = new MetaInfo();
        metaInfo.setName(name);
        metaInfo.setValue(value);
        if (metaInfoDao.update(metaInfo)) {
            mav.addObject("message", "修改成功");
        } else {
            mav.addObject("message", "修改失败");
        }
        mav.addObject("metaInfo", metaInfo);
        return mav;
    }

    /**
     * 图书馆头部设置--显示页面
     * @param request
     * @param response
     * @param session
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/meta/library_head/show.htm", method = RequestMethod.GET)
    public ModelAndView libraryHeadShow(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/library-head-show");

        MetaInfo libraryHeadTitile = metaInfoDao.getByName(SystemConstants.meta_library_title);
        mav.addObject("libraryHeadTitile", libraryHeadTitile);

        MetaInfo libraryHeadContent = metaInfoDao.getByName(SystemConstants.meta_library_content);
        mav.addObject("libraryHeadContent", libraryHeadContent);

        mav.addObject("title", "图书馆头部");

        return mav;
    }

    /**
     * 图书馆头部--标题内容修改处理
     * @param request
     * @param response
     * @param session
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/meta/library-head/update.htm", method = RequestMethod.POST)
    public ModelAndView libraryHeadUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");

        String title = WebUtils.getRequestParameterAsString(request,"title","");
        String content = WebUtils.getRequestParameterAsString(request,"content","");

        if(StringUtils.isBlank(title) || StringUtils.isBlank(content)){
            mav.addObject("message","标题、内容不能为空");
            return mav ;
        }

        MetaInfo metaInfoTitle = new MetaInfo();
        metaInfoTitle.setName(SystemConstants.meta_library_title);
        metaInfoTitle.setValue(title);

        MetaInfo metaInfoContent = new MetaInfo();
        metaInfoContent.setName(SystemConstants.meta_library_content);
        metaInfoContent.setValue(content);


        if (metaInfoDao.update(metaInfoTitle) && metaInfoDao.update(metaInfoContent)){
            mav.addObject("message","设置成功");
        }
        else {
            mav.addObject("message","设置失败");
        }
        return mav ;
    }


    @RequestMapping(value = "/meta/contact-us/show.htm", method = RequestMethod.GET)
    public ModelAndView contactusShow(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/contactus-show");
        MetaInfo contactusContent = metaInfoDao.getByName(SystemConstants.meta_contact_us);
        mav.addObject("contactusContent", contactusContent);
        mav.addObject("title", "联系我们");

        return mav;
    }

    @RequestMapping(value = "/meta/contact-us/update.htm", method = RequestMethod.POST)
    public ModelAndView contactusUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");

        String contactusContent = WebUtils.getRequestParameterAsString(request,"contactusContent","");
        if(StringUtils.isBlank(contactusContent)){
            mav.addObject("message","内容不能为空");
            return mav ;
        }


        MetaInfo metaInfoContent = new MetaInfo();
        metaInfoContent.setName(SystemConstants.meta_contact_us);
        metaInfoContent.setValue(contactusContent);

        if (metaInfoDao.update(metaInfoContent)){
            mav.addObject("message","设置成功");
        }
        else {
            mav.addObject("message","设置失败");
        }
        return mav ;
    }
}
