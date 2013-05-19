/**
 *
 */
package com.glamey.innerweb.controller.manager;

import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.MetaInfoDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.MetaInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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

    @RequestMapping(value = "/sys-list.htm", method = RequestMethod.GET)
    public String managerHome(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        return "mg/sys/index";
    }

    /*是否需要审核*/
    @RequestMapping(value = "/permit-notices-show.htm", method = RequestMethod.GET)
    public ModelAndView permitNoticesShow(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        MetaInfo metaInfo = metaInfoDao.getByName(SystemConstants.permit_notices);
        ModelAndView mav = new ModelAndView("mg/sys/permit-notices-show");
        mav.addObject("metaInfo", metaInfo);
        return mav;
    }

    /*是否需要审核处理*/
    @RequestMapping(value = "/permit-notices-update.htm", method = RequestMethod.POST)
    public ModelAndView permitNoticesUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/permit-notices-show");
        MetaInfo metaInfo = metaInfoDao.getByName(SystemConstants.permit_notices);
        String value = WebUtils.getRequestParameterAsString(request, "value");
        if (StringUtils.isBlank(value)) {
            mav.addObject("message", "不能为空");
            return mav;
        }
        metaInfo.setValue(value);
        if (metaInfoDao.update(metaInfo)) {
            mav.addObject("message", "设置成功");
        } else {
            mav.addObject("message", "设置失败");
        }
        mav.addObject("metaInfo", metaInfo);
        mav.addObject("message", message);
        return mav;
    }

    /**
     * 首页主体模块设置
     */
    @RequestMapping(value = "/area-show.htm", method = RequestMethod.GET)
    public ModelAndView area(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/area-show");
        MetaInfo meatArea1 = metaInfoDao.getByName(SystemConstants.AREA_1);
        MetaInfo meatArea2 = metaInfoDao.getByName(SystemConstants.AREA_2);
        MetaInfo meatArea3 = metaInfoDao.getByName(SystemConstants.AREA_3);
        MetaInfo meatArea4 = metaInfoDao.getByName(SystemConstants.AREA_4);

        List<Category> categoryArea1List = new ArrayList<Category>();
        if (meatArea1 != null && StringUtils.isNotBlank(meatArea1.getValue())) {
            for (String a : StringUtils.split(meatArea1.getValue(), ",")) {
                categoryArea1List.add(categoryDao.getById(a));
            }
        }

        List<Category> categoryArea2List = new ArrayList<Category>();
        if (meatArea2 != null && StringUtils.isNotBlank(meatArea2.getValue())) {
            for (String a : StringUtils.split(meatArea2.getValue(), ",")) {
                categoryArea2List.add(categoryDao.getById(a));
            }
        }

        List<Category> categoryArea3List = new ArrayList<Category>();
        if (meatArea3 != null && StringUtils.isNotBlank(meatArea3.getValue())) {
            for (String a : StringUtils.split(meatArea3.getValue(), ",")) {
                categoryArea3List.add(categoryDao.getById(a));
            }
        }

        List<Category> categoryArea4List = new ArrayList<Category>();
        if (meatArea4 != null && StringUtils.isNotBlank(meatArea4.getValue())) {
            for (String a : StringUtils.split(meatArea4.getValue(), ",")) {
                categoryArea4List.add(categoryDao.getById(a));
            }
        }

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

    /**
     * 板块调整
     */
    @RequestMapping(value = "/area-update.htm")
    public ModelAndView areaUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/sys/area-show");

        try {
            for (int i = 1; i <= 4; i++) {
                String areas[] = WebUtils.getRequestParameterAsStringArrs(request, "area" + i);
                if(areas == null || areas.length == 0){
                    mav.addObject("message",message);
                    return mav ;
                }
                StringBuffer areaArrays = new StringBuffer();
                for (String area : areas) {
                    areaArrays.append(",").append(area);
                }
                String areaResutl = areaArrays.length() > 0 ? areaArrays.substring(1) : "";

                MetaInfo metaInfo = new MetaInfo();
                switch (i) {
                    case 1:
                        metaInfo.setName(SystemConstants.AREA_1);
                        metaInfo.setValue(areaResutl);
                        metaInfoDao.update(metaInfo);
                        break;

                    case 2:
                        metaInfo.setName(SystemConstants.AREA_2);
                        metaInfo.setValue(areaResutl);
                        metaInfoDao.update(metaInfo);
                        break;

                    case 3:
                        metaInfo.setName(SystemConstants.AREA_3);
                        metaInfo.setValue(areaResutl);
                        metaInfoDao.update(metaInfo);
                        break;

                    case 4:
                        metaInfo.setName(SystemConstants.AREA_4);
                        metaInfo.setValue(areaResutl);
                        metaInfoDao.update(metaInfo);
                        break;
                }
            }
            mav.addObject("message","操作成功");
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("message","操作失败");
        }
        return mav;
    }

    /**
     * 首页--网站信息
     */
    @RequestMapping(value = "/home/webInfo.htm")
    public String webInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        return "mg/home/webInfo";
    }
}
