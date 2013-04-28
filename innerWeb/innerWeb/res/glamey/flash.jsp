<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.com.checne.util.StringTools" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<object id="bcastr4"
		data="bcastr4.swf?xml=<%=StringTools.encoder("bcastr.xml")%>"
		type="application/x-shockwave-flash" width="500" height="150">
		<param name="movie"
			value="bcastr4.swf?xml=<%=StringTools.encoder("bcastr.xml")%>" />
	</object>

</body>
</html>