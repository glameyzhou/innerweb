/**
 *
 */
package com.glamey.library.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.SystemConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.controller.front.IncludeFront;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.FeedBackInfoDao;
import com.glamey.library.dao.MetaInfoDao;
import com.glamey.library.dao.UserInfoDao;
import com.glamey.library.model.domain.FeedBackInfo;
import com.glamey.library.model.domain.MetaInfo;
import com.glamey.library.model.domain.Post;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.FeedBackQuery;
import com.glamey.library.model.dto.PostQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
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
import java.util.List;

/**
 * 后台管理系统--系统设置
 *
 * @author zy
 */
@Controller
@RequestMapping(value = "/mg/feedback")
public class FeedbackManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(FeedbackManagerController.class);
    @Resource
    private IncludeFront includeFront ;
    @Resource
    private UserInfoDao userInfoDao ;
    @Resource
    private FeedBackInfoDao feedBackInfoDao ;


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
            FeedBackInfo fb = new FeedBackInfo();
            fb.setFbUsername(username);
            fb.setFbEmail(email);
            fb.setFbContent(content);
            if(feedBackInfoDao.create(fb)){
                result.append("O");
            }
            else {
                result.append("B");
            }
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

    @RequestMapping(value = "/list.htm", method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[manager-feedbak-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        //请求参数获取
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);
        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        FeedBackQuery query = new FeedBackQuery();
        query.setKeyword(keyword);
        query.setStartTime(WebUtils.getRequestParameterAsString(request, "startTime"));
        query.setEndTime(WebUtils.getRequestParameterAsString(request, "endTime"));
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        //获取指定分类下的所有文章
        List<FeedBackInfo> feedBackInfoDaoList = feedBackInfoDao.getList(query);
        pageBean.setMaxRowCount(feedBackInfoDao.getCount(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("feedBackInfoDaoList", feedBackInfoDaoList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.setViewName("mg/feedback/fb-list");
        return mav;
    }

    @RequestMapping(value = "/delete.htm", method = RequestMethod.GET)
    public ModelAndView delete(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");

        try {
            String fbId = WebUtils.getRequestParameterAsString(request,"fbId");
            if(StringUtils.isBlank(fbId)){
                mav.addObject("message","无效操作");
                return mav ;
            }
            String fbIds [] = StringUtils.split(fbId,",");
            for (String id : fbIds) {
                logger.info("[feedback] #delete# fbId=" + id + " result=" + feedBackInfoDao.del(id) );
            }
            mav.addObject("message","操作成功");
            mav.addObject("href","mg/feedback/list.htm");
            return mav ;
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("message","操作失败，请重试.");
            return mav ;
        }
    }

    @RequestMapping(value = "/detail.htm", method = RequestMethod.GET)
    public ModelAndView detail(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("mg/feedback/fb-detail");
        try {
            String fbId = WebUtils.getRequestParameterAsString(request,"fbId");
            if(StringUtils.isBlank(fbId)){
                mav.addObject("message","无效操作");
                return mav ;
            }
            FeedBackInfo fb = feedBackInfoDao.getById(fbId);
            mav.addObject("fb",fb);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav ;
    }
}
