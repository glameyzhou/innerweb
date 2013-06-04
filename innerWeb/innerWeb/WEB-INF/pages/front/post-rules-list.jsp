<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${basePath}res/front/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/footer.css" rel="stylesheet" type="text/css"/>
    <title>内网管理系统 - 规章制度</title>
</head>
<body>
<div class="box">
    <%@include file="include/header.jsp" %>
    <div class="body">
        <div class="body_left">
            <%@include file="include/links-out.jsp" %>
            <%@include file="include/links-in.jsp" %>
            <%@include file="include/popular_Links.jsp" %>
            <%@include file="include/searcher.jsp" %>
        </div>
        <div class="right_neiye">
            <div class="body_right_tit" style="width:962px;">
                <ul class="tit_biao">
                    <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                    <li style="padding-left:15px;">
                        <c:if test="${not empty category}">${category.name}</c:if>
                    </li>
                </ul>
            </div>
            <div class="neiye_right_con" style="width:932px;">
                <c:forEach var="post" items="${postList}" varStatus="status">
                    <ul class="con_neiye">
                        <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
                        <li>[${post.deptCategory.name}]${post.title}</li>
                        <li style="float:right;"><a href="${basePath}rules-download-${post.id}.htm">下载</a>&nbsp;&nbsp;${fmtString:substring(post.time,10)}</li>
                    </ul>
                </c:forEach>
                <c:set var="pageURL" value="${basePath}rules-news-${category.id}.htm?"/>
                <%@include file="../common/pages-front.jsp" %>
            </div>
        </div>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>