package com.glamey.library.model.dto;

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
public class BBSPostDTO implements Serializable {

    private String postId;
    private String title;
    private String userId;
    private UserInfo userInfo;
    private int showTop;
    private int showGreat;
    private int showPopular;
    private Date postUpdateTime;
    private int viewCount;
    private int replyCount;

    private String lastReplyUserId;
    private UserInfo lastReplyUserInfo;
    private Date lastReplyUpdateTime;

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
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

    public Date getPostUpdateTime() {
        return postUpdateTime;
    }

    public void setPostUpdateTime(Date postUpdateTime) {
        this.postUpdateTime = postUpdateTime;
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

    public String getLastReplyUserId() {
        return lastReplyUserId;
    }

    public void setLastReplyUserId(String lastReplyUserId) {
        this.lastReplyUserId = lastReplyUserId;
    }

    public UserInfo getLastReplyUserInfo() {
        return lastReplyUserInfo;
    }

    public void setLastReplyUserInfo(UserInfo lastReplyUserInfo) {
        this.lastReplyUserInfo = lastReplyUserInfo;
    }

    public Date getLastReplyUpdateTime() {
        return lastReplyUpdateTime;
    }

    public void setLastReplyUpdateTime(Date lastReplyUpdateTime) {
        this.lastReplyUpdateTime = lastReplyUpdateTime;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SIMPLE_STYLE);
    }
}
