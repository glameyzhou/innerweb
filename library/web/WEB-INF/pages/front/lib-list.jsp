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
                <div class="neirong_tit">${category.name}</div>
                <div class="seat">目录 : ${category.categoryParent.name} >> ${category.name}</div>
                <div class="neiye_right_con">
                    <c:forEach var="lib" items="${libraryInfoList}">
                        <ul class="con_neiye">
                            <li><img src="${basePath}res/front/library/images/notice_list.png"/></li>
                            <li><a href="${basePath}library-detail-${lib.id}.htm" title="${lib.name}">${fmtString:substringAppend(lib.name,40 ,'...' )}</a></li>
                            <li style="float:right;"><fmt:formatDate value="${lib.time}" pattern="yyyy-MM-dd"/></li>
                        </ul>
                    </c:forEach>
                    <c:set var="pageURL" value="${basePath}library-list-${category.id}.htm?"/>
                    <%@include file="../common/pages-front.jsp" %>
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
