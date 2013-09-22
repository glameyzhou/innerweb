<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <title>用户详情（${userInfo.nickname}）</title>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 用户管理 - 用户详情</div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/user/user-${opt}.htm" id="jvForm">
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">角色:</td>
                <td width="85%" class="pn-fcontent">
                    <c:forEach var="role" items="${userInfo.roleInfoList}">
                        <c:out value="${role.roleName}"/><br/>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">用户名:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.username}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">真实姓名:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.nickname}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">状态:</td>
                <td width="85%" class="pn-fcontent">
                    <c:if test="${userInfo.isLive ==1}">开启</c:if><c:if test="${userInfo.isLive ==0}">禁用</c:if>
                </td>
            </tr>
            <%--<tr>
                <td width="15%" class="pn-flabel pn-flabel-h">问题:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.question}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">答案:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.answer}"/></td>
            </tr>--%>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">单位:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.company}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">部门:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.dept}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">职务:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.duty}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">单位地址:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.address}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">联系电话(手机):</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.mobile}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">联系电话(座机):</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.phone}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">电邮:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.email}"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">注册时间:</td>
                <td width="85%" class="pn-fcontent"><c:out value="${userInfo.time}"/></td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>