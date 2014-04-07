package com.glamey.chec_cn.model.domain;

import java.util.Date;

/**
 * 正文内容
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class Post {
    private String id;
    private String cateId;
    private String cateType;
    private Category category;
    private String title;
    private String author;
    private String source;
    private Date publishTime;
    private Date updateTime;
    private String outLink;
    /**
     * 排序越大越靠前
     */
    private int order;
    private int showIndex;
    private int showList;
    private int isValid;
    private int isFoucs;
    private String foucsImg;
    private String summary;
    private String content;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCateId() {
        return cateId;
    }

    public void setCateId(String cateId) {
        this.cateId = cateId;
    }

    public String getCateType() {
        return cateType;
    }

    public void setCateType(String cateType) {
        this.cateType = cateType;
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
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

    public String getOutLink() {
        return outLink;
    }

    public void setOutLink(String outLink) {
        this.outLink = outLink;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public int getShowIndex() {
        return showIndex;
    }

    public void setShowIndex(int showIndex) {
        this.showIndex = showIndex;
    }

    public int getShowList() {
        return showList;
    }

    public void setShowList(int showList) {
        this.showList = showList;
    }

    public int getIsValid() {
        return isValid;
    }

    public void setIsValid(int valid) {
        isValid = valid;
    }

    public int getIsFoucs() {
        return isFoucs;
    }

    public void setIsFoucs(int foucs) {
        isFoucs = foucs;
    }

    public String getFoucsImg() {
        return foucsImg;
    }

    public void setFoucsImg(String foucsImg) {
        this.foucsImg = foucsImg;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
