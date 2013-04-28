<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>左侧菜单栏目</title>
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
		<li><a href="${basePath}manager/index/webInfo.htm" target="rightFrame">欢迎界面</a></li>
		<li><a href="${basePath}manager/index/webInfo.htm" target="rightFrame">欢迎界面</a></li>
	</ul>
</body>
</html>