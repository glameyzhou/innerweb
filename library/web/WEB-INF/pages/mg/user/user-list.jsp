<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>系统用户列表</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(userId) {
            window.location = '${basePath}mg/user/user-show.htm?userId=' + userId;
        }
        function del(userId) {
            if (!confirm("确定要删除?")) {
                return;
            }
            window.location = '${basePath}mg/user/user-del.htm?userId=' + userId;
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 系统用户 - 管理</div>
        <form class="ropt">
            <input type="submit" value="添加" onclick="this.form.action='${basePath}mg/user/user-show.htm';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/user/user-list.htm" method="get" style="padding-top:5px;">
        <div>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
            用户状态&nbsp;<select name="isLive" id="isLive">
            <option value="">请选择</option>
            <option value="0" <c:if test="${query.isLive == 0}">selected="selected" </c:if>>禁用</option>
            <option value="1" <c:if test="${query.isLive == 1}">selected="selected" </c:if>>启用</option>
        </select>&nbsp;&nbsp;
            <input type="submit" value="查询">
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="7%">用户名</th>
                <th width="7%">真实姓名</th>
                <th width="5%">用户状态</th>
                <th>单位</th>
                <th width="10%">手机号</th>
                <th width="10%">固话</th>
                <th width="15%">邮箱</th>
                <th  width="15%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${userInfoList}" var="user" varStatus="status">
                <tr>
                    <%--<td align="center"><input type="checkbox" id="userId" name="userId" value="${user.userId}"/></td>--%>
                    <td align="center">${user.username}</td>
                    <td align=center>${user.nickname}</td>
                    <td align=center>
                        <c:if test="${user.isLive == 1}">启用</c:if>
                        <c:if test="${user.isLive == 0}">禁用</c:if>
                    </td>
                    <td align=center>${user.company}</td>
                    <td align=center>${user.mobile}</td>
                    <td align=center>${user.phone}</td>
                    <td align=center>${user.email}</td>
                    <td align=center>
                        <a href="javascript:edit('${user.userId}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${user.userId}');">删除</a>&nbsp;&nbsp;
                        <a href="${basePath}mg/user/user-detail.htm?userId=${user.userId}">详情</a>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/user/user-list.htm?keyword=${fmtString:encoder(query.keyword)}&isLive=${query.isLive}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>