<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
    </script>
</head>
<body>
<c:if test="${!isGroupLeader}">
    <c:set  var="requiredCssSyle" value=" <span class=\"pn-frequired\">*</span> "/>
    <c:set  var="requiredClass" value=" class=\"required\" "/>
</c:if>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 用户管理 - 个人信息修改</div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/user/user-${opt}.htm" id="jvForm">
        <input type="hidden" id="userId" name="userId" value="${userInfo.userId}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>角色:</td>
                <td width="85%" class="pn-fcontent">
                    <c:forEach var="role" items="${roleInfoList}">
                        ${role.roleName}<br/>
                    </c:forEach>
                    <select id="sltTarget" name="sltTarget"  multiple="true" style="display: none;">
                        <c:forEach var="role" items="${roleInfoList}">
                            <option value="${role.roleId}" selected="selected">${role.roleName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户名:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="username" id="username" class="required" size="80"
                           value="${userInfo.username}"
                           <c:if test="${opt eq 'update'}">readonly="readonly" </c:if> />&nbsp;<font color="red">唯一标识</font>
                </td>
            </tr>
            <c:choose>
                <c:when test="${opt eq 'update'}">
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="text" maxlength="100" name="passwd" id="passwd" size="80"
                                   value="">&nbsp;<font color="red">留空不更新密码</font>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="password" maxlength="100" name="passwd" id="passwd" size="80"
                                   value="">
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>确认密码:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="password" maxlength="100" name="passwdRp" id="passwdRp" class="required"
                                   size="80"
                                   value="">
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>

            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>真实姓名:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="nickname" id="nickname" class="required" size="80"
                           value="${userInfo.nickname}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>单位:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="company" id="company" class="required" size="80"
                           value="${userInfo.company}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">部门:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="dept" id="dept" size="80"
                           value="${userInfo.dept}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">职务:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="duty" id="duty" size="80"
                           value="${userInfo.duty}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">单位地址:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="address" id="address" size="80"
                           value="${userInfo.address}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">${requiredCssSyle}手机号:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="mobile" id="mobile" size="80" ${requiredClass}
                           value="${userInfo.mobile}"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">${requiredCssSyle}固话:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="phone" id="phone" size="80" value="${userInfo.phone}"  ${requiredClass}/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">${requiredCssSyle}邮箱:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="email" id="email" size="80" value="${userInfo.email}"  ${requiredClass}/>
                </td>
            </tr>
            <c:if test="${isSuper}">
                <tr>
                    <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户状态:</td>
                    <td width="85%" class="pn-fcontent">
                        <input type="radio" name="isLive" id="isLive" value="0"
                               <c:if test="${userInfo.isLive == 0}">checked="checked"</c:if> />禁用&nbsp;
                        <input type="radio" name="isLive" id="isLive" value="1"
                               <c:if test="${userInfo.isLive == 1}">checked="checked"</c:if> />启用&nbsp;
                    </td>
                </tr>
            </c:if>
            <tr>
                <td colspan="2" class="pn-fbutton">
                    <input type="submit" value="提交"> &nbsp; <input type="reset" value="重置">
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>