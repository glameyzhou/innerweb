/**
 *
 */
package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.UserInfoDao;
import com.glamey.chec_cn.model.domain.UserInfo;
import com.glamey.chec_cn.util.WebCookieUtils;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
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
public class ConsoleManagerController extends BaseController {

    @Autowired
    private CategoryDao categoryDao ;
    @Resource
    private UserInfoDao userInfoDao;
    @Resource
    private WebCookieUtils webCookieUtils ;

    /**
     * 登陆界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/console.htm", method = RequestMethod.GET)
    public ModelAndView loginShow(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login");
        boolean isCookieLogin = webCookieUtils.isCookieLogin(request, response);
        if(isCookieLogin){
            mav.setViewName("redirect:/index.htm");
        }
        return mav;
    }
    /**
     * 后台管理首页
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
        UserInfo userInfo = (UserInfo) obj;
        mav.addObject("userInfo",userInfo);
        //权限List
        List<String> rightsList = userInfo.getRightsList();
        mav.addObject("rightsList",rightsList);

        UserInfo sessionUserInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        mav.addObject("sessionUserInfo",sessionUserInfo);
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
