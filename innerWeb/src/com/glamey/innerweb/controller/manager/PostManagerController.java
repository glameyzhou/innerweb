package com.glamey.innerweb.controller.manager;

import com.glamey.framework.utils.FileUtils;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.model.domain.Category;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
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
    private List<String> allowedUploadImages;

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
        String parentId = WebUtils.getRequestParameterAsString(request, "parentId", "0");
        /*
        String parentId = WebUtils.getRequestParameterAsString(request, "parentId", "0");
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);
        List<Category> categoryList = categoryDao.getByParentId(parentId, aliasName, pageBean.getStart(), pageBean.getRowsPerPage());
        pageBean.setMaxRowCount(categoryDao.getCountByParentId(parentId, aliasName));
        pageBean.setMaxPage();
        pageBean.setPageNoList();*/
        Category categoryParent = categoryDao.getByAliasName(aliasName);

        List<Category> categoryList = categoryDao.getByParentId(parentId,aliasName,0,Integer.MAX_VALUE);
        mav.addObject("parentId", parentId);
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
        String opt = "create";
        Category categoryDomain = new Category();
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId", "");
        if (StringUtils.isNotBlank(categoryId)) {
            categoryDomain = categoryDao.getById(categoryId);
            opt = "update";
        }
        mav.addObject("opt", opt);
        mav.addObject("categoryDomain", categoryDomain);
        mav.addObject("category", aliasName);
        mav.setViewName("mg/" + aliasName + "/category-show");
        return mav;
    }

    /*分类新增（指定分类）*/
    @RequestMapping(value = "/{aliasName}/category-create.htm", method = RequestMethod.POST)
    public ModelAndView categoryCreate(
            @PathVariable String category,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-post-category-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(category)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-categoryCreate");
            return mav;
        }
        Category categoryDomain = new Category();
        try {
            /*图片上传*/
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            MultipartFile multipartFile = multipartRequest.getFile("image");
            String originalFilename = multipartFile.getOriginalFilename();
            if (StringUtils.isNotBlank(originalFilename)) {
                if (!isAllowed(originalFilename)) {
                    mav.addObject("message", "上传文件类型不符合,必须是以下几种<br/>" + this.allowedUploadImages.toString());
                    return mav;
                }
                String fileName = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss") + "." + FilenameUtils.getExtension(originalFilename);
                String basePath = request.getRealPath("/") + "/";
                String relativePath = "userfiles/upload/user-images/" + DateFormatUtils.format(new Date(), "yyyy-MM-dd").replaceAll("-", "/") + "/";
                FileUtils.mkdirs(basePath + relativePath);
                multipartFile.transferTo(new File(basePath + relativePath + fileName));
                categoryDomain.setCategoryImage(relativePath + fileName);
            }

            String name = WebUtils.getRequestParameterAsString(request, "name");
            String shortName = WebUtils.getRequestParameterAsString(request, "shortName");
            String aliasName = WebUtils.getRequestParameterAsString(request, "aliasName");
            String description = WebUtils.getRequestParameterAsString(request, "description");
            String showIndex = WebUtils.getRequestParameterAsString(request, "name");

            categoryDomain.setName(WebUtils.getRequestParameterAsString(request, "name"));
            categoryDomain.setShortName(WebUtils.getRequestParameterAsString(request, "shortName"));
            categoryDomain.setAliasName(WebUtils.getRequestParameterAsString(request, "aliasName"));
            categoryDomain.setDescribe(WebUtils.getRequestParameterAsString(request, "describe"));
            categoryDomain.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", 0));
            categoryDomain.setShowType(WebUtils.getRequestParameterAsInt(request, "showType", 0));
            categoryDomain.setCategoryType(WebUtils.getRequestParameterAsString(request, "categoryType"));

            if (categoryDao.create(categoryDomain)) {
                message = "分类新建失败,请稍后重试!";
            } else {
                message = "分类新建成功.";
            }
            mav.addObject("message", message);
            mav.addObject("category", category);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return mav;
    }/*分类修改（指定分类）*/

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
        Category categoryDomain = new Category();
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(categoryId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要更新的内容");
            return mav;
        }
        categoryDomain = categoryDao.getById(categoryId);
        try {
            /*图片上传*/
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            MultipartFile multipartFile = multipartRequest.getFile("image");
            String originalFilename = multipartFile.getOriginalFilename();
            if (StringUtils.isNotBlank(originalFilename)) {
                if (!isAllowed(originalFilename)) {
                    mav.addObject("message", "上传文件类型不符合,必须是以下几种<br/>" + this.allowedUploadImages.toString());
                    return mav;
                }
                String fileName = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss") + "." + FilenameUtils.getExtension(originalFilename);
                String basePath = request.getRealPath("/") + "/";
                String relativePath = "userfiles/upload/user-images/" + DateFormatUtils.format(new Date(), "yyyy-MM-dd").replaceAll("-", "/") + "/";
                FileUtils.mkdirs(basePath + relativePath);
                multipartFile.transferTo(new File(basePath + relativePath + fileName));
                categoryDomain.setCategoryImage(relativePath + fileName);
            }

            categoryDomain.setName(WebUtils.getRequestParameterAsString(request, "name"));
            categoryDomain.setShortName(WebUtils.getRequestParameterAsString(request, "shortName"));
            categoryDomain.setAliasName(WebUtils.getRequestParameterAsString(request, "aliasName"));
            categoryDomain.setDescribe(WebUtils.getRequestParameterAsString(request, "describe"));
            categoryDomain.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", 0));
            categoryDomain.setShowType(WebUtils.getRequestParameterAsInt(request, "showType", 0));
            categoryDomain.setCategoryType(WebUtils.getRequestParameterAsString(request, "categoryType"));

            if (categoryDao.update(categoryDomain)) {
                message = "分类更新失败,请稍后重试!";
            } else {
                message = "分类更新成功.";
            }
            mav.addObject("message", message);
            mav.addObject("aliasName", aliasName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return mav;
    }

    /**
     * 检测上传的图片是否为指定格式
     *
     * @param fileName
     * @return false=不允许上传 true=允许上传
     */
    public boolean isAllowed(String fileName) {
        for (String suffix : this.allowedUploadImages) {
            if (StringUtils.equalsIgnoreCase(suffix,
                    FilenameUtils.getExtension(fileName))) {
                return true;
            }
        }
        return false;
    }
}
