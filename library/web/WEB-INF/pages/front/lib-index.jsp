<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电图书馆-您身边的能源行业情报秘书</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${basePath}res/common/js/jquery.js"></script>
    <script type="text/javascript" src="${basePath}/res/common/js/library-showDiv.js"></script>
</head>
<body>
<c:if test="${sessionUserInfo.username eq 'lib_Tourist_uid'}">
    <c:set  var="isT" value="true"/>
</c:if>
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
        <div class="neirong_tit">${category.name}</div>
        <div class="daohang">&nbsp;&nbsp;分类导航：
            <c:forEach var="c" items="${category.children}" varStatus="vStatus">
                <a href="${basePath}library-list-${c.id}.htm">${c.name}</a><c:if test="${!vStatus.last}"> | </c:if>
            </c:forEach>
        </div>
        <c:forEach var="lib_cat" items="${libraryInfoDTOList}">
            <div class="neirong_tit_tit">
                <ul>
                    <li>${lib_cat.category.name}</li>
                    <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png);float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                        <a href="${basePath}library-list-${lib_cat.category.id}.htm">更多</a>
                    </li>
                </ul>
            </div>
            <div class="neirong_con_con">
                <table width="98%" border="0" cellspacing="0">
                    <tr>
                        <c:forEach var="lib" items="${lib_cat.libraryInfoList}" varStatus="statusIndex">
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
                            <c:choose>
                                <c:when test="${category.id == 'beqiMn' or category.id == 'mMN7Vz' or category.id == 'ZjYZR3'}">
                                    <c:set var="imageSize" value=" width=\"283\" height=\"57\" "/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="imageSize" value=" width=\"218\" height=\"218\" "/>
                                </c:otherwise>
                            </c:choose>
                            <%--1、正常情况，外链 2、自定义内容，内部使用 3、图片链接--%>
                            <c:if test="${lib.type == 1}">
                                &nbsp;&nbsp;&nbsp;&nbsp;<img src="${basePath}res/front/library/images/right_tit_biao3.png"/>
                                <a title="${lib.name}" ${libHref}>${lib.name}</a>
                                <c:if test="${lib.showisNew == 1}"><img src="${basePath}res/front/library/images/new.gif"/></c:if>
                                <br/><br/>
                            </c:if>
                            <c:if test="${lib.type == 2}">
                                &nbsp;&nbsp;&nbsp;&nbsp;<img src="${basePath}res/front/library/images/right_tit_biao3.png"/>
                                <a title="${lib.name}" ${libHref}>${lib.name}</a>
                                <c:if test="${lib.showisNew == 1}"><img src="${basePath}res/front/library/images/new.gif"/></c:if>
                                <br/><br/>
                            </c:if>
                            <c:if test="${lib.type == 3}">
                                <a ${libHref}>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <img ${imageSize} border="0" src="${basePath}${lib.image}"
                                         onmouseout="closeTxDiv();" onmouseover="showTxDiv(this,'${lib.image}','${lib.name}');"/>
                                </a>
                                <c:if test="${statusIndex.count % 2 == 0}"><br/><br/></c:if>
                            </c:if>
                        </c:forEach>
                    </tr>
                </table>
            </div>
        </c:forEach>
    </div>
</div>
<!--底部代码开始-->
<%@include file="include/footer.jsp"%>
<!--底部代码结束-->
    <%@include file="include/library-showDiv.jsp"%>
</div>
</body>
</html>