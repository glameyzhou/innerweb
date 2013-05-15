/**
 *
 */
package com.glamey.innerweb.controller.manager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.model.domain.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.glamey.innerweb.controller.BaseController;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
    @RequestMapping(value = "/home.htm", method = RequestMethod.GET)
    public String managerHome(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        return "mg/home";
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
    public String homeContent(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        return "mg/home/content";
    }

    /**
     * 用户角色权限
     */
    @RequestMapping(value = "/home/role.htm")
    public ModelAndView top(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        ModelAndView mav = new ModelAndView("mg/home/role");
        List<Category> newsCategoryList = categoryDao.getByParentId("0", CategoryConstants.CATEGORY_NEWS,0,Integer.MAX_VALUE);


        mav.addObject("newsCategoryList",newsCategoryList);
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
