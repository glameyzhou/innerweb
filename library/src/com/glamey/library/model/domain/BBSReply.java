package com.glamey.library.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSReply {
    /**
     * 回帖分类，多余字段，只要是为了方便统计使用
     */
    private String categoryId;
    private String postId;
    private String id;
    private String userId;
    private UserInfo userInfo;
    private Date publishTime;
    private Date updateTime;
    private String content;
    private String lastedUpdateUserId;
    private UserInfo lastedUpdateUserInfo;

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
