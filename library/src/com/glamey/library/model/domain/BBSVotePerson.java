package com.glamey.library.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User:zy
 * To change this template use File | Settings | File Templates.
 */
public class BBSVotePerson implements Serializable {
    private String voteId;
    private String propertyId;
    private String voteUserId;
    private UserInfo userInfo;
    private Date voteTime;

    public String getVoteId() {
        return voteId;
    }

    public void setVoteId(String voteId) {
        this.voteId = voteId;
    }

    public String getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(String propertyId) {
        this.propertyId = propertyId;
    }

    public String getVoteUserId() {
        return voteUserId;
    }

    public void setVoteUserId(String voteUserId) {
        this.voteUserId = voteUserId;
    }

    public Date getVoteTime() {
        return voteTime;
    }

    public void setVoteTime(Date voteTime) {
        this.voteTime = voteTime;
    }

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
