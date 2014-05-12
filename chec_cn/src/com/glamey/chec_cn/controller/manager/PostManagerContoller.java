package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.PostDao;
import com.glamey.chec_cn.dao.UserInfoDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Post;
import com.glamey.chec_cn.model.domain.UserInfo;
import com.glamey.chec_cn.model.dto.PostQuery;
import com.glamey.chec_cn.util.DateUtils;
import com.glamey.chec_cn.util.WebUploadUtils;
import com.glamey.chec_cn.util.XMLUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.RegexUtils;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/mg/post")
public class PostManagerContoller extends BaseController {
    public static final Logger logger = Logger.getLogger(PostManagerContoller.class);

    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private UserInfoDao userInfoDao;
    @Autowired
    private WebUploadUtils uploadUtils;

    /*获取指定分类下的所有文章*/
    @RequestMapping(value = "/post-list.do", method = RequestMethod.GET)
    public ModelAndView postList(HttpServletRequest request, HttpSession session) {
        logger.info("[manager-post-list]" + request.getRequestURI());
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        ModelAndView mav = new ModelAndView();
        //请求参数获取
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");

        if (StringUtils.isBlank(categoryId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "服务器繁忙，请稍后重试!");
            return mav;
        }

        Category category = categoryDao.getById(categoryId);
        Category pCategory = categoryDao.getBySmpleId(category.getParentId());
        /**
         * 详情页面显示
         */
        if (category.getShowType() == 1) {
            Post post = new Post();
            PostQuery query = new PostQuery();
            query.setCategoryId(categoryId);
            query.setStart(0);
            query.setNum(1);
            List<Post> list = postDao.getByQuery(query);
            if (CollectionUtils.isEmpty(list)) {
                post.setCategoryId(categoryId);
                post.setCategoryType(category.getCategoryType());
                post.setPublishTime(new Date());
                post.setAuthor(userInfo.getNickname());
            } else {
                post = postDao.getByPostId(list.get(0).getId());
                if (StringUtils.isBlank(post.getAuthor()))
                    post.setAuthor(userInfo.getNickname());
            }
            mav.setViewName("mg/post/post-show");
            mav.addObject("post", post);
            mav.addObject("category", category);
            mav.addObject("pCategory", pCategory);
            mav.addObject("opt", "create");
            return mav;
        }
        /**
         * 列表方式显示
         */
        else {
            int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
            pageBean = new PageBean(Constants.rowsPerPageFront);
            pageBean.setCurPage(curPage);

            String keyword = WebUtils.getRequestParameterAsString(request, "kw");
            keyword = StringTools.converISO2UTF8(keyword);
            PostQuery query = new PostQuery();
            query.setKw(keyword);
            query.setPublishStartTime(WebUtils.getRequestParameterAsString(request, "startTime"));
            query.setPublishEndTime(WebUtils.getRequestParameterAsString(request, "endTime"));
            query.setCategoryId(categoryId);
            query.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", -1));
            query.setShowList(WebUtils.getRequestParameterAsInt(request, "showList", -1));
            query.setShowFocusImage(WebUtils.getRequestParameterAsInt(request, "showFocusImage", -1));
            query.setShowTop(WebUtils.getRequestParameterAsInt(request, "showTop", -1));

            query.setStart(pageBean.getStart());
            query.setNum(pageBean.getRowsPerPage());

            List<Post> postList = postDao.getByQuery(query);
            pageBean.setMaxRowCount(postDao.getCountByQuery(query));
            pageBean.setMaxPage();
            pageBean.setPageNoList();

            mav.addObject("postList", postList);
            mav.addObject("pageBean", pageBean);
            mav.addObject("query", query);
            mav.addObject("category", category);
            mav.addObject("pCategory", pCategory);
            mav.setViewName("mg/post/post-list");
        }
        return mav;
    }

