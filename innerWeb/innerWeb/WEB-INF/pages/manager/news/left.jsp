<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>左侧菜单栏目--系统设置</title>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
	<script type="text/javascript">
	$(function(){
		Cms.lmenu('lmenu');
	});
	</script>
</head>
<body class="lbody">
	<ul id="lmenu">
		<li><a href="${basePath}super/news/category-show.do" target="rightFrame">栏目添加</a></li>
		<li><a href="${basePath}super/news/category-list.do" target="rightFrame">栏目管理</a></li>
		<li><a href="${basePath}super/news/news-show.do" target="rightFrame">新闻添加</a></li>
		<li><a href="${basePath}super/news/news-list.do" target="rightFrame">新闻管理</a></li>
	</ul>
</body>
</html>