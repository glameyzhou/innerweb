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
                <div class="neirong_tit">图片滚动 <c:if test="${not empty category}">>> ${category.name}</c:if></div>
                <div class="seat">分类&nbsp;&nbsp;<a href="${basePath}rolling-.htm">所有</a> |
                    <c:forEach var="cate" items="${categoryList}" varStatus="index">
                        <a href="${basePath}rolling-${cate.id}.htm">${cate.name}</a><c:if test="${!index.last}"> | </c:if>
                    </c:forEach>
                </div>
                <div class="neiye_right_con">
                    <table width="99%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <c:forEach var="rolling" items="${rollingImageInfoList}" varStatus="statusIndex">
                                <td width="33%">
                                    <img src="${basePath}${rolling.image}" alt="" height="147" width="200"
                                         <%--onmouseout="closeTxDiv();" onmouseover="showTxDiv(this,'${rolling.image}','${rolling.name}');"--%>/><br/>
                                    名称：${rolling.name}<br/>
                                    时间：<fmt:formatDate value="${rolling.rollingDate}" pattern="yyyy-MM-dd"/><br/><br/>
                                </td>
                                <c:if test="${statusIndex.count % 3 == 0}">
                                    </tr><tr>
                                </c:if>
                            </c:forEach>
                        </tr>
                    </table>
                    <c:set var="pageURL" value="${basePath}rolling-${category.id}.htm?"/>
                    <%@include file="../common/pages-front.jsp" %>
                </div>
            </div>
        </div>
        <!--右半边代码结束-->
    </div>
    <!--底部代码开始-->
    <%@include file="include/footer.jsp"%>
    <!--底部代码结束-->
    <%@include file="include/library-showDiv.jsp"%>
</div>
</body>
</html>
