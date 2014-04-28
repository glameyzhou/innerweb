<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/left-lanmu.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/job.css" rel="stylesheet" type="text/css"/>
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x">
<div class="box">
    <%@include file="../include/header.jsp" %>
    <div class="content">
        <div class="neiye-left">
            <div class="left-tit">招聘公告</div>
            <div class="left-con lanmu">
                <ul>
                    <c:forEach var="category" items="${categoryList}">
                        <li>
                            <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/>
                            <a href="${basePath}band-${rootCategory.categoryType}.htm?cate=${category.id}">${category.name}</a>
                        </li>
                    </c:forEach>
                    <li class="lanmu-hover">
                        <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/><a href="${basePath}jobs.htm">招聘公告</a>
                    </li>
                </ul>
            </div>
            <%@include file="../include/frame-images.jsp" %>
        </div>
        <div class="neiye-right">
            <div class="weizhi">您所在的位置：
                <a href="${basePath}">首页</a>&nbsp;>&nbsp;
                <a href="${basePath}brand-${rootCategory.categoryType}.htm">${rootCategory.name}</a>&nbsp;>&nbsp;
                <a href="${basePath}jobs.htm">招聘公告</a>
            </div>
            <div class="right-con">
                <p>
                    <h3>
                        <c:choose>
                            <c:when test="${not empty createId}">简历投递成功，感谢你的支持！</c:when>
                            <c:otherwise>
                                <div class="errTxtArea">
                                    <p class="txt_title"><c:if test="${fn:length(resumeResult)>5}">${resumeResult}</c:if></p>
                                    <p><input type="button" class="btnFn1" value="返回" onclick="javascript:history.go(-1);" /></p>
                                </div>
                                <c:if test="${fn:length(resumeResult)==5}">简历投递失败，请稍后重试!</c:if>
                            </c:otherwise>
                        </c:choose>
                    </h3>
                </p>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>
