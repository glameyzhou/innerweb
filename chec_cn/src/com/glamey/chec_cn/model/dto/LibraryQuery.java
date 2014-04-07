package com.glamey.chec_cn.model.dto;

import com.glamey.chec_cn.constants.Constants;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class LibraryQuery implements Serializable {
    private static final long serialVersionUID = 8123860852124264495L;
    private String keyword;
    private String categoryId;
    private List<String> categoryIds;
    private int type = -1;
    private int showImage = -1;
    private int showIndex = -1;
    private int showFouceImage = -1;
    private int showRecent = -1;
    private int start;
    private int num;

    /**
     * 排序的列名称
     */
    @Deprecated
    private String orderColumnName;
    /**
     * 排序方式
     */
    @Deprecated
    private String orderType;

    /**
     * 是否有图片的选项
     */
    private int isFocusImage = -1;
    /**
     * 是否为推荐阅读
     */
    private int showSugguest = -1;

    /**
     * 排序方式
     * key      需要进行排序的字段
     * value    待排序字段的顺序
     */
    private LinkedHashMap<String, String> orderMap = new LinkedHashMap<String, String>(){{
        put(Constants.ORDERBYCOLUMNNAME_LIB_ORDER, Constants.ORDERBYDESC);
        put(Constants.ORDERBYCOLUMNNAME_LIB_TIME, Constants.ORDERBYDESC);
    }};

    public int getShowRecent() {
        return showRecent;
    }

    public void setShowRecent(int showRecent) {
        this.showRecent = showRecent;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
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

    public int getShowImage() {
        return showImage;
    }

    public void setShowImage(int showImage) {
        this.showImage = showImage;
    }

    public List<String> getCategoryIds() {
        return categoryIds;
    }

    public void setCategoryIds(List<String> categoryIds) {
        this.categoryIds = categoryIds;
    }

    public int getShowIndex() {
        return showIndex;
    }

    public void setShowIndex(int showIndex) {
        this.showIndex = showIndex;
    }

    public int getShowFouceImage() {
        return showFouceImage;
    }

    public void setShowFouceImage(int showFouceImage) {
        this.showFouceImage = showFouceImage;
    }

    public String getOrderColumnName() {
        return orderColumnName;
    }

    public void setOrderColumnName(String orderColumnName) {
        this.orderColumnName = orderColumnName;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public int getIsFocusImage() {
        return isFocusImage;
    }

    public void setIsFocusImage(int focusImage) {
        isFocusImage = focusImage;
    }

    public int getShowSugguest() {
        return showSugguest;
    }

    public void setShowSugguest(int showSugguest) {
        this.showSugguest = showSugguest;
    }

    public LinkedHashMap<String, String> getOrderMap() {
        return orderMap;
    }

    public void setOrderMap(LinkedHashMap<String, String> orderMap) {
        this.orderMap = orderMap;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this,
                ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
