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
        <c:set var="basePath"
               value="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/"/>
    </c:when>
    <c:otherwise>
        <c:set var="basePath"
               value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/"/>
    </c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${basePath}res/front/library/css/register.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css"/>
    <title>华电迷你图书馆-您身边的能源情报站-游客注册结果</title>
</head>
<body background="${basePath}res/front/library/images/register_bg.jpg" style="background-repeat:repeat-x;">
<div class="register_logo">
    <a href="${basePath}login.htm"><img src="${basePath}res/front/library/images/register_logo.png" border="0"/></a>
</div>
<div class="register_con">
    <p>微型图书馆 >> 注册结果</p>
    <div style="width:375px; margin:0px auto; margin-top:80px;">
        <div class="register_con_1" style="margin-top:0px;margin-right: 30px;">
            <ul>
                <li style="width:300px; height:100px; border:1px solid #7f9cba; font-weight:bold; margin-right:30px;text-align: center;color: #38B1B9;">
                    <c:out value="${message}" escapeXml="false"/>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>