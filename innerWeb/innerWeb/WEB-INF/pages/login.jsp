<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include  file="common/tagInclude.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>内网系统-登陆界面</title>
<script type="text/javascript">
	function changeCode() {
		var currentTime = Math.round(Math.random() * 10000);
		document.getElementById('verifyCodeImg').src = '${basePath}verifyCode.htm?currentTime=' + currentTime;
	}
</script>
</head>
<body>
	<c:if test="${not empty message}">
			<li><font color='red'>${message}</font></li>
    </c:if>
	<form action="${basePath}manager.htm" method="post">
		用户&nbsp;<input type="text" name="username" id="username" /><br/>
		密码&nbsp;<input type="password" name="password" id="password" /><br/>
		验证码&nbsp;<input type="text" name="verifyCode" id="verifyCode" />
		<img src="${basePath}verifyCode.htm" width="69" height="20" onclick="this.src='${basePath}verifyCode.htm?time='+new Date().getTime()"
             title="点击刷新验证码" /><br/>
		<input type="submit" value="登陆"/> &nbsp;&nbsp;<input type="reset" value="重置"/>
	</form>
</body>
</html>