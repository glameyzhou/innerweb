package com.glamey.library.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.*;
import com.glamey.library.model.domain.BBSPost;
import com.glamey.library.model.domain.BBSReply;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.UserInfo;
import com.glamey.library.model.dto.BBSPostQuery;
import com.glamey.library.model.dto.BBSReplyQuery;
import com.glamey.library.util.DateUtils;
import com.glamey.library.util.WebUploadUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * 论坛帖子后台管理
 * <p/>
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/mg/bbs")
public class BBSPostManagerController extends BaseController {

    private static final Logger logger = Logger.getLogger(BBSPostManagerController.class);
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private LibraryInfoDao libraryDao;
    @Resource
    private WebUploadUtils uploadUtils;
    @Resource
    private BBSPostDao bbsPostDao;
    @Resource
    private BBSReplyDao bbsReplyDao;
    @Resource
    private UserInfoDao userInfoDao;

    /*所有主帖*/
    @RequestMapping(value = "/post-list.htm", method = RequestMethod.GET)
    public ModelAndView postList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/bbs/post-list");

        pageBean = new PageBean();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        String userId = WebUtils.getRequestParameterAsString(request, "userId");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        Category category = categoryDao.getBySmpleId(categoryId);

        int showTop = WebUtils.getRequestParameterAsInt(request,"showTop",-1);
        int showGreat = WebUtils.getRequestParameterAsInt(request,"showGreat",-1);
        int showPopular = WebUtils.getRequestParameterAsInt(request,"showPopular",-1);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        /*String today = DateFormatUtils.format(new Date(),"yyyy-MM-dd");
        String startTime = WebUtils.getRequestParameterAsString(request, "startTime", today + " 00:00:00");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime",today + " 23:59:59");*/

        String startTime = WebUtils.getRequestParameterAsString(request, "startTime");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime");

