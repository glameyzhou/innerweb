package com.glamey.innerweb.controller.front;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.innerweb.controller.BaseController;

@Controller
public class IntroduceFrontController extends BaseController {
	private static final Logger logger = Logger.getLogger(IntroduceFrontController.class);

	/*//首页面
	@RequestMapping(value="/{lg}/introduce",method=RequestMethod.GET)
	public ModelAndView index(
			@PathVariable String lg,
			@RequestParam(value = "cateId", required = false, defaultValue = "0") String cId,
			@RequestParam(value = "curPage", required = false, defaultValue = "1") String pg,
			HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("");
		
		pageBean = new PageBean();
		mav.addAllObjects(modelMap);
		return mav ;
	}*/
	
	
	public ModelAndView index(HttpServletRequest request,HttpServletResponse response,HttpSession session, ModelMap modelMap) throws Exception {
		logger.info("[首页] #index#");
		
		/**
		 * TODO
		 * 1、用户信息
		 * 2、用户消息
		 * 3、通知(公司、部门)
		 * 4、新闻分类内容列表
		 * 5、快捷入口(总院、集团)
		 * 6、友情链接
		 * 7、页尾(footer)
		 */
		return null ;
	}
}