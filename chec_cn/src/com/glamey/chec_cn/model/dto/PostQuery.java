package com.glamey.chec_cn.model.dto;

import com.glamey.chec_cn.constants.Constants;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class PostQuery implements Serializable {

    private String kw;

    private String categoryId;
    private List<String> categoryIds;

    private String publishStartTime;
    private String publishEndTime;

    private int showIndex = -1;
    private int showList = -1;
    private int showFocusImage = -1;
    private int showTop = -1;
    private int start;
    private int num;

    private LinkedHashMap<String, String> orderMap = new LinkedHashMap<String, String>() {{
        put(Constants.ORDERBYCOLUMNNAME_POST_ORDER, Constants.ORDERBYDESC);
        put(Constants.ORDERBYCOLUMNNAME_POST_PUBLIS_TIME, Constants.ORDERBYDESC);
    }};

    public String getKw() {
        return kw;
    }

    public void setKw(String kw) {
        this.kw = kw;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public List<String> getCategoryIds() {
        return categoryIds;
    }

    public void setCategoryIds(List<String> categoryIds) {
        this.categoryIds = categoryIds;
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

    public int getShowFocusImage() {
        return showFocusImage;
    }

    public void setShowFocusImage(int showFocusImage) {
        this.showFocusImage = showFocusImage;
    }

    public int getShowTop() {
        return showTop;
    }

    public void setShowTop(int showTop) {
        this.showTop = showTop;
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

    public LinkedHashMap<String, String> getOrderMap() {
        return orderMap;
    }

    public void setOrderMap(LinkedHashMap<String, String> orderMap) {
        this.orderMap = orderMap;
    }
}
