package com.glamey.innerweb.controller.manager;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Links;
import com.glamey.innerweb.model.domain.UploadInfo;
import com.glamey.innerweb.model.dto.LinksQuery;
import com.glamey.innerweb.util.WebUploadUtils;

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

    /*首页*/
    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-index]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mg/frame/frame_links");
        return mav;
    }

    /*显示分类栏目下左侧菜单*/
    @RequestMapping(value = "/left.htm", method = RequestMethod.GET)
    public ModelAndView left(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-left]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("mg/links/left");
        List<Category> categoryList = categoryDao.getByParentId("0", "links", 0, Integer.MAX_VALUE);
        mav.addObject("categoryList", categoryList);
        return mav;
    }

    /*分类列表（指定分类）*/
    @RequestMapping(value = "/allroot.htm", method = RequestMethod.GET)
    public ModelAndView allroot(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-category-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        List<Category> categoryList = categoryDao.getByParentId("0", "links", 0, Integer.MAX_VALUE);
        mav.addObject("categoryList", categoryList);
        mav.setViewName("mg/links/allroot");
        return mav;
    }

    /*链接修改、新增显示页面*/
    @RequestMapping(value = "/{categoryType}/{categoryId}/links-show.htm", method = RequestMethod.GET)
    public ModelAndView linksShow(
            @PathVariable String categoryType,
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(categoryId) || StringUtils.isBlank(categoryType)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        Category categoryParent = categoryDao.getById(categoryId);
        String opt = "create";
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        Links links = new Links();
        if (StringUtils.isNotBlank(linksId)) {
            opt = "update";
            links = linksDao.getById(linksId);
        }
        links.setCategoryType(categoryParent.getCategoryType());
        links.setCategoryId(categoryParent.getId());
        mav.addObject("opt", opt);
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("links", links);
        mav.setViewName("mg/links/links-show");
        return mav;
    }

    /*链接新增*/
    @RequestMapping(value = "/{categoryType}/{categoryId}/links-create.htm", method = RequestMethod.POST)
    public ModelAndView linksCreate(
            @PathVariable String categoryType,
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(categoryId) || StringUtils.isBlank(categoryType)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        Category categoryParent = categoryDao.getById(categoryId);
        Links links = new Links();
        //处理图片
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() != 0)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            links.setImage(ui.getFilePath());

        links.setCategoryType(categoryParent.getCategoryType());
        links.setCategoryId(categoryId);
        links.setName(WebUtils.getRequestParameterAsString(request, "name"));
        links.setUrl(WebUtils.getRequestParameterAsString(request, "url"));
        links.setOrder(WebUtils.getRequestParameterAsInt(request, "order", 0));

        if (linksDao.create(links)) {
            mav.addObject("message", "links create success!");
        } else {
            mav.addObject("message", "links create failure!");
        }
        mav.addObject("categoryParent", categoryParent);
        return mav;
    }

    /*链接更新*/
    @RequestMapping(value = "/{categoryType}/{categoryId}/links-update.htm", method = RequestMethod.POST)
    public ModelAndView linksUpdate(
            @PathVariable String categoryType,
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(categoryId) || StringUtils.isBlank(categoryType)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        if (StringUtils.isBlank(linksId)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }
        Category categoryParent = categoryDao.getById(categoryId);
        Links links = linksDao.getById(linksId);
        //处理图片
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() != 0)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            links.setImage(ui.getFilePath());

        links.setCategoryType(categoryParent.getCategoryType());
        links.setCategoryId(categoryId);
        links.setName(WebUtils.getRequestParameterAsString(request, "name"));
        links.setUrl(WebUtils.getRequestParameterAsString(request, "url"));
        links.setOrder(WebUtils.getRequestParameterAsInt(request, "order", 0));

        if (linksDao.update(links)) {
            mav.addObject("message", "links update success!");
        } else {
            mav.addObject("message", "links update failure!");
        }
        mav.addObject("categoryParent", categoryParent);
        return mav;
    }

    /*链接删除*/
    @RequestMapping(value = "/{categoryType}/{categoryId}/links-del.htm", method = RequestMethod.GET)
    public ModelAndView linksDel(
            @PathVariable String categoryType,
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        if (StringUtils.isBlank(categoryId) || StringUtils.isBlank(categoryType)) {
            mav.addObject("message", "cant's find the links category!");
            return mav;
        }
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        if (StringUtils.isBlank(linksId)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }
        Category categoryParent = categoryDao.getById(categoryId);
        try {
            String linksIdArray[] = StringUtils.split(linksId, ",");
            for (String s : linksIdArray) {
                logger.info("[links-del] linksId=" + s + linksDao.deleteById(s));
            }
            mav.addObject("message", "delete the links success!");
        } catch (Exception e) {
            logger.info("[links-del] error " + e);
            mav.addObject("message", "delete the links failure!");
        }
        mav.addObject("categoryParent", categoryParent);
        return mav;
    }

    /*获取指定分来下的所有链接*/
    @RequestMapping(value = "/{categoryType}/{categoryId}/links-list.htm", method = RequestMethod.GET)
    public ModelAndView linksList(
            @PathVariable String categoryType,
            @PathVariable String categoryId,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(categoryType) || StringUtils.isBlank(categoryId)) {
            mav.setViewName("common/message");
            mav.addObject("message", "can't find the links category!");
            return mav;
        }
        Category categoryParent = categoryDao.getById(categoryId);
        
        String keyword = WebUtils.getRequestParameterAsString(request,"keyword");
        keyword = StringTools.converISO2UTF8(keyword);
       
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);
        
        LinksQuery query = new LinksQuery();
        query.setCategoryType(categoryType);
        query.setCategoryId(categoryId);
        query.setKeyword(keyword);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
       
        List<Links> linksList = linksDao.getByParentId(query);
        pageBean.setMaxRowCount(linksDao.getCountByParentId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("linksList", linksList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.setViewName("mg/links/links-list");
        return mav;
    }
    
    /*删除链接中的图片信息*/
    @RequestMapping(value = "/{categoryType}/{categoryId}/links-delImage.htm", method = RequestMethod.GET)
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
