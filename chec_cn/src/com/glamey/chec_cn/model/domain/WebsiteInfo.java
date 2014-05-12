package com.glamey.chec_cn.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;

/**
 * 集团网站管理信息
 */
public class WebsiteInfo implements Serializable {
	private int id;
	private String name;
	private String desc;
	private String url;
	private String sign;
	private int isSelf = 0;
    private String kw;

    public WebsiteInfo(){}
    public WebsiteInfo(String kw) {
        this.kw = kw;
    }
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return this.desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getSign() {
		return this.sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public int getIsSelf() {
		return this.isSelf;
	}

	public void setIsSelf(int isSelf) {
		this.isSelf = isSelf;
	}

    public String getKw() {
        return kw;
    }

    public void setKw(String kw) {
        this.kw = kw;
    }

    public String toString() {
		return ToStringBuilder.reflectionToString(this,
                ToStringStyle.MULTI_LINE_STYLE);
	}
}