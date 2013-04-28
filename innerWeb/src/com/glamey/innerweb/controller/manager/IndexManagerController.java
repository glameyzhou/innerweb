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

/**
 * 后台管理系统
 * @author zy
 *
 */
@Controller
@RequestMapping(value="/manager")
public class IndexManagerController extends BaseController {
	/**后台管理系统首页*/
	@RequestMapping(value="/index.htm")
	public String managerIndex(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "manager/index";
	}
	
	/**头部导航条*/
	@RequestMapping(value="/frame/top.htm")
	public String top(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "manager/frame/top";
	}
	
	/**后台管理系统首页*/
	@RequestMapping(value="/frame/index.htm")
	public String index(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "manager/frame/frame_index";
	}
	
	/**首页--左侧导航*/
	@RequestMapping(value="/index/left.htm")
	public String left(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "manager/index/left";
	}
	
	/**首页--网站信息*/
	@RequestMapping(value="/index/webInfo.htm")
	public String webInfo(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) throws Exception {
		return "manager/index/webInfo";
	}
}
