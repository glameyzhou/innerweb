package com.glamey.chec_cn.model.dto;

import com.glamey.chec_cn.model.domain.WebsiteInfo;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;

public class AnalyzerInfo implements Serializable {
    private static final long serialVersionUID = -5177111528002169083L;
    private int websiteId;
    private WebsiteInfo websiteInfo;
    private int sendCount;
    private int revCount;
    private int readCount;
    private int usedCount;

    public int getWebsiteId() {
        return this.websiteId;
    }

    public void setWebsiteId(int websiteId) {
        this.websiteId = websiteId;
    }

    public WebsiteInfo getWebsiteInfo() {
        return this.websiteInfo;
    }

    public void setWebsiteInfo(WebsiteInfo websiteInfo) {
        this.websiteInfo = websiteInfo;
    }

    public int getSendCount() {
        return this.sendCount;
    }

    public void setSendCount(int sendCount) {
        this.sendCount = sendCount;
    }

    public int getRevCount() {
        return this.revCount;
    }

    public void setRevCount(int revCount) {
        this.revCount = revCount;
    }

    public int getReadCount() {
        return this.readCount;
    }

    public void setReadCount(int readCount) {
        this.readCount = readCount;
    }

    public int getUsedCount() {
        return this.usedCount;
    }

    public void setUsedCount(int usedCount) {
        this.usedCount = usedCount;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this,
                ToStringStyle.SHORT_PREFIX_STYLE);
    }
}