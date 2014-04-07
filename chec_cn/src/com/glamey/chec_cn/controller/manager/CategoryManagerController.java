package com.glamey.chec_cn.controller.manager;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.dto.CategoryQuery;
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
import java.util.List;

/**
 * 分类管理
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class CategoryManagerController extends BaseController {

    private static final Logger logger = Logger.getLogger(CategoryManagerController.class);

    @Autowired
    private CategoryDao categoryDao;


    /**
     * 分类列表
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/category-list.htm", method = RequestMethod.GET)
    public ModelAndView categoryList(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/library/category-list");
        String pid = WebUtils.getRequestParameterAsString(request, "pid", "0");
        String type = WebUtils.getRequestParameterAsString(request, "type");
        Category pCategory = new Category();
        if (!StringUtils.equalsIgnoreCase(pid, "0")) {
            pCategory = categoryDao.getById(pid);
        }
        CategoryQuery query = new CategoryQuery();
        query.setPid(pid);
        query.setType(type);
        query.setStart(0);
        query.setNum(Integer.MAX_VALUE);
        List<Category> categoryList = categoryDao.getListByQuery(query);
        mav.addObject("categoryList", categoryList);
        mav.addObject("query", query);
        return mav;
    }

    /**
     * 分类创建修改界面
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/category-show.htm", method = RequestMethod.GET)
    public ModelAndView categoryShow(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("mg/library/category-show");
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String type = WebUtils.getRequestParameterAsString(request, "type");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String opt = "create";
        Category category = new Category();
        if (StringUtils.isNotBlank(id)) {
            category = categoryDao.getById(id);
            opt = "update";
        }
        mav.addObject("category", category);
        mav.addObject("opt", opt);
        mav.addObject("pid", pid);
        mav.addObject("type", type);
        return mav;
    }


    /**
     * 分类创建、修改
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/category-saveUpdate.htm", method = RequestMethod.POST)
    public ModelAndView categorySaveUpdate(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String pid = WebUtils.getRequestParameterAsString(request, "pid", CategoryConstants.PARENTID);
        String type = WebUtils.getRequestParameterAsString(request, "type");
        int order = WebUtils.getRequestParameterAsInt(request, "order", 0);
        int isShow = WebUtils.getRequestParameterAsInt(request, "isShow", 1);
        int isList = WebUtils.getRequestParameterAsInt(request, "isList", 1);
        int hasChildren = 0;
        String name = WebUtils.getRequestParameterAsString(request, "name");
        String aliasName = Pinyin4jUtils.getPinYin(name);
        String desc = WebUtils.getRequestParameterAsString(request, "describe");
        //TODO 需要修改对应的图片、flash信息
        String img = WebUtils.getRequestParameterAsString(request, "img");
        String flv = WebUtils.getRequestParameterAsString(request, "flv");

        boolean isUpdate = false;
        Category category = new Category();
        if (StringUtils.isNotBlank(id)) {
            category = categoryDao.getById(id);
            isUpdate = true;
        }
        category.setId(id);
        category.setPid(pid);
        category.setType(type);
        category.setOrder(order);
        category.setIsShow(isShow);
        category.setIsList(isList);
        category.setHasChildren(hasChildren);
        category.setName(name);
        category.setAliasName(aliasName);
        category.setImage(img);
        category.setFlv(flv);
        category.setDesc(desc);

        boolean result = false;
        String createCateId = null;
        if (isUpdate) {
            result = categoryDao.update(category);
        } else {
            createCateId = categoryDao.createReturnId(category);
        }
        if (result || StringUtils.isNotBlank(createCateId)) {
            mav.addObject("message", "分类" + (isUpdate ? "修改" : "添加") + "成功");
            mav.addObject("href", "mg/library/category-list.htm?pid=" + category.getPid() + "&type=" + type);
        } else {
            mav.addObject("message", "分类" + (isUpdate ? "修改" : "添加") + "失败");
        }
        return mav;
    }

    /**
     * 分类删除、并且删除对应旗下的所有文章内容
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/category-delete.htm", method = RequestMethod.POST)
    public ModelAndView categoryDelete(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        String pid = WebUtils.getRequestParameterAsString(request, "pid");
        String type = WebUtils.getRequestParameterAsString(request, "type");
        boolean result = categoryDao.delete(id);
        if (result) {
            //TODO 删除对应的分类文章内容
            mav.addObject("message", "删除分类成功");
            mav.addObject("href", "mg/library/category-list.htm?pid=" + pid + "&type=" + type);
        } else {
            mav.addObject("message", "删除分类失败");
        }
        return mav;
    }
}
