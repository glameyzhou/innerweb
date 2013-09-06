package com.glamey.library.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统功能配置对象
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class RightsInfo implements Serializable {
    private String rightsId ;
    private String rightsName ;
    private String rightsDesc ;
    private String rightsValue ;
    private Date rightsTime ;

    public String getRightsId() {
        return rightsId;
    }

    public void setRightsId(String rightsId) {
        this.rightsId = rightsId;
    }

    public String getRightsName() {
        return rightsName;
    }

    public void setRightsName(String rightsName) {
        this.rightsName = rightsName;
    }

    public String getRightsDesc() {
        return rightsDesc;
    }

    public void setRightsDesc(String rightsDesc) {
        this.rightsDesc = rightsDesc;
    }

    public String getRightsValue() {
        return rightsValue;
    }

    public void setRightsValue(String rightsValue) {
        this.rightsValue = rightsValue;
    }

    public Date getRightsTime() {
        return rightsTime;
    }

    public void setRightsTime(Date rightsTime) {
        this.rightsTime = rightsTime;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
