package com.glamey.chec_cn.controller.front;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.WebUtils;
import com.glamey.chec_cn.constants.CategoryConstants;
import com.glamey.chec_cn.constants.Constants;
import com.glamey.chec_cn.constants.SystemConstants;
import com.glamey.chec_cn.controller.BaseController;
import com.glamey.chec_cn.dao.AccessLogDao;
import com.glamey.chec_cn.dao.CategoryDao;
import com.glamey.chec_cn.dao.LinksDao;
import com.glamey.chec_cn.model.domain.Category;
import com.glamey.chec_cn.model.domain.Links;
import com.glamey.chec_cn.model.domain.UserInfo;
import com.glamey.chec_cn.model.dto.LinksQuery;
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
    @Resource
    private AccessLogDao accessLogDao;

    @RequestMapping(value = "/linksFront-{type}-{categoryId}.htm",method=RequestMethod.GET)
    public ModelAndView linksList(
    		@PathVariable String type ,
    		@PathVariable String categoryId ,
    		HttpServletRequest request,HttpServletResponse response,HttpSession session) {
        ModelAndView mav = new ModelAndView("front/links-list");


        mav.addAllObjects(includeFront.allInclude(request,response,session));

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
        Category category = categoryDao.getBySmpleId(categoryId);

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

        accessLogDao.save("linksFront-" + type + "-" + categoryId + ".htm","友情链接(" + category.getName() + ")",categoryId,session);

        return mav;
    }
}
