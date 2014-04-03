package com.glamey.library.model.dto;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSReplyQuery implements Serializable {
    private String kw;
    private String userId;
    private String publishStartTime;
    private String publishEndTime;
    private String updateStartTime;
    private String updateEndTime;
    private int start;
    private int num;
    private String postId;

    private String orderColumn;
    private String orderType;

    /**
     * 是否已经删除
     *
     * 1=删除
     * 0=未删除
     */
    private int isDelete = -1;

    public String getKw() {
        return kw;
    }

    public void setKw(String kw) {
        this.kw = kw;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPublishStartTime() {
        return publishStartTime;
    }

    public void setPublishStartTime(String publishStartTime) {
        this.publishStartTime = publishStartTime;
    }

    public String getPublishEndTime() {
        return publishEndTime;
    }

    public void setPublishEndTime(String publishEndTime) {
        this.publishEndTime = publishEndTime;
    }

    public String getUpdateStartTime() {
        return updateStartTime;
    }

    public void setUpdateStartTime(String updateStartTime) {
        this.updateStartTime = updateStartTime;
    }

    public String getUpdateEndTime() {
        return updateEndTime;
    }

    public void setUpdateEndTime(String updateEndTime) {
        this.updateEndTime = updateEndTime;
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

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getOrderColumn() {
        return orderColumn;
    }

    public void setOrderColumn(String orderColumn) {
        this.orderColumn = orderColumn;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int delete) {
        isDelete = delete;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
