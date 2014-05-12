package com.glamey.chec_cn.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.commons.lang.time.DateFormatUtils;

import java.io.Serializable;
import java.util.Date;

public class MsgInfo implements Serializable {
	private static final long serialVersionUID = 6582347186536021992L;
	private String msgId;
	private int msgFrom;
	private WebsiteInfo websiteFrom;
	private int msgTo;
	private WebsiteInfo websiteTo;
	private String contentId;
	private ContentInfo contentInfo;
	private String msgTime = DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss");
	private int msgStatus = -1;
	private String statusTime = DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss");
	private int isRead = 0;
	private String readTime = DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss");
	private int isUsed = 0;
	private String usedTime = DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss");
	private int websiteId;
	private String startTime;
	private String endTime;

	public String getMsgId() {
		return this.msgId;
	}

	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}

	public int getMsgFrom() {
		return this.msgFrom;
	}

	public void setMsgFrom(int msgFrom) {
		this.msgFrom = msgFrom;
	}

	public WebsiteInfo getWebsiteFrom() {
		return this.websiteFrom;
	}

	public void setWebsiteFrom(WebsiteInfo websiteFrom) {
		this.websiteFrom = websiteFrom;
	}

	public int getMsgTo() {
		return this.msgTo;
	}

	public void setMsgTo(int msgTo) {
		this.msgTo = msgTo;
	}

	public WebsiteInfo getWebsiteTo() {
		return this.websiteTo;
	}

	public void setWebsiteTo(WebsiteInfo websiteTo) {
		this.websiteTo = websiteTo;
	}

	public String getContentId() {
		return this.contentId;
	}

	public void setContentId(String contentId) {
		this.contentId = contentId;
	}

	public ContentInfo getContentInfo() {
		return this.contentInfo;
	}

	public void setContentInfo(ContentInfo contentInfo) {
		this.contentInfo = contentInfo;
	}

	public String getMsgTime() {
		return this.msgTime;
	}

	public void setMsgTime(String msgTime) {
		this.msgTime = msgTime;
	}

	public int getMsgStatus() {
		return this.msgStatus;
	}

	public void setMsgStatus(int msgStatus) {
		this.msgStatus = msgStatus;
	}

	public String getStatusTime() {
		return this.statusTime;
	}

	public void setStatusTime(String statusTime) {
		this.statusTime = statusTime;
	}

	public int getIsRead() {
		return this.isRead;
	}

	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}

	public String getReadTime() {
		return this.readTime;
	}

	public void setReadTime(String readTime) {
		this.readTime = readTime;
	}

	public int getIsUsed() {
		return this.isUsed;
	}

	public void setIsUsed(int isUsed) {
		this.isUsed = isUsed;
	}

	public String getUsedTime() {
		return this.usedTime;
	}

	public void setUsedTime(String usedTime) {
		this.usedTime = usedTime;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getWebsiteId() {
		return this.websiteId;
	}

	public void setWebsiteId(int websiteId) {
		this.websiteId = websiteId;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this,
                ToStringStyle.SHORT_PREFIX_STYLE);
	}
}