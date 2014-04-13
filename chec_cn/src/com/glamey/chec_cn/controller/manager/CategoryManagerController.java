package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.framework.utils.Pinyin4jUtils;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;


/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/mg/category")
public class CategoryManagerController extends BaseController {

    private static final Logger logger = Logger.getLogger(CategoryManagerController.class);

    @Autowired
    private CategoryDao categoryDao;

    /*通过父ID，列举所有的分类信息*/
    @RequestMapping(value = "/category-list.do", method = RequestMethod.GET)
    public ModelAndView categoryList(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/category/category-list");
        String pid = WebUtils.getRequestParameterAsString(request, "pid", "0");
        String type = WebUtils.getRequestParameterAsString(request, "type");
        Category pCategory = new Category();
        if (!StringUtils.equalsIgnoreCase(pid, "0")) {
            pCategory = categoryDao.getById(pid);
        }
        else {
            //如果是根目录的话，一般categoryType == aliasName
            pCategory = categoryDao.getByAliasName(type);
        }
        List<Category> categoryList = categoryDao.getByParentId(pid, type, 0, Integer.MAX_VALUE);
        mav.addObject("pid", pid);
        mav.addObject("type", type);
        mav.addObject("pCategory", pCategory);
        mav.addObject("categoryList", categoryList);
        return mav;
    }


    /*分类修改、创建页面*/
    @RequestMapping(value = "/category-show.do", method = RequestMethod.GET)
    public ModelAndView categoryShow(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/category/category-show");
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String type = WebUtils.getRequestParameterAsString(request, "type");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String opt = "create";
        Category category = new Category();
        Category pCategory = categoryDao.getBySmpleId(pid);
        if (StringUtils.isNotBlank(id)) {
            category = categoryDao.getById(id);
            opt = "update";
        }
        mav.addObject("category", category);
        mav.addObject("pCategory", pCategory);
        mav.addObject("opt", opt);
        mav.addObject("pid", pid);
        mav.addObject("type", type);
        return mav;
    }

    /*创建分类*/
    @RequestMapping(value = "/category-create.do", method = RequestMethod.POST)
    public ModelAndView categoryCreate(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String type = WebUtils.getRequestParameterAsString(request, "type", CategoryConstants.CATEGORY_LIBRARY);
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String aliasName = Pinyin4jUtils.getPinYin(name);
        String shortName = WebUtils.getRequestParameterAsString(request, "shortName");
        String desc = WebUtils.getRequestParameterAsString(request, "describe");
        int showType = WebUtils.getRequestParameterAsInt(request, "showType", 0);
        int showIndex = WebUtils.getRequestParameterAsInt(request, "showIndex", 1);
        int showInTree = WebUtils.getRequestParameterAsInt(request, "showInTree", 1);
        int treeorder = WebUtils.getRequestParameterAsInt(request, "treeOrder", 0);
        int categoryOrder = WebUtils.getRequestParameterAsInt(request, "categoryOrder", 0);
        Category category = new Category();
        category.setParentId(pid);
        category.setName(name);
        category.setShortName(shortName);
        category.setAliasName(aliasName);
        category.setDescribe(desc);
        category.setShowType(showType);
        category.setShowIndex(showIndex);
        category.setShowInTree(showInTree);
        category.setTreeOrder(treeorder);
        category.setCategoryOrder(categoryOrder);
        category.setCategoryType(type);
        category.setCategoryTime(new Date());
        category.setHasChild(0);

        //新增分类的时候，同时需要进行更新父节点下边是否有孩子
        String uniqueId = categoryDao.createReturnId(category);
        if (StringUtils.isNotBlank(uniqueId)) {
            category = categoryDao.getById(uniqueId);
            mav.addObject("message", "分类添加成功");
            mav.addObject("href", "mg/category/category-list.do?pid=" + category.getParentId() + "&type=" + type);
        } else {
            mav.addObject("message", "分类添加失败,请重试");
        }
        return mav;
    }


    /*更新分类*/
    @RequestMapping(value = "/category-update.do", method = RequestMethod.POST)
    public ModelAndView categoryUpdate(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "无效操作");
            return mav;
        }
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String type = WebUtils.getRequestParameterAsString(request, "type", CategoryConstants.CATEGORY_LIBRARY);
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String aliasName = Pinyin4jUtils.getPinYin(name);
        String shortName = WebUtils.getRequestParameterAsString(request, "shortName");
        String desc = WebUtils.getRequestParameterAsString(request, "describe");
        int showType = WebUtils.getRequestParameterAsInt(request, "showType", 0);
        int showIndex = WebUtils.getRequestParameterAsInt(request, "showIndex", 1);
        int showInTree = WebUtils.getRequestParameterAsInt(request, "showInTree", 1);
        int treeorder = WebUtils.getRequestParameterAsInt(request, "treeOrder", 0);
        int categoryOrder = WebUtils.getRequestParameterAsInt(request, "categoryOrder", 0);
        Category category = categoryDao.getById(id);
        category.setParentId(pid);
        category.setName(name);
        category.setShortName(shortName);
        category.setAliasName(aliasName);
        category.setDescribe(desc);
        category.setShowType(showType);
        category.setShowIndex(showIndex);
        category.setShowInTree(showInTree);
        category.setTreeOrder(treeorder);
        category.setCategoryOrder(categoryOrder);
        category.setCategoryType(type);
        boolean result = categoryDao.update(category);
        if (result) {
            mav.addObject("message", "分类修改成功");
            mav.addObject("href", "mg/category/category-list.do?pid=" + category.getParentId() + "&type=" + type);
        } else {
            mav.addObject("message", "分类修改失败,请重试");
        }
        return mav;
    }

}
