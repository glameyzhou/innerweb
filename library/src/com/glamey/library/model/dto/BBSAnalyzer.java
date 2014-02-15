package com.glamey.library.model.dto;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSAnalyzer implements Serializable{
    private String categoryId;
    /**
     * 主帖总量
     */
    private int postCount;
    /**
     * 主帖+回复总量
     */
    private int postReplyCount;
    /**
     * 当天的主帖+回复总量
     */
    private int todayPostReplyCount;

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public int getPostCount() {
        return postCount;
    }

    public void setPostCount(int postCount) {
        this.postCount = postCount;
    }

    public int getPostReplyCount() {
        return postReplyCount;
    }

    public void setPostReplyCount(int postReplyCount) {
        this.postReplyCount = postReplyCount;
    }

    public int getTodayPostReplyCount() {
        return todayPostReplyCount;
    }

    public void setTodayPostReplyCount(int todayPostReplyCount) {
        this.todayPostReplyCount = todayPostReplyCount;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SIMPLE_STYLE);
    }
}
