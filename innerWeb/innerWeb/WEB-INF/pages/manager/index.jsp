<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/tagInclude.jsp"%>
<link rel="Shortcut Icon" href="<%=request.getContextPath()%>/res/ico/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>内网管理系统</title>
</head>
<frameset rows="95,*" border="0" framespacing="0">
	<frame src="${basePath}manager/frame/top.htm" name="topFrame" noresize="noresize" id="leftFrame" />
	<frame src="${basePath}manager/frame/index.htm" name="mainFrame" id="rightFrame" />
</frameset>
<noframes><body></body></noframes>
</html>
