<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <title>用户<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></title>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
    </script>
</head>
<body>
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
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>部门:</td>
                <td width="85%" class="pn-fcontent">
                    <select id="deptId" name="deptId" class="required">
                        <option value="">请选择</option>
                        <c:forEach items="${deptInfoList}" var="dept">
                            <option value="${dept.id}" <c:if test="${userInfo.category.id eq dept.id}">selected</c:if>>${dept.name}</option>
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
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="passwd" id="passwd" size="80"
                           value="">&nbsp;<font color="red">留空不更新密码</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>姓名:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="nickname" id="nickname" class="required" size="80"
                           value="${userInfo.nickname}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>手机号:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="mobile" id="mobile" class="required" size="80"
                           value="${userInfo.mobile}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">固话:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="phone" id="phone" size="80" value="${userInfo.phone}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">邮箱:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="email" id="email" size="80" value="${userInfo.email}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">地址:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="address" id="address" size="100"
                           value="${userInfo.address}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户状态:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="isLive" id="isLive" value="0"
                    <c:if test="${userInfo.isLive == 0}">checked="checked"</c:if> />禁用&nbsp;
                    <input type="radio" name="isLive" id="isLive" value="1"
                    <c:if test="${userInfo.isLive == 1}">checked="checked"</c:if> />启用&nbsp;
                </td>
            </tr>
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