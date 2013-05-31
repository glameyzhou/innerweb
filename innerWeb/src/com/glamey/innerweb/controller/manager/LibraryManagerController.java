package com.glamey.innerweb.controller.manager;

import com.glamey.framework.utils.Pinyin4jUtils;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.dto.CategoryQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/mg/library")
public class LibraryManagerController extends BaseController {

    private static final Logger logger = Logger.getLogger(LibraryManagerController.class);

    @Resource
    private CategoryDao categoryDao;


    @RequestMapping(value = "/category-list.htm", method = RequestMethod.GET)
    public ModelAndView categoryList(HttpServletRequest request, HttpServletResponse response) {
        String pid = WebUtils.getRequestParameterAsString(request, "pid","0");
        String id = WebUtils.getRequestParameterAsString(request, "id");

        Category pCategory = new Category();
        Category category = new Category();

        CategoryQuery query = new CategoryQuery();
        query.setCategoryType(CategoryConstants.CATEGORY_LIBRARY);
        query.setParentId(pid);

        List<Category> categoryList = categoryDao.getByParentId(pid, CategoryConstants.CATEGORY_LIBRARY, 0, Integer.MAX_VALUE);

        ModelAndView mav = new ModelAndView("mg/library/category-list");
        mav.addObject("pid", pid);
        mav.addObject("id", "id");
        mav.addObject("pCategory", pCategory);
        mav.addObject("category", category);
        mav.addObject("categoryList", categoryList);
        return mav;
    }

    @RequestMapping(value = "/category-show.htm", method = RequestMethod.GET)
    public ModelAndView categoryShow(HttpServletRequest request, HttpServletResponse response) {
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String opt = "create";
        Category category = new Category();
        if (StringUtils.isNotBlank(id)) {
            category = categoryDao.getById(id);
        }
        Category pCategory = new Category();
        if (StringUtils.equals(pid, "0") && StringUtils.isNotBlank(pid)) {
            pCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_LIBRARY);
        } else {
            pCategory = categoryDao.getById(pid);
        }
        ModelAndView mav = new ModelAndView("mg/library/category-show");
        mav.addObject("category", category);
        mav.addObject("pCategory", pCategory);
        return mav;
    }

    @RequestMapping(value = "/category-create.htm", method = RequestMethod.GET)
    public ModelAndView categoryCreate(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String aliasName = Pinyin4jUtils.getPinYin(name);
        String shortName = WebUtils.getRequestParameterAsString(request, "shortName");
        String desc = WebUtils.getRequestParameterAsString(request, "describe");
        int showIndex = WebUtils.getRequestParameterAsInt(request, "showIndex", 1);
        int categoryOrder = WebUtils.getRequestParameterAsInt(request, "categoryOrder", 0);
        Category category = new Category();
        category.setParentId(pid);
        category.setName(name);
        category.setShortName(shortName);
        category.setAliasName(aliasName);
        category.setDescribe(desc);
        category.setShowIndex(showIndex);
        category.setCategoryOrder(categoryOrder);
        category.setCategoryType(CategoryConstants.CATEGORY_LIBRARY);
        String uniqueId = categoryDao.createReturnId(category);
        if (StringUtils.isNotBlank(uniqueId)) {
            category = categoryDao.getById(uniqueId);
            mav.addObject("message", "分类添加成功");
            mav.addObject("href", "mg/library/category-list.htm?pid=" + category.getParentId() + "&id=" + category.getId());
        } else {
            mav.addObject("message", "分类添加失败,请重试");
        }
        return mav;
    }

    @RequestMapping(value = "/category-update.htm", method = RequestMethod.GET)
    public ModelAndView categoryUpdate(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "无效操作");
            return mav;
        }
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String aliasName = Pinyin4jUtils.getPinYin(name);
        String shortName = WebUtils.getRequestParameterAsString(request, "shortName");
        String desc = WebUtils.getRequestParameterAsString(request, "describe");
        int showIndex = WebUtils.getRequestParameterAsInt(request, "showIndex", 1);
        int categoryOrder = WebUtils.getRequestParameterAsInt(request, "categoryOrder", 0);
        Category category = categoryDao.getById(id);
        category.setParentId(pid);
        category.setName(name);
        category.setShortName(shortName);
        category.setAliasName(aliasName);
        category.setDescribe(desc);
        category.setShowIndex(showIndex);
        category.setCategoryOrder(categoryOrder);
        category.setCategoryType(CategoryConstants.CATEGORY_LIBRARY);
        boolean result = categoryDao.update(category);
        if (result) {
            mav.addObject("message", "分类修改成功");
            mav.addObject("href", "mg/library/category-list.htm?pid=" + category.getParentId() + "&id=" + category.getId());
        } else {
            mav.addObject("message", "分类修改失败,请重试");
        }
        return mav;
    }
}
