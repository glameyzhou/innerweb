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
        <%--面包屑--%>
        <%--<div class="seat">
            <span><a href="#">分类1</a>&nbsp;&nbsp;<a href="#">分类2</a>&nbsp;asdf</span>
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
                    <li style="padding-left:15px;">
                        <table width="150px">
                            <tr align="center">
                                <td width="50%" bgcolor="#26B7E8">
                                    <a href="${basePath}library-${pCategoryId}-${categoryId}-1.htm">图片链接</a>
                                </td>
                                <td width="50%" onmouseover="this.bgColor='#26B7E8';" onmouseout="this.bgColor='';">
                                    <a href="${basePath}library-${pCategoryId}-${categoryId}-0.htm">文字链接</a>
                                </td>
                            </tr>
                        </table>
                    </li>
                </ul>
            </div>
            <div class="neiye_right_con" style="width:932px;">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr align="left" height="150px">
                        <c:forEach var="lib" items="${libraryInfos}" varStatus="status">
                            <td width="25%">
                                <a href="${lib.url}"><img src="${lib.image}" width="130px" height="130px" border="0"/></a>
                            </td>
                        	<c:if test="${status.count % 4 == 0 }"></tr><tr></c:if>
                        </c:forEach>
                    <tr>
                </table>
                <br/>
                <c:set var="pageURL" value="${basePath}library-${pCategoryId}-${categoryId}-1.htm?"/>
                <%@include file="../common/pages-front.jsp" %>
            </div>
        </div>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>