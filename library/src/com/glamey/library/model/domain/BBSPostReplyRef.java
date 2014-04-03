package com.glamey.library.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSPostReplyRef implements Serializable {

    private String postId;
    private String replyId;
    private int replyFloor;
    private String replyUserId;
    private UserInfo replyUserInfo;

    private String curReplyId;
    private String curReplyUserId;
    private UserInfo curReplyUserInfo;

    private Date replyTime;

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getReplyId() {
        return replyId;
    }

    public void setReplyId(String replyId) {
        this.replyId = replyId;
    }

    public int getReplyFloor() {
        return replyFloor;
    }

    public void setReplyFloor(int replyFloor) {
        this.replyFloor = replyFloor;
    }

    public String getReplyUserId() {
        return replyUserId;
    }

    public void setReplyUserId(String replyUserId) {
        this.replyUserId = replyUserId;
    }


    public String getCurReplyId() {
        return curReplyId;
    }

    public void setCurReplyId(String curReplyId) {
        this.curReplyId = curReplyId;
    }

    public String getCurReplyUserId() {
        return curReplyUserId;
    }

    public void setCurReplyUserId(String curReplyUserId) {
        this.curReplyUserId = curReplyUserId;
    }


    public Date getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(Date replyTime) {
        this.replyTime = replyTime;
    }

    public UserInfo getCurReplyUserInfo() {
        return curReplyUserInfo;
    }

    public void setCurReplyUserInfo(UserInfo curReplyUserInfo) {
        this.curReplyUserInfo = curReplyUserInfo;
    }

    public UserInfo getReplyUserInfo() {
        return replyUserInfo;
    }

    public void setReplyUserInfo(UserInfo replyUserInfo) {
        this.replyUserInfo = replyUserInfo;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
