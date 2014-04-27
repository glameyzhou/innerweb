<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/consoleLogin/css/css.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        <!--
        body {
            background-image: url(${basePath}res/consoleLogin/images/bg11.jpg);
            background-repeat: repeat-x;
        }
        -->
    </style>
    <script type="text/javascript">
        function changeCode() {
            var currentTime = Math.round(Math.random() * 10000);
            document.getElementById('verifyCodeImg').src = '${basePath}verifyCode.htm?currentTime=' + currentTime;
        }
    </script>
</head>
<body>
<form name="loginForm" method="post" action="${basePath}manager.htm" id="loginForm">
    <table width="562" height="92" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="562"><a href="#" onClick="window.close()"></a></td>
        </tr>
    </table>
    <table width="562" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <table width="562" height="390" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="99%" valign="top" background="${basePath}res/consoleLogin/images/login.jpg">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="50" align="right"><a href="#" onClick="window.close()"></a></td>
                        <td width="28">&nbsp;</td>
                    </tr>
                </table>
                <table width="100" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="50">&nbsp;</td>
                    </tr>
                </table>
                <table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="20%" height="30" align="right"><span id="spantbLoginName">帐　号：</span></td>
                        <td width="80%">
                            <input name="username" type="text" size="35" id="username" class="input_login" check_str="帐号"/>
                        </td>
                    </tr>
                    <tr>
                        <td height="30" align="right"><span id="spantbPassword">密　码：</span></td>
                        <td>
                            <input name="password" type="password" size="35" id="password" class="input_login" check_str="密码"/>
                        </td>
                    </tr>
                    <tr>
                        <td height="30" align="right">验证码：</td>
                        <td><input name="verifyCode" type="text" size="30" id="verifyCode" class="input_login2" />
                            &nbsp;<img src="${basePath}verifyCode.htm" id="codeImg" align="absmiddle" style="cursor:pointer" onclick="this.src='${basePath}verifyCode.htm?time='+new Date().getTime()" ></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="color: red;text-align: center;">
                            <c:if test="${not empty message}">${message}</c:if>
                        </td>
                    </tr>
                    <tr>
                        <td height="45">&nbsp;</td>
                        <td align="left" valign="bottom">　　　
                            <input type="image" name="ibLoginBu" id="ibLoginBu" src="${basePath}res/consoleLogin/images/login.gif" border="0" onclick="return checkValidateCode();" language="javascript" style="height:23px;width:71px;" />　　
                            <img src="${basePath}res/consoleLogin/images/cansel.gif" width="71" height="23" style="cursor:pointer" onClick="Form1.reset();"></td>
                    </tr>
                </table></td>
        </tr>
    </table>
</form>

<%--<form action="${basePath}manager.htm" method="post" id="loginForm" name="loginForm">
    <div class="login"><img src="${basePath}res/front/library/images/login.png"  width="882"/>
        <div class="login_con">
            <div class="landing_con">
                <ul>
                    <li>用户名：</li>
                    <li><input name="username" id="username" type="text"  class="login_text"/></li>
                </ul>
            </div>
            <div class="landing_con">
                <ul>
                    <li>密&nbsp;&nbsp;码：</li>
                    <li><input name="password" id="password" type="password"  class="login_text"/></li>
                </ul>
            </div>
            <div class="landing_con">
                <ul>
                    <li>验证码：</li>
                    <li><input name="verifyCode" id="verifyCode" type="text" class="login_text" style="width:60px;"/></li>
                    <li style="padding-left:5px;">
                        <img src="${basePath}verifyCode.htm" width="69" height="20" align="absmiddle"
                             onclick="this.src='${basePath}verifyCode.htm?time='+new Date().getTime()" title="点击刷新验证码"/>
                    </li>
                </ul>
            </div>
            <div class="landing_con">
                <ul>
                    <li><input type="checkbox" id="remeberUser" name="remeberUser" value="1" /></li>
                    <li>记住密码</li>
                    <c:if test="${not empty message}">
                        <li><font style="font-weight: normal;color: red;">&nbsp;&nbsp;${message}</font></li>
                    </c:if>
                </ul>
            </div>
            <p style="float:left; margin-top:10px;">
                <input name="" type="button" class="login_botton1" onclick="javascript:loginSubmit();"/>
                <input name="" type="button" class="login_botton2" onclick="javascrip:loginRegistry();"/>
                <input name="" type="button" class="login_botton3" onclick="javascript:loginBrower();"/>
            </p>
        </div>
    </div>
</form>--%>
<script type="text/javascript">
    window.onload = function () {
        document.body.onkeydown = function (event) {
            if (event.keyCode == 13) {
                loginSubmit();
            }
        }
    }
    function loginSubmit() {
        document.getElementById("loginForm").submit();
    }
</script>
</body>
</html>
