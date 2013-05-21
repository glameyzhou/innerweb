package com.glamey.innerweb.util;

import com.glamey.innerweb.constants.Constants;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class UserLoginFilter implements Filter {
    private static final long serialVersionUID = -1998907343910499L;
    //未登录允许访问的请求
    private Map<String, String> map = new HashMap<String, String>();

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
        System.out.println("requestURI=" + requestURI + " requestURIExtension=" + suffix);
        boolean isAllowed = false;
        if (obj == null && !isAllowed(requestURI)) {
            response.sendRedirect(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath());
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {
    }

    private boolean isAllowed(String requestURI) {
        return map.containsKey(requestURI) || map.containsValue(requestURI);
    }
}
