/**
 *
 */
package com.glamey.library.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.LibraryCollectDao;
import com.glamey.library.dao.UserInfoDao;
import com.glamey.library.model.domain.LibraryCollect;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.LibraryCollectQuery;
import com.glamey.library.model.dto.UserQuery;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/mg/library")
public class LibraryCollectManagerController extends BaseController {

    @Autowired
    private CategoryDao categoryDao;
    @Resource
    private UserInfoDao userInfoDao;
    @Resource
    private LibraryCollectDao collectDao;


    @RequestMapping(value = "/library-collect.htm", method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("mg/library/library-collect");

        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        pageBean = new PageBean();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        LibraryCollectQuery query = new LibraryCollectQuery();
        query.setUserId(userId);
        query.setStartTime(WebUtils.getRequestParameterAsString(request, "startTime"));
        query.setEndTime(WebUtils.getRequestParameterAsString(request, "endTime"));
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<LibraryCollect> collectList = collectDao.getList(query);
        pageBean.setMaxRowCount(collectDao.getCountList(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        UserQuery userQuery = new UserQuery();
        userQuery.setStart(0);
        userQuery.setNum(Integer.MAX_VALUE);
        List<UserInfo> userInfoList = userInfoDao.getUserList(userQuery);

        mav.addObject("collectList", collectList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("userInfoList", userInfoList);
        mav.addObject("query", query);
        return mav;
    }

    @RequestMapping(value = "/library-collect-del.htm", method = RequestMethod.GET)
    public ModelAndView collectDel(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");

        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        String userId = userInfo.getUserId();

        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", message);
            return mav;
        }

        try {
            String ids[] = StringUtils.split(id, ",");
            for (String s : ids) {
                collectDao.deleteById(s);
            }
            mav.addObject("message", "删除成功");
            mav.addObject("href", "mg/library/library-collect.htm?userId=" + userId);
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("message", "删除失败");
        }
        return mav;
    }
}