        BBSPostQuery query = new BBSPostQuery();
        query.setUserId(userId);
        query.setCategoryId(categoryId);
        query.setShowTop(showTop);
        query.setShowGreat(showGreat);
        query.setShowPopular(showPopular);
        query.setKw(keyword);
        query.setPublishStartTime(startTime);
        query.setPublishEndTime(endTime);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<BBSPost> bbsPostList = bbsPostDao.getByQuery(query);
        pageBean.setMaxRowCount(bbsPostDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("bbsPostList", bbsPostList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.addObject("category", category);
        return mav;
    }

    /*个人主帖管理*/
    @RequestMapping(value = "/personal/post-list.htm", method = RequestMethod.GET)
    public ModelAndView postList4Personal(HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("mg/bbs/personal/post-list");

        pageBean = new PageBean();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        String userId = userInfo.getUserId();

        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        Category category = categoryDao.getBySmpleId(categoryId);

        int showTop = WebUtils.getRequestParameterAsInt(request,"showTop",-1);
        int showGreat = WebUtils.getRequestParameterAsInt(request,"showGreat",-1);
        int showPopular = WebUtils.getRequestParameterAsInt(request,"showPopular",-1);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        String startTime = WebUtils.getRequestParameterAsString(request, "startTime");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime");

        BBSPostQuery query = new BBSPostQuery();
        query.setUserId(userId);
        query.setCategoryId(categoryId);
        query.setShowTop(showTop);
        query.setShowGreat(showGreat);
        query.setShowPopular(showPopular);
        query.setKw(keyword);
        query.setPublishStartTime(startTime);
        query.setPublishEndTime(endTime);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<BBSPost> bbsPostList = bbsPostDao.getByQuery(query);
        pageBean.setMaxRowCount(bbsPostDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("bbsPostList", bbsPostList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.addObject("category", category);
        return mav;
    }

    /*设置主帖的删除、置顶、精华等等操作*/
    @RequestMapping(value = "/post-setSelectContent.htm", method = RequestMethod.GET)
    public ModelAndView setSelectContent(HttpServletRequest request) {
        //type=delete,showTop,showGreat
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        String postIds = WebUtils.getRequestParameterAsString(request, "id");
        String type = WebUtils.getRequestParameterAsString(request,"type");
        String itemValue = WebUtils.getRequestParameterAsString(request,"itemValue");

        if (StringUtils.isBlank(itemValue) || StringUtils.isBlank(postIds) || StringUtils.isBlank(type)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        String arrays [] = StringUtils.split(postIds,",");
        if(arrays == null || arrays.length == 0){
            mav.addObject("message", "请选择您需要操作的主帖");
            return mav;
        }
        try {
            //删除
            if (StringUtils.equals(type,"delete")) {
                for (String id : arrays) {
                    logger.info(String.format("[bbs] post-delete postId=%s,result=%s",id,bbsPostDao.deleteById(id)));
                }
            }
            //置顶、精华
            else {
                logger.info(String.format("[bbs] post-setUpdateProperties postIds=%s,type=%s,itemValue=%s",
                        Arrays.deepToString(arrays),type,itemValue,
                        bbsPostDao.update(Arrays.asList(arrays),type,Integer.valueOf(itemValue))));
            }

            String isPersonal = WebUtils.getRequestParameterAsString(request,"isPersonal");
            String jumpUrl = StringUtils.equals(isPersonal, "y") ? "mg/bbs/personal/post-list.htm" : ("mg/bbs/post-list.htm?categoryId=" + categoryId);

            mav.addObject("message", "操作成功");
            mav.addObject("href", jumpUrl);

        } catch (Exception e) {
            mav.addObject("message", "设置失败");
            logger.error(String.format("[bbs] post-setUpdateProperties error,postIds=%s,type=%s,itemValue=%s",
                    Arrays.deepToString(arrays),type,itemValue),e);
        }
        return mav;
    }

    /*版主列表*/
    @RequestMapping(value = "/brand-manager.htm", method = RequestMethod.GET)
    public ModelAndView brandManagerShow() {
        ModelAndView mav = new ModelAndView("mg/bbs/brand-manager");

        Map<Category,UserInfo> result = new LinkedHashMap<Category, UserInfo>();
        List<Category> bbsCategoryList = categoryDao.getByParentId(CategoryConstants.CATEGORY_BBS_ROOT,CategoryConstants.CATEGORY_BBS,0,Integer.MAX_VALUE);
        for (Category category : bbsCategoryList) {
            UserInfo userInfo = bbsPostDao.getBBSManager(category.getId());
            result.put(category,userInfo);
        }
        mav.addObject("result",result);
        return mav;
    }

    /*设置版主*/
    @RequestMapping(value = "/brand-manager-set.htm", method = RequestMethod.GET)
    public ModelAndView brandManagerSet(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");

        String brandId = WebUtils.getRequestParameterAsString(request,"brandId");
        String userId = WebUtils.getRequestParameterAsString(request,"userId");

        UserInfo userInfo = userInfoDao.getUserSimpleById(userId);
        Category category = categoryDao.getBySmpleId(brandId);

        String msg = bbsPostDao.setBBSManager(brandId,userId) ? "成功" : "失败";
        mav.addObject("message", "设置 " + userInfo.getNickname() + " 为 " + category.getName() + " 版主" + msg);
        mav.addObject("href", "mg/bbs/brand-manager.htm");

        return mav;
    }

    /*个人回帖列表*/
    @RequestMapping(value = "/personal/reply-list.htm", method = RequestMethod.GET)
    public ModelAndView replyList4Personal(HttpServletRequest request,HttpSession session) {
        ModelAndView mav = new ModelAndView("mg/bbs/personal/reply-list");

        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        String userId = userInfo.getUserId();

        pageBean = new PageBean();
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        int isDelete = WebUtils.getRequestParameterAsInt(request, "isDelete",-1);
        String startTime = WebUtils.getRequestParameterAsString(request, "startTime");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime");

        BBSReplyQuery query = new BBSReplyQuery();
        query.setUserId(userId);
        query.setKw(keyword);
        query.setPublishStartTime(startTime);
        query.setPublishEndTime(endTime);
        query.setIsDelete(isDelete);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<BBSReply> bbsReplyList = bbsReplyDao.getPersonalByQuery(query);
        pageBean.setMaxRowCount(bbsReplyDao.getPersonalCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("bbsReplyList", bbsReplyList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        return mav;
    }

    /*主帖-回帖列表*/
    @RequestMapping(value = "/reply-list.htm", method = RequestMethod.GET)
    public ModelAndView replyLis(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/bbs/reply-list");

        String postId = WebUtils.getRequestParameterAsString(request,"postId");
        BBSPost bbsPost = bbsPostDao.getPostById(postId);

        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        Category category = categoryDao.getBySmpleId(categoryId);

        pageBean = new PageBean(15);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        int isDelete = WebUtils.getRequestParameterAsInt(request, "isDelete",-1);
        String startTime = WebUtils.getRequestParameterAsString(request, "startTime");
        String endTime = WebUtils.getRequestParameterAsString(request,"endTime");

        BBSReplyQuery query = new BBSReplyQuery();
        query.setPostId(postId);
        query.setKw(keyword);
        query.setPublishStartTime(startTime);
        query.setPublishEndTime(endTime);
        query.setKw(keyword);
        query.setIsDelete(isDelete);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<BBSReply> bbsReplyList = bbsReplyDao.getByQuery(query);
        pageBean.setMaxRowCount(bbsReplyDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("bbsReplyList", bbsReplyList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.addObject("category", category);
        mav.addObject("bbsPost", bbsPost);
        return mav;
    }
    /*设置回帖内容*/
    @RequestMapping(value = "/reply-setSelectContent.htm", method = RequestMethod.GET)
    public ModelAndView replySetSelectContent(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        String replyIds = WebUtils.getRequestParameterAsString(request, "replyId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");

        if (StringUtils.isBlank(categoryId) || StringUtils.isBlank(replyIds) || StringUtils.isBlank(postId)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        String arrays [] = StringUtils.split(replyIds,",");
        if(arrays == null || arrays.length == 0){
            mav.addObject("message", "请选择您需要操作的帖子");
            return mav;
        }
        try {
            //删除
            for (String id : arrays) {
                logger.info(String.format("[bbs] reply-delete categoryId=%s,replyId=%s,postId=%s,result=%s",categoryId,id,postId,bbsReplyDao.deleteById(id,postId)));
            }

            String isPersonal = WebUtils.getRequestParameterAsString(request,"isPersonal");
            String jumpUrl = StringUtils.equals(isPersonal, "y") ? "mg/bbs/personal/reply-list.htm" : ("mg/bbs/reply-list.htm?categoryId=" + categoryId + "&postId=" +  postId);

            mav.addObject("message", "删除成功");
            mav.addObject("href", jumpUrl);

        } catch (Exception e) {
            mav.addObject("message", "设置失败");
            logger.error(String.format("[bbs] reply-delete categoryId=%s,replyIds=%s,postId=%s",categoryId,replyIds,postId),e);
        }
        return mav;
    }

    /*主帖-修改界面*/
    @RequestMapping(value = "/post-show.htm", method = RequestMethod.GET)
    public ModelAndView postShow(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/bbs/post-show");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        Category category = categoryDao.getBySmpleId(categoryId);
        BBSPost bbsPost = bbsPostDao.getPostById(postId);

        mav.addObject("category", category);
        mav.addObject("bbsPost", bbsPost);
        mav.addObject("isPersonal", WebUtils.getRequestParameterAsString(request,"isPersonal"));
        return mav;
    }

    /*主帖-修改*/
    @RequestMapping(value = "/post-update.htm", method = RequestMethod.POST)
    public ModelAndView postUpdate(HttpServletRequest request,HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        String categoryId = null;
        try {
            String title = WebUtils.getRequestParameterAsString(request,"title");
            String userId = WebUtils.getRequestParameterAsString(request,"userId");
            String publishTime = WebUtils.getRequestParameterAsString(request,"publishTime");
//        String updateTime = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
            int showTop = WebUtils.getRequestParameterAsInt(request, "showTop", 0);
            int showGreat = WebUtils.getRequestParameterAsInt(request,"showGreat",0);
            String content = WebUtils.getRequestParameterAsString(request,"content");

            BBSPost bbsPost = bbsPostDao.getPostById(postId);
            categoryId = bbsPost.getCategoryId();
            bbsPost.setTitle(title);
            bbsPost.setUserId(userId);
            bbsPost.setPublishTime(DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));
            bbsPost.setUpdateTime(new Date());
            bbsPost.setShowTop(showTop);
            bbsPost.setShowGreat(showGreat);
            bbsPost.setContent(content);
            bbsPost.setLastedUpdateUserId(((UserInfo)session.getAttribute(Constants.SESSIN_USERID)).getUserId());

            bbsPostDao.update(bbsPost);

            String isPersonal = WebUtils.getRequestParameterAsString(request,"isPersonal");
            String jumpUrl = StringUtils.equals(isPersonal, "y") ? "mg/bbs/personal/post-list.htm" : ("mg/bbs/post-list.htm?categoryId=" + categoryId);

            mav.addObject("message", "修改成功");
            mav.addObject("href", jumpUrl);
        } catch (Exception e) {
            mav.addObject("message", "修改失败");
            logger.error(String.format("[bbs] post-update error categoryId=%s,postId=%s",categoryId,postId),e);
        }
        return mav;
    }

    /*回帖-修改界面*/
    @RequestMapping(value = "/reply-show.htm", method = RequestMethod.GET)
    public ModelAndView replyShow(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("mg/bbs/reply-show");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        String replyId = WebUtils.getRequestParameterAsString(request, "replyId");
        Category category = categoryDao.getBySmpleId(categoryId);
        BBSPost bbsPost = bbsPostDao.getPostById(postId);
        BBSReply bbsReply = bbsReplyDao.getReplyById(replyId);

        mav.addObject("category", category);
        mav.addObject("bbsPost", bbsPost);
        mav.addObject("bbsReply", bbsReply);
        mav.addObject("isPersonal",WebUtils.getRequestParameterAsString(request, "isPersonal"));
        return mav;
    }

    /*回帖-修改*/
    @RequestMapping(value = "/reply-update.htm", method = RequestMethod.POST)
    public ModelAndView replyUpdate(HttpServletRequest request,HttpSession session) {
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        String replyId = WebUtils.getRequestParameterAsString(request, "replyId");
        try {
            String publishTime = WebUtils.getRequestParameterAsString(request,"publishTime");
//        String updateTime = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
            String content = WebUtils.getRequestParameterAsString(request,"content");

            BBSReply bbsReply = bbsReplyDao.getReplyById(replyId);
            bbsReply.setPublishTime(DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));
            bbsReply.setUpdateTime(new Date());
            bbsReply.setContent(content);
            bbsReply.setLastedUpdateUserId(((UserInfo)session.getAttribute(Constants.SESSIN_USERID)).getUserId());


            String isPersonal = WebUtils.getRequestParameterAsString(request,"isPersonal");
            String jumpUrl = StringUtils.equals(isPersonal, "y") ? "mg/bbs/personal/reply-list.htm" : ("mg/bbs/reply-list.htm?categoryId=" + categoryId + "&postId=" + postId);
            bbsReplyDao.update(bbsReply);
            mav.addObject("message", "修改成功");
            mav.addObject("href", jumpUrl);
        } catch (Exception e) {
            mav.addObject("message", "修改失败");
            logger.error(String.format("[bbs] post-update error categoryId=%s,postId=%s,replyId=%s",categoryId,postId,replyId),e);
        }
        return mav;
    }

}
