<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../common/tagInclude.jsp"%>
    <link rel="Shortcut Icon" href="<%=request.getContextPath()%>/res/ico/favicon.ico" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>华电迷你图书馆-您身边的能源情报站</title>
</head>
<frameset rows="65,*" border="0" framespacing="0">
    <frame src="${basePath}mg/home/top.htm" name="topFrame" noresize="noresize" id="topFrame" />
    <frame src="${basePath}mg/home/content.htm?opt=${opt}" name="contentFrame" id="contentFrame" />
</frameset>
<noframes><body></body></noframes>
</html>
