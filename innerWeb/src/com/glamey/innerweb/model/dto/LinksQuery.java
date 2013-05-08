package com.glamey.innerweb.model.dto;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * Date: 13-5-8
 * Time: 下午7:27
 * To change this template use File | Settings | File Templates.
 */
public class LinksQuery implements Serializable {
    private String keyword ;

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    @Override
    public String toString() {
        return "LinksQuery{" +
                "keyword='" + keyword + '\'' +
                '}';
    }
}
