package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.LinksDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Links;
import com.glamey.chec_cn.model.domain.UploadInfo;
import com.glamey.chec_cn.model.dto.LinksQuery;
import com.glamey.chec_cn.util.WebUploadUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
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
import java.util.Date;
import java.util.List;

/**
 * 链接管理
 * Created with IntelliJ IDEA.
 * User: zy
 * Date: 13-5-4 上午12:08
 */
@Controller
@RequestMapping(value = "/mg/links")
public class LinksManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(LinksManagerController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private LinksDao linksDao;
    @Resource
    private WebUploadUtils uploadUtils;

    /*分类列表（指定分类）*/
    @Deprecated
    @RequestMapping(value = "/allroot.htm", method = RequestMethod.GET)
    public ModelAndView allroot(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-category-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        List<Category> categoryList = categoryDao.getByParentId(CategoryConstants.PARENTID, CategoryConstants.CATEGORY_LINKS, 0, Integer.MAX_VALUE);
        mav.addObject("categoryList", categoryList);
        mav.setViewName("mg/links/allroot");
        return mav;
    }
    /*链接分类管理*/
    @RequestMapping(value = "/{aliasName}/category-list.htm", method = RequestMethod.GET)
    public ModelAndView categoryList(
    		@PathVariable String aliasName ,
    		HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-category-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if(StringUtils.isBlank(aliasName)){
        	mav.setViewName("common/message");
        	mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        List<Category> categoryList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);
        mav.addObject("categoryList", categoryList);
        mav.addObject("categoryParent", categoryParent);
        mav.setViewName("mg/links/category-list");
        return mav;
    }
    
    /*链接分类展示页面*/
    @RequestMapping(value = "/{aliasName}/category-show.htm", method = RequestMethod.GET)
    public ModelAndView categoryShow(
    		@PathVariable String aliasName ,
    		HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-category-show]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if(StringUtils.isBlank(aliasName)){
        	mav.setViewName("common/message");
        	mav.addObject("message", "cant's find the links category!");
            return mav;
        }
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
        mav.setViewName("mg/links/category-show");
        return mav;
    }
    /*分类新增（指定分类）*/
    @RequestMapping(value = "/{aliasName}/category-create.htm", method = RequestMethod.POST)
    public ModelAndView categoryCreate(
            @PathVariable String aliasName,
            HttpServletRequest request,HttpServletResponse response) {
        logger.info("[manager-post-category-create]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if(StringUtils.isBlank(aliasName)){
        	mav.setViewName("common/message");
        	mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        Category category = new Category();
        /*图片上传(非必须参数)*/
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() == 2)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            category.setCategoryImage(ui.getFilePath());

        category.setCategoryImage(ui.getFilePath());
        category.setName(WebUtils.getRequestParameterAsString(request, "name"));
        category.setShortName(WebUtils.getRequestParameterAsString(request, "shortName"));
        category.setAliasName(WebUtils.getRequestParameterAsString(request, "aliasName"));
        category.setDescribe(WebUtils.getRequestParameterAsString(request, "describe"));
        category.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", 0));
        category.setShowType(WebUtils.getRequestParameterAsInt(request, "showType", 0));
        category.setCategoryOrder(WebUtils.getRequestParameterAsInt(request, "categoryOrder", 0));
        category.setCategoryType(WebUtils.getRequestParameterAsString(request, "categoryType"));
        category.setParentId(WebUtils.getRequestParameterAsString(request, "parentId"));
        category.setCategoryTime(new Date());

        if (!categoryDao.create(category)) {
            message = "分类新建失败,请稍后重试!";
        } else {
            message = "分类新建成功.";
            mav.addObject("href", "mg/links/" + aliasName + "/category-list.htm");
        }
        mav.addObject("message", message);
        mav.addObject("category", category);
        return mav;
    }

    /*分类修改（指定分类）*/
    @RequestMapping(value = "/{aliasName}/category-update.htm", method = RequestMethod.POST)
    public ModelAndView categoryUpdate(
            @PathVariable String aliasName,
            HttpServletRequest request,HttpServletResponse response) {
        logger.info("[manager-post-category-update]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if(StringUtils.isBlank(aliasName)){
        	mav.setViewName("common/message");
        	mav.addObject("message", "cant's find the links category!");
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
        if (ui.getResultCode() == 2)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            category.setCategoryImage(ui.getFilePath());

        category.setName(WebUtils.getRequestParameterAsString(request, "name"));
        category.setShortName(WebUtils.getRequestParameterAsString(request, "shortName"));
        category.setAliasName(WebUtils.getRequestParameterAsString(request, "aliasName"));
        category.setDescribe(WebUtils.getRequestParameterAsString(request, "describe"));
        category.setShowIndex(WebUtils.getRequestParameterAsInt(request, "showIndex", 0));
        category.setShowType(WebUtils.getRequestParameterAsInt(request, "showType", 0));
        category.setCategoryOrder(WebUtils.getRequestParameterAsInt(request, "categoryOrder", 0));
        category.setCategoryType(WebUtils.getRequestParameterAsString(request, "categoryType"));

        if (!categoryDao.update(category)) {
            message = "分类更新失败,请稍后重试!";
        } else {
            message = "分类更新成功.";
            mav.addObject("href", "mg/links/" + aliasName + "/category-list.htm");
        }
        mav.addObject("message", message);
        return mav;
    }

    /*删除分类中的图片信息*/
    @RequestMapping(value = "/{aliasName}/category-delImage.htm", method = RequestMethod.GET)
    public ModelAndView delImage(
            @PathVariable String aliasName, HttpServletRequest request) {
        logger.info("[manager-post-category-delete-images]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if(StringUtils.isBlank(aliasName)){
        	mav.setViewName("common/message");
        	mav.addObject("message", "cant's find the links category!");
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
    public ModelAndView categoryDelete(
            @PathVariable String aliasName, HttpServletRequest request) {
        logger.info("[manager-post-category-delete]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if(StringUtils.isBlank(aliasName)){
        	mav.setViewName("common/message");
        	mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(categoryId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要操作的内容");
            return mav;
        }
        //需要删除对下旗下的所有链接
        if(categoryDao.deleteById(categoryId, aliasName)){
        	mav.addObject("message", "分类删除成功,旗下所有链接将无归类!");
        	mav.addObject("href", "mg/links/" + aliasName + "/category-list.htm");
        }
        else{
        	mav.addObject("message", "分类删除失败，请稍后重试!");
        }
        return mav;
    }
    
    
    /*链接修改、新增显示页面*/
    @RequestMapping(value = "/{aliasName}/links-show.htm", method = RequestMethod.GET)
    public ModelAndView linksShow(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        //获取根结点
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        //当前结点
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        categoryId = StringUtils.isNotBlank(categoryId) ? categoryId : categoryParent.getId();
        Category category = categoryDao.getById(categoryId);

        String opt = "create";
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        Links links = new Links();
        if (StringUtils.isNotBlank(linksId)) {
            opt = "update";
            links = linksDao.getById(linksId);
        }
        links.setCategoryType(categoryParent.getCategoryType());
        links.setCategoryId(categoryId);
        mav.addObject("opt", opt);
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("category",category);
        mav.addObject("links", links);
        mav.setViewName("mg/links/links-show");
        return mav;
    }

    /*链接新增*/
    @RequestMapping(value = "/{aliasName}/links-create.htm", method = RequestMethod.POST)
    public ModelAndView linksCreate(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        //获取根结点
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        //当前结点
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        categoryId = StringUtils.isNotBlank(categoryId) ? categoryId : categoryParent.getId();
        Category category = categoryDao.getById(categoryId);

        Links links = new Links();
        //处理图片,非必须参数
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() == 2)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            links.setImage(ui.getFilePath());

        links.setCategoryType(categoryParent.getCategoryType());
        links.setCategoryId(categoryId);
        links.setName(WebUtils.getRequestParameterAsString(request, "name"));
        links.setUrl(WebUtils.getRequestParameterAsString(request, "url"));
        links.setOrder(WebUtils.getRequestParameterAsInt(request, "order", 0));
        links.setShowIndex(WebUtils.getRequestParameterAsInt(request,"showIndex",1));

        if (linksDao.create(links)) {
            mav.addObject("message", "创建成功!");
            mav.addObject("href", "mg/links/" + aliasName+ "/links-list.htm?categoryId=" + category.getId());
        } else {
            mav.addObject("message", "创建失败!");
        }
        return mav;
    }

    /*链接更新*/
    @RequestMapping(value = "/{aliasName}/links-update.htm", method = RequestMethod.POST)
    public ModelAndView linksUpdate(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        if (StringUtils.isBlank(linksId)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }

        //获取根结点
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        //当前结点
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        categoryId = StringUtils.isNotBlank(categoryId) ? categoryId : categoryParent.getId();
        Category category = categoryDao.getById(categoryId);

        Links links = linksDao.getById(linksId);
        //处理图片,非必须参数
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() == 2)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            links.setImage(ui.getFilePath());

        links.setCategoryType(categoryParent.getCategoryType());
        links.setCategoryId(categoryId);
        links.setName(WebUtils.getRequestParameterAsString(request, "name"));
        links.setUrl(WebUtils.getRequestParameterAsString(request, "url"));
        links.setOrder(WebUtils.getRequestParameterAsInt(request, "order", 0));
        links.setShowIndex(WebUtils.getRequestParameterAsInt(request,"showIndex",1));

        if (linksDao.update(links)) {
            mav.addObject("message", "更新成功!");
            mav.addObject("href", "mg/links/" + aliasName+ "/links-list.htm?categoryId=" + category.getId());
        } else {
            mav.addObject("message", "更新失败!");
        }
        return mav;
    }

    /*链接删除*/
    @RequestMapping(value = "/{aliasName}/links-del.htm", method = RequestMethod.GET)
    public ModelAndView linksDel(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        String categoyId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        if (StringUtils.isBlank(linksId)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        try {
            String linksIdArray[] = StringUtils.split(linksId, ",");
            for (String s : linksIdArray) {
                logger.info("[links-del] linksId=" + s + linksDao.deleteById(s));
            }
            mav.addObject("message", "删除成功!");
            mav.addObject("href", "mg/links/" + aliasName+ "/links-list.htm?categoryId=" + categoyId);
        } catch (Exception e) {
            logger.info("[links-del] error " + e);
            mav.addObject("message", "delete the links failure!");
        }
        mav.addObject("categoryParent", categoryParent);
        return mav;
    }

    /*获取指定分来下的所有链接*/
    @RequestMapping(value = "/{aliasName}/links-list.htm", method = RequestMethod.GET)
    public ModelAndView linksList(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "can't find the links category!");
            return mav;
        }
        //根结点
        Category categoryParent = categoryDao.getByAliasName(aliasName);
        //当前结点
        String categoryId = WebUtils.getRequestParameterAsString(request,"categoryId");
        categoryId = StringUtils.isNotBlank(categoryId) ? categoryId : categoryParent.getId();
        Category category = categoryDao.getById(categoryId);
        //根结点下所有的分类信息
        List<Category> categoryList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);
        
        //当前节点下的内容列表
        String keyword = WebUtils.getRequestParameterAsString(request,"keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        int showIndex = WebUtils.getRequestParameterAsInt(request,"showIndex",-1);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        LinksQuery query = new LinksQuery();
        query.setCategoryType(categoryParent.getCategoryType());
        query.setCategoryId(categoryId);
        query.setShowIndex(showIndex);
        query.setKeyword(keyword);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
       
        List<Links> linksList = linksDao.getByParentId(query);
        pageBean.setMaxRowCount(linksDao.getCountByParentId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("category", category);
        mav.addObject("linksList", linksList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.addObject("categoryList", categoryList);
        mav.setViewName("mg/links/links-list");
        return mav;
    }
    
    /*删除链接中的图片信息*/
    @RequestMapping(value = "/{aliasName}/links-delImage.htm", method = RequestMethod.GET)
    public ModelAndView delImage(
            @PathVariable String aliasName, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-delete-images]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message", "无对应的分类列表-category-deleteImage");
            return mav;
        }
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        if (StringUtils.isBlank(linksId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要操作的内容");
            return mav;
        }

        if (!categoryDao.deleteImage(linksId)) {
            message = "链接图片删除失败,请稍后重试!";
        } else {
            message = "链接图片删除成功.";
        }
        mav.addObject("message", message);
        return mav;
    }
}
