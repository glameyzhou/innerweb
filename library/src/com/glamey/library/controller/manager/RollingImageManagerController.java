package com.glamey.library.controller.manager;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.CategoryDao;
import com.glamey.library.dao.RollingImageDao;
import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.RollingImageInfo;
import com.glamey.library.model.domain.UploadInfo;
import com.glamey.library.model.dto.RollingImageQuery;
import com.glamey.library.util.WebUploadUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 滚动图片管理
 * Created with IntelliJ IDEA.
 * User: zy
 */
@Controller
@RequestMapping(value = "/mg/rolling")
public class RollingImageManagerController extends BaseController {
    private static final Logger logger = Logger.getLogger(RollingImageManagerController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private RollingImageDao rollingImageDao;
    @Resource
    private WebUploadUtils uploadUtils;


    /*修改、新增显示页面*/
    @RequestMapping(value = "/rolling-show.htm", method = RequestMethod.GET)
    public ModelAndView rollingShow(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        //获取根结点
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_ROLLINGIMAGE);
        //当前结点
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        categoryId = StringUtils.isNotBlank(categoryId) ? categoryId : categoryParent.getId();
        Category category = categoryDao.getById(categoryId);

        String opt = "create";
        String id = WebUtils.getRequestParameterAsString(request, "id");
        RollingImageInfo rolling = new RollingImageInfo();
        if (StringUtils.isNotBlank(id)) {
            opt = "update";
            rolling = rollingImageDao.getById(id);
        }
        rolling.setCategoryId(categoryId);
        mav.addObject("opt", opt);
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("category", category);
        mav.addObject("rolling", rolling);
        mav.setViewName("mg/rolling/rolling-show");
        return mav;
    }

    /*链接新增*/
    @RequestMapping(value = "/rolling-create.htm", method = RequestMethod.POST)
    public ModelAndView rollingCreate(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        //获取根结点
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_ROLLINGIMAGE);
        //当前结点
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        categoryId = StringUtils.isNotBlank(categoryId) ? categoryId : categoryParent.getId();
        Category category = categoryDao.getById(categoryId);

        RollingImageInfo rolling = new RollingImageInfo();
        //处理图片
        UploadInfo ui = uploadUtils.doUpload(request, response);
        if (ui.getResultCode() != 0)
            return ui.getModelAndView();
        if (StringUtils.isNotBlank(ui.getFilePath()))
            rolling.setImage(ui.getFilePath());

        rolling.setCategoryId(categoryId);
        rolling.setName(WebUtils.getRequestParameterAsString(request, "name"));
        rolling.setValid(WebUtils.getRequestParameterAsInt(request, "valid", 1));

        if (rollingImageDao.create(rolling)) {
            mav.addObject("message", "创建成功!");
            mav.addObject("href", "mg/rolling/rolling-list.htm?categoryId=" + category.getId());
        } else {
            mav.addObject("message", "创建失败!");
        }
        return mav;
    }

    /*链接更新*/
    @RequestMapping(value = "/rolling-update.htm", method = RequestMethod.POST)
    public ModelAndView linksUpdate(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }

        //获取根结点
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_ROLLINGIMAGE);
        //当前结点
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        categoryId = StringUtils.isNotBlank(categoryId) ? categoryId : categoryParent.getId();
        Category category = categoryDao.getById(categoryId);

        RollingImageInfo rolling = rollingImageDao.getById(id);
        //处理图片
        if(StringUtils.isBlank(rolling.getImage())){
            UploadInfo ui = uploadUtils.doUpload(request, response);
            if (ui.getResultCode() != 0)
                return ui.getModelAndView();
            if (StringUtils.isNotBlank(ui.getFilePath()))
                rolling.setImage(ui.getFilePath());
        }

        rolling.setCategoryId(categoryId);
        rolling.setName(WebUtils.getRequestParameterAsString(request, "name"));
        rolling.setValid(WebUtils.getRequestParameterAsInt(request, "valid", 1));

        if (rollingImageDao.update(rolling)) {
            mav.addObject("message", "更新成功!");
            mav.addObject("href", "mg/rolling/rolling-list.htm?categoryId=" + category.getId());
        } else {
            mav.addObject("message", "更新失败!");
        }
        return mav;
    }

    /*链接删除*/
    @RequestMapping(value = "/rolling-del.htm", method = RequestMethod.GET)
    public ModelAndView linksDel(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        ModelAndView mav = new ModelAndView("common/message");
        String categoyId = WebUtils.getRequestParameterAsString(request, "categoryId");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "cant's find the linksId!");
            return mav;
        }
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_ROLLINGIMAGE);
        try {
            String linksIdArray[] = StringUtils.split(id, ",");
            for (String s : linksIdArray) {
                logger.info("[rolling-del] rollingId=" + s + rollingImageDao.deleteById(s));
            }
            mav.addObject("message", "删除成功!");
            mav.addObject("href", "mg/rolling/rolling-list.htm?categoryId=" + categoyId);
        } catch (Exception e) {
            logger.info("[rolling-del] error " + e);
            mav.addObject("message", "delete the rolling failure!");
        }
        mav.addObject("categoryParent", categoryParent);
        return mav;
    }

    /*获取指定分来下的所有链接*/
    @RequestMapping(value = "/rolling-list.htm", method = RequestMethod.GET)
    public ModelAndView linksList(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-rolling-list]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        //根结点
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_ROLLINGIMAGE);
        //当前结点
        String categoryId = WebUtils.getRequestParameterAsString(request, "categoryId");
        categoryId = StringUtils.isNotBlank(categoryId) ? categoryId : categoryParent.getId();
        Category category = categoryDao.getById(categoryId);
        //根结点下所有的分类信息
        List<Category> categoryList = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        //当前节点下的内容列表
        String keyword = WebUtils.getRequestParameterAsString(request, "keyword");
        keyword = StringTools.converISO2UTF8(keyword);
        int valid = WebUtils.getRequestParameterAsInt(request, "valid", -1);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean = new PageBean();
        pageBean.setCurPage(curPage);

        RollingImageQuery query = new RollingImageQuery();
        query.setCategoryId(categoryId);
        query.setValid(valid);
        query.setKeyword(keyword);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<RollingImageInfo> rollingImageInfoList = rollingImageDao.getByParentId(query);
        pageBean.setMaxRowCount(rollingImageDao.getCountByParentId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();
        mav.addObject("categoryParent", categoryParent);
        mav.addObject("category", category);
        mav.addObject("rollingImageInfoList", rollingImageInfoList);
        mav.addObject("pageBean", pageBean);
        mav.addObject("query", query);
        mav.addObject("categoryList", categoryList);
        mav.setViewName("mg/rolling/rolling-list");
        return mav;
    }

    /*删除链接中的图片信息*/
    @RequestMapping(value = "/rolling-delImage.htm", method = RequestMethod.GET)
    public ModelAndView delImage(
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[manager-links-delete-images]" + request.getRequestURI());
        ModelAndView mav = new ModelAndView("common/message");
        String id = WebUtils.getRequestParameterAsString(request, "id");
        if (StringUtils.isBlank(id)) {
            mav.setViewName("common/message");
            mav.addObject("message", "获取不到要操作的内容");
            return mav;
        }

        if (!rollingImageDao.deleteImage(id)) {
            message = "图片删除失败,请稍后重试!";
        } else {
            message = "图片删除成功.";
        }
        mav.addObject("message", message);
        return mav;
    }
}
