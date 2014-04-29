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
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
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
public class IndexFrontController extends BaseController {

    @Autowired
    private UserInfoDao userInfoDao;
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private LinksDao linksDao;


    @RequestMapping(value = {"/index.htm","/index.html"}, method = RequestMethod.GET)
    public ModelAndView loginShow(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("front/index");

        /*焦点图*/
        PostQuery query = new PostQuery();
        query.setShowFocusImage(1);
        query.setShowIndex(1);
        query.setStart(0);
        query.setNum(6);
        query.setCategoryType(CategoryConstants.CATEGORY_NEWS);
        List<Post> focusImageList = postDao.getByQuery(query);
        mav.addObject("focusImageList",focusImageList);

        /*要闻快递*/
        query = new PostQuery();
        query.setStart(0);
        query.setNum(6);
        query.setCategoryType(CategoryConstants.CATEGORY_NEWS);
        query.setCategoryId(CategoryConstants.CATEGORY_ID_YAOWENKUAIDI);
        List<Post> yaowenkuaidiList = postDao.getByQuery(query);
        mav.addObject("yaowenkuaidiList",yaowenkuaidiList);

        /*公司新闻*/
        query = new PostQuery();
        query.setStart(0);
        query.setNum(7);
        query.setCategoryType(CategoryConstants.CATEGORY_NEWS);
        query.setCategoryId(CategoryConstants.CATEGORY_ID_GONGSIXINWEN);
        List<Post> gongsixinwenList = postDao.getByQuery(query);
        mav.addObject("gongsixinwenList",gongsixinwenList);

        /*公司简介*/
        query = new PostQuery();
        query.setStart(0);
        query.setNum(1);
        query.setCategoryId(CategoryConstants.CATEGORY_ID_GONGSIJIANJIE);
        query.setCategoryType(CategoryConstants.CATEGORY_INTRODUCE);
        List<Post> gongsijianjieList = postDao.getByQuery(query);
        Post gongsijianjie = CollectionUtils.isEmpty(gongsijianjieList) ? new Post() : gongsijianjieList.get(0);
        mav.addObject("gongsijianjie",gongsijianjie);

        /**
         * 公司业绩描述
         */
        Category rootBusiness = categoryDao.getByAliasName(CategoryConstants.CATEGORY_BUSINESS);
        String businessContent = rootBusiness.getDescribe();
        if (StringUtils.isNotBlank(businessContent))
            businessContent = businessContent.replaceAll("<.+?>","").replaceAll("&nbsp;","");
        rootBusiness.setDescribe(businessContent);
        mav.addObject("rootBusiness",rootBusiness);

        /*发展战略*/
        query = new PostQuery();
        query.setStart(0);
        query.setNum(1);
        query.setCategoryId(CategoryConstants.CATEGORY_ID_FAZHANZHALUE);
        query.setCategoryType(CategoryConstants.CATEGORY_INTRODUCE);
        List<Post> fazhanzhanlue_list = postDao.getByQuery(query);
        Post fazhanzhanlue = CollectionUtils.isEmpty(fazhanzhanlue_list) ? new Post() : fazhanzhanlue_list.get(0);
        mav.addObject("fazhanzhanlue",fazhanzhanlue);

        /**
         * 资质荣誉描述
         */
        Category zizhirongyu = categoryDao.getById(CategoryConstants.CATEGORY_ID_ZIZHIRONGYU);
        String zzryContent = zizhirongyu.getDescribe();
        if (StringUtils.isNotBlank(zzryContent))
            zzryContent = zzryContent.replaceAll("<.+?>","").replaceAll("&nbsp;","");
        zizhirongyu.setDescribe(zzryContent);
        mav.addObject("zizhirongyu",zizhirongyu);


        /*所有链接*/
        Category categoryLinks = categoryDao.getByAliasName(CategoryConstants.CATEGORY_LINKS);
        List<Category> categoryList_links = categoryDao.getByParentId(categoryLinks.getId(),categoryLinks.getCategoryType(),0,Integer.MAX_VALUE);
        Map<Category,List<Links>> linksMap = new LinkedHashMap<Category, List<Links>>();
        for (Category category : categoryList_links) {
            LinksQuery linksQuery = new LinksQuery();
            linksQuery.setCategoryId(category.getId());
            linksQuery.setNum(Integer.MAX_VALUE);
            List<Links> list = linksDao.getByQuery(linksQuery);
            linksMap.put(category,list);
        }
        mav.addObject("linksMap", linksMap);
        return mav;
    }
}
