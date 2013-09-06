<%@ page import="com.glamey.library.model.domain.UserInfo" %>
<%@ page import="com.glamey.library.constants.Constants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%String projectBasePath =request.getContextPath() + "/" ;%>
<link href="<%=projectBasePath%>res/jeecms/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="<%=projectBasePath%>res/common/css/theme.css" rel="stylesheet" type="text/css"/>
<link href="<%=projectBasePath%>res/common/css/jquery.validate.css" rel="stylesheet" type="text/css"/>
<link href="<%=projectBasePath%>res/common/css/jquery.treeview.css" rel="stylesheet" type="text/css"/>
<link href="<%=projectBasePath%>res/common/css/jquery.ui.css" rel="stylesheet" type="text/css"/>
<script src="<%=projectBasePath%>res/common/js/jquery.js" type="text/javascript"></script>
<script src="<%=projectBasePath%>res/common/js/jquery.ext.js" type="text/javascript"></script>
<script src="<%=projectBasePath%>res/common/js/glamey.js" type="text/javascript"></script>
<script src="<%=projectBasePath%>res/jeecms/js/admin.js" type="text/javascript"></script>
<script src="<%=projectBasePath%>res/jeecms/js/console.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=projectBasePath%>kindeditor/themes/default/default.css" />
<link rel="stylesheet" href="<%=projectBasePath%>kindeditor/plugins/code/prettify.css" />
<script charset="utf-8" src="<%=projectBasePath%>kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="<%=projectBasePath%>kindeditor/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=projectBasePath%>kindeditor/plugins/code/prettify.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>头部信息--导航条</title>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=projectBasePath%>res/jeecms/img/admin/top_bg.jpg">
    <tr>
        <td width="223px"><img src="<%=projectBasePath%>res/jeecms/img/admin/logo.png"></td>
        <td align="left">&nbsp;&nbsp;
            <img src="<%=projectBasePath%>res/jeecms/img/admin/welconlogin-icon.png"><span style="color: #FFF;padding: 0 10px 0 5px ;"></span>
            <img src="<%=projectBasePath%>res/jeecms/img/admin/loginout-icon.png" />
            <a style="color: #FFF;padding: 0 10px 0 5px ;" href="${projectBasePath}index.htm" id="logout" target="_blank">回首页11</a>
        </td>
    </tr>
</table>
</body>
</html>