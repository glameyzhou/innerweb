<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/login.css" rel="stylesheet" type="text/css" />
    <title>华电迷你图书馆-您身边的能源情报站</title>
    <script type="text/javascript">
        function changeCode() {
            var currentTime = Math.round(Math.random() * 10000);
            document.getElementById('verifyCodeImg').src = '${basePath}verifyCode.htm?currentTime=' + currentTime;
        }
    </script>
</head>
<body background="${basePath}res/front/library/images/login_bg.jpg" style="background-repeat:repeat-x;">
<form action="${basePath}manager.htm" method="post" id="loginForm" name="loginForm">
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
</form>
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
    function loginRegistry(){
        window.location = '${basePath}register.jsp' ;
    }
    function loginBrower(){
        window.location = '${basePath}tourist.htm'
    }
</script>
</body>
</html>
