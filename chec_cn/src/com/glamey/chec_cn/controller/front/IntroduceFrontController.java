package com.glamey.chec_cn.controller.front;

import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.LinksDao;
import com.glamey.chec_cn.dao.PostDao;
import com.glamey.chec_cn.dao.UserInfoDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Post;
import com.glamey.chec_cn.model.dto.PostQuery;
import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class IntroduceFrontController extends BaseController {

    @Autowired
    private UserInfoDao userInfoDao;
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private LinksDao linksDao;


    @RequestMapping(value = {"/introduce.htm"}, method = RequestMethod.GET)
    public ModelAndView loginShow(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/introduce/introduce");

        Category rootCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_INTRODUCE);
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
}
