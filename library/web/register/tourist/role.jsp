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
    <title>左侧菜单栏目</title>
    <script type="text/javascript">
        $(function () {
            Cms.lmenu('lmenu');
        });
        function divDisplay(divName) {
            var d = document.getElementById(divName);
            if (d.style.display == 'block') {
                d.style.display = 'none';
            }
            else {
                d.style.display = 'block';
            }
        }
    </script>
</head>
<body class="lbody">
<p style="font: bold;color: #ff0000;">&nbsp;角色选择&nbsp;游客</p>
<ul id="lmenu">

    <li>暂无权限</li>
</ul>
</body>
</html>