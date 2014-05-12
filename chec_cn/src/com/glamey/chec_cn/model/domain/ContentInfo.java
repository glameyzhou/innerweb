package com.glamey.chec_cn.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;

public class ContentInfo implements Serializable {
	private String contentId;
	private String title;
	private int websiteId;
	private String text;
	private String publishTime;
	private int userId;
	private UserInfo userInfo;
	private String kw;
	private WebsiteInfo websiteInfo;

	public String getContentId() {
		return this.contentId;
	}

	public void setContentId(String contentId) {
		this.contentId = contentId;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getWebsiteId() {
		return this.websiteId;
	}

	public void setWebsiteId(int websiteId) {
		this.websiteId = websiteId;
	}

	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getPublishTime() {
		return this.publishTime;
	}

	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}

	public String getKw() {
		return this.kw;
	}

	public void setKw(String kw) {
		this.kw = kw;
	}

	public WebsiteInfo getWebsiteInfo() {
		return this.websiteInfo;
	}

	public void setWebsiteInfo(WebsiteInfo websiteInfo) {
		this.websiteInfo = websiteInfo;
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public UserInfo getUserInfo() {
		return this.userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this,
                ToStringStyle.SHORT_PREFIX_STYLE);
	}
}