<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>系统通讯录</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 通讯录</div>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/user/contact.htm" method="get" style="padding-top:5px;">
        <div>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
            部门&nbsp;<select name="deptId" id="deptId">
            <option value="">请选择</option>
            <c:forEach var="dept" items="${deptInfoList}">
                <option value="${dept.id}"
                        <c:if test="${query.deptId eq dept.id}">selected="selected" </c:if>>${dept.name}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;
            <input type="submit" value="查询">
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th>姓名</th>
                <th>部门</th>
                <th>手机号</th>
                <th>固话</th>
                <th>邮箱</th>
                <th>地址</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${userInfoList}" var="user" varStatus="status">
                <tr>
                    <td align=center>${user.nickname}</td>
                    <td align=center>${user.category.name}</td>
                    <td align=center>${user.mobile}</td>
                    <td align=center>${user.phone}</td>
                    <td align=center>${user.email}</td>
                    <td align=center>${user.address}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/user/contact.htm?keyword=${fmtString:encoder(query.keyword)}&deptId=${query.deptId}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>