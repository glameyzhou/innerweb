/**
 * 
 */
package com.glamey.innerweb.controller.manager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.glamey.innerweb.controller.BaseController;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 后台管理系统--首页内容
 * @author zy
 *
 */
@Controller
@RequestMapping(value="/mg")
public class HomeManagerController extends BaseController {
	/**后台管理系统首页*/
    @RequestMapping(value="/home.htm",method= RequestMethod.GET)
	public String managerHome(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "mg/home";
	}

	/**头部导航条*/
	@RequestMapping(value="/frame/top.htm")
	public String top(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "mg/frame/top";
	}
	
	/**后台管理系统首页*/
	@RequestMapping(value="/frame/home.htm")
	public String index(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "mg/frame/frame_home";
	}
	
	/**首页--左侧导航*/
	@RequestMapping(value="/home/left.htm")
	public String left(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "mg/home/left";
	}
	
	/**首页--网站信息*/
	@RequestMapping(value="/home/webInfo.htm")
	public String webInfo(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "mg/home/webInfo";
	}
}
