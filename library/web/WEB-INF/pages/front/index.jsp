<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css"/>
    <title>华电图书馆-您身边的能源行业情报秘书</title>
</head>
<body>
<div class="box">
    <%--头部--%>
    <%@include file="include/header.jsp" %>
    <div class="center">
        <!--左半边代码开始-->
        <div class="center_left">
            <%--最新资讯公告--%>
            <%@include file="include/post-newest.jsp" %>
            <%@include file="include/library-category.jsp" %>
            <%@include file="include/contact.jsp" %>
        </div>
        <!--左半边代码结束-->
        <!--右半边代码开始-->
        <div class="center_right">
            <div class="focus">
                <div class="focus_title">
                    <ul>
                        <li><img src="${basePath}res/front/library/images/focus_title1.jpg"/></li>
                        <li>图书馆简介&nbsp;ABOUTS</li>
                        <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; margin-top:5px; padding-left:15px;">
                            <a href="${basePath}library-aboutus.htm">更多</a>
                        </li>
                    </ul>
                </div>
                <div class="focus_content">
                    <div class="focus_pic"><img src="${basePath}res/front/library/images/focus_pic1.jpg"/></div>
                    <div class="focus_news">${libraryHeadContent}</div>
                </div>
            </div>
            <%--<%@include file="include/library-index.jsp" %>--%>
            <%--图书馆首页内容显示--%>
            <div class="zixun">
                <c:forEach var="dto" items="${libraryInfoDTOList}" varStatus="libStatus">
                    <%--整体方框div的布局设置开始--%>
                    <%--第二个div方框--%>
                    <c:if test="${libStatus.index == 1}">
                        <c:set var="libListStyle" value=" style=\"margin-left:10px; _margin-left:10px;\""/>
                    </c:if>
                    <%--从第三个方框开始,并且是偶数的，主要是左侧方框--%>
                    <c:if test="${libStatus.index > 1 && libStatus.index %2 == 0}">
                        <c:set var="libListStyle" value=" style=\"margin-top:10px;\""/>
                    </c:if>
                    <%--从第四个方框开始,并且是奇数的，主要是右侧方框--%>
                    <c:if test="${libStatus.index > 1 && libStatus.index %2 != 0}">
                        <c:set var="libListStyle" value=" style=\"margin-top:10px; margin-left:10px; _margin-left:10px;\""/>
                    </c:if>
                    <%--整体方框div的布局设置结束--%>
                    <c:if test="${libStatus.index % 2 == 0}">
                        <c:set var="libTitleStyle" value=" class=\"zixun_kuang_tit\""/>
                    </c:if>
                    <c:if test="${libStatus.index % 2 != 0}">
                        <c:set var="libTitleStyle" value=" class=\"zixun_kuang_tit2\""/>
                    </c:if>
                <div class="zixun_kuang" ${libListStyle}>
                    <div ${libTitleStyle}>
                        <ul>
                            <li>${dto.category.name}</li>
                            <li style="list-style-type:none;background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                                <a href="${basePath}library-list-${dto.category.id}.htm">更多</a>
                        </ul>
                    </div>
                    <div class="zixun_kuang_con">
                        <c:forEach var="cat_dto" items="${dto.libraryInfoDTOList}" varStatus="cate_status">
                        <p>
                            ${cat_dto.category.name}
                                <span style="float:right;"><a href="${basePath}library-list-${cat_dto.category.id}.htm">
                                    <img src="${basePath}res/front/library/images/zixun_more.jpg"/></a>
                                </span>
                        </p>
                        <ul>
                            <c:forEach var="lib" items="${cat_dto.libraryInfoList}" varStatus="statusIndex">
                                <li>
                                    <a href="${basePath}library-detail-${lib.id}.htm" title="${lib.name}">${fmtString:substringAppend(lib.name,18 ,'' )}</a>
                                </li>
                            </c:forEach>
                        </ul>
                        </c:forEach>
                    </div>
                </div>
                </c:forEach>
            </div>
            <%@include file="include/friendlyLinks.jsp" %>
        </div>
        <!--右半边代码结束-->
    </div>
    <!--底部代码开始-->
    <%@include file="include/footer.jsp" %>
    <!--底部代码结束-->
</div>
</body>
</html>