    /*添加-修改页面*/
    @RequestMapping(value = "/post-show.do", method = RequestMethod.GET)
    public ModelAndView postShow(HttpServletRequest request, HttpSession session) {
        logger.info("[manager-post-postShow]" + request.getRequestURI());
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        ModelAndView mav = new ModelAndView("mg/post/post-show");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        Category category = categoryDao.getById(categoryId);
        Category pCategory = new Category();
        String opt = "create";
        Post post = new Post();
        post.setPublishTime(new Date());
        post.setAuthor(userInfo.getNickname());
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        if (StringUtils.isNotBlank(postId)) {
            post = postDao.getByPostId(postId);
            if (StringUtils.isBlank(post.getAuthor()))
                post.setAuthor(userInfo.getNickname());
            pCategory = categoryDao.getBySmpleId(category.getParentId());
            opt = "update";
        }
        mav.addObject("opt", opt);
        mav.addObject("post", post);
        mav.addObject("category", category);
        mav.addObject("pCategory", pCategory);
        return mav;
    }

    /*文章创建*/
    @RequestMapping(value = "/post-create.do", method = RequestMethod.POST)
    public ModelAndView postCreate(HttpServletRequest request, HttpSession session) {
        logger.info("[manager-post-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        Post post = new Post();
        /*图片上传*/
        /*UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() == 2)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            post.setFocusImage(ui.getFilePath());*/

        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String title = WebUtils.getRequestParameterAsString(request, "title");
        String source = WebUtils.getRequestParameterAsString(request, "source");
        String author = WebUtils.getRequestParameterAsString(request, "author");
        String publishTime = WebUtils.getRequestParameterAsString(request, "publishTime");
        int showIndex = WebUtils.getRequestParameterAsInt(request, "showIndex", 1);
        int showList = WebUtils.getRequestParameterAsInt(request, "showList", 1);
        int showFocusImage = WebUtils.getRequestParameterAsInt(request, "showFocusImage", 0);
        int showTop = WebUtils.getRequestParameterAsInt(request, "showTop", 0);
        String summary = WebUtils.getRequestParameterAsString(request, "summary");
        String content = WebUtils.getRequestParameterAsString(request, "content");

        Category category = categoryDao.getBySmpleId(categoryId);
        post.setCategoryId(categoryId);
        post.setCategoryType(category.getCategoryType());
        post.setTitle(title);
        post.setSource(source);
        post.setAuthor(StringUtils.isBlank(author) ? userInfo.getNickname() : author);
        post.setShowIndex(showIndex);
        post.setShowList(showList);
        post.setShowFocusImage(showFocusImage);
        post.setShowTop(showTop);
        post.setSummary(summary);
        post.setContent(content);
        post.setPublishTime(StringUtils.isBlank(publishTime) ? new Date() : DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));
        post.setCategoryId(WebUtils.getRequestParameterAsString(request, "categoryId"));

        //从正文中提取第一张图片作为焦点图
        String focusImage = getContentImage(request, post.getContent());
        if (StringUtils.isNotBlank(focusImage))
            post.setFocusImage(focusImage);

        String returnPostId = postDao.createReturnId(post);
        if (StringUtils.isBlank(returnPostId)) {
            message = "文章新建失败,请稍后重试!";
        } else {
            message = "文章新建成功.";
            mav.addObject("href", "mg/post/post-list.do?categoryId=" + post.getCategoryId() + "&type=" + category.getCategoryType());

            //进行焦点图的更新
            if (StringUtils.equals(post.getCategoryType(), CategoryConstants.CATEGORY_NEWS)) {
                PostQuery query = new PostQuery();
                query.setShowIndex(1);
                query.setShowFocusImage(1);
                query.setStart(0);
                query.setNum(10);
                List<Post> list = postDao.getByQuery(query);
                XMLUtils.buildXML(list, request);
            }
        }
        mav.addObject("message", message);
        mav.addObject("post", post);
        return mav;
    }

