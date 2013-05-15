<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>左侧菜单栏目</title>
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
    <li><a href="${basePath}mg/home/webInfo.htm" target="mainFrame">欢迎界面</a></li>
    <li><a href="${basePath}mg/home/webInfo.htm" target="mainFrame">个人信息管理</a></li>
    <li><a href="${basePath}mg/home/webInfo.htm" target="mainFrame">新闻分类管理</a></li>
    <c:forEach var="cate" items="${newsCategoryList}">
        <li><a href="${basePath}mg/post/${cate.aliasName}/list.htm" target="mainFrame">${cate.name}管理</a></li>
    </c:forEach>
</ul>
</body>
</html>