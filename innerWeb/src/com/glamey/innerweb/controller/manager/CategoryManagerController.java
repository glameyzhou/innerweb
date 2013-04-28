/**
 * 
 */
package com.glamey.innerweb.controller.manager;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.framework.utils.PageBean;
import com.glamey.framework.utils.StringTools;
import com.glamey.framework.utils.WebUtils;
import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.dao.CategoryDao;
import com.glamey.innerweb.model.domain.Category;

/**
 * @author zy
 *
 */
@Controller
@RequestMapping(value="/manager/category")
public class CategoryManagerController extends BaseController {
	
	private static final Logger logger = Logger.getLogger(CategoryManagerController.class);
	@Resource
	private CategoryDao categoryDao ;
	
	@RequestMapping(value="/create.htm",method=RequestMethod.GET)
	public ModelAndView createShow(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[分类管理] #createShow# " + req.getRequestURI());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/category/category-show");
		mav.addObject("categoryType", "news_category");
		mav.addObject("opt", "create");
		return mav ;
	}

	@RequestMapping(value="/create.htm",method=RequestMethod.POST)
	public ModelAndView create(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[分类管理] #create# " + req.getRequestURI());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("common/message");

		String name = WebUtils.getRequestParameterAsString(req, "name", "");
		String describe = WebUtils.getRequestParameterAsString(req, "describe", "");
		int showType = WebUtils.getRequestParameterAsInt(req, "showType", 0);
		int showIndex = WebUtils.getRequestParameterAsInt(req, "showIndex", 0);
		String parentId = WebUtils.getRequestParameterAsString(req, "parentId", "");
		String categoryType = WebUtils.getRequestParameterAsString(req, "categoryType", "news_category");
		String id = StringTools.getUniqueId();
		
		Category category = new Category();
		category.setId(id);
		category.setName(name);
		category.setDescribe(describe);
		category.setShowType(showType);
		category.setShowIndex(showIndex);
		category.setParentId(parentId);
		category.setCategoryType(categoryType);
		
		if(categoryDao.create(category)){
			message = "新闻分类添加成功!" ;
		}
		else{
			message = "新闻分类添加失败!" ;
		}
		mav.addObject("message", message);
		return mav ;
	}
	
	@RequestMapping(value="/update.htm",method=RequestMethod.GET)
	public ModelAndView updateShow(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[分类管理] #updateShow#" + req.getRequestURI());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/category/category-show");
		mav.addObject("categoryType", "news_category");
		mav.addObject("opt", "update");
		
		String id = WebUtils.getRequestParameterAsString(req, "id", "");
		if(StringUtils.isBlank(id)){
			message = "数据错误,请重试!" ;
			mav.addObject("message", message);
			return mav ;
		}
		Category category = categoryDao.getById(id);
		mav.addObject("category", category);
		return mav ;
	}
	
	@RequestMapping(value="/update.htm",method=RequestMethod.POST)
	public ModelAndView update(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[分类管理] #update#" + req.getRequestURI());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("common/message");
		
		String id = WebUtils.getRequestParameterAsString(req, "id", "");
		String name = WebUtils.getRequestParameterAsString(req, "name", "");
		String describe = WebUtils.getRequestParameterAsString(req, "describe", "");
		int showType = WebUtils.getRequestParameterAsInt(req, "showType", 0);
		int showIndex = WebUtils.getRequestParameterAsInt(req, "showIndex", 0);
		String parentId = WebUtils.getRequestParameterAsString(req, "parentId", "");
		String categoryType = WebUtils.getRequestParameterAsString(req, "categoryType", "news_category");
		
		if(StringUtils.isBlank(id)){
			message = "数据错误,请重试!" ;
			mav.addObject("message", message);
			return mav ;
		}
		
		Category category = categoryDao.getById(id);
		category.setName(name);
		category.setDescribe(describe);
		category.setShowType(showType);
		category.setShowIndex(showIndex);
		category.setParentId(parentId);
		category.setCategoryType(categoryType);
		
		if(categoryDao.update(category))
			message = "新闻分类更新成功!" ;
		else
			message = "新闻分类更新失败!" ;
		mav.addObject("message", message);
		return mav ;
	}
		
	@RequestMapping(value="/list.htm",method=RequestMethod.GET)
	public ModelAndView list(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[分类管理] #list#");
		String categoryType = WebUtils.getRequestParameterAsString(req, "categoryType", "news_category");
		String parentId = WebUtils.getRequestParameterAsString(req, "parentId", "0");
		
		pageBean = new PageBean();
		pageBean.setMaxRowCount(categoryDao.getCountByParentId(parentId, categoryType));
		pageBean.setMaxPage();
		pageBean.setPageNoList();
		List<Category> categoryList = categoryDao.getByParentId(parentId, categoryType,pageBean.getStart(),pageBean.getRowsPerPage());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/category/category-list");
		mav.addObject("pageBean", pageBean);
		mav.addObject("categoryList",categoryList);
		mav.addObject("categoryType",categoryType);
		mav.addObject("parentId",parentId);
		return mav ;
	}
}
