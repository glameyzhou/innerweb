package com.glamey.library.model.dto;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class AccessLogQuery implements Serializable {
    private String userId;
    private String [] userIds;
    private String accessStartTime;
    private String accessEndTime;
    private String categoryId;
    private int start;
    private int num;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String[] getUserIds() {
        return userIds;
    }

    public void setUserIds(String[] userIds) {
        this.userIds = userIds;
    }

    public String getAccessStartTime() {
        return accessStartTime;
    }

    public void setAccessStartTime(String accessStartTime) {
        this.accessStartTime = accessStartTime;
    }

    public String getAccessEndTime() {
        return accessEndTime;
    }

    public void setAccessEndTime(String accessEndTime) {
        this.accessEndTime = accessEndTime;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
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
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SIMPLE_STYLE);
    }
}
