package com.glamey.library.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSPostVote implements Serializable {
    private String postId;
    private String voteId;
    private String voteEndDate;
    private int isMultiVote;
    private int multiVoteSize;
    private int seeAfterVote;
    private int votePersonOut;

    private List<BBSVoteProperty> votePropertyList;

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getVoteId() {
        return voteId;
    }

    public void setVoteId(String voteId) {
        this.voteId = voteId;
    }

    public String getVoteEndDate() {
        return voteEndDate;
    }

    public void setVoteEndDate(String voteEndDate) {
        this.voteEndDate = voteEndDate;
    }

    public int getIsMultiVote() {
        return isMultiVote;
    }

    public void setIsMultiVote(int multiVote) {
        isMultiVote = multiVote;
    }

    public int getMultiVoteSize() {
        return multiVoteSize;
    }

    public void setMultiVoteSize(int multiVoteSize) {
        this.multiVoteSize = multiVoteSize;
    }

    public int getSeeAfterVote() {
        return seeAfterVote;
    }

    public void setSeeAfterVote(int seeAfterVote) {
        this.seeAfterVote = seeAfterVote;
    }

    public int getVotePersonOut() {
        return votePersonOut;
    }

    public void setVotePersonOut(int votePersonOut) {
        this.votePersonOut = votePersonOut;
    }

    public List<BBSVoteProperty> getVotePropertyList() {
        return votePropertyList;
    }

    public void setVotePropertyList(List<BBSVoteProperty> votePropertyList) {
        this.votePropertyList = votePropertyList;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
