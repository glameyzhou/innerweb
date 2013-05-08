<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>左侧菜单</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            Cms.lmenu('lmenu');
        });
    </script>
</head>
<body class="lbody">
    <ul id="lmenu">
        <li><a href="${basePath}mg/links/allroot.htm" target="rightFrame">链接根目录</a></li>
        <c:forEach items="${categoryList}" var="cate" varStatus="status">
        	<li><a href="${basePath}mg/links/${cate.categoryType}/${cate.id}/links-list.htm" target="rightFrame">${cate.name}-链接管理</a></li>
        </c:forEach>
    </ul>
</body>
</html>