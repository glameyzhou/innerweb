package com.glamey.innerweb.model.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 系统用户角色对象
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class RoleInfo implements Serializable {
    private String roleId;
    private String roleName;
    private String roleDesc;
    private String roleRightsIds;
    private Date roleTime;
    private List<RightsInfo> rightsInfoList;

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }

    public String getRoleRightsIds() {
        return roleRightsIds;
    }

    public void setRoleRightsIds(String roleRightsIds) {
        this.roleRightsIds = roleRightsIds;
    }

    public Date getRoleTime() {
        return roleTime;
    }

    public void setRoleTime(Date roleTime) {
        this.roleTime = roleTime;
    }

    public List<RightsInfo> getRightsInfoList() {
        return rightsInfoList;
    }

    public void setRightsInfoList(List<RightsInfo> rightsInfoList) {
        this.rightsInfoList = rightsInfoList;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
