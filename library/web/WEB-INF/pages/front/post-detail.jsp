<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电图书馆-您身边的能源行业情报秘书</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="box">
    <!--头部代码开始-->
    <%@include file="include/header.jsp"%>
    <!--头部代码结束-->
    <div class="center">
        <!--左半边代码开始-->
        <div class="center_left">
            <%@include file="include/post-newest.jsp"%>
            <%@include file="include/library-category.jsp"%>
            <%@include file="include/contact.jsp" %>
        </div>
        <!--左半边代码结束-->

        <!--右半边代码开始-->
        <div class="center_right">
            <div class="neirong">
                <div class="neirong_tit">资讯公告</div>
                <div class="seat" style="font-weight: bold">${post.title}</div>
                <div class="neirong_con">
                    <p style="text-align: center;">来源：${post.source} &nbsp;&nbsp;时间：${fmtString:substring(post.time,10)}</p>
                    ${post.content}
                </div>
            </div>
        </div>
        <!--右半边代码结束-->
    </div>

    <!--底部代码开始-->
    <%@include file="include/footer.jsp"%>
    <!--底部代码结束-->
</div>
</body>
</html>