<%--
  Created by IntelliJ IDEA.
  User: zy
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmtString" uri="/string-tag" %>
<c:set var="basePathPort" value="${pageContext.request.serverPort}"/>
<c:choose>
    <c:when test="${basePathPort eq '80' }">
        <c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/"/>
    </c:when>
    <c:otherwise>
        <c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/"/>
    </c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${basePath}res/front/library/css/register.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${basePath}res/ztree/js/jquery-1.4.4.min.js"></script>
    <title>华电图书馆-您身边的能源行业情报秘书-游客注册</title>
    <script type="text/javascript">
        function stringTrim(str) {
            return str.replace(/^\s*/g, "").replace(/\s*$/g, "");
        }
        function pageOnBlur(itemName){
            var obj = document.getElementById(itemName);
            var value = stringTrim(obj.value);
            if(value == ''){
                document.getElementById(itemName + '_li').innerText = '必填项' ;
            }
            /*if(itemName == 'username'){
                $.ajax({
                    url: '',
                    type: '',
                    data: '',
                    cache: false,
                    success: function(data) {
                        if(data == 'O'){
                            $('#username').innerText = '' ;
                        }else{
                            $('#username').innerText = '' ;
                            $("#register_submit").attr("disabled", true);
                        }

                    }
                });
            }*/
        }
        function pageOnSubmit(){

        }
        function pageOnUp(itemName){
            var obj = document.getElementById(itemName);
            var value = stringTrim(obj.value);
            if(value != ''){
                document.getElementById(itemName + '_li').innerText = '' ;
            }

        }
    </script>
</head>
<body background="${basePath}res/front/library/images/register_bg.jpg" style="background-repeat:repeat-x;">
<form action="" method="post" onsubmit="pageOnSubmit();">
<div class="register_logo"><img src="${basePath}res/front/library/images/register_logo.png"/></div>
<div class="register_con">
    <p>立刻注册微型图书馆帐号</p>
    <div style="width:375px; margin:0px auto; margin-top:80px;">
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;用户名：</li>
                <li><input name="username" id="username" type="text" class="register_text" onblur="pageOnBlur('username');" onkeyup="pageOnUp('username')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="username_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li class="liLeft">真实姓名：</li>
                <li><input name="nickname" id="nickname" type="text" class="register_text" onblur="pageOnBlur('nickname');" onkeyup="pageOnUp('nickname')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="nickname_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;密码：</li>
                <li><input name="passwd" id="passwd" type="password" class="register_text" onblur="pageOnBlur('passwd');" onkeyup="pageOnUp('passwd')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="passwd_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>确认密码：</li>
                <li><input name="passwdRp" id="passwdRp" type="password" class="register_text" onblur="pageOnBlur('passwdRp');" onkeyup="pageOnUp('passwdRp')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="passwdRp_li"/>
            </ul>
        </div>

        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;单位：</li>
                <li><input name="company" id="company" type="text" class="register_text" onblur="pageOnBlur('company');" onkeyup="pageOnUp('company')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="company_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;部门：</li>
                <li><input name="dept" id="dept" type="text" class="register_text" onblur="pageOnBlur('dept');" onkeyup="pageOnUp('dept')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="dept_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;手机号：</li>
                <li><input name="mobile" id="mobile" type="text" class="register_text" onblur="pageOnBlur('mobile');" onkeyup="pageOnUp('mobile')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="mobile_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;固话：</li>
                <li><input name="phone" id="phone" type="text" class="register_text" onblur="pageOnBlur('phone');" onkeyup="pageOnUp('phone')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="phone_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;邮箱：</li>
                <li><input name="email" id="email" type="text" class="register_text" onblur="pageOnBlur('email');" onkeyup="pageOnUp('email')"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="email_li"/>
            </ul>
        </div>
        <div class="register_con_1" style="margin-left:120px;_margin-left:120px; margin-top:30px;">
            <ul>
                <li><input name="register_submit" id="register_submit" type="submit" value="提交" class="register_botton"/></li>
                <li><input name="register_reset" type="reset" value="清空" class="register_botton"/></li>
            </ul>
        </div>
    </div>
</div>
</form>
</body>
</html>