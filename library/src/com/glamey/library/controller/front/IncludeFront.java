package com.glamey.library.controller.front;

import com.glamey.library.constants.CategoryConstants;
import com.glamey.library.constants.Constants;
import com.glamey.library.constants.SystemConstants;
import com.glamey.library.dao.*;
import com.glamey.library.model.domain.*;
import com.glamey.library.model.dto.FriendlyLinksDTO;
import com.glamey.library.model.dto.LibraryQuery;
import com.glamey.library.model.dto.LinksQuery;
import com.glamey.library.model.dto.PostQuery;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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
    private LinksDao linksDao;
    @Resource
    private MetaInfoDao metaInfoDao;
    @Resource
    private PostDao postDao;
    @Resource
    private LibraryInfoDao libraryInfoDao ;

    public ModelMap ofenLinks() {
        ModelMap modelMap = new ModelMap();
        //常用链接管理
        List<FriendlyLinksDTO> linksDTOs = new ArrayList<FriendlyLinksDTO>();
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEGORY_OFENLINKS);
        List<Category> ofenLinksCategory = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);
        FriendlyLinksDTO dto = null;
        for (Category category : ofenLinksCategory) {
            LinksQuery query = new LinksQuery();
            query.setCategoryId(category.getId());
            query.setCategoryType(category.getCategoryType());
            query.setShowIndex(1);
            query.setStart(0);
            query.setNum(Integer.MAX_VALUE);
            List<Links> linksList = linksDao.getByParentId(query);

            dto = new FriendlyLinksDTO();
            dto.setCategory(category);
            dto.setLinksList(linksList);

            linksDTOs.add(dto);
        }
        modelMap.addAttribute("linksDTOs", linksDTOs);

        return modelMap;
    }
    public ModelMap friendlyLinks(HttpServletRequest request) {
        int port = request.getServerPort();
        String basePath = request.getScheme() + "://" + request.getServerName() + (port == 80 ? "" : ":" + port) + request.getContextPath() + "/";
        ModelMap modelMap = new ModelMap();

        //友情链接内容显示
        List<FriendlyLinksDTO> friendlyLinksDTOs = new ArrayList<FriendlyLinksDTO>();
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEOGRY_FRIENDLYLINKS);
        List<Category> friendlyLinksCategory = categoryDao.getByParentId(1,categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);
//        getByParentId(final int showIndex, final String parentId, final String categoryType, final int start, final int num)

        FriendlyLinksDTO dto = null;
        int count = Constants.FRIENDLYLINKSCOUNT;
        for (Category category : friendlyLinksCategory) {
            dto = new FriendlyLinksDTO();

            LinksQuery query = new LinksQuery();
            query.setCategoryId(category.getId());
            query.setCategoryType(category.getCategoryType());
            query.setShowIndex(1);
            query.setStart(0);
            query.setNum(count);
            List<Links> linksList = linksDao.getByParentId(query);
            int currentSize = linksList != null ? linksList.size() : 0;
            int max = linksDao.getCountByParentId(query);
            boolean hasMore = max > count;
            for (int i = currentSize; i < count; i++) {
                linksList.add(new Links());
            }
            if (hasMore) {
                Links links = new Links();
                links.setUrl(basePath + "linksFront-" + category.getCategoryType() + "-" + category.getId() + ".htm");
                links.setName("&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"" + basePath + "res/front/library/images/zixun_more.jpg\" border=\"0\" />");
                linksList.add(links);
            } else {
                linksList.add(new Links());
            }
            dto.setHasMore(hasMore);
            dto.setCategory(category);
            dto.setLinksList(linksList);
            friendlyLinksDTOs.add(dto);
        }
        modelMap.addAttribute("friendlyLinksDTOs", friendlyLinksDTOs);

        return modelMap;
    }

    public String getMetaByName(String name) {
        MetaInfo metaInfo = metaInfoDao.getByName(name);
        return metaInfo != null ? metaInfo.getValue() : "";
    }

    public ModelMap allInclude(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelMap map = new ModelMap();
        /*页面尾部*/
        map.put("page_foot", getMetaByName(SystemConstants.meta_page_foot));

        //页面左侧--最新荐读（行业资讯）
        /*PostQuery postQuery = new PostQuery();
        postQuery.setIsValid(1);
        postQuery.setCategoryId(CategoryConstants.CATEGORY_HANGYEZIXUN);
        postQuery.setStart(0);
        postQuery.setNum(4);
        List<Post> postList = postDao.getPostList(postQuery);
        map.put("includePostList", postList);*/

        //modify by zy 20140217 从tbl_post中摘除行业资讯，调整到图书管理分类中
        LibraryQuery query = new LibraryQuery();
        query.setCategoryId(CategoryConstants.CATEGORY_HANGYEZIXUN);
        query.setShowIndex(1);
        query.setOrderColumnName(Constants.ORDERBYCOLUMNNAME_LIB_TIME);
        query.setOrderType(Constants.ORDERBYDESC);
        query.setStart(0);
        query.setNum(6);
        List<LibraryInfo> libraryInfoList = libraryInfoDao.getByQuery(query);
        map.put("includePostList",libraryInfoList);


        //个人信息
        UserInfo sessionUserInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        map.put("sessionUserInfo", sessionUserInfo);

        //图书信息分类
        List<Category> categoryList = categoryDao.getCategoryListByType(CategoryConstants.CATEGORY_LIBRARY, 1);
        map.put("libraryCategoryList", categoryList);
        return map;
    }
}
