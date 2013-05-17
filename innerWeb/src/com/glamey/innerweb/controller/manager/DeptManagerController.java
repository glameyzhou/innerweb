package com.glamey.innerweb.controller.manager;

import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.dto.CategoryQuery;
import com.glamey.innerweb.util.WebUploadUtils;
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
import java.util.Date;
import java.util.List;

/**
 * 部门管理
 * Created with IntelliJ IDEA.
 * User: zy
 */
@Controller
@RequestMapping(value = "/mg/dept")
public class DeptManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(DeptManagerController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private WebUploadUtils uploadUtils;

    @RequestMapping(value = "/dept-list.htm", method = RequestMethod.GET)
    public ModelAndView deptList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-dept-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();

        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);

        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        CategoryQuery query = new CategoryQuery();
        query.setKeyword(keyword);
        query.setCategoryType(categoryParent.getCategoryType());
        query.setParentId(categoryParent.getId());
        List<Category> deptList = categoryDao.getByQuery(query, 0, Integer.MAX_VALUE);

        mav.addObject("deptList", deptList);
        mav.addObject("query", query);
        mav.addObject("categoryParent", categoryParent);
        mav.setViewName("mg/user/dept-list");
        return mav;
    }

    @RequestMapping(value = "/dept-show.htm", method = RequestMethod.GET)
    public ModelAndView deptShow(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-dept-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        String opt = "create";
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        Category category = new Category();
        if (StringUtils.isNotBlank(categoryId)) {
            category = categoryDao.getById(categoryId);
            opt = "update";
        }
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        mav.addObject("category", category);
        mav.addObject("opt", opt);
        mav.addObject("categoryParent", categoryParent);
        mav.setViewName("mg/user/dept-show");
        return mav;
    }

    @RequestMapping(value = "/dept-create.htm", method = RequestMethod.POST)
    public ModelAndView deptCreate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-dept-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String name = WebUtils.getRequestParameterAsString(request, "name");
        if (StringUtils.isBlank(name)) {
            mav.addObject("message", "名称不能为空!");
            return mav;
        }
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        Category category = new Category();
        category.setName(name);
        category.setCategoryType(categoryParent.getCategoryType());
        category.setParentId(categoryParent.getId());
        //TODO 通过第三方jar，汉字转拼音
        category.setAliasName("");
        category.setShortName(name);
        category.setDescribe(WebUtils.getRequestParameterAsString(request,"describe"));
        category.setCategoryTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
        if (!categoryDao.create(category)) {
            message = "部门新建失败,请稍后重试!";
        } else {
            message = "部门新建成功.";
        }
        return mav;
    }


    @RequestMapping(value = "/dept-update.htm", method = RequestMethod.POST)
    public ModelAndView deptUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-dept-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(categoryId)) {
            mav.addObject("message", "无效操作!");
            return mav;
        }
        Category category = categoryDao.getById(categoryId);
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_DEPT);
        String name = WebUtils.getRequestParameterAsString(request, "name") ;
        category.setName(name);
        category.setCategoryType(categoryParent.getCategoryType());
        category.setParentId(categoryParent.getId());
        //TODO 通过第三方jar，汉字转拼音
        category.setAliasName("");
        category.setShortName(name);
        category.setDescribe(WebUtils.getRequestParameterAsString(request,"describe"));
        category.setCategoryTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
        if (!categoryDao.update(category)) {
            message = "部门修改失败,请稍后重试!";
        } else {
            message = "部门修改成功.";
        }
        return mav;
    }

    @RequestMapping(value = "/dept-del.htm", method = RequestMethod.GET)
    public ModelAndView deptDel(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-dept-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        if (StringUtils.isBlank(categoryId)) {
            mav.addObject("message", "无效操作!");
            return mav;
        }
        if (!categoryDao.deleteById(categoryId)) {
            message = "部门删除失败,请稍后重试!";
        } else {
            message = "部门删除成功.";
        }
        return mav;
    }
}
