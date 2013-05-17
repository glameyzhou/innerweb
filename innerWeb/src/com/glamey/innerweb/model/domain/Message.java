/**
 * 
 */
package com.glamey.innerweb.model.domain;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * @author zy
 * 
 */
public class Message implements Serializable {
	private static final long serialVersionUID = 5360258966924619268L;
	private String id;
	private String from;
	private String to;
	private String time;
	private String content;
	/* 是否已读 1=是 0=否 */
	private int flag;

	public void setId(String id) {
		this.id = id;
	}
	public String getId() {
		return id;
	}
	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,
				ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
