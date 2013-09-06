package com.glamey.innerweb.model.dto;

import com.glamey.innerweb.model.domain.Category;
import com.glamey.innerweb.model.domain.LibraryInfo;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class LibraryInfoDTO implements Serializable {

    private Category category;
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

    @Override
    public String toString() {
        return "LibraryInfoDTO{" +
                "category=" + category +
                ", libraryInfoList=" + libraryInfoList +
                ", libraryInfoDTOList=" + libraryInfoDTOList +
                '}';
    }
}
