package com.glamey.innerweb.controller.front;

import com.glamey.framework.utils.BlowFish;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.UserInfoDao;
import com.glamey.innerweb.model.domain.UserInfo;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import sun.java2d.pipe.DuctusRenderer;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 内网系统登陆管理
 *
 * @author zy
 */
@Controller
public class LoginFrontController extends BaseController {
    protected static final Logger logger = Logger.getLogger(LoginFrontController.class);

    @Resource
    private UserInfoDao userInfoDao;

    /**
     * 显示登陆界面
     */
    @RequestMapping(value = "/login.htm", method = RequestMethod.GET)
    public ModelAndView loginShow(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login");
        return mav;
    }

    /**
     * 登出操作
     */
    @RequestMapping(value = "/mg/logout.htm", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        session.removeAttribute(Constants.SESSIN_USERID);
        session.invalidate();
        return "redirect:/home.jsp";
    }


    /**
     * 用户登陆
     */
    @RequestMapping(value = "/manager.htm", method = RequestMethod.POST)
    public ModelAndView manager(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("login");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String verifyCode = request.getParameter("verifyCode");

        /*是否记录用户Cookies，适用于下次免登陆*/
        String remeberUser = request.getParameter("remeberUser");
        BlowFish bf = new BlowFish(Constants.SECRET_KEY);
        if(StringUtils.equals(remeberUser,"1")){
            String value = null ;
            Cookie cookies [] = request.getCookies();
            for (Cookie cookie : cookies) {
                if(cookie != null && StringUtils.equals(cookie.getName(),"OFFICEINNER_SESSION_ID")){
                    value = cookie.getValue();
                    break;
                }
            }
            /*说明无cookie，返回重新登录*/
            if(value == null){
                mav.addObject("message", "不能为空!");
                return mav;
            }
            else{
                value = bf.decryptString(value);
                String values [] = StringUtils.split(value,"<>");
                if(value == null || value.length() != 2){
                    mav.addObject("message", "不能为空!");
                    return mav;
                }
                username = values[0];
                password = values[1];
            }
        }

        if (StringUtils.isBlank(username) || StringUtils.isBlank(password) || StringUtils.isBlank(verifyCode)) {
            mav.addObject("message", "不能为空!");
            return mav;
        }

        if (!StringUtils.equals(verifyCode, session.getAttribute(Constants.VERIFYCODE) + "")) {
            mav.addObject("message", "验证码错误!");
            return mav;
        }

        UserInfo userInfo = userInfoDao.getUserByName(username);
        if(userInfo != null && userInfo.getIsLive() == 0){
            mav.addObject("message", "账户被冻结,请联系管理员!");
            return  mav ;
        }

        if (userInfo != null && StringUtils.isNotBlank(userInfo.getUsername()) && StringUtils.isNotBlank(userInfo.getPasswd())) {
            String dbPasswd = bf.decryptString(userInfo.getPasswd());
            if (StringUtils.equals(password, dbPasswd)) {
                session.setAttribute(Constants.SESSIN_USERID, userInfo);
                mav.setViewName("redirect:/index.htm");

                /*设置用户cookies*/
                if(StringUtils.equals(remeberUser,"1")){
                    String value = username + "<>" + password ;
                    value = bf.encryptString(value);
                    Cookie cookie = new Cookie("OFFICEINNER_SESSION_ID", value);
                    cookie.setPath("/");
                    cookie.setDomain(request.getServerName());
                    cookie.setMaxAge(Integer.MAX_VALUE);
                    response.addCookie(cookie);
                }
                return mav;
            }
        }
        mav.addObject("message", "登陆校验失败,请重试!");
        return mav;
    }
}