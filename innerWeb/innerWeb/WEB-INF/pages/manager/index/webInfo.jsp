<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>web应用属性</title>
</head>
<%
java.util.Properties pro = System.getProperties();
%>
<body>
<div class="body-box">
<div class="rhead">
	<div class="rpos">当前位置: 首页  - 系统属性</div>
	<div class="clear"></div>
</div>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="border:#c8c8e7 1px solid; border-top:0; margin-top:5px;">
  <tr>
    <td height="26" colspan="2" align="left" background="${basePath}res/jeecms/img/admin/msg_bg.jpg">
	&nbsp;&nbsp;<img src="${basePath}res/jeecms/img/admin/ico1.gif" border="0" align="absmiddle"/><strong>系统属性</strong> </td>
  </tr>
  <tr style="background-color:#F7F8FA">
    <td height="25" align="right" style="border-bottom:#cccccc 1px dashed;">User country&nbsp;&nbsp;</td>
    <td align="left" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("user.country")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">OS Name&nbsp;&nbsp;</td>
    <td align="left" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("user.country")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">OS Version&nbsp;&nbsp;</td>
    <td align="left" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("os.version")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">OS Patch&nbsp;&nbsp;</td>
    <td align="left" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("sun.os.patch.level")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">OS.Architecture:</td>
    <td align="left" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("os.arch")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">JVM Vendor&nbsp;&nbsp;</td>
    <td align="left" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("java.vm.vendor")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">OS.Architecture:</td>
    <td align="left" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("os.arch")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">JVM Version&nbsp;&nbsp;</td>
    <td align="left" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("java.version")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">File Encoding&nbsp;&nbsp;</td>
    <td align="left" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=pro.getProperty("file.encoding")%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">Web Server&nbsp;&nbsp;</td>
    <td align="left" bgcolor="#FFFFFF" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;<%=application.getServerInfo()%></td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">Server Memory&nbsp;&nbsp;</td>
    <td align="left" bgcolor="#F7F8FA" style="border-bottom:#cccccc 1px dashed;">&nbsp;&nbsp;
				Max Memory:<%=Runtime.getRuntime().maxMemory()/(1024*1024)%>M&nbsp;&nbsp;
				Total Memory:<%=Runtime.getRuntime().totalMemory()/(1024*1024)%>M&nbsp;&nbsp;
				free Memory:<%=Runtime.getRuntime().freeMemory()/(1024*1024)%>M&nbsp;&nbsp;    </td>
  </tr>
</table>

</div>
</body>
</html>