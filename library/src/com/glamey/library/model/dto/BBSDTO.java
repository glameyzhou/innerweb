package com.glamey.library.model.dto;

import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.UserInfo;

import java.io.Serializable;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSDTO implements Serializable {
    private Category category;
    private List<BBSPostDTO> bbsPostDTOList_top;
    private List<BBSPostDTO> bbsPostDTOList_normal;
    private BBSAnalyzer analyzer;
    private UserInfo bbsManager;

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<BBSPostDTO> getBbsPostDTOList_top() {
        return bbsPostDTOList_top;
    }

    public void setBbsPostDTOList_top(List<BBSPostDTO> bbsPostDTOList_top) {
        this.bbsPostDTOList_top = bbsPostDTOList_top;
    }

    public List<BBSPostDTO> getBbsPostDTOList_normal() {
        return bbsPostDTOList_normal;
    }

    public void setBbsPostDTOList_normal(List<BBSPostDTO> bbsPostDTOList_normal) {
        this.bbsPostDTOList_normal = bbsPostDTOList_normal;
    }

    public BBSAnalyzer getAnalyzer() {
        return analyzer;
    }

    public void setAnalyzer(BBSAnalyzer analyzer) {
        this.analyzer = analyzer;
    }

    public UserInfo getBbsManager() {
        return bbsManager;
    }

    public void setBbsManager(UserInfo bbsManager) {
        this.bbsManager = bbsManager;
    }
}
