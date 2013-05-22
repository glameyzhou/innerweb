<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="${basePath}"/>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="res/front/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="res/front/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="res/front/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="res/front/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="res/front/css/footer.css" rel="stylesheet" type="text/css"/>
    <title>内网管理系统 - 检索${kw}</title>
</head>
<body>
<div class="box">
    <%@include file="include/header.jsp" %>
    <!--中间内容部分代码开始-->
    <div class="body">
        <!--左半边代码开始-->
        <div class="body_left">
            <%@include file="include/links-out.jsp" %>
            <%@include file="include/links-in.jsp" %>
            <%--常用链接--%>
            <%@include file="include/popular_Links.jsp" %>
            <%--搜索框--%>
            <%@include file="include/searcher.jsp" %>
        </div>
        <!--左半边代码结束-->
        <%--右半边代码开始--%>
        <div class="right_neiye">
            <div class="body_right_tit" style="width:962px;">
                <ul class="tit_biao">
                    <li><img src="res/front/images/right_tit_biao.png"/></li>
                    <li style="padding-left:15px;">检索关键字[${kw}]
                    </li>
                </ul>
                <%--<ul class="tit_biao_right">
                    <li><img src="res/front/images/right_tit_biao2.png" /></li>
                    <li><a href="#">更&nbsp;多</a></li>
                </ul>--%>
            </div>
            <div class="neiye_right_con" style="width:932px;">
                <c:forEach var="entry" items="${entries}" varStatus="status">
                    <ul class="con_neiye">
                        <li><img src="res/front/images/right_tit_biao3.png"/></li>
                        <li><a href="${entry.href}"></a>${entry.title}</li>
                        <li style="float:right;">${entry.modelName}&nbsp;&nbsp;&nbsp;${fmtString:substring(entry.time,10)}</li>
                    </ul>
                </c:forEach>
                <c:set var="pageURL" value="search.htm?kw=${fmtString:encoder(kw)}&"/>
                <%@include file="../common/pages-front.jsp" %>
            </div>
        </div>
        <%--右半边代码结束--%>
        <%--友情链接--%>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <!--中间内容部分代码结束-->
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>