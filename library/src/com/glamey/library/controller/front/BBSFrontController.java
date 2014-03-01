package com.glamey.library.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.framework.utils.json.JsonMapper;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.*;
import com.glamey.library.model.domain.BBSPost;
import com.glamey.library.model.domain.BBSReply;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    private static final JsonMapper jsonMapper = JsonMapper.nonNullMapper();
    private static final int postTotal = 20;
    private static final int postTopTotal = 5;
    private static int postNormalTotal = 15;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[front] #index#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/bbs/index");
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));

        List<BBSDTO> bbsdtoList = new ArrayList<BBSDTO>();
        BBSDTO bbsdto = null;
        List<Category> bbsCategoryList = categoryDao.getByParentId(CategoryConstants.PARENTID,CategoryConstants.CATEGORY_BBS,0,Integer.MAX_VALUE);
        for (Category category : bbsCategoryList) {
            //栏目帖子总量分析
            BBSAnalyzer analyzer = bbsPostDao.getAnalyzer(category.getId());
            //版主
            UserInfo userInfo = bbsPostDao.getBBSManager(category.getId());
            //每个栏目的帖子总量为20，其中置顶为5，普通为15.
            //置顶帖子
            BBSPostQuery query = new BBSPostQuery();
            query.setCategoryId(category.getId());
            query.setShowTop(1);
            query.setStart(0);
            query.setNum(postTopTotal);
            List<BBSPostDTO> bbsPostDTOList_top = bbsPostDao.getPostDTOListByQuery(query);

            //普通帖子(如果置顶帖子不够)
            if (CollectionUtils.isEmpty(bbsPostDTOList_top) || bbsPostDTOList_top.size() < postTopTotal) {
                postNormalTotal = postTotal - bbsPostDTOList_top.size();
            }
            query = new BBSPostQuery();
            query.setCategoryId(category.getId());
            query.setShowTop(0);
            query.setStart(0);
            query.setNum(postNormalTotal);
            List<BBSPostDTO> bbsPostDTOList_normal = bbsPostDao.getPostDTOListByQuery(query);

            bbsdto = new BBSDTO();
            bbsdto.setCategory(category);
            bbsdto.setAnalyzer(analyzer);
            bbsdto.setBbsManager(userInfo);
            bbsdto.setBbsPostDTOList_top(bbsPostDTOList_top);
            bbsdto.setBbsPostDTOList_normal(bbsPostDTOList_normal);

            bbsdtoList.add(bbsdto);
        }

        mav.addObject("bbsdtoList",bbsdtoList);


        accessLogDao.save("bbs/index.htm","专题讨论区-首页","",session);
        return mav;
    }

    /**发帖子新增界面*/
    @RequestMapping(value = "/post-{categoryId}-show.htm", method = RequestMethod.GET)
    public ModelAndView postShow(
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[front] #postShow#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("front/bbs/post-show");
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));
        if (StringUtils.isBlank(categoryId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无效操作");
            mav.addObject("href", "mg/bbs/index.htm");
            return mav;
        }
        Category category = categoryDao.getBySmpleId(categoryId);
        mav.addObject("categoryId",categoryId);
        mav.addObject("category",category);

        accessLogDao.save("bbs/index.htm","发主贴界面，栏目" + category.getName() ,categoryId,session);
        return mav;
    }

    /**发主题*/
//    @ResponseBody
    @RequestMapping(value = "/post-submit.htm", method = RequestMethod.POST)
    public void postSubmit(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[front] #postSubmit#" + request.getRequestURI());

        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        String title = WebUtils.getRequestParameterAsString(request,"title");
        String content = WebUtils.getRequestParameterAsString(request,"postContent");
        String errorMsg = "";
        if (StringUtils.isBlank(categoryId)) {
            errorMsg += "为选择发帖分类<br/>";
        }
        if (StringUtils.isBlank(title) || StringUtils.trim(title).length() < 10) {
            errorMsg += "标题不能小于10个字符<br/>";
        }
        if (StringUtils.isBlank(content) || StringUtils.trim(content).length() < 10) {
            errorMsg += "内容不能小于10个字符";
        }

        Map<String,String> resultMap = new HashMap<String, String>();
        String pCode = "0", pData = "", postId = "";
        if (StringUtils.isNotBlank(errorMsg)) {
            pCode = "1";
            pData = errorMsg;
        }
        else {
            Category category = categoryDao.getBySmpleId(categoryId);
            UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
            BBSPost post = new BBSPost();
            post.setCategoryId(categoryId);
            post.setTitle(title);
            post.setContent(content);
            post.setUserId(userInfo.getUserId());
            postId = bbsPostDao.create(post);
            if (StringUtils.isBlank(postId)) {
                pCode = "2";
                pData = "网络超时，请稍后重试";
            }
            else {
                pData = "发表成功";
                accessLogDao.save(userInfo.getUserId(),"bbs/post.htm","发帖成功，栏目" + category.getName() ,categoryId);
            }
        }
        resultMap.put("pCode", pCode);
        resultMap.put("pData", pData);
        resultMap.put("postId", postId);
        output(response, jsonMapper.toJson(resultMap));

//        return jsonMapper.toJson(resultMap);
    }
    /**回复帖子*/
