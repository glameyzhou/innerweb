package com.glamey.innerweb.controller.front;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.dao.MetaInfoDao;
import com.glamey.innerweb.model.domain.MetaInfo;
import com.glamey.innerweb.model.domain.Post;
import com.glamey.innerweb.model.dto.PostDTO;
import com.glamey.innerweb.model.dto.PostQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.dao.PostDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Links;
import com.glamey.innerweb.model.dto.CategoryQuery;
import com.glamey.innerweb.model.dto.LinksQuery;

@Controller
public class IndexFrontController extends BaseController {
    private static final Logger logger = Logger.getLogger(IndexFrontController.class);

    @Resource
    private CategoryDao categoryDao;
    @Resource
    private PostDao postDao;
    @Resource
    private LinksDao linksDao;
    @Resource
    private MetaInfoDao metaInfoDao;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws Exception {
        logger.info("[front] #index#");
        ModelAndView mav = new ModelAndView("front/index");

        //外部快捷入口
        Category outCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_OUTFASTENTRANCE);
        LinksQuery outLinksQuery = new LinksQuery();
        outLinksQuery.setCategoryType(outCategory.getCategoryType());
        outLinksQuery.setCategoryId(outCategory.getId());
        outLinksQuery.setShowIndex(1);
        outLinksQuery.setStart(0);
        outLinksQuery.setNum(10);
        List<Links> outLinksList = linksDao.getByParentId(outLinksQuery);
        mav.addObject("outLinksList", outLinksList);
        mav.addObject("outCategory", outCategory);
        //内部快捷入口
        Category inCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_INFASTENTRANCE);
        LinksQuery inLinksQuery = new LinksQuery();
        inLinksQuery.setCategoryType(inCategory.getCategoryType());
        inLinksQuery.setCategoryId(inCategory.getId());
        inLinksQuery.setShowIndex(1);
        inLinksQuery.setStart(0);
        inLinksQuery.setNum(10);
        List<Links> inLinksList = linksDao.getByParentId(inLinksQuery);
        mav.addObject("inLinksList", inLinksList);
        mav.addObject("inCategory", inCategory);

        //四个板块
        //第一板块
        List<PostDTO> area1PostDTOList = new ArrayList<PostDTO>();
        MetaInfo metaInfo1 = metaInfoDao.getByName(SystemConstants.AREA_1);
        if (metaInfo1 != null && StringUtils.isNotBlank(metaInfo1.getValue())) {
            String arrays[] = StringUtils.split(metaInfo1.getValue(), ",");
            PostDTO dto = null;
            for (String array : arrays) {
                dto = new PostDTO();
                Category cate = categoryDao.getById(array);
                dto.setCategory(cate);

                PostQuery query = new PostQuery();
                query.setCategoryId(cate.getId());
                query.setCategoryType(cate.getCategoryType());
                query.setShowIndex(1);
                query.setStart(0);
                query.setNum(5);
                List<Post> postList = postDao.getByCategoryId(query);
                dto.setPostList(postList);

                area1PostDTOList.add(dto);
            }
        }
        mav.addObject("area1PostDTOList", area1PostDTOList);
        System.out.println(area1PostDTOList);
        //第二板块
        List<PostDTO> area2PostDTOList = new ArrayList<PostDTO>();
        List<Category> area2CateList = new ArrayList<Category>();
        MetaInfo metaInfo2 = metaInfoDao.getByName(SystemConstants.AREA_2);
        if (metaInfo2 != null && StringUtils.isNotBlank(metaInfo2.getValue())) {
            String arrays[] = StringUtils.split(metaInfo2.getValue(), ",");
            PostDTO dto = null;
            for (String array : arrays) {
                dto = new PostDTO();
                Category cate = categoryDao.getById(array);
                dto.setCategory(cate);

                PostQuery query = new PostQuery();
                query.setCategoryId(cate.getId());
                query.setCategoryType(cate.getCategoryType());
                query.setShowIndex(1);
                query.setStart(0);
                query.setNum(5);
                List<Post> postList = postDao.getByCategoryId(query);
                dto.setPostList(postList);

                area2PostDTOList.add(dto);
            }
        }
        mav.addObject("area2PostDTOList", area2PostDTOList);

        //第三板块
        List<PostDTO> area3PostDTOList = new ArrayList<PostDTO>();
        List<Category> area3CateList = new ArrayList<Category>();
        MetaInfo metaInfo3 = metaInfoDao.getByName(SystemConstants.AREA_3);
        if (metaInfo3 != null && StringUtils.isNotBlank(metaInfo3.getValue())) {
            String arrays[] = StringUtils.split(metaInfo3.getValue(), ",");
            PostDTO dto = null;
            for (String array : arrays) {
                dto = new PostDTO();
                Category cate = categoryDao.getById(array);
                dto.setCategory(cate);

                PostQuery query = new PostQuery();
                query.setCategoryId(cate.getId());
                query.setCategoryType(cate.getCategoryType());
                query.setShowIndex(1);
                query.setStart(0);
                query.setNum(5);
                List<Post> postList = postDao.getByCategoryId(query);
                dto.setPostList(postList);

                area3PostDTOList.add(dto);
            }
        }
        mav.addObject("area3PostDTOList", area3PostDTOList);

        //第四板块
        List<PostDTO> area4PostDTOList = new ArrayList<PostDTO>();
        List<Category> area4CateList = new ArrayList<Category>();
        MetaInfo metaInfo4 = metaInfoDao.getByName(SystemConstants.AREA_4);
        if (metaInfo4 != null && StringUtils.isNotBlank(metaInfo4.getValue())) {
            String arrays[] = StringUtils.split(metaInfo4.getValue(), ",");
            PostDTO dto = null;
            for (String array : arrays) {
                dto = new PostDTO();
                Category cate = categoryDao.getById(array);
                dto.setCategory(cate);

                PostQuery query = new PostQuery();
                query.setCategoryId(cate.getId());
                query.setCategoryType(cate.getCategoryType());
                query.setShowIndex(1);
                query.setStart(0);
                query.setNum(5);
                List<Post> postList = postDao.getByCategoryId(query);
                dto.setPostList(postList);

                area4PostDTOList.add(dto);
            }
        }
        mav.addObject("area4PostDTOList", area4PostDTOList);

        
        /*友情链接内容显示*/
        Map<Category, List<Links>> friendlyLinksMap = new HashMap<Category, List<Links>>();
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEOGRY_FRIENDLYLINKS);
        List<Category> friendlyLinksCategory = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);
        for (Category category : friendlyLinksCategory) {
            LinksQuery query = new LinksQuery();
            query.setCategoryId(category.getId());
            query.setCategoryType(category.getCategoryType());
            query.setShowIndex(1);
            query.setStart(0);
            query.setNum(10);
            List<Links> linksList = linksDao.getByParentId(query);

            friendlyLinksMap.put(category, linksList);
        }
        System.out.println(friendlyLinksMap);

        mav.addObject("friendlyLinksMap", friendlyLinksMap);
        return mav;
    }
}