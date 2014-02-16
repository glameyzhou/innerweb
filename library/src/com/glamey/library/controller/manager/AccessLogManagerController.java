package com.glamey.library.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.AccessLogDao;
import com.glamey.library.dao.UserInfoDao;
import com.glamey.library.model.domain.AccessLog;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.AccessLogQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * 系统日志管理
 * Created with IntelliJ IDEA.
 * User: zy
 */
@Controller
@RequestMapping(value = "/mg/sys/accessLog")
public class AccessLogManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(AccessLogManagerController.class);

    @Resource
    private AccessLogDao accessLogDao;
    @Resource
    private UserInfoDao userInfoDao;


    @RequestMapping(value = "/list.htm", method = RequestMethod.GET)
    public ModelAndView postList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-accessLog-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        //请求参数获取
        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        if (StringUtils.isNotBlank(userId)) {
            UserInfo userInfo = userInfoDao.getUserSimpleById(userId);
            mav.addObject("userInfo",userInfo);
        }

        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);
        AccessLogQuery query = new AccessLogQuery();
        query.setUserId(userId);
        String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
        String startTime = WebUtils.getRequestParameterAsString(request, "startTime", today + " 00:00:00");
        String endTime = WebUtils.getRequestParameterAsString(request, "endTime", today + " 23:59:59");
        query.setAccessStartTime(startTime);
        query.setAccessEndTime(endTime);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        query.setCategoryId(categoryId);

        //获取指定分类下的所有文章
        List<AccessLog> accessLogList = accessLogDao.getByQuery(query);
        pageBean.setMaxRowCount(accessLogDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("accessLogList", accessLogList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.setViewName("mg/sys/accessLog-list");
        return mav;
    }
}
