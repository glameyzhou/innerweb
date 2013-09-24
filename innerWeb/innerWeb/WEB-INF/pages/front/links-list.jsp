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
    <title>内网管理系统 - 友情链接</title>
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
                    <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                    <li style="padding-left:15px;">友情链接 - ${category.name}</li>
                </ul>
            </div>
            <div class="neiye_right_con" style="width:932px;">
                <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr align="left" height="30px">
                        <c:forEach var="links" items="${linksLIst}" varStatus="status">
                           <td width="25%"><a href="${links.url}" target="_blank">${links.name}</a></td>
                            <c:if test="${status.count %4 == 0}"></tr><tr align="left" height="30px"></c:if>
                        </c:forEach>
                        </tr>
                </table>
                <br/>
                <c:set var="pageURL" value="${basePath}linksFront-${category.categoryType}-${category.id}.htm?"/>
                <%@include file="../common/pages-front.jsp" %>
            </div>
        </div>
        <%--<%@include file="include/friendlyLinks.jsp" %>--%>
    </div>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>