<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>

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
                <div class="neirong_tit">全站检索</div>
                <%--<div class="seat">目录 : 能源行业规划及政策>> 法规- 国家级政策、法规>></div>--%>
                <div class="neiye_right_con">
                    <c:forEach var="entry" items="${entries}">
                        <ul class="con_neiye">
                            <li><img src="${basePath}res/front/library/images/notice_list.png"/></li>
                            <c:choose>
                                <c:when test="${fmtString:aContantsb(entry.model,'post')}">
                                    <li><a href="${basePath}${entry.href}">${entry.title}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${fmtString:aContantsb(entry.model,'lib_1') || fmtString:aContantsb(entry.model,'lib_3')}">
                                        <li><a href="${entry.href}" target="_blank">${entry.title}</a></li>
                                    </c:if>
                                    <c:if test="${fmtString:aContantsb(entry.model,'lib_2')}">
                                        <li><a href="${basePath}${entry.href}">${entry.title}</a></li>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                            <li style="float:right;">${fmtString:substring(entry.time,10)}</li>
                        </ul>
                    </c:forEach>
                    <c:set var="pageURL" value="${basePath}search.htm?kw=${fmtString:encoder(kw)}&"/>
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
