/**
 *
 */
package com.glamey.innerweb.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.util.List;

/**
 * 系统所有分类信息
 *
 * @author zy
 */
public class Category implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    /* 唯一标识，通过UUID生成唯一的短地址作为ID*/
    private String id;
    /*分类名字*/
    private String name;
    /* 分类显示短名字*/
    private String shortName;
    /*alias 引用名字，适用于URL引用之类的，推荐使用数字、字母、下划线等，最好不要出现中文*/
    private String aliasName;
    /*分类描述*/
    private String describe;
    /*显示类型 0=列表页 1=内容页*/
    private int showType;
    /*是否首页显示 0=否 1=是*/
    private int showIndex;
    /*父ID 根为0*/
    private String parentId = "0";
    /*分类类型*/
    private String categoryType;
    /*分类图片*/
    private String categoryImage;
    /*分类排序，数字越小越靠前*/
    private int categoryOrder ;
    /*分类建立时间*/
    private String categoryTime;

    private List<Category> children ;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getAliasName() {
        return aliasName;
    }

    public void setAliasName(String aliasName) {
        this.aliasName = aliasName;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public int getShowType() {
        return showType;
    }

    public void setShowType(int showType) {
        this.showType = showType;
    }

    public int getShowIndex() {
        return showIndex;
    }

    public void setShowIndex(int showIndex) {
        this.showIndex = showIndex;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getCategoryType() {
        return categoryType;
    }

    public void setCategoryType(String categoryType) {
        this.categoryType = categoryType;
    }

    public String getCategoryImage() {
        return categoryImage;
    }

    public void setCategoryImage(String categoryImage) {
        this.categoryImage = categoryImage;
    }

    public String getCategoryTime() {
        return categoryTime;
    }

    public void setCategoryTime(String categoryTime) {
        this.categoryTime = categoryTime;
    }

    public int getCategoryOrder() {
        return categoryOrder;
    }

    public void setCategoryOrder(int categoryOrder) {
        this.categoryOrder = categoryOrder;
    }

    public List<Category> getChildren() {
        return children;
    }

    public void setChildren(List<Category> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
