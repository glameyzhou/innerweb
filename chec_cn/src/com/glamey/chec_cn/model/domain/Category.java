/**
 *
 */
package com.glamey.chec_cn.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 系统所有分类信息
 *
 * @author zy
 */
public class Category implements java.io.Serializable {

    private String id;
    private String pid;
    private Category categoryPid;
    /**
     * 枚举类型
     */
    private String type;
    private int order;
    /**
     * 是否显示
     */
    private int isShow;
    /**
     * 是否为列表
     */
    private int isList;
    private int hasChildren;
    /**
     * 仅显示一级分类
     */
    private Category children;
    private String name;
    private String aliasName;
    private String image;
    private String flv;
    private String desc;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public Category getCategoryPid() {
        return categoryPid;
    }

    public void setCategoryPid(Category categoryPid) {
        this.categoryPid = categoryPid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public int getIsShow() {
        return isShow;
    }

    public void setIsShow(int show) {
        isShow = show;
    }

    public int getIsList() {
        return isList;
    }

    public void setIsList(int list) {
        isList = list;
    }

    public int getHasChildren() {
        return hasChildren;
    }

    public void setHasChildren(int hasChildren) {
        this.hasChildren = hasChildren;
    }

    public Category getChildren() {
        return children;
    }

    public void setChildren(Category children) {
        this.children = children;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAliasName() {
        return aliasName;
    }

    public void setAliasName(String aliasName) {
        this.aliasName = aliasName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getFlv() {
        return flv;
    }

    public void setFlv(String flv) {
        this.flv = flv;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
