package com.glamey.innerweb.util;

import com.glamey.framework.utils.BlowFish;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.dao.UserInfoDao;
import com.glamey.innerweb.model.domain.UserInfo;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;

import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class UserLoginFilter implements Filter {
    private static final long serialVersionUID = -1998907343910499L;
    //未登录允许访问的请求
    private Map<String, String> map = new HashMap<String, String>();
    @Resource
    private UserInfoDao userInfoDao;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String str = filterConfig.getInitParameter("allowed");
        String arrays[] = StringUtils.split(str, ",");
        for (String array : arrays) {
            map.put(array, array);
        }
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        Object obj = request.getSession().getAttribute(Constants.SESSIN_USERID);
        String requestURI = request.getRequestURI();
        String suffix = FilenameUtils.getExtension(requestURI);
        requestURI = getLastString(requestURI);

        boolean login = obj == null ? loginByCookie(request, response) : true;

        if (!login && !isAllowed(requestURI)) {
            response.sendRedirect(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath());
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }

        /*if (obj == null && !isAllowed(requestURI)) {
            response.sendRedirect(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath());
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }*/
    }

    @Override
    public void destroy() {
    }

    private String getLastString(String requestURI) {
        int index = StringUtils.lastIndexOf(requestURI, "/");
        if (index > -1) {
            return requestURI.substring(index);
        }
        return requestURI;
    }

    private boolean isAllowed(String requestURI) {
        return map.containsKey(requestURI) || map.containsValue(requestURI);
    }


    /**
     * 使用cookie进行登录
     *
     * @param request
     * @param response
     * @return
     */
    private boolean loginByCookie(HttpServletRequest request, HttpServletResponse response) {
        BlowFish bf = new BlowFish(Constants.SECRET_KEY);
        String value = null;
        Cookie cookies[] = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie != null && StringUtils.equals(cookie.getName(), "OFFICEINNER_SESSION_ID")) {
                value = cookie.getValue();
                break;
            }
        }
        if (value == null) {
            return false;
        }
        value = bf.decryptString(value);
        String values[] = StringUtils.split(value, "<>");
        if (values == null || values.length != 2) {
            return false;
        }
        String username = values[0];
        String password = values[1];
        UserInfo userInfo = userInfoDao.getUserByName(username);
        if (userInfo != null && userInfo.getIsLive() == 0) {
            return false;
        }
        if (userInfo != null && StringUtils.isNotBlank(userInfo.getUsername()) && StringUtils.isNotBlank(userInfo.getPasswd())) {
            String dbPasswd = bf.decryptString(userInfo.getPasswd());
            if (StringUtils.equals(password, dbPasswd)) {
                HttpSession session = request.getSession();
                session.setAttribute(Constants.SESSIN_USERID, userInfo);
                return true;
            }
        }
        return false;
    }
}
