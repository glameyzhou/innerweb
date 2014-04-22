package com.glamey.chec_cn.controller.front;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.LinksDao;
import com.glamey.chec_cn.dao.PostDao;
import com.glamey.chec_cn.dao.UserInfoDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Links;
import com.glamey.chec_cn.model.domain.Post;
import com.glamey.chec_cn.model.dto.LinksQuery;
import com.glamey.chec_cn.model.dto.PostQuery;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.lf5.viewer.categoryexplorer.CategoryAbstractCellEditor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class PostFrontController extends BaseController {

    @Autowired
    private UserInfoDao userInfoDao;
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private LinksDao linksDao;

    @RequestMapping(value = {"/band-{rootCategoryName}.htm"}, method = RequestMethod.GET)
    public ModelAndView bandCategoryPage(
            @PathVariable String rootCategoryName,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/band/band");
        if (StringUtils.isBlank(rootCategoryName)){
            return pageNotFound(request,response);
        }
        Category rootCategory = categoryDao.getByAliasName(rootCategoryName);
        if (rootCategory == null || StringUtils.isBlank(rootCategory.getId())) {
            return pageNotFound(request,response);
        }
        List<Category> categoryList = categoryDao.getByParentId(1, rootCategory.getId(), rootCategory.getCategoryType(), 0, Integer.MAX_VALUE);
        String curCategory = WebUtils.getRequestParameterAsString(request, "cate");
        Category defaultCategory = new Category();

        if (StringUtils.isBlank(curCategory)) {
            if (!CollectionUtils.isEmpty(categoryList)) {
                defaultCategory = categoryList.get(0);
            }
        }
        else {
            defaultCategory = categoryDao.getById(curCategory);
        }

        int curPage = WebUtils.getRequestParameterAsInt(request,"curPage",1);
        pageBean = new PageBean();
        PostQuery postQuery = new PostQuery();
        postQuery.setCategoryId(defaultCategory.getId());
        postQuery.setCategoryType(defaultCategory.getCategoryType());

        //列表显示
        if (defaultCategory.getShowType() == 0) {
            postQuery.setShowList(1);
            postQuery.setStart(pageBean.getStart());
            postQuery.setNum(pageBean.getRowsPerPage());
        }
        //详情显示
        else {
            postQuery.setStart(0);
            postQuery.setNum(1);
        }
        pageBean.setCurPage(curPage);
        List<Post> postList = postDao.getByQuery(postQuery);
        pageBean.setMaxRowCount(postDao.getCountByQuery(postQuery));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("rootCategory",rootCategory);
        mav.addObject("categoryList",categoryList);
        mav.addObject("defaultCategory",defaultCategory);
        mav.addObject("postList",postList);
        mav.addObject("pageBean",pageBean);
        return mav;
    }

    @RequestMapping(value = {"/default-{aliasName}.htm"}, method = RequestMethod.GET)
    public ModelAndView loginShow(
            @PathVariable String aliasName,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/p-default");

        if (StringUtils.isBlank(aliasName)) {
            mav.setViewName("common/message");
            mav.addObject("message","您查看的页面不存在！");
            return mav;
        }

        Category root = categoryDao.getByAliasName(aliasName);
        if (root == null || StringUtils.isBlank(root.getId())) {
            mav.setViewName("common/message");
            mav.addObject("message","您查看的页面不存在！");
            return mav;
        }
        List<Category> categoryList = categoryDao.getByParentId(root.getId(),root.getCategoryType(),0,Integer.MAX_VALUE);
        //默认页面
        if (!CollectionUtils.isEmpty(categoryList)){
            Category firstCategory = categoryList.get(0);
            int curPage = WebUtils.getRequestParameterAsInt(request, "curPage", 1);
            pageBean = new PageBean(20);
            pageBean.setCurPage(curPage);
            PostQuery postQuery = new PostQuery();
            postQuery.setCategoryId(firstCategory.getId());
            postQuery.setCategoryType(firstCategory.getCategoryType());
            postQuery.setStart(pageBean.getStart());
            postQuery.setNum(pageBean.getRowsPerPage());
            List<Post> postList = postDao.getByQuery(postQuery);
            pageBean.setMaxRowCount(postDao.getCountByQuery(postQuery));
            pageBean.setMaxPage();
            pageBean.setPageNoList();

            mav.addObject("pageBean",pageBean);
            mav.addObject("postList",postList);
            mav.addObject("pageBean",pageBean);
            mav.addObject("firstCategory",firstCategory);
        }
        mav.addObject("root",root);
        mav.addObject("categoryList",categoryList);
        return mav;
    }

    @RequestMapping(value = {"/post-{postId}.htm"}, method = RequestMethod.GET)
    public ModelAndView adsf(
            @PathVariable String postId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/index");

        if (StringUtils.isBlank(postId)) {
            mav.setViewName("common/message");
            mav.addObject("message","您查看的页面不存在！");
            return mav;
        }

        Post post = postDao.getByPostId(postId);
        return mav;
    }
}
