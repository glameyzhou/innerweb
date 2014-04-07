package com.glamey.chec_cn.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSPost implements Serializable {

    private String id;
    private String categoryId;
    private Category category;
    private String title;
    private String userId;
    private UserInfo userInfo;
    private Date publishTime;
    private Date updateTime;
    private String Content;
    private int viewCount;
    private int replyCount;
    private int showTop;
    private int showGreat;
    private int showPopular;
    private String lastedUpdateUserId;
    private UserInfo lastedUpdateUserInfo;

    private int postType;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
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

    public String getLastedUpdateUserId() {
        return lastedUpdateUserId;
    }

    public void setLastedUpdateUserId(String lastedUpdateUserId) {
        this.lastedUpdateUserId = lastedUpdateUserId;
    }

    public UserInfo getLastedUpdateUserInfo() {
        return lastedUpdateUserInfo;
    }

    public void setLastedUpdateUserInfo(UserInfo lastedUpdateUserInfo) {
        this.lastedUpdateUserInfo = lastedUpdateUserInfo;
    }

    public int getPostType() {
        return postType;
    }

    public void setPostType(int postType) {
        this.postType = postType;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
