package com.glamey.chec_cn.model.dto;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.util.Date;
import java.util.List;

/**
 * 正文内容查询对象
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class PostQuery {
    private String cateId;
    private String cateType;
    private List<String> cateIds;
    private String kw;
    private Date publishTime_start;
    private Date publishTime_end;
    private int showIndex = -1;
    private int showList = -1;
    private int isValid = -1;
    private int isFoucs = -1;
    private int start;
    private int num;

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

    public List<String> getCateIds() {
        return cateIds;
    }

    public void setCateIds(List<String> cateIds) {
        this.cateIds = cateIds;
    }

    public String getKw() {
        return kw;
    }

    public void setKw(String kw) {
        this.kw = kw;
    }

    public Date getPublishTime_start() {
        return publishTime_start;
    }

    public void setPublishTime_start(Date publishTime_start) {
        this.publishTime_start = publishTime_start;
    }

    public Date getPublishTime_end() {
        return publishTime_end;
    }

    public void setPublishTime_end(Date publishTime_end) {
        this.publishTime_end = publishTime_end;
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
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
