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
    <title>内网管理系统 - 微型图书馆</title>
</head>
<body>
<div class="box">
    <%@include file="include/header.jsp" %>
    <div class="body">
        <%--&lt;%&ndash;面包屑&ndash;%&gt;
        <div class="seat">
            <a href="#">首页</a>&nbsp;>&nbsp;<a href="#">${post.category.name}</a>&nbsp;>&nbsp;<span>${post.title}</span>
        </div>--%>
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
                    <%--<li style="padding-left:15px;">
                    	<a href="${basePath}library-0-0-1.htm">微型图书馆</a> - 
                    	<a href="${basePath}library-0-${info.category.id}-1.htm">${info.category.name}</a> - 
                    	<a href="#">${info.name}</a>
                    </li>--%>
                    <li style="padding-left:15px;">微型图书馆 - ${info.category.name} - ${info.name}</li>
                </ul>
                <%--<ul class="tit_biao_right">
                    <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
                    <li><a href="#">更&nbsp;多</a></li>
                </ul>--%>
            </div>
            <div class="neiye_right_con" style="width:932px;">
                <div class="neirong_con" style="width:930px;">
                    <h2>${info.name}</h2>
                    <br/>
                    <br/>

                    <div class="neirong_con">
                        ${info.content}
                    </div>
                </div>
            </div>
        </div>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>