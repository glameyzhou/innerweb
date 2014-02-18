<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function setBrandManager(categoryId) {
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 论坛 - 版主列表&nbsp;&nbsp;(版主具有设置精华帖、置顶、删帖权限，请谨慎设置！)</div>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/bbs/post-list.htm" method="get" style="padding-top:5px;" enctype="multipart/form-data">
        <div></div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="35%">板块</th>
                <th width="35%">版主</th>
                <th width="30%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
                <c:forEach var="result" items="${result}">
                    <c:set var="category" value="${result.key}"/>
                    <c:set var="userinfo" value="${result.value}"/>
                    <tr align="center">
                        <td><a href="${basePath}bbs/brand-${category.id}.htm" target="_blank">${category.name}</a></td>
                        <td>${userinfo.nickname}</td>
                        <td><a href="${basePath}mg/user/user-list.htm?brandId=${category.id}">设置版主</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>