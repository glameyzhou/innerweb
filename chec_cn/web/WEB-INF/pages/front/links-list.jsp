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
                <div class="neirong_tit">${category.name}</div>
                <div class="daohang">分类导航：${category.categoryParent.name} >> ${category.name}</div>
                    <div class="neirong_con_con">
                        <table width="98%" border="0" cellspacing="0">
                            <tr><td width="4%"></td>
                                <c:forEach var="link" items="${linksLIst}" varStatus="vStatus">
                                    <td width="20%" height="30"><a href="${link.url}" target="_blank">${link.name}</a></td>
                                    <c:if test="${vStatus.count % 4 == 0}"></tr><tr><td width="4%"></td></c:if>
                                </c:forEach>
                            </tr>
                        </table>
                        <c:set var="pageURL" value="${basePath}linksFront-friendlyLinks-${category.id}.htm?"/>
                        <%@include file="../common/pages-front.jsp" %>
                    </div>
            </div>
         </div>
        <!--底部代码开始-->
        <%@include file="include/footer.jsp"%>
        <!--底部代码结束-->
    </div>
</body>
</html>