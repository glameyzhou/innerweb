/**
 *
 */
package com.glamey.library.controller.manager;

import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.SystemConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.controller.front.IncludeFront;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.MetaInfoDao;
import com.glamey.library.dao.UserInfoDao;
import com.glamey.library.model.domain.MetaInfo;
import com.glamey.library.model.domain.UserInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * 后台管理系统--系统设置
 *
 * @author zy
 */
@Controller
@RequestMapping(value = "/mg/feedback")
public class FeedbackManagerController extends BaseController {

    @Resource
    private IncludeFront includeFront ;
    @Resource
    private UserInfoDao userInfoDao ;


    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView fronIndex(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("front/feedback");
        mav.addAllObjects(includeFront.allInclude(request,response,session));

        UserInfo sessionUserinfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        mav.addObject("userInfo",sessionUserinfo);
        return mav ;
    }

    @RequestMapping(value = "/feedback.htm", method = RequestMethod.POST)
    public void feedback(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        String username = WebUtils.getRequestParameterAsString(request,"username");
        String email = WebUtils.getRequestParameterAsString(request,"email");
        String content = WebUtils.getRequestParameterAsString(request, "content");
        StringBuffer result = new StringBuffer();
        if(StringUtils.isBlank(username) || StringUtils.isBlank(email) || StringUtils.isBlank(content)){
            result.append("E");
        }else{
            result.append("O");
        }
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        response.setHeader("expires", "0");
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }
}
