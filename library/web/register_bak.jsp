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
    <%--<style type="text/css">
        liLeft{
            text-align: right;
        }
        liRight{
            text-align: left;
        }
    </style>--%>
    <title>华电图书馆-您身边的能源行业情报秘书-游客注册</title>
</head>
<body background="${basePath}res/front/library/images/register_bg.jpg" style="background-repeat:repeat-x;">
<form action="" method="post">
<div class="register_logo"><img src="${basePath}res/front/library/images/register_logo.png"/></div>
<div class="register_con">
    <p>立刻注册微型图书馆帐号</p>
    <div style="width:375px; margin:0px auto; margin-top:80px;">
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;用户名：</li>
                <li><input name="username" id="username" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li class="liLeft">真实姓名：</li>
                <li><input name="nickname" id="nickname" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>密码：</li>
                <li><input name="passwd" id="passwd" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>确认密码：</li>
                <li><input name="passwdRp" id="passwdRp" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>密码提示问题：</li>
                <li><input name="question" id="question" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;密码问题答案：</li>
                <li><input name="answer" id="answer" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;单位：</li>
                <li><input name="company" id="company" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;部门：</li>
                <li><input name="dept" id="dept" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;职务：</li>
                <li><input name="duty" id="duty" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;单位地址：</li>
                <li><input name="address" id="address" type="text" class="register_text"/></li>
            </ul>
        </div>

        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;手机号：</li>
                <li><input name="mobile" type="mobile" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;固话：</li>
                <li><input name="phone" type="phone" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;电话：</li>
                <li><input name="" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;单位：</li>
                <li><input name="" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;邮箱：</li>
                <li><input name="email" id="email" type="text" class="register_text"/></li>
            </ul>
        </div>
        <div class="register_con_1" style="margin-left:120px;_margin-left:120px; margin-top:30px;">
            <ul>
                <li><input name="" type="button" value="提交" class="register_botton"/></li>
                <li><input name="" type="button" value="清空" class="register_botton"/></li>
            </ul>
        </div>
    </div>
</div>
</form>
</body>
</html>