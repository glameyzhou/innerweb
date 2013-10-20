package com.glamey.library.model.dto;

import com.glamey.library.model.domain.Category;
import com.glamey.library.model.domain.LibraryInfo;

import java.io.Serializable;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class LibraryInfoDTO implements Serializable {

    private Category category;
    private List<Category> childrenCategory;
    private List<LibraryInfo> libraryInfoList;

    private List<LibraryInfoDTO> libraryInfoDTOList ;


    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<LibraryInfo> getLibraryInfoList() {
        return libraryInfoList;
    }

    public void setLibraryInfoList(List<LibraryInfo> libraryInfoList) {
        this.libraryInfoList = libraryInfoList;
    }

    public List<LibraryInfoDTO> getLibraryInfoDTOList() {
        return libraryInfoDTOList;
    }

    public void setLibraryInfoDTOList(List<LibraryInfoDTO> libraryInfoDTOList) {
        this.libraryInfoDTOList = libraryInfoDTOList;
    }

    public List<Category> getChildrenCategory() {
        return childrenCategory;
    }

    public void setChildrenCategory(List<Category> childrenCategory) {
        this.childrenCategory = childrenCategory;
    }

    @Override
    public String toString() {
        return "LibraryInfoDTO{" +
                "category=" + category +
                ", libraryInfoList=" + libraryInfoList +
                ", libraryInfoDTOList=" + libraryInfoDTOList +
                '}';
    }
}
