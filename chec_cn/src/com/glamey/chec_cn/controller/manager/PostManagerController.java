package com.glamey.chec_cn.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.PostDao;
import com.glamey.chec_cn.model.domain.*;
import com.glamey.chec_cn.model.dto.PostQuery;
import com.glamey.chec_cn.util.WebUploadUtils;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 内容管理
 * Created with IntelliJ IDEA.
 * User: zy
 * Date: 13-5-4 上午12:08
 */
@Controller
@RequestMapping(value = "/mg/post")
public class PostManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(PostManagerController.class);

    @Resource
    private PostDao postDao;
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private WebUploadUtils uploadUtils;


    /*@RequestMapping(value = "/post-show.htm", method = RequestMethod.GET)
    public ModelAndView postShow(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-postShow]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("mg/post/post-show");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        Category category = categoryDao.getById(categoryId);
        String opt = "create";
        Post post = new Post();
        String postId = WebUtils.getRequestParameterAsString(request,"postId");
        post.setTime(DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
        post.setIsValid(1);
        if(StringUtils.isNotBlank(postId)){
            post = postDao.getByPostId(postId);
            opt = "update" ;
        }
        mav.addObject("opt", opt);
        mav.addObject("post", post);
        mav.addObject("category", category);
        return mav;
    }
    *//*文章创建*//*
    @RequestMapping(value = "/post-create.htm", method = RequestMethod.POST)
    public ModelAndView postCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        Post post = new Post();
        *//*图片上传*//*
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() == 2)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            post.setImage(ui.getFilePath());

        post.setCategoryId(WebUtils.getRequestParameterAsString(request,"categoryId"));
        post.setTitle(WebUtils.getRequestParameterAsString(request, "title"));
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
//        post.setAuthor(userInfo.getUserId());
        post.setAuthor(WebUtils.getRequestParameterAsString(request,"author"));
        post.setSource(WebUtils.getRequestParameterAsString(request, "source"));
        String time = WebUtils.getRequestParameterAsString(request, "time");
        if (StringUtils.isBlank(time)) {
            post.setTime(WebUtils.getRequestParameterAsString(request, "time", DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")));
        } else {
            post.setTime(time);
        }
        post.setSummary(WebUtils.getRequestParameterAsString(request, "summary"));
        post.setContent(WebUtils.getRequestParameterAsString(request, "content"));
        post.setIsValid(WebUtils.getRequestParameterAsInt(request, "isValid", 1));

        if (!postDao.create(post)) {
            message = "文章新建失败,请稍后重试!";
        } else {
            message = "文章新建成功.";
            mav.addObject("href", "mg/post/post-list.htm?categoryId=" + post.getCategoryId());
        }
        mav.addObject("message", message);
        mav.addObject("post", post);
        return mav;
    }

    *//*文章更新*//*
    @RequestMapping(value = "/post-update.htm", method = RequestMethod.POST)
    public ModelAndView postUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        Post post ;
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        if (StringUtils.isBlank(postId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        post = postDao.getByPostId(postId);
        *//*图片上传*//*
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() == 2)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            post.setImage(ui.getFilePath());

        post.setCategoryId(WebUtils.getRequestParameterAsString(request,"categoryId"));
        post.setTitle(WebUtils.getRequestParameterAsString(request, "title"));
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
//        post.setAuthor(userInfo.getUserId());
        post.setAuthor(WebUtils.getRequestParameterAsString(request,"author"));
        post.setSource(WebUtils.getRequestParameterAsString(request, "source"));
        String time = WebUtils.getRequestParameterAsString(request, "time");
        if (StringUtils.isBlank(time)) {
            post.setTime(WebUtils.getRequestParameterAsString(request, "time", DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")));
        } else {
            post.setTime(time);
        }
        post.setSummary(WebUtils.getRequestParameterAsString(request, "summary"));
        post.setContent(WebUtils.getRequestParameterAsString(request, "content"));
        post.setIsValid(WebUtils.getRequestParameterAsInt(request, "isValid", 1));

        if (!postDao.update(post)) {
            message = "文章更新失败,请稍后重试!";
        } else {
            message = "文章更新成功.";
            mav.addObject("href", "mg/post/post-list.htm?categoryId=" + post.getCategoryId());
        }
        mav.addObject("message", message);
        return mav;
    }

    *//*获取指定分类下的所有文章*//*
    @RequestMapping(value = "/post-list.htm", method = RequestMethod.GET)
    public ModelAndView postList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        //请求参数获取
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        Category category = categoryDao.getById(categoryId);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);
        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        int isValid = WebUtils.getRequestParameterAsInt(request, "isValid", -1);
        PostQuery query = new PostQuery();
        query.setKeyword(keyword);
        query.setStartTime(WebUtils.getRequestParameterAsString(request, "startTime"));
        query.setEndTime(WebUtils.getRequestParameterAsString(request, "endTime"));
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        query.setIsValid(isValid);
        query.setCategoryId(categoryId);

        //获取指定分类下的所有文章
        List<Post> postList = postDao.getPostList(query);
        pageBean.setMaxRowCount(postDao.getCountPostList(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("postList", postList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.addObject("category", category);
        mav.setViewName("mg/post/post-list");
        return mav;
    }

    @RequestMapping(value = "/post-del.htm", method = RequestMethod.GET)
    public ModelAndView postDel(HttpServletRequest request) {
        logger.info("[manager-post-post-postDel]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        //postID集合，中间以","分割
        String postIds = WebUtils.getRequestParameterAsString(request, "postId");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");

        if (StringUtils.isBlank(postIds)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的操作标识");
            return mav;
        }
        String postIdArray[] = StringUtils.split(postIds, ",");
        try {
            for (String s : postIdArray) {
                logger.info("[manager-post-post-postDel] postId=" + s + " operateResult=" + postDao.deleteById(s));
            }
            mav.addObject("message", "操作成功!");
            mav.addObject("href", "mg/post/post-list.htm?categoryId=" + categoryId);
        } catch (Exception e) {
            mav.addObject("message", "操作失败,请稍后重试!");
            logger.info("[manager-post-post-postDel] error!", e);
        }
        return mav;
    }


    *//*设置图书的属性*//*
    @RequestMapping(value = "/post-setSelectContent.htm", method = RequestMethod.GET)
    public ModelAndView setSelectContent(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String libIds = WebUtils.getRequestParameterAsString(request, "id");
        String category = WebUtils.getRequestParameterAsString(request,"category");
        String type = WebUtils.getRequestParameterAsString(request,"type");
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        if (StringUtils.isBlank(libIds) || StringUtils.isBlank(category) || StringUtils.isBlank(type)) {
            mav.addObject("message", "操作无效");
            return mav;
        }

        String arrays [] = StringUtils.split(libIds,",");
        if(arrays == null || arrays.length == 0){
            mav.addObject("message", "请选择您需要操作内容");
            return mav;
        }

        try {
            if (StringUtils.equals(category,"del")) {
                for (String s : arrays) {
                    logger.info("[manager-post-post-setSelectContent] postId=" + s + " operateResult=" + postDao.deleteById(s));
                }
            }

            if (StringUtils.equals(category,"valid")) {
                for (String s : arrays) {
                    Post p = postDao.getByPostId(s);
                    p.setIsValid(Integer.valueOf(type));
                    postDao.update(p);
                }
            }

            mav.addObject("message", "操作成功!");
            mav.addObject("href", "mg/post/post-list.htm?categoryId=" + categoryId);
        } catch (Exception e) {
            mav.addObject("message", "操作失败,请稍后重试!");
            logger.info("[manager-post-post-setSelectContent] error!", e);
        }
        return mav;
    }*/

}
