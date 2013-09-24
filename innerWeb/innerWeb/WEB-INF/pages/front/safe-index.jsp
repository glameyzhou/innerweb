<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${basePath}res/front/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/footer.css" rel="stylesheet" type="text/css"/>
    <title>内网管理系统 - ${rootCategory.name}</title>
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
        <div class="body_right">
            <c:forEach var="dto" items="${postDTOList}" varStatus="status">
                <c:choose>
                    <c:when test="${status.index % 2 == 0}"><c:set var="cssIndex" value="1"/></c:when>
                    <c:otherwise><c:set var="cssIndex" value="2"/></c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${status.count == 1 || status.count == 2}"><c:set var="csstit" value="body_right_tit"/></c:when>
                    <c:when test="${status.count == 3 || status.count == 4}"><c:set var="csstit" value="body_right_tit1"/></c:when>
                    <c:when test="${status.count == 5 || status.count == 6}"><c:set var="csstit" value="body_right_tit2"/></c:when>
                    <c:otherwise><c:set var="csstit" value="body_right_tit3"/></c:otherwise>
                </c:choose>
                <div class="body_right_${cssIndex}">
                    <div class="${csstit}">
                        <ul class="tit_biao">
                            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                            <li style="padding-left:15px;">${dto.category.name}</li>
                        </ul>
                        <ul class="tit_biao_right">
                            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
                            <li><a href="${basePath}pl-${dto.category.categoryType}-${dto.category.id}.htm">更&nbsp;多</a></li>
                        </ul>
                    </div>
                    <div class="body_right_con">
                        <c:forEach var="post" items="${dto.postList}" varStatus="postStatus">
                            <ul class="con_right">
                                <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
                                <li><a href="${basePath}p-${post.id}.htm" target="_blank"
                                       title="${post.title}">${fmtString:substringAppend(post.title,26,'...' )}</a></li>
                                <li style="float:right;">${fmtString:substring(post.time,10)}</li>
                            </ul>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
        <%--<%@include file="include/friendlyLinks.jsp" %>--%>
    </div>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>