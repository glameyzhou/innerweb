package com.glamey.innerweb.model.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 系统用户角色对象
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class RoleInfo implements Serializable {
	private static final long serialVersionUID = 7068755647919955643L;
	private String roleId;
    private String roleName;
    private String roleDesc;
    private String roleRightsIds;
    private Date roleTime;
    private List<String> rightsList ;

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

    public List<String> getRightsList() {
		return rightsList;
	}

	public void setRightsList(List<String> rightsList) {
		this.rightsList = rightsList;
	}

	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
