package com.glamey.innerweb.controller.front;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.innerweb.controller.BaseController;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.innerweb.constants.Constants;

/**
 * 内网系统登陆管理
 * @author zy
 *
 */
@Controller
public class LoginFrontController extends BaseController{
	protected static final Logger logger = Logger.getLogger(LoginFrontController.class);
	
	/**显示登陆界面*/
	@RequestMapping(value = "/login.htm", method = RequestMethod.GET)
	public ModelAndView loginShow(HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("login");
		return mav;
	}

    /**登出操作*/
    @RequestMapping(value = "/mg/logout.htm", method = RequestMethod.GET)
    public String logout(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
        System.out.println("sessionId=" + session.getAttribute(Constants.SESSIN_USERID));
        session.removeAttribute(Constants.SESSIN_USERID);
        session.invalidate();
        return "front/index" ;
    }

	
	/**用户登陆*/
	@RequestMapping(value = "/manager.htm", method = RequestMethod.POST)
	public ModelAndView manager(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView(); 
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String verifyCode = request.getParameter("verifyCode");
		
		if(StringUtils.isBlank(username) || StringUtils.isBlank(password) || StringUtils.isBlank(verifyCode)){
			mav.setViewName("login");
			mav.addObject("message", "不能为空!");
			return mav ;
		}
		
		if(!StringUtils.equals(verifyCode, session.getAttribute(Constants.VERIFYCODE) + "")){
			mav.setViewName("login");
			mav.addObject("message", "验证码错误!");
			return mav ;
		}
		
		session.setAttribute(Constants.SESSIN_USERID, username);
        //首页
		mav.setViewName("redirect:/index.htm");
		return mav;
	}
}