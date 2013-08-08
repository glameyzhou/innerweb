package com.glamey.innerweb.controller.front;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.glamey.innerweb.constants.SystemConstants;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;

import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.dao.MessageDao;
import com.glamey.innerweb.dao.MetaInfoDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Links;
import com.glamey.innerweb.model.domain.MetaInfo;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.FriendlyLinksDTO;
import com.glamey.innerweb.model.dto.LinksQuery;
import com.glamey.innerweb.model.dto.MessageQuery;

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
    private MessageDao messageDao;

    public ModelMap linksEntrance() {
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

        return modelMap;
    }

    public ModelMap friendlyLinks(HttpServletRequest request) {
        int port = request.getServerPort();
        String basePath = request.getScheme() + "://" + request.getServerName() + (port == 80 ? "" : ":" + port) + request.getContextPath() + "/";
        ModelMap modelMap = new ModelMap();

        //友情链接内容显示
        List<FriendlyLinksDTO> friendlyLinksDTOs = new ArrayList<FriendlyLinksDTO>();
        Category categoryParent = categoryDao.getByAliasName(CategoryConstants.CATEOGRY_FRIENDLYLINKS);
        List<Category> friendlyLinksCategory = categoryDao.getByParentId(categoryParent.getId(), categoryParent.getCategoryType(), 0, Integer.MAX_VALUE);

        FriendlyLinksDTO dto = null;
        int count = com.glamey.innerweb.constants.Constants.FRIENDLYLINKSCOUNT;
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
                links.setName("&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"" + basePath + "res/front/images/right_tit_biao2.png\" border=\"0\" />");
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

    public String getMetaByName(String name) {
        MetaInfo metaInfo = metaInfoDao.getByName(name);
        return metaInfo != null ? metaInfo.getValue() : "";
    }

    public int unReadMessage(String userId) {
        MessageQuery query = new MessageQuery();
        query.setFlag(2);
        query.setTo(userId);
        int count = messageDao.getCountMessageList(query);
        return count;
    }

    public ModelMap allInclude(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelMap map = new ModelMap();

        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        String userId = userInfo.getUserId();

        /*未读消息*/
        map.put("unReadMessage", unReadMessage(userId));

        /*快捷链接入口*/
        map.addAllAttributes(linksEntrance());

        /*常用链接*/
        map.addAllAttributes(ofenLinks());

        /*友情链接*/
        map.addAllAttributes(friendlyLinks(request));

        /*页面尾部*/
        map.put("page_foot",getMetaByName(SystemConstants.page_foot));
        return map;
    }
}
