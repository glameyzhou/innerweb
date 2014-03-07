<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电迷你图书馆-您身边的能源情报站</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}/res/common/js/library-showDiv.js"></script>
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
        <div class="center_right">
            <div class="neirong">
                <div class="neirong_tit">
                    <c:choose>
                        <c:when test="${not empty src}">最新荐读</c:when>
                        <c:otherwise>近期收录</c:otherwise>
                    </c:choose>
                </div>
                <div class="neiye_right_con">
                    <table width="99%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <c:forEach var="lib" items="${libraryInfoList}" varStatus="statusIndex">
                                <c:choose>
                                    <c:when test="${sessionUserInfo.username eq 'lib_Tourist_uid'}">
                                        <c:set var="libHref" value="href=\"#\""/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${lib.type ==1 || lib.type == 3}">
                                            <c:set var="libHref" value="href=\"${lib.url}\" target=\"_blank\""/>
                                        </c:if>
                                        <c:if test="${lib.type ==2}">
                                            <c:set var="libHref" value="href=\"${basePath}library-detail-${lib.id}.htm\""/>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                                <%--1、正常情况，外链 2、自定义内容，内部使用 3、图片链接--%>
                                &nbsp;
                                <img src="${basePath}res/front/library/images/right_tit_biao3.png"/>&nbsp;
                                <a title="${lib.name}" ${libHref}>${lib.name}</a>
                                <c:if test="${lib.showisNew == 1}"><img src="${basePath}res/front/library/images/new.gif"/></c:if>
                                <br/><br/>
                            </c:forEach>
                        </tr>
                    </table>
                    <c:set var="pageURL" value="${basePath}library-newest.htm?categoryId=${libraryQuery.categoryId}&src=${src}&"/>
                    <%@include file="../common/pages-front.jsp" %>
                </div>
            </div>
        </div>
        <!--右半边代码结束-->
    </div>
    <!--底部代码开始-->
    <%@include file="include/footer.jsp"%>
    <!--底部代码结束-->
    <%--<%@include file="include/library-showDiv.jsp"%>--%>
</div>
</body>
</html>
