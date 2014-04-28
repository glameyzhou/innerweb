<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/left-lanmu.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x" >
<div class="box">
    <%@include file="../include/header.jsp"%>
    <div class="content">
        <div class="neiye-left">
            <div class="left-tit">${defaultCategory.name}</div>
            <div class="left-con lanmu">
                <ul>
                    <c:forEach var="category" items="${categoryList}">
                        <c:choose>
                            <c:when test="${defaultCategory.id eq category.id}">
                                <c:set var="liCss" value="class=\"lanmu-hover\""/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="liCss" value="onmousemove=\"this.className='lanmu-hover'\" onmouseout=\"this.className=''\""/>
                            </c:otherwise>
                        </c:choose>
                        <li ${liCss}>
                            <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/>
                            <a href="${basePath}band-${rootCategory.categoryType}.htm?cate=${category.id}">${category.name}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${rootCategory.categoryType eq 'HR'}">
                        <li>
                            <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/>
                            <a href="${basePath}jobs.htm">招聘公告</a>
                        </li>
                    </c:if>
                </ul>
            </div>
            <%@include file="../include/frame-images.jsp"%>
        </div>
        <div class="neiye-right">
            <div class="weizhi">您所在的位置：<a href="${basePath}">首页</a>&nbsp;>&nbsp;<a href="${basePath}band-${rootCategory.categoryType}.htm">${rootCategory.name}</a>&nbsp;>&nbsp;<a href="${basePath}band-${rootCategory.categoryType}.htm?cate=${defaultCategory.id}">${defaultCategory.name}</a></div>
            <div class="right-con">
                <br/>
                <h2 style="text-align: center;font-size: 14px;margin-top: 5px;">${postInfo.title}</h2>
                <p style="text-align: right;margin-right: 10px;">发布时间:<fmt:formatDate value="${postInfo.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                <p style="margin-top: 5px;">${postInfo.content}</p>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
