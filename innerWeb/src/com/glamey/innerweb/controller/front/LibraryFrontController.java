package com.glamey.innerweb.controller.front;

import java.util.ArrayList;
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
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LibraryInfoDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.LibraryInfo;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.LibraryQuery;

@Controller
public class LibraryFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(LibraryFrontController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private IncludeFront includeFront;
    @Resource
    private LibraryInfoDao libraryInfoDao;


    /*library-0-0-0.htm*/
    @RequestMapping(value = "/library-{pCategoryId}-{categoryId}-{showImage}.htm", method = RequestMethod.GET)
    public ModelAndView libList(
            @PathVariable String pCategoryId,
            @PathVariable String categoryId,
            @PathVariable int showImage,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.equalsIgnoreCase(categoryId, "0")) {
            categoryId = null;
        }
        List<String> categoryIds = new ArrayList<String>();
        if (!StringUtils.equalsIgnoreCase(pCategoryId, "0") && StringUtils.equalsIgnoreCase(categoryId, "0")) {
            List<Category> categoryList = categoryDao.getByParentId(pCategoryId, CategoryConstants.CATEGORY_LIBRARY, 0, Integer.MAX_VALUE);
            for (Category category : categoryList) {
                categoryIds.add(category.getId());
            }
            categoryId = null;
        }

        pageBean = new PageBean(50);
        int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
        pageBean.setCurPage(curPage);

        LibraryQuery query = new LibraryQuery();
        query.setCategoryId(categoryId);
        query.setCategoryIds(categoryIds);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());
        query.setShowImage(showImage);

        List<LibraryInfo> libraryInfos = libraryInfoDao.getByQuery(query);
        pageBean.setMaxRowCount(libraryInfoDao.getCountByQuery(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("pageBean", pageBean);
        mav.addObject("libraryInfos", libraryInfos);
        mav.addObject("query", query);
        mav.addObject("pCategoryId", StringUtils.isBlank(pCategoryId) ? "0" : pCategoryId);
        mav.addObject("categoryId", StringUtils.isBlank(categoryId) ? "0" : categoryId);

        //固定内容
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks(request));
        mav.addObject("unReadMessage", includeFront.unReadMessage(userInfo.getUserId()));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));

        mav.setViewName("front/lib-list" + showImage);
        return mav;
    }

    @RequestMapping(value = "/library-detail-{id}.htm", method = RequestMethod.GET)
    public ModelAndView libraryDetail(
            @PathVariable String id,
            HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("[front] #postList#" + request.getRequestURI());
        ModelAndView mav = new ModelAndView();
        if (StringUtils.isBlank(id)) {
            mav.addObject("message", "无效操作");
            mav.setViewName("404");
            return mav;
        }

        LibraryInfo info = libraryInfoDao.getById(id);
        mav.addObject("info", info);

        //固定内容
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks(request));
        mav.addObject("unReadMessage", includeFront.unReadMessage(userInfo.getUserId()));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));
        mav.setViewName("front/lib-detail");
        return mav;
    }
}