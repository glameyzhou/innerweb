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
    <title>用户注册</title>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 用户注册</div>
        <div class="clear"></div>
    </div>
    <form method="post" action="<%=projectBasePath%>user-register.htm" id="jvForm">
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <%--用户注册。用户名（必选）、真实姓名（必选）、密码（6位及以上）、密码提示问题（可自选提示问题）、单位（必选）、部门（必选）、职务、单位地址、联系电话（座机、手机）（必选）、电邮（必选）、--%>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户名:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="username" id="username" class="required" size="80"/>&nbsp;<font color="red">唯一标识</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>真实姓名:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="nickname" id="nickname" class="required" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="password" maxlength="100" name="password" id="password" class="required" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码确认:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="password" maxlength="100" name="rePassword" id="rePassword" class="required" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">密码提示问题:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="question" id="question" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">密码问题回答:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="answer" id="answer" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>单位:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="company" id="company" class="required" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>部门:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="dept" id="dept" class="required" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">职务:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="duty" id="duty" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">单位地址:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="address" id="address" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>联系方式(座机):</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="phone" id="phone" class="required" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>联系方式(手机):</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="mobile" id="mobile" class="required" size="80"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>联系方式(电邮):</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="email" id="email" class="email" size="80"/>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="pn-fbutton">
                    <input type="submit" value="提交"> &nbsp; <input type="reset" value="重置">
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>