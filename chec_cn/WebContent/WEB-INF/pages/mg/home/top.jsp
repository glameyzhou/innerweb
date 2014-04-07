<%@ page import="com.glamey.library.model.domain.UserInfo" %>
<%@ page import="com.glamey.library.constants.Constants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>头部信息--导航条</title>
</head>
<%
    UserInfo userInfo = new UserInfo();
    Object obj = session.getAttribute(Constants.SESSIN_USERID);
    if (obj != null) {
        userInfo = (UserInfo) obj;
    }
    /*/home/chdiofficevcchldoidoufsfficcfe/logs/*/

%>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="${basePath}res/jeecms/img/admin/top_bg.jpg">
    <tr>
        <td width="223px"><img src="${basePath}res/jeecms/img/admin/logo.png"></td>
        <td align="left">&nbsp;&nbsp;
            <img src="${basePath}res/jeecms/img/admin/welconlogin-icon.png"><span
                    style="color: #FFF;padding: 0 10px 0 5px ;">用户名：<%=userInfo.getNickname()%> </span>
            <img src="${basePath}res/jeecms/img/admin/loginout-icon.png">
            <a style="color: #FFF;padding: 0 10px 0 5px ;" href="${basePath}mg/logout.htm" target="_top">注销</a>&nbsp;&nbsp;
            <a style="color: #FFF;padding: 0 10px 0 5px ;" href="${basePath}index.htm" id="logout"
               target="_blank">回首页</a>&nbsp;</span>
        </td>
    </tr>
</table>
</body>
</html>