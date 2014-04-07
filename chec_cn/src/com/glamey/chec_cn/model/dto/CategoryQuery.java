/**
 *
 */
package com.glamey.chec_cn.model.dto;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.util.List;

/**
 * 分类信息查询对象
 *
 * @author zy
 */
public class CategoryQuery implements java.io.Serializable {

    private String pid;
    private List<String> idList;
    private String kw;
    private String type;
    private int isShow = -1;
    private int isList = -1;
    private int start;
    private int num;

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public List<String> getIdList() {
        return idList;
    }

    public void setIdList(List<String> idList) {
        this.idList = idList;
    }

    public String getKw() {
        return kw;
    }

    public void setKw(String kw) {
        this.kw = kw;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
