package com.glamey.library.controller.front;

import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.AccessLogDao;
import com.glamey.library.dao.LibraryCollectDao;
import com.glamey.library.model.domain.LibraryCollect;
import com.glamey.library.model.domain.UserInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

/**
 *
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class LibraryCollectFrontController extends BaseController{

    @Resource
    private LibraryCollectDao collectDao ;
    @Resource
    private AccessLogDao accessLogDao;

    @RequestMapping(value = "/library-collect.htm",method=RequestMethod.GET)
    public void collectList(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException {
        PrintWriter out = response.getWriter();
        UserInfo sessionUserInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        String userId = sessionUserInfo.getUserId() ;
        String libId = WebUtils.getRequestParameterAsString(request,"libId");
        if(StringUtils.isNotBlank(libId)){
            LibraryCollect collect = new LibraryCollect();
            collect.setUserId(userId);
            collect.setLibId(libId);
            collect.setTime(new Date());
            if(collectDao.create(collect)){
                out.print("OK");
                accessLogDao.save(userId,"library-collect.htm","联系我们","");
            }
            else{
                out.print("Error");
            }
        }
        else{
            out.print("NoLibId");
        }

        out.flush();
        out.close();
    }
}
