package com.glamey.innerweb.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.framework.utils.tld.StringTld;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.*;
import com.glamey.innerweb.model.domain.*;
import com.glamey.innerweb.model.dto.PostQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
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
import java.util.Arrays;
import java.util.List;

@Controller
public class LibraryFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(LibraryFrontController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private PostDao postDao;
    @Resource
    private LinksDao linksDao;
    @Resource
    private MetaInfoDao metaInfoDao;
    @Resource
    private IncludeFront includeFront;
    @Resource
    private PostReadInfoDao postReadInfoDao;
    @Resource
    private UserInfoDao userInfoDao;
    /**
     * 文章内容详情
     *
     * @param postId
     * @param request
     * @param response
     * @param session
     * @param modelMap
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/p-{postId}.htm", method = RequestMethod.GET)
    public ModelAndView postDetail(
            @PathVariable String postId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #postDetail#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/post-detail");
        if (StringUtils.isBlank(postId)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("front/404");
            return mav;
        }
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        String userId = ((UserInfo) obj).getUserId();

        Post post = postDao.getByPostId(postId);
        mav.addObject("post", post);

        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks());
        mav.addObject("unReadMessage", includeFront.unReadMessage(userId));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));

        //插入已读
        final PostReadInfo postReadInfo = new PostReadInfo();
        postReadInfo.setPostId(postId);
        postReadInfo.setUserId(userId);
        postReadInfoDao.create(postReadInfo);

        //读过文章的人数
        List<UserInfo> postReadUserList = postReadInfoDao.getUserListByPostId(postId);
        mav.addObject("postReadUserList", postReadUserList);

        return mav;
    }*/

    /**
     * @param pid
     * @param id
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping(value = "/lib-{pid}-{id}.htm", method = RequestMethod.GET)
    public ModelAndView libList(
            @PathVariable String pid,
            @PathVariable String id,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/lib-list");
        if (StringUtils.isBlank(pid) || StringUtils.isBlank(id)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("front/404");
            return mav;
        }

        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        //固定内容
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks());
        mav.addObject("unReadMessage", includeFront.unReadMessage(userInfo.getUserId()));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));

        return mav;
    }
}