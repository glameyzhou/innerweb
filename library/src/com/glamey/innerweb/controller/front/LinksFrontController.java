package com.glamey.innerweb.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.constants.CategoryConstants;
import com.glamey.innerweb.constants.Constants;
import com.glamey.innerweb.constants.SystemConstants;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.dao.LinksDao;
import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.Links;
import com.glamey.innerweb.model.domain.UserInfo;
import com.glamey.innerweb.model.dto.LinksQuery;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 友情链接前段显示
 * 
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class LinksFrontController extends BaseController{

    @Resource
    private IncludeFront includeFront ;
    @Resource
    private LinksDao linksDao ;
    @Resource
    private CategoryDao categoryDao ;


    @RequestMapping(value = "/linksFront-{type}-{categoryId}.htm",method=RequestMethod.GET)
    public ModelAndView linksList(
    		@PathVariable String type ,
    		@PathVariable String categoryId ,
    		HttpServletRequest request,HttpServletResponse response,HttpSession session) {
        UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
        ModelAndView mav = new ModelAndView("front/links-list");

        int curPage = WebUtils.getRequestParameterAsInt(request,"curPage",1);
        pageBean = new PageBean(200);
        pageBean.setCurPage(curPage);

        if(StringUtils.isBlank(type)){
        	type = CategoryConstants.CATEOGRY_FRIENDLYLINKS ;
        }
        if(StringUtils.isBlank(categoryId)){
            mav.addObject("message","无效操作");
            mav.setViewName("common/errorPage");
            return mav ;
        }
        Category category = categoryDao.getById(categoryId);

        LinksQuery query = new LinksQuery();
        query.setShowIndex(1);
        query.setCategoryId(categoryId);
        query.setCategoryType(type);
        query.setStart(pageBean.getStart());
        query.setNum(pageBean.getRowsPerPage());

        List<Links> linksLIst = linksDao.getByParentId(query);
        pageBean.setMaxRowCount(linksDao.getCountByParentId(query));
        pageBean.setMaxPage();
        pageBean.setPageNoList();

        mav.addObject("pageBean",pageBean);
        mav.addObject("linksLIst",linksLIst);
        mav.addObject("category",category);

        mav.addAllObjects(includeFront.linksEntrance());
        mav.addAllObjects(includeFront.friendlyLinks(request));
        mav.addObject("unReadMessage", includeFront.unReadMessage(userInfo.getUserId()));
        mav.addAllObjects(includeFront.ofenLinks());
        mav.addObject(SystemConstants.page_foot, includeFront.getMetaByName(SystemConstants.page_foot));
        
        return mav;
    }
}