//    @ResponseBody
    @RequestMapping(value = "/reply-{postId}-submit.htm", method = RequestMethod.POST)
    public void replySubmit(
            @PathVariable String postId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("[front] #replySubmit#" + request.getRequestURI());

        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        String content = WebUtils.getRequestParameterAsString(request,"content");
        String errorMsg = "";
        if (StringUtils.isBlank(categoryId)) {
            errorMsg += "请选择发帖分类<br/>";
        }
        if (StringUtils.isBlank(postId)) {
            errorMsg += "请选择回帖的主题<br/>";
        }
        if (StringUtils.isBlank(content) || StringUtils.trim(content).length() < 10) {
            errorMsg += "内容不能小于10个字符";
        }

        Map<String,String> resultMap = new HashMap<String, String>();
        String pCode = "0", pData = "";
        if (StringUtils.isNotBlank(errorMsg)) {
            pCode = "1";
            pData = errorMsg;
        }
        else {
            Category category = categoryDao.getBySmpleId(categoryId);
            UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);

            BBSReply reply = new BBSReply();
            reply.setCategoryId(categoryId);
            reply.setUserId(userInfo.getUserId());
            reply.setPostId(postId);
            reply.setContent(content);

            if (!bbsReplyDao.create(reply)) {
                pCode = "2";
                pData = "网络超时，请稍后重试";
            }
            else {
                pData = "回复成功";
                accessLogDao.save(userInfo.getUserId(),"bbs/post-" + postId + ".htm","回帖成功，栏目" + category.getName() ,categoryId);
            }
        }
        resultMap.put("pCode", pCode);
        resultMap.put("pData", pData);
        resultMap.put("postId", postId);
        output(response, jsonMapper.toJson(resultMap));
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
        //帖子类型："greate"精华
        String type = WebUtils.getRequestParameterAsString(request,"type");
        //所在栏目
        Category category = categoryDao.getById(categoryId);
        //本栏目下帖子统计
        BBSAnalyzer analyzer = bbsPostDao.getAnalyzer(categoryId);
        //版主
        UserInfo bbsManager = bbsPostDao.getBBSManager(categoryId);

        //置顶帖子
        BBSPostQuery query = new BBSPostQuery();
        query.setCategoryId(category.getId());
        query.setShowTop(1);
        query.setStart(0);
        query.setNum(postTopTotal);
        List<BBSPostDTO> bbsPostDTOList_top = bbsPostDao.getPostDTOListByQuery(query);

        //普通帖子
        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);
        query = new BBSPostQuery();
        query.setCategoryId(category.getId());
        query.setShowTop(0);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        if (StringUtils.equals("great",type))
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
        mav.addObject("pageBean", pageBean);
        mav.addObject("type", type);

        accessLogDao.save("brand-{categoryId}.htm?type" + type,"专题讨论区-" + category.getName() + "列表",categoryId,session);

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
        if (StringUtils.isBlank(postId)) {
            mav.addObject("message", "操作无效");
            mav.setViewName("common/errorPage");
            return mav;
        }
        //包含页面
        mav.addAllObjects(includeFront.allInclude(request, response, session));

        //主帖
        BBSPost bbsPost = bbsPostDao.getPostById(postId);
        if (bbsPost == null) {
            mav.addObject("message", "操作无效");
            mav.setViewName("common/errorPage");
            return mav;
        }
        //增加本主题的viewcount
        bbsPostDao.addViewCount(postId);
        //查看用户
        String userId = WebUtils.getRequestParameterAsString(request,"u");
        //回帖
        pageBean = new PageBean(Constants.rowsPerPageFront);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        BBSReplyQuery query = new BBSReplyQuery();
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        query.setPostId(postId);
        query.setUserId(userId);

        List<BBSReply> bbsReplyList = bbsReplyDao.getByQuery(query);
        pageBean.setMaxRowCount(bbsReplyDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        //帖子栏目
        Category category = categoryDao.getById(bbsPost.getCategoryId());

        //上一个主题
        BBSPostQuery postQuery = new BBSPostQuery();
        postQuery.setCategoryId(category.getId());
        postQuery.setPublishEndTime(DateFormatUtils.format(bbsPost.getPublishTime().getTime() + 1,"yyyy-MM-dd HH:mm:ss"));
        postQuery.setStart(0);
        postQuery.setNum(1);
        List<BBSPost> list = bbsPostDao.getByQuery(postQuery);
        BBSPost postPre = CollectionUtils.isEmpty(list) ? null : list.get(0);
        //下一个主题
        postQuery.setPublishStartTime(DateFormatUtils.format(bbsPost.getPublishTime().getTime() -1,"yyyy-MM-dd HH:mm:ss"));
        list = bbsPostDao.getByQuery(postQuery);
        BBSPost postSub = CollectionUtils.isEmpty(list) ? null : list.get(0);

        mav.addObject("category", category);
        mav.addObject("bbsPost", bbsPost);
        mav.addObject("bbsReplyList", bbsReplyList);
        mav.addObject("query", query);
        mav.addObject("pageBean", pageBean);
        mav.addObject("pageURL", "bbs/post-" + postId + ".htm?curPage=" + curPage);
        mav.addObject("postPre",postPre);
        mav.addObject("postSub",postSub);

        return mav;
    }

    private void output(HttpServletResponse response,String data) {
        try {
//            response.setCharacterEncoding("UTF-8");
//            response.setContentType("application/json");
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.print(data);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}