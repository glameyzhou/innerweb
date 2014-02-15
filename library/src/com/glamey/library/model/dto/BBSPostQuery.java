package com.glamey.library.model.dto;

import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.UserInfo;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSPostQuery implements Serializable {
    private String kw;
    private String categoryId;
    private String userId;
    private Date publishStartTime;
    private Date publishEndTime;
    private Date updateStartTime;
    private Date updateEndTime;
    private int viewCount = -1;
    private int replyCount = -1;
    private int showTop = -1;
    private int showGreat = -1;
    private int showPopular = -1;
    private int start;
    private int num;

    public String getKw() {
        return kw;
    }

    public void setKw(String kw) {
        this.kw = kw;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getPublishStartTime() {
        return publishStartTime;
    }

    public void setPublishStartTime(Date publishStartTime) {
        this.publishStartTime = publishStartTime;
    }

    public Date getPublishEndTime() {
        return publishEndTime;
    }

    public void setPublishEndTime(Date publishEndTime) {
        this.publishEndTime = publishEndTime;
    }

    public Date getUpdateStartTime() {
        return updateStartTime;
    }

    public void setUpdateStartTime(Date updateStartTime) {
        this.updateStartTime = updateStartTime;
    }

    public Date getUpdateEndTime() {
        return updateEndTime;
    }

    public void setUpdateEndTime(Date updateEndTime) {
        this.updateEndTime = updateEndTime;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getReplyCount() {
        return replyCount;
    }

    public void setReplyCount(int replyCount) {
        this.replyCount = replyCount;
    }

    public int getShowTop() {
        return showTop;
    }

    public void setShowTop(int showTop) {
        this.showTop = showTop;
    }

    public int getShowGreat() {
        return showGreat;
    }

    public void setShowGreat(int showGreat) {
        this.showGreat = showGreat;
    }

    public int getShowPopular() {
        return showPopular;
    }

    public void setShowPopular(int showPopular) {
        this.showPopular = showPopular;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
