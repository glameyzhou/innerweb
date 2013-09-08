package com.glamey.library.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.LibraryCollectDao;
import com.glamey.library.dao.LinksDao;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.LibraryCollect;
import com.glamey.library.model.domain.Links;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.LinksQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.lucene.search.MultiTermQuery;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

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
