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
<%--<c:forEach var="dto" items="${libraryInfoDTOList}" varStatus="libStatus">
    一级分类：${dto.category.name}<br/>
    <c:forEach var="cat_dto" items="${dto.libraryInfoDTOList}" varStatus="cate_status">
        二级分类：${cat_dto.category.name}<br/>
        <c:forEach var="lib" items="${cat_dto.libraryInfoList}">
            分类内容：${lib.id} -- ${lib.name} <br/>
        </c:forEach>
        <br/><br/>
    </c:forEach>
    <br/><br/><br/><br/>
</c:forEach>--%>
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
            <c:forEach var="dto" items="${libraryInfoDTOList}" varStatus="libStatus">
                <c:if test="${libStatus.count % 2 == 0}"><c:set var="titleCSS" value="body_right_tit1" /></c:if>
                <c:if test="${libStatus.count % 2 == 1}"><c:set var="titleCSS" value="body_right_tit2" /></c:if>
                <div class="right_neiye">
                    <div class="${titleCSS}" style="width:962px;">
                        <ul class="tit_biao">
                            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                            <li style="padding-left:15px;">${dto.category.name}</li>
                        </ul>
                        <%--<ul class="tit_biao_right">
                            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
                            <li><a href="${basePath}library-${dto.category.id}-0--1.htm">更&nbsp;多</a></li>
                        </ul>--%>
                    </div>
                    <div class="neiye_right_con" style="width:932px;">
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <c:forEach var="cat_dto" items="${dto.libraryInfoDTOList}" varStatus="cate_status">
                                <tr valign="top">
                                    <td height="35px;" width="33%" style="font-weight: bolder">
                                        <a href="${basePath}library_${dto.category.id}_${cat_dto.category.id}_-1.htm">${cat_dto.category.name}</a>
                                    </td>
                                    <td colspan="2" align="right">
                                        <c:if  test="${fn:length(cat_dto.libraryInfoList) > 0}">
                                            <a href="${basePath}library_${dto.category.id}_${cat_dto.category.id}_-1.htm"><img src="${basePath}res/front/images/right_tit_biao2.png" border="0"/>&nbsp;更多</a>
                                        </c:if>
                                    </td>
                                </tr>
                                <c:choose>
                                <c:when test="${dto.category.id eq 'RrEvqi' or dto.category.id eq 'QRZrUb' or dto.category.id eq 'eaAr6j'}">
                                    <c:forEach var="lib" items="${cat_dto.libraryInfoList}" varStatus="statusIndex">
                                        <tr>
                                            <td colspan="3">
                                                <c:if test="${lib.type == 1}">
                                                    <img src="${basePath}res/front/images/right_tit_biao3.png"/>&nbsp;<a href="${lib.url}" target="_blank" title="${lib.name}">${lib.name}</a>
                                                </c:if>
                                                <c:if test="${lib.type == 2}">
                                                    <img src="${basePath}res/front/images/right_tit_biao3.png"/>&nbsp;<a href="${basePath}library-detail-${lib.id}.htm" target="_blank" title="${lib.name}">${lib.name}</a>
                                                </c:if>
                                                <c:if test="${lib.type == 3}">
                                                    <a href="${lib.url}"><img width="130px;" height="130px" border="0" src="${basePath}${lib.image}"/></a>
                                                    <br/>
                                                    <a href="${lib.url}">${lib.name}</a><br/>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <c:forEach var="lib" items="${cat_dto.libraryInfoList}" varStatus="statusIndex">
                                            <c:if test="${lib.type == 1}">
                                                <td width="33%" height="30px;">
                                                    <img src="${basePath}res/front/images/right_tit_biao3.png"/>&nbsp;<a href="${lib.url}" target="_blank" title="${lib.name}">${fmtString:substringAppend(lib.name,23 ,'..' )}</a>
                                                </td>
                                            </c:if>
                                            <c:if test="${lib.type == 2}">
                                                <td width="33%" height="30px;">
                                                    <img src="${basePath}res/front/images/right_tit_biao3.png"/>&nbsp;<a href="${basePath}library-detail-${lib.id}.htm" target="_blank" title="${lib.name}">${fmtString:substringAppend(lib.name,23 ,'..' )}</a>
                                                </td>
                                            </c:if>
                                            <c:if test="${lib.type == 3}">
                                                <td width="33%" height="132px;">
                                                    <a href="${lib.url}" target="_blank"><img width="130px;" height="130px" border="0" src="${basePath}${lib.image}"/></a>
                                                    <br/>
                                                    <a href="${lib.url}">${lib.name}</a><br/>
                                                </td>
                                            </c:if>
                                            <c:if test="${statusIndex.count % 3 == 0}">
                                                </tr><tr>
                                            </c:if>
                                        </c:forEach>
                                    </tr>
                                </c:otherwise>
                                </c:choose>
                                <tr><td colspan="3">&nbsp;</td></tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </c:forEach>
        </div>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>