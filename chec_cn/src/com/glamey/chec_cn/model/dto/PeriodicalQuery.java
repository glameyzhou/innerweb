package com.glamey.chec_cn.model.dto;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class PeriodicalQuery implements Serializable {
    private String kw;
    private int yearsStart;
    private int yeasEnd;
    private int start;
    private int num;

    public String getKw() {
        return kw;
    }

    public void setKw(String kw) {
        this.kw = kw;
    }

    public int getYearsStart() {
        return yearsStart;
    }

    public void setYearsStart(int yearsStart) {
        this.yearsStart = yearsStart;
    }

    public int getYeasEnd() {
        return yeasEnd;
    }

    public void setYeasEnd(int yeasEnd) {
        this.yeasEnd = yeasEnd;
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
