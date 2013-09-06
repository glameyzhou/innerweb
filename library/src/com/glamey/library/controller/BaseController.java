/**
 * 
 */
package com.glamey.library.controller;

import com.glamey.framework.utils.PageBean;

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
}
