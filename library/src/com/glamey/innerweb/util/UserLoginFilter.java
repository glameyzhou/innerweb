package com.glamey.innerweb.util;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.glamey.innerweb.constants.Constants;

/**
 * Created with IntelliJ IDEA. User: zy To change this template use File |
 * Settings | File Templates.
 */
@Repository
public class UserLoginFilter implements Filter {
	private static final long serialVersionUID = -1998907343910499L;
	// 未登录允许访问的请求
	private Map<String, String> map = new HashMap<String, String>();
	/*@Resource
	private WebCookieUtils webCookieUtils ;*/
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		String str = filterConfig.getInitParameter("allowed");
		String arrays[] = StringUtils.split(str, ",");
		for (String array : arrays) {
			map.put(array, array);
		}
	}

	@Override
	public void doFilter(ServletRequest servletRequest,
			ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		Object obj = request.getSession().getAttribute(Constants.SESSIN_USERID);
		String requestURI = request.getRequestURI();
		requestURI = getLastString(requestURI);
		/*boolean login = obj == null ? webCookieUtils.isCookieLogin(request, response) : true;
		if (!login && !isAllowed(requestURI)) {
			response.sendRedirect(request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath());
		} else {
			filterChain.doFilter(servletRequest, servletResponse);
		}*/

		
		if (obj == null && !isAllowed(requestURI)) {
			response.sendRedirect(request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath());
		} else {
			filterChain.doFilter(servletRequest, servletResponse);
		}
		 
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
}
