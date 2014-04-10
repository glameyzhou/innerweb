/**
 *
 */
package com.glamey.chec_cn.util;

import com.glamey.framework.utils.BlowFish;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.dao.UserInfoDao;
import com.glamey.chec_cn.model.domain.UserInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author zy
 */
@Repository
public class WebCookieUtils {

    @Resource
    private UserInfoDao userInfoDao;

    public boolean isCookieLogin(HttpServletRequest request,HttpServletResponse response) {
        BlowFish bf = new BlowFish(Constants.SECRET_KEY);
        String value = null;
        Cookie cookies[] = request.getCookies();
        if (cookies != null && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (cookie != null && StringUtils.equalsIgnoreCase(cookie.getName(), Constants.COOKIES_ID)) {
                    value = cookie.getValue();
                    break;
                }
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
        /* 如果cookies中有对应的正确信息,那么就直接登录 */
        if (userInfo != null && StringUtils.isNotBlank(userInfo.getUsername())
                && StringUtils.isNotBlank(userInfo.getPasswd())) {
            String dbPasswd = bf.decryptString(userInfo.getPasswd());
            if (StringUtils.equals(password, dbPasswd)) {
                HttpSession session = request.getSession();
                session.setAttribute(Constants.SESSIN_USERID, userInfo);
                return true;
            }
        }
        return false;
    }

    public void cookieRemove(HttpServletRequest request, HttpServletResponse response) {
        Cookie cookies[] = request.getCookies();
        for (int i = 0; i < cookies.length; i++) {
            Cookie cookie = new Cookie(cookies[i].getName(), null);
            cookie.setPath("/");
            cookie.setDomain(request.getServerName());
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
    }
}
