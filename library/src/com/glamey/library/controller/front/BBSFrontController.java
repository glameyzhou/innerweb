package com.glamey.library.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.*;
import com.glamey.library.model.domain.BBSPost;
import com.glamey.library.model.domain.BBSReply;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.BBSAnalyzer;
import com.glamey.library.model.dto.BBSPostDTO;
import com.glamey.library.model.dto.BBSPostQuery;
import com.glamey.library.model.dto.BBSReplyQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/bbs")
public class BBSFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(BBSFrontController.class);

    @Resource
    private BBSPostDao bbsPostDao;
    @Resource
    private BBSReplyDao bbsReplyDao;
    @Resource
    private UserInfoDao userInfoDao;
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private IncludeFront includeFront;
    @Resource
    private AccessLogDao accessLogDao;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[front] #index#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/bbs/index");
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));


        accessLogDao.save("bbs/index.htm","论坛首页","",session);
        return mav;
    }

    /**发帖子新增界面*/
    @RequestMapping(value = "/post.htm", method = RequestMethod.GET)
    public ModelAndView postShow(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[front] #postShow#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/bbs/post-show");
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));


        accessLogDao.save("bbs/index.htm","发帖子","",session);
        return mav;
    }

    /**
     * 栏目列表页面（栏目名称、帖子数量、版主、置顶、普通）
     * 帖子包含信息（标题、作者、最后更新时间、回复量、浏览量、最后回帖时间、人）
     */
    @RequestMapping(value = "/brand-{categoryId}.htm", method = RequestMethod.GET)
    public ModelAndView brandList(
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[front] #brandList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/bbs/post-list");
        if (StringUtils.isBlank(categoryId)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("common/errorPage");
            return mav;
        }
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));
        //所在栏目
        Category category = categoryDao.getById(categoryId);
        //本栏目下帖子统计
        BBSAnalyzer analyzer = bbsPostDao.getAnalyzer(categoryId);
        //版主
        UserInfo bbsManager = bbsPostDao.getBBSManager(categoryId);

        //置顶帖子
        BBSPostQuery query = new BBSPostQuery();
        query.setCategoryId(categoryId);
        query.setShowTop(1);
        query.setStart(0);
        query.setNum(10);
        List<BBSPostDTO> bbsPostDTOList_top = bbsPostDao.getPostDTOListByQuery(query);

        //普通帖子
        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);
        query = new BBSPostQuery();
        query.setCategoryId(categoryId);
        query.setShowTop(0);
        query.setStart(0);
        query.setNum(pageBean.getRowsPerPage());
        String postType = WebUtils.getRequestParameterAsString(request,"postType","");
        if (StringUtils.equals("great",postType))
            query.setShowGreat(1);

        List<BBSPostDTO> bbsPostDTOList_normal = bbsPostDao.getPostDTOListByQuery(query);
        pageBean.setMaxRowCount(bbsPostDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();


        mav.addObject("category", category);
        mav.addObject("analyzer", analyzer);
        mav.addObject("bbsManager", bbsManager);

        mav.addObject("bbsPostDTOList_top", bbsPostDTOList_top);
        mav.addObject("bbsPostDTOList_normal", bbsPostDTOList_normal);
        mav.addObject("postType", postType);

        return mav;
    }

    /**
     * 帖子详情
     */
    @RequestMapping(value = "/post-{postId}.htm", method = RequestMethod.GET)
    public ModelAndView bbsDetail(
            @PathVariable String postId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #bbsDetail#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/bbs/post-detail");
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));

        //主帖
        BBSPost bbsPost = bbsPostDao.getPostById(postId);

        //回帖
        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        BBSReplyQuery query = new BBSReplyQuery();
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        query.setPostId(postId);

        List<BBSReply> bbsReplyList = bbsReplyDao.getByQuery(query);
        pageBean.setMaxRowCount(bbsReplyDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        //帖子栏目
        Category category = categoryDao.getById(bbsPost.getCategoryId());

        mav.addObject("bbsPost", bbsPost);
        mav.addObject("category", category);
        mav.addObject("bbsReplyList", bbsReplyList);
        mav.addObject("pageBean", pageBean);

        return mav;
    }
}