<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>内网系统-登陆界面</title>
    <style>
        ul, li {
            margin: 0px;
            padding: 0px;
            list-style: none;
        }

        body {
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            background: #99ccff;
        }

        .login {
            width: 766px;
            margin: 0 auto;
            margin-top: 30px;
            padding-top: 235px;
            height: 327px;
            background: url(${basePath}res/consoleLogin/images/login_bg_en.jpg) no-repeat;
        }

        .login_l {
            float: left;
            height: 40px;
            width: 120px;
            padding-left: 175px;
        }

        .login_r {
            width: 400px;
            padding-left: 50px;
            float: left;
        }

        .login_r li {
            padding: 5px 0;
            color: #666666;
        }

        .login_r .input00 {
            width: 135px;
            height: 20px;
            border: 0;
            background: #fff;
        }

        .login_r .input01 {
            width: 135px;
            height: 16px;
            border: 0;
            background: #fff;
        }

        .login_r .input02 {
            width: 60px;
            height: 16px;
            border: 0;
            background: #fff;
        }

        .btn {
            padding-top: 15px;
        }

        .btn01, .btn02 {
            width: 74px;
            height: 25px;
            border: none;
        }

        .btn01 {
            background: url(${basePath}res/consoleLogin/images/btn_01.jpg) no-repeat;
        }

        .btn02 {
            background: url(${basePath}res/consoleLogin/images/btn_02.jpg) no-repeat;
        }

        .login_r li span {
            color: FF0000;
            /*FF0000  #F00*/
        }
    </style>
    <script type="text/javascript">
        function changeCode() {
            var currentTime = Math.round(Math.random() * 10000);
            document.getElementById('verifyCodeImg').src = '${basePath}verifyCode.htm?currentTime=' + currentTime;
        }
    </script>
</head>
<body>
<form action="${basePath}manager.htm" method="post">
    <div class="login">
        <div class="login_l"><img src="${basePath}res/consoleLogin/images/tit_02.jpg" width="118" height="40"/></div>
        <div class="login_r">
            <ul>
                <li>用户&nbsp;<input type="text" name="username" id="username" class="input01"/></li>
                <li>密码&nbsp;<input type="password" name="password" id="password" class="input01"/></li>
                <li>验证码&nbsp;<input type="text" name="verifyCode" id="verifyCode" class="input02"/>
                    <img src="${basePath}verifyCode.htm" width="69" height="20" align="absmiddle"
                         onclick="this.src='${basePath}verifyCode.htm?time='+new Date().getTime()" title="点击刷新验证码"/>
                </li>
                <li><input type="checkbox" id="remeberUser" name="remeberUser" value="1"/>&nbsp;保存登录Cookies</li>
                <c:if test="${not empty message}">
                    <li><font color='red'>${message}</font></li>
                </c:if>
            </ul>
            <div class="btn">
                <input type="submit" name="button" id="button" value="" class="btn01"/>
                <input type="reset" name="button" id="button" value="" class="btn02"/>
            </div>
        </div>
    </div>
</form>
</body>
</html>