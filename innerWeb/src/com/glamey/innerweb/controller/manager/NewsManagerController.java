/**
 * 
 */
package com.glamey.innerweb.controller.manager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.innerweb.controller.BaseController;
import com.glamey.innerweb.model.domain.Category;

/**
 * 新闻内容管理
 * @author zy
 *
 */
@Controller
@RequestMapping(value="/manager/news")
public class NewsManagerController extends BaseController {
	private static final Logger logger = Logger.getLogger(Category.class);
	
	/**新闻管理--首页**/
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String index(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		return "manager/frame/frame_news" ;
	}
	
	/**新闻管理--首页--左侧**/
	@RequestMapping(value="/left",method=RequestMethod.GET)
	public String left(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		return "manager/news/left" ;
	}
	
	
	@RequestMapping(value="/create",method=RequestMethod.GET)
	public ModelAndView createShow(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[NewsCategoryController] #createShow#");
		return null ;
	}
	
	@RequestMapping(value="/create",method=RequestMethod.POST)
	public ModelAndView create(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[NewsCategoryController] #create#");
		return null ;
	}
	
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public ModelAndView updateShow(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[NewsCategoryController] #updateShow#");
		return null ;
	}
	
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public ModelAndView update(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[NewsCategoryController] #update#");
		return null ;
	}
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public ModelAndView list(HttpServletRequest req,HttpServletResponse resp,HttpSession session){
		logger.info("[NewsCategoryController] #list#");
		return null ;
	}
}
