package com.glamey.library.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.SystemConstants;
import com.glamey.library.controller.BaseController;
import com.glamey.library.dao.*;
import com.glamey.library.model.domain.*;
import com.glamey.library.model.dto.LibraryInfoDTO;
import com.glamey.library.model.dto.LibraryQuery;
import com.glamey.library.model.dto.RollingImageQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Controller
public class RollingFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(RollingFrontController.class);

    @Resource
    private IncludeFront includeFront;
    @Resource
    private CategoryDao categoryDao ;
    @Resource
    private LibraryInfoDao libraryInfoDao ;
    @Resource
    private LinksDao linksDao ;
    @Resource
    private RollingImageDao rollingImageDao ;


    @RequestMapping(value = "/rolling-{categoryId}.htm", method = RequestMethod.GET)
    public ModelAndView indexNewest(
            @PathVariable String categoryId ,
            HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #indexNewest#");
        ModelAndView mav = new ModelAndView("front/rolling-list");
        Object obj = session.getAttribute(Constants.SESSIN_USERID);
        UserInfo userInfo = (UserInfo) obj;
        mav.addAllObjects(includeFront.allInclude(request, response, session));

        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_ROLLINGIMAGE);
        List<Category> categoryList = categoryDao.getByParentId(categoryParent.getId(),CategoryConstants.CATEGORY_ROLLINGIMAGE,0,Integer.MAX_VALUE);
        List<RollingImageInfo> rollingImageInfoList = new ArrayList<RollingImageInfo>();

        pageBean = new PageBean(30);
        int curPage = WebUtils.getRequestParameterAsInt(request,"curPage",1);
        pageBean.setCurPage(curPage);

        RollingImageQuery query = new RollingImageQuery();
        query.setValid(1);
        query.setCategoryId(categoryId);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        rollingImageInfoList = rollingImageDao.getByParentId(query);
        pageBean.setMaxRowCount(rollingImageDao.getCountByParentId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        Category category = categoryDao.getById(categoryId);

        mav.addObject("pageBean",pageBean);
        mav.addObject("query",query);
        mav.addObject("rollingImageInfoList",rollingImageInfoList);
        mav.addObject("category",category);
        mav.addObject("categoryList",categoryList);



        return mav;
    }
}