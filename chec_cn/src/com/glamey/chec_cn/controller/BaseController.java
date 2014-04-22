/**
 * 
 */
package com.glamey.chec_cn.controller;

import com.glamey.framework.utils.PageBean;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author zy
 *
 */
public class BaseController {

	/** 消息内容 */
	protected String message ;
	/** 消息指向的链接地址 */
	protected String href ;
	/**分页*/
	protected PageBean pageBean ;
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public PageBean getPageBean() {
		return pageBean;
	}
	public void setPageBean(PageBean pageBean) {
		this.pageBean = pageBean;
	}

    public ModelAndView pageNotFound(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("common/message");
        mav.addObject("message", "访问页面不存在");
        return mav;
    }
}
