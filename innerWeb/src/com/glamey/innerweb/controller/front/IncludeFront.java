package com.glamey.innerweb.controller.front;

import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.dao.MetaInfoDao;
import com.glamey.innerweb.dao.PostDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Links;
import com.glamey.innerweb.model.dto.LinksQuery;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 前端页面的包含内容
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class IncludeFront {
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private PostDao postDao;
    @Resource
    private LinksDao linksDao;
    @Resource
    private MetaInfoDao metaInfoDao;

    public ModelMap linksEntrance(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelMap modelMap = new ModelMap();
        //外部快捷入口
        Category outCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_OUTFASTENTRANCE);
        LinksQuery outLinksQuery = new LinksQuery();
        outLinksQuery.setCategoryType(outCategory.getCategoryType());
        outLinksQuery.setCategoryId(outCategory.getId());
        outLinksQuery.setShowIndex(1);
        outLinksQuery.setStart(0);
        outLinksQuery.setNum(10);
        List<Links> outLinksList = linksDao.getByParentId(outLinksQuery);
        modelMap.addAttribute("outLinksList", outLinksList);
        modelMap.addAttribute("outCategory", outCategory);
        //内部快捷入口
        Category inCategory = categoryDao.getByAliasName(CategoryConstants.CATEGORY_INFASTENTRANCE);
        LinksQuery inLinksQuery = new LinksQuery();
        inLinksQuery.setCategoryType(inCategory.getCategoryType());
        inLinksQuery.setCategoryId(inCategory.getId());
        inLinksQuery.setShowIndex(1);
        inLinksQuery.setStart(0);
        inLinksQuery.setNum(10);
        List<Links> inLinksList = linksDao.getByParentId(inLinksQuery);
        modelMap.addAttribute("inLinksList", inLinksList);
        modelMap.addAttribute("inCategory", inCategory);

        return modelMap ;
    }

    public ModelMap friendlyLinks(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelMap modelMap = new ModelMap();

        //友情链接内容显示
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
        modelMap.addAttribute("friendlyLinksMap", friendlyLinksMap);

        return modelMap ;
    }
}
