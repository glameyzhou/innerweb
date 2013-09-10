package com.glamey.library.controller.front;

import com.glamey.framework.utils.BlowFish;
import com.glamey.framework.utils.Pinyin4jUtils;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.UserInfoDao;
import com.glamey.library.model.domain.RightsInfo;
import com.glamey.library.model.domain.RoleInfo;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.util.WebCookieUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
	@Resource
	private WebCookieUtils webCookieUtils ;
    /**
     * 显示登陆界面
     */
    @RequestMapping(value = "/login.htm", method = RequestMethod.GET)
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
     * 登出操作
     */
    @RequestMapping(value = "/mg/logout.htm", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        session.removeAttribute(Constants.SESSIN_USERID);
        session.invalidate();
        webCookieUtils.cookieRemove(request, response);
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
                    Cookie cookie = new Cookie(Constants.COOKIES_ID, value);
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

    @RequestMapping(value = "/register_userExist.htm", method = RequestMethod.POST)
    public void registry_userExist(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        response.setHeader("expires", "0");
        String username = WebUtils.getRequestParameterAsString(request,"username");

        String result = "" ;

        if(StringUtils.isBlank(username)){
            result = "{\"regStatus\":\"empty\",\"regMessage\":\"用户名不能为空\"}";
        }
        else if (userInfoDao.isUserExist(username)){
            result = "{\"regStatus\":\"exist\",\"regMessage\":\"用户名已经被占用\"}" ;
        }
        else {
            result =  "{\"regStatus\":\"ok\",\"regMessage\":\"恭喜您," + username + "可以使用\"}";
        }
        response.getOutputStream().write(result.getBytes("UTF-8"));
    }


    @RequestMapping(value = "/register.htm", method = RequestMethod.POST)
    public ModelAndView register(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        logger.info("[register]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("register_result");
        StringBuilder result = new StringBuilder();
        String username = WebUtils.getRequestParameterAsString(request, "username");
        if (StringUtils.isBlank(username)) {
            result.append("用户名不能为空<br/>");
            result.append("点击<a href='javascript:history.go(-1);'>这里</a>返回重试...<br/>");
            mav.addObject("message",result.toString());
            return mav ;
        }
        if (userInfoDao.isUserExist(username)) {
            result.append("用户名已经存在<br/>");
            result.append("点击<a href='javascript:history.go(-1);'>这里</a>返回重试...<br/>");
            mav.addObject("message",result.toString());
            return mav ;
        }

        String passwd = WebUtils.getRequestParameterAsString(request, "passwd");
        String passwdRp = WebUtils.getRequestParameterAsString(request, "passwdRp");
        if (!StringUtils.equals(passwd, passwdRp) || (StringUtils.isBlank(passwd) || StringUtils.isBlank(passwdRp))) {
            result.append("两次输入密码不一致<br/>");
            result.append("点击<a href='javascript:history.go(-1);'>这里</a>返回重试...<br/>");
            mav.addObject("message",result.toString());
            return mav ;
        }
        UserInfo userInfo = new UserInfo();
        userInfo.setUsername(username);
        BlowFish bf = new BlowFish(Constants.SECRET_KEY);
        userInfo.setPasswd(bf.encryptString(passwd));
        String nickName = WebUtils.getRequestParameterAsString(request, "nickname");
        userInfo.setNickname(nickName);
        userInfo.setNicknamePinyin(Pinyin4jUtils.getPinYin(nickName));
        userInfo.setCompany(WebUtils.getRequestParameterAsString(request, "company"));
        userInfo.setDept(WebUtils.getRequestParameterAsString(request, "dept"));
        userInfo.setPhone(WebUtils.getRequestParameterAsString(request, "phone"));
        userInfo.setMobile(WebUtils.getRequestParameterAsString(request, "mobile"));
        userInfo.setEmail(WebUtils.getRequestParameterAsString(request, "email"));
        userInfo.setIsLive(WebUtils.getRequestParameterAsInt(request, "isLive", 1));

        //TODO 需要默认设置游客的角色ID集合
        List<String> roleIdList = new ArrayList<String>();
        userInfo.setRoleIdList(roleIdList);

        if (userInfoDao.createUser(userInfo)) {
            String basePath = request.getScheme() + "://" + request.getServerName() + (request.getServerPort() == 80 ? "" : ":" + request.getServerPort()) + request.getContextPath() + "/index.htm";
            result.append("用户注册成功<br/>");
            result.append("点击<a href=\"" + basePath + "\">这里</a>进行浏览...");
        }
        else{
            result.append("用户注册失败<br/>");
            result.append("点击<a href='javascript:history.go(-1);'>这里</a>返回重试...<br/>");
        }
        mav.addObject("message",result.toString());
        return mav ;
    }


    @RequestMapping(value = "/tourist.htm", method = RequestMethod.GET)
    public ModelAndView tourist(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        logger.info("[tourist]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/index.htm");

        //设置权限功能
        List<RoleInfo> roleInfoList = new ArrayList<RoleInfo>();
        RoleInfo roleInfo = new RoleInfo();
        roleInfo.setRoleId(Constants.sysTouristRoleId);
        roleInfo.setRoleName("游客");
        roleInfo.setRoleRightsIds("00");
        List<String> rigthsList = new ArrayList<String>();
        rigthsList.add("00");
        roleInfo.setRightsList(rigthsList);
        roleInfoList.add(roleInfo);

        UserInfo userInfo = new UserInfo();
        userInfo.setUserId("000000");
        userInfo.setUsername(Constants.sysTouristUID);
        userInfo.setRightsList(rigthsList);
        List<String> roleIdList = new ArrayList<String>();
        roleIdList.add(Constants.sysTouristRoleId);
        userInfo.setRoleIdList(roleIdList);
        userInfo.setRoleInfoList(roleInfoList);
        userInfo.setIsLive(1);


        session.setAttribute(Constants.SESSIN_USERID, userInfo);
        return mav ;
    }
}