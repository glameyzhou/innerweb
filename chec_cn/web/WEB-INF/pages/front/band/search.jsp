<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/left-lanmu.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x" >
<div class="box">
    <%@include file="../include/header.jsp"%>
    <div class="content">
        <div class="neiye-left">
            <div class="left-tit">搜索</div>
            <div class="left-con lanmu">
                <%--<ul>
                        <li class="lanmu-hover">
                        </li>
                </ul>--%>
            </div>
            <%@include file="../include/frame-images.jsp"%>
        </div>
        <div class="neiye-right">
            <div class="weizhi">您所在的位置：<a href="${basePath}">首页</a>&nbsp;>&nbsp;关键字搜索</div>
            <div class="right-con">
                <p style="margin-left: 15px;font: 14px;">搜索的关键字是：${kw}</p>
                <ul style="padding:0px 30px 8px 30px">
                    <c:forEach var="entry" items="${entries}">
                        <li style="height: 30px;">
                            <span style="float:right; color:#919191">[${fmtString:substring(entry.time, 10)}]</span>
                            <img src="${basePath}res/front/chec_cn/images/liebiao-biao.png" align="middle" />
                            <a href="${entry.href}">${entry.title}</a>
                        </li>
                    </c:forEach>
                </ul>
                <c:set var="pageURL" value="${basePath}search.htm?kw=${fmtString:encoder(kw)}&"/>
                <%@include file="../../common/pages.jsp"%>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
