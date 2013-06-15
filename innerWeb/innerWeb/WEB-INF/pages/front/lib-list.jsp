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
        <div class="body_left">
            <%@include file="include/links-out.jsp" %>
            <%@include file="include/links-in.jsp" %>
            <%@include file="include/popular_Links.jsp" %>
            <%@include file="include/searcher.jsp" %>
        </div>
        <div class="body_right">
            <div class="right_neiye">
                <div class="body_right_tit" style="width:962px;">
                    <ul class="tit_biao">
                        <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                        <%--<li style="padding-left:15px;font-size: 4px;">
                            <a href="${basePath}library.htm">微型图书馆</a>
                            - <a href="${basePath}library_${pCategory.id}_0_-1.htm">${pCategory.name}</a>
                            - <a href="${basePath}library_${pCategory.id}_${category.id}_-1.htm">${category.name}</a>
                        </li>--%>
                        <li style="padding-left:15px;">微型图书馆 - ${pCategory.name} - ${category.name}</li>
                    </ul>
                </div>
                <c:choose>
                    <c:when test="${isImage}">
                        <div class="neiye_right_con" style="width:932px;">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr valign="top" style="height: 140px;">
                                    <c:forEach var="lib" items="${libraryInfos}" varStatus="status">
                                        <c:choose>
                                            <c:when test="${ empty lib.image}"><td width="25%" align="left"></td></c:when>
                                            <c:otherwise>
                                                <td width="25%" align="left" height="130px;">
                                                    <a href="${lib.url}"><img style="width: 130px;height: 130px; border: 0;" src="${lib.image}"/></a>
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${status.count % 4 == 0 }"></tr><tr></c:if>
                                    </c:forEach>
                                <tr>
                            </table>
                            <br/>
                            <c:set var="pageURL" value="${basePath}library_${pCategory.id}_${category.id}_-1.htm?"/>
                            <%@include file="../common/pages-front.jsp" %>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="neiye_right_con" style="width:932px;">
                            <c:forEach var="lib" items="${libraryInfos}" varStatus="status">
                                <ul class="con_neiye">
                                    <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
                                    <c:if test="${lib.type == 1}">
                                        <li><a href="${lib.url}" target="_blank" title="${lib.name}">${lib.name}</a></li>
                                    </c:if>
                                    <c:if test="${lib.type == 2}">
                                        <li><a href="${basePath}library-detail-${lib.id}.htm" target="_blank" title="${lib.name}">${lib.name}</a></li>
                                    </c:if>
                                    <li style="float:right;"><fmt:formatDate value="${lib.time}" pattern="yyyy-MM-dd" /></li>
                                </ul>
                            </c:forEach>
                            <c:set var="pageURL" value="${basePath}library_${pCategory.id}_${category.id}_-1.htm?"/>
                            <%@include file="../common/pages-front.jsp" %>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>