    /*文章更新*/
    @RequestMapping(value = "/post-update.do", method = RequestMethod.POST)
    public ModelAndView postUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        Post post;
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        if (StringUtils.isBlank(postId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        post = postDao.getByPostId(postId);
        /*图片上传*/
        /*UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() == 2)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            post.setFocusImage(ui.getFilePath());*/

        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String title = WebUtils.getRequestParameterAsString(request, "title");
        String source = WebUtils.getRequestParameterAsString(request, "source");
        String author = WebUtils.getRequestParameterAsString(request, "author");
        String publishTime = WebUtils.getRequestParameterAsString(request, "publishTime");
        int showIndex = WebUtils.getRequestParameterAsInt(request, "showIndex", 1);
        int showList = WebUtils.getRequestParameterAsInt(request, "showList", 1);
        int showFocusImage = WebUtils.getRequestParameterAsInt(request, "showFocusImage", 0);
        int showTop = WebUtils.getRequestParameterAsInt(request, "showTop", 0);
        String summary = WebUtils.getRequestParameterAsString(request, "summary");
        String content = WebUtils.getRequestParameterAsString(request, "content");

        Category category = categoryDao.getBySmpleId(categoryId);
        post.setCategoryId(categoryId);
        post.setCategoryType(category.getCategoryType());
        post.setTitle(title);
        post.setSource(source);
        post.setAuthor(StringUtils.isBlank(author) ? userInfo.getNickname() : author);
        post.setShowIndex(showIndex);
        post.setShowList(showList);
        post.setShowFocusImage(showFocusImage);
        post.setShowTop(showTop);
        post.setSummary(summary);
        post.setContent(content);
        post.setPublishTime(StringUtils.isBlank(publishTime) ? new Date() : DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));
        post.setCategoryId(WebUtils.getRequestParameterAsString(request, "categoryId"));

        //从正文中提取第一张图片作为焦点图
        String focusImage = getContentImage(request, post.getContent());
        if (StringUtils.isNotBlank(focusImage))
            post.setFocusImage(focusImage);

        if (!postDao.update(post)) {
            message = "文章更新失败,请稍后重试!";
        } else {
            message = "文章更新成功.";
            mav.addObject("href", "mg/post/post-list.do?categoryId=" + post.getCategoryId() + "&type=" + category.getCategoryType());

            //进行焦点图的更新
            if (StringUtils.equals(post.getCategoryType(), CategoryConstants.CATEGORY_NEWS)) {
                PostQuery query = new PostQuery();
                query.setShowIndex(1);
                query.setShowFocusImage(1);
                query.setStart(0);
                query.setNum(10);
                List<Post> list = postDao.getByQuery(query);
                XMLUtils.buildXML(list, request);
            }
        }
        mav.addObject("message", message);
        return mav;
    }


    private static String getContentImage(HttpServletRequest request, String source) {
        if (StringUtils.isBlank(source)) {
            return null;
        }
        String image = null;
        String reg = "<img\\s*.+?src=[\"|'| ](.+?(jpg|jpeg|png|bmp|gif|ico))[\"|'| ].+?>";
        List<String> images = RegexUtils.getStringGoup1(source, reg);
        if (images != null && images.size() > 0) {
            /*int size = images.size();
            image = images.get(size - 1);*/
            image = images.get(0);

            if (image.toLowerCase().startsWith("http")) {
                return image;
            }
            /*String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
            return basePath + image;*/
            return image;
        }
        return image;
    }


    @RequestMapping(value = "/post-del.do", method = RequestMethod.GET)
    public ModelAndView postDel(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String type = WebUtils.getRequestParameterAsString(request, "type");
        if (StringUtils.isBlank(postId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到对应的信息");
            return mav;
        }
        boolean result = false;
        try {
            String arrays[] = StringUtils.split(postId, ",");
            for (String array : arrays) {
                postDao.deleteById(array);
            }
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!result) {
            message = "内容删除失败,请稍后重试!";
        } else {
            message = "内容删除成功";
            mav.addObject("href", "mg/post/post-list.do?categoryId=" + categoryId + "&type=" + type);

            //进行焦点图的更新
            if (StringUtils.isNotBlank(categoryId)) {
                Category category = categoryDao.getById(categoryId);
                if (StringUtils.equals(category.getCategoryType(), CategoryConstants.CATEGORY_NEWS)) {
                    PostQuery query = new PostQuery();
                    query.setShowIndex(1);
                    query.setShowFocusImage(1);
                    query.setStart(0);
                    query.setNum(10);
                    List<Post> list = postDao.getByQuery(query);
                    XMLUtils.buildXML(list, request);
                }
            }
        }
        mav.addObject("message", message);
        return mav;
    }
}
