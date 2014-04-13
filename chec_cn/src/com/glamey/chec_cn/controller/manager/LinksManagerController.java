package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.LinksDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Links;
import com.glamey.chec_cn.model.dto.LinksQuery;
import com.glamey.chec_cn.util.DateUtils;
import com.glamey.chec_cn.util.WebUploadUtils;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.sun.xml.internal.fastinfoset.alphabet.BuiltInRestrictedAlphabets;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 链接管理
 * Created with IntelliJ IDEA.
 * User: zy
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

    @RequestMapping(value = "/links-show.do", method = RequestMethod.GET)
    public ModelAndView linksShow(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        Category root = categoryDao.getByAliasName(CategoryConstants.CATEGORY_LINKS);
        List<Category> categoryList = categoryDao.getByParentId(root.getId(), root.getCategoryType(),0,Integer.MAX_VALUE);

        String opt = "create";
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        Links links = new Links();
        links.setPublishTime(new Date());
        if (StringUtils.isNotBlank(linksId)) {
            opt = "update";
            links = linksDao.getById(linksId);
        }
        Category category = categoryDao.getById(categoryId);
        mav.addObject("opt", opt);
        mav.addObject("links", links);
        mav.addObject("category", category);
        mav.addObject("categoryList", categoryList);
        mav.setViewName("mg/links/links-show");
        return mav;
    }

    @RequestMapping(value = "/links-create.do", method = RequestMethod.POST)
    public ModelAndView linksCreate(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");

        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String url = WebUtils.getRequestParameterAsString(request, "url");
        int order = WebUtils.getRequestParameterAsInt(request, "order", 0);
        String publishTime = WebUtils.getRequestParameterAsString(request, "publishTime");

        Links links = new Links();
        links.setCategoryId(categoryId);
        links.setName(name);
        links.setUrl(url);
        links.setOrder(order);
        links.setPublishTime(StringUtils.isNotBlank(publishTime) ? new Date() : DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));

        if (linksDao.create(links)) {
            mav.addObject("message", "链接创建成功");
            mav.addObject("href", "mg/links/links-list.do?categoryId=" + categoryId);
        } else {
            mav.addObject("message", "创建失败!");
        }
        return mav;
    }

    /*链接更新*/
    @RequestMapping(value = "/links-update.do", method = RequestMethod.POST)
    public ModelAndView linksUpdate(HttpServletRequest request) {

        ModelAndView mav = new ModelAndView("common/message");
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        if (StringUtils.isBlank(linksId)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }
        Links links = linksDao.getById(linksId);
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String url = WebUtils.getRequestParameterAsString(request, "url");
        int order = WebUtils.getRequestParameterAsInt(request, "order", 0);
        String publishTime = WebUtils.getRequestParameterAsString(request, "publishTime");

        links.setCategoryId(categoryId);
        links.setName(name);
        links.setUrl(url);
        links.setOrder(order);
        links.setPublishTime(StringUtils.isNotBlank(publishTime) ? new Date() : DateUtils.format(publishTime, "yyyy-MM-dd HH:mm:ss"));

        if (linksDao.update(links)) {
            mav.addObject("message", "链接更新成功!");
            mav.addObject("href", "mg/links/links-list.do?categoryId=" + categoryId);
        } else {
            mav.addObject("message", "更新失败!");
        }
        return mav;
    }

    /*链接删除*/
    @RequestMapping(value = "/links-del.do", method = RequestMethod.GET)
    public ModelAndView linksDel(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String linksId = WebUtils.getRequestParameterAsString(request, "linksId");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(linksId)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }
        try {
            String linksIdArray[] = StringUtils.split(linksId, ",");
            for (String s : linksIdArray) {
                logger.info("[links-del] linksId=" + s + linksDao.deleteById(s));
            }
            mav.addObject("message", "删除成功!");
            mav.addObject("href", "mg/links/links-list.do?categoryId=" + categoryId);
        } catch (Exception e) {
            logger.info("[links-del] error " + e);
            mav.addObject("message", "链接删除失败!");
        }
        return mav;
    }

    /*获取指定分来下的所有链接*/
    @RequestMapping(value = "/links-list.do", method = RequestMethod.GET)
    public ModelAndView linksList(HttpServletRequest request) {
        logger.info("[manager-links-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        Category root = categoryDao.getByAliasName(CategoryConstants.CATEGORY_LINKS);
        List<Category> categoryList = categoryDao.getByParentId(root.getId(), root.getCategoryType(), 0, Integer.MAX_VALUE);

        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        Category category = categoryDao.getById(categoryId);
        //当前节点下的内容列表
        String keyword = WebUtils.getRequestParameterAsString(request, "kw");
        keyword = StringTools.converISO2UTF8(keyword);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        LinksQuery query = new LinksQuery();
        query.setKw(keyword);
        query.setCategoryId(categoryId);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<Links> linksList = linksDao.getByQuery(query);
        pageBean.setMaxRowCount(linksDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();
        mav.addObject("categoryList", categoryList);
        mav.addObject("category", category);
        mav.addObject("linksList", linksList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.setViewName("mg/links/links-list");
        return mav;
    }
}
