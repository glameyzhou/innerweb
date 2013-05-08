package com.glamey.innerweb.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.PostDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Post;
import com.glamey.innerweb.model.domain.UploadInfo;
import com.glamey.innerweb.model.dto.PostQuery;
import com.glamey.innerweb.util.WebUploadUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
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
    private CategoryDao categoryDao;
    @Resource
    private PostDao postDao;
    @Resource
    private WebUploadUtils uploadUtils;

    /*直接跳转到对应的分类模块首页*/
    @RequestMapping(value = "/{aliasName}/index.htm", method = RequestMethod.GET)
    public ModelAndView index(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-index]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的视图信息-categoryIndex");
            return mav;
        }
        mav.setViewName("mg/frame/frame_post");
        mav.addObject("aliasName", aliasName);
        return mav;
    }

    /*显示分类栏目下左侧菜单*/
    @RequestMapping(value = "/{aliasName}/left.htm", method = RequestMethod.GET)
    public ModelAndView left(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-left]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的视图信息-categoryLeft");
            return mav;
        }
        mav.setViewName("mg/post/left");
        mav.addObject("aliasName", aliasName);
        return mav;
    }

    /*分类列表（指定分类）
    * 默认的都是第一级分类，例如：新闻动态、通告等等
    * */
    @RequestMapping(value = "/{aliasName}/category-list.htm", method = RequestMethod.GET)
    public ModelAndView categoryList(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-category-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoryList");
            return mav;
        }
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        String parentId = categoryParent.getId();
        List<Category> categoryList = categoryDao.getByParentId(parentId, aliasName, 0, Integer.MAX_VALUE);
        mav.addObject("categoryList", categoryList);
        mav.addObject("aliasName", aliasName);
        mav.addObject("categoryParent", categoryParent);
        mav.setViewName("mg/post/category-list");
        return mav;
    }

    /*分类新增、更新页面（指定分类）*/
    @RequestMapping(value = "/{aliasName}/category-show.htm", method = RequestMethod.GET)
    public ModelAndView categoryShow(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-category-show]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoryShow");
            return mav;
        }
        /*获取指定分类的对象*/
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        String opt = "create";
        Category category = new Category();
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId", "");
        if (StringUtils.isNotBlank(categoryId)) {
            category = categoryDao.getById(categoryId);
            opt = "update";
        }
        mav.addObject("opt", opt);
        mav.addObject("category", category);
        mav.addObject("categoryParent", categoryParent);
        mav.setViewName("mg/post/category-show");
        return mav;
    }

    /*分类新增（指定分类）*/
    @RequestMapping(value = "/{aliasName}/category-create.htm", method = RequestMethod.POST)
    public ModelAndView categoryCreate(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-category-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoryCreate");
            return mav;
        }
        Category category = new Category();
        /*图片上传*/
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() != 0)
            return ui.getModelAndView();
        if(StringUtils.isNotBlank(ui.getFilePath()))
            category.setCategoryImage(ui.getFilePath());

        category.setCategoryImage(ui.getFilePath());
        category.setName(WebUtils.getRequestParameterAsString(request, "name"));
        category.setShortName(WebUtils.getRequestParameterAsString(request, "shortName"));
        category.setAliasName(WebUtils.getRequestParameterAsString(request, "aliasName"));
        category.setDescribe(WebUtils.getRequestParameterAsString(request, "describe"));
        category.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", 0));
        category.setShowType(WebUtils.getRequestParameterAsInt(request, "showType", 0));
        category.setCategoryType(WebUtils.getRequestParameterAsString(request, "categoryType"));
        category.setParentId(WebUtils.getRequestParameterAsString(request, "parentId"));
        category.setCategoryTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));

        if (!categoryDao.create(category)) {
            message = "分类新建失败,请稍后重试!";
        } else {
            message = "分类新建成功.";
        }
        mav.addObject("message", message);
        mav.addObject("category", category);
        return mav;
    }

    /*分类修改（指定分类）*/
    @RequestMapping(value = "/{aliasName}/category-update.htm", method = RequestMethod.POST)
    public ModelAndView categoryUpdate(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-category-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoyUpdate");
            return mav;
        }
        Category category = new Category();
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(categoryId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        category = categoryDao.getById(categoryId);
        /*图片上传*/
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() != 0)
            return ui.getModelAndView();
        if(StringUtils.isNotBlank(ui.getFilePath()))
            category.setCategoryImage(ui.getFilePath());

        category.setName(WebUtils.getRequestParameterAsString(request, "name"));
        category.setShortName(WebUtils.getRequestParameterAsString(request, "shortName"));
        category.setAliasName(WebUtils.getRequestParameterAsString(request, "aliasName"));
        category.setDescribe(WebUtils.getRequestParameterAsString(request, "describe"));
        category.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", 0));
        category.setShowType(WebUtils.getRequestParameterAsInt(request, "showType", 0));
        category.setCategoryType(WebUtils.getRequestParameterAsString(request, "categoryType"));

        if (!categoryDao.update(category)) {
            message = "分类更新失败,请稍后重试!";
        } else {
            message = "分类更新成功.";
        }
        mav.addObject("message", message);
        return mav;
    }

    /*删除分类中的图片信息*/
    @RequestMapping(value = "/{aliasName}/category-delImage.htm", method = RequestMethod.GET)
    public ModelAndView delImage(
            @PathVariable String aliasName, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-category-delete-images]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-category-deleteImage");
            return mav;
        }
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(categoryId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要操作的内容");
            return mav;
        }

        if (!categoryDao.deleteImage(categoryId)) {
            message = "分类图片删除失败,请稍后重试!";
        } else {
            message = "分类图片删除成功.";
        }
        mav.addObject("message", message);
        return mav;
    }

    /*删除分类*/
    @RequestMapping(value = "/{aliasName}/category-del.htm", method = RequestMethod.GET)
    public ModelAndView categorDelete(
            @PathVariable String aliasName, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-category-delete]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-category-delete");
            return mav;
        }
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(categoryId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要操作的内容");
            return mav;
        }

        return mav;
    }

    /*文章新增、更新页面-指定分类*/
    @RequestMapping(value = "/{aliasName}/post-show.htm", method = RequestMethod.GET)
    public ModelAndView postShow(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-show]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoryShow");
            return mav;
        }
        /*获取指定分类的对象*/
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        List<Category> categoryList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        String opt = "create";
        Post post = new Post();
        String postId = WebUtils.getRequestParameterAsString(request, "postId", "");
        if (StringUtils.isNotBlank(postId)) {
            post = postDao.getByPostId(postId);
            opt = "update";
        }
        mav.addObject("opt", opt);
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("categoryList", categoryList);
        mav.addObject("aliasName", aliasName);
        mav.addObject("post", post);
        mav.setViewName("mg/post/post-show");
        return mav;
    }

    /*文章创建*/
    @RequestMapping(value = "/{aliasName}/post-create.htm", method = RequestMethod.POST)
    public ModelAndView postCreate(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoryCreate");
            return mav;
        }
        Post post = new Post();
        /*图片上传*/
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() != 0)
            return ui.getModelAndView();
        if(StringUtils.isNotBlank(ui.getFilePath()))
            post.setImage(ui.getFilePath());
        post.setCategoryType(WebUtils.getRequestParameterAsString(request, "categoryType"));
        post.setCategoryId(WebUtils.getRequestParameterAsString(request, "categoryId"));
        post.setTitle(WebUtils.getRequestParameterAsString(request, "title"));
        post.setAuthor(WebUtils.getRequestParameterAsString(request, "author"));
        post.setSource(WebUtils.getRequestParameterAsString(request, "source"));
        //post.setTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
        post.setTime(WebUtils.getRequestParameterAsString(request,"time",DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")));
        post.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", 0));
        post.setShowList(WebUtils.getRequestParameterAsInt(request, "showList", 0));
        post.setApply(WebUtils.getRequestParameterAsInt(request, "apply", 0));
        post.setHot(WebUtils.getRequestParameterAsInt(request, "hot", 0));
        post.setFocusImage(WebUtils.getRequestParameterAsInt(request, "focusImage", 0));
        post.setSummary(WebUtils.getRequestParameterAsString(request, "summary"));
        post.setContent(WebUtils.getRequestParameterAsString(request, "content"));

        if (!postDao.create(post)) {
            message = "文章新建失败,请稍后重试!";
        } else {
            message = "文章新建成功.";
        }
        mav.addObject("message", message);
        mav.addObject("post", post);
        return mav;
    }

    /*文章更新*/
    @RequestMapping(value = "/{aliasName}/post-update.htm", method = RequestMethod.POST)
    public ModelAndView postUpdate(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoyUpdate");
            return mav;
        }
        Post post = new Post();
        String postId = WebUtils.getRequestParameterAsString(request, "postId");
        if (StringUtils.isBlank(postId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        post = postDao.getByPostId(postId);
        /*图片上传*/
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() != 0)
            return ui.getModelAndView();
        if(StringUtils.isNotBlank(ui.getFilePath()))
            post.setImage(ui.getFilePath());

        post.setCategoryType(WebUtils.getRequestParameterAsString(request, "categoryType"));
        post.setCategoryId(WebUtils.getRequestParameterAsString(request, "categoryId"));
        post.setTitle(WebUtils.getRequestParameterAsString(request, "title"));
        post.setAuthor(WebUtils.getRequestParameterAsString(request, "author"));
        post.setSource(WebUtils.getRequestParameterAsString(request, "source"));
        //TODO 调整时间为用户设置时间
        post.setTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
        post.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", 0));
        post.setShowList(WebUtils.getRequestParameterAsInt(request, "showList", 0));
        post.setApply(WebUtils.getRequestParameterAsInt(request, "apply", 0));
        post.setHot(WebUtils.getRequestParameterAsInt(request, "hot", 0));
        post.setFocusImage(WebUtils.getRequestParameterAsInt(request, "focusImage", 0));
        post.setSummary(WebUtils.getRequestParameterAsString(request, "summary"));
        post.setContent(WebUtils.getRequestParameterAsString(request, "content"));

        if (!postDao.update(post)) {
            message = "文章更新失败,请稍后重试!";
        } else {
            message = "文章更新成功.";
        }
        mav.addObject("message", message);

        return mav;
    }

    /*获取指定分类下的所有文章*/
    @RequestMapping(value = "/{aliasName}/post-list.htm", method = RequestMethod.GET)
    public ModelAndView postList(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoryList");
            return mav;
        }

        //获取所有分类
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        List<Category> categoryList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        //请求参数获取
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        String categoryType = categoryParent.getCategoryType();
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String keyword = WebUtils.getRequestParameterAsString(request,"keyword");
        keyword = StringTools.converISO2UTF8(keyword);

        PostQuery query = new PostQuery();
        query.setKeyword(keyword);
        query.setShowIndex(WebUtils.getRequestParameterAsInt(request,"showIndex",-1));
        query.setShowList(WebUtils.getRequestParameterAsInt(request,"showList",-1));
        query.setApply(WebUtils.getRequestParameterAsInt(request,"apply",-1));
        query.setFocusImage(WebUtils.getRequestParameterAsInt(request,"focusImage",-1));
        query.setStartTime(WebUtils.getRequestParameterAsString(request,"startTime"));
        query.setEndTime(WebUtils.getRequestParameterAsString(request,"endTime"));
        query.setCategoryType(categoryType);
        query.setCategoryId(categoryId);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        //获取指定分类下的所有文章
        List<Post> postList = postDao.getByCategoryId(query);
        pageBean.setMaxRowCount(postDao.getCountByCategoryId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("categoryList", categoryList);
        mav.addObject("aliasName", aliasName);
        mav.addObject("categoryParent", categoryParent);

        mav.addObject("postList", postList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);

        mav.setViewName("mg/post/post-list");
        return mav;
    }

    /*页面列表数据的属性设置：删除；设置、取消首页显示、列表显示 、审核、显示焦点图*/
    @RequestMapping(value = "/{aliasName}/post-pageOperate.htm",method = RequestMethod.GET)
    public ModelAndView pageOperate(@PathVariable String aliasName,
                                    HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-post-pageOperate]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoryList");
            return mav;
        }
        //操作符合 1=设置 0=取消
        String flag = WebUtils.getRequestParameterAsString(request,"flag");
        //操作分类 1=删除 2=首页显示 3=列表页显示 4=审核 5=焦点图设置
        String type = WebUtils.getRequestParameterAsString(request,"type");
        //postID集合，中间以","分割
        String postIds = WebUtils.getRequestParameterAsString(request,"postId");

        if(StringUtils.isBlank(flag) || StringUtils.isBlank(type) || StringUtils.isBlank(postIds)){
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的操作标识");
            return mav;
        }
        String postIdArray [] = StringUtils.split(postIds,",");
        try {
            for (String s : postIdArray) {
                logger.info("[manager-post-post-pageOperate] postId=" + s + " type=" + type + " flag=" + flag + " operateResult=" + postDao.pageOperate(s,type,flag));
            }
            mav.addObject("message","操作成功!");
        } catch (Exception e) {
            mav.addObject("message","操作失败,请稍后重试!");
            logger.info("[manager-post-post-pageOperate] error!",e);
        }
        return mav ;
    }

}
