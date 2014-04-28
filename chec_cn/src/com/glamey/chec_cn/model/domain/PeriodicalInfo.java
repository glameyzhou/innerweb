package com.glamey.chec_cn.model.domain;

import com.glamey.framework.utils.NumberUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class PeriodicalInfo implements Serializable {
    private String id;
    private String title;
    private String summary;
    private String images;
    private int years;
    private int periodical;
    private int periodicalAll;
    private String filePath;
    private String fileName;
    private long fileSize;
    private String fileShowSize;
    private Date createTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getYears() {
        return years;
    }

    public void setYears(int years) {
        this.years = years;
    }

    public int getPeriodical() {
        return periodical;
    }

    public void setPeriodical(int periodical) {
        this.periodical = periodical;
    }

    public int getPeriodicalAll() {
        return periodicalAll;
    }

    public void setPeriodicalAll(int periodicalAll) {
        this.periodicalAll = periodicalAll;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileShowSize() {
        return NumberUtils.getFileSize(fileSize);
    }

    public void setFileShowSize(String fileShowSize) {
        this.fileShowSize = fileShowSize;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
