<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/tagInclude.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新闻默认首页</title>
</head>
<frameset cols="240,*" frameborder="0" border="0" framespacing="0" id="fullFrame">
	<frame src="${basePath}mg/${category}/left.htm" name="leftFrame" noresize="noresize" id="leftFrame" />
	<frame src="${basePath}mg/${category}/category-list.htm" name="rightFrame" id="rightFrame" />
</frameset>
<noframes><body></body></noframes>
</html>
