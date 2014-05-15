package cn.com.checne.servlet;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by zy
 */
public class UrlFilter implements Filter {

    public void init(FilterConfig config) {
    }
    public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String basePath = request.getScheme() + "://" + request.getServerName() + "" + (request.getServerPort() == 80 ? "" : request.getServerPort());
        String uri = req.getRequestURI();
        String queryString = req.getQueryString();
        if (basePath != null && !basePath.equals("")) {
            String jumpUrl = "http://www.checne.com";
            if (basePath.indexOf("checne.com.cn") > -1) {
                if (uri != null && uri.equals("/")){
                    jumpUrl = "http://www.checne.com";
                }

                if (uri != null && uri.length() > 1) {
                    jumpUrl = "http://www.checne.com" + uri;
                }

                if (queryString != null){
                    jumpUrl = "http://www.checne.com" + uri + "?" + queryString;
                }
                resp.sendRedirect(jumpUrl);
            }
        }
        chain.doFilter(request, response);
    }
    public void destroy() {
    }
}