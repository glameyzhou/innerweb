<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%String projectBasePath = request.getContextPath() + "/";%>
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
    <link rel="stylesheet" href="<%=projectBasePath%>kindeditor/themes/default/default.css"/>
    <link rel="stylesheet" href="<%=projectBasePath%>kindeditor/plugins/code/prettify.css"/>
    <script charset="utf-8" src="<%=projectBasePath%>kindeditor/kindeditor.js"></script>
    <script charset="utf-8" src="<%=projectBasePath%>kindeditor/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%=projectBasePath%>kindeditor/plugins/code/prettify.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Links-Index</title>
</head>
<frameset cols="240,*" frameborder="0" border="0" framespacing="0" id="fullFrame">
    <frame src="role.jsp" name="leftFrame" noresize="noresize" id="leftFrame"/>
    <frame src="register.jsp" name="mainFrame" id="mainFrame"/>
</frameset>
<noframes>
    <body></body>
</noframes>
</html>
