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
                            <c:choose>
                                <%--如果是资质荣誉--%>
                                <c:when test="${category.id eq 'beYjum'}">
                                    <a href="${basePath}introduce-zzry.htm">${category.name}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${basePath}band-${rootCategory.categoryType}.htm?cate=${category.id}">${category.name}</a>
                                </c:otherwise>
                            </c:choose>
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
                <p>${defaultCategory.describe}</p>
                    <table width="40%"cellspacing="0" cellpadding="0" style="font-size: 14px;font-weight: bold;margin-left: 40px;">
                        <%--<tr>
                            <c:forEach var="cate" items="${defaultChild}">
                                <td><a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a></td>
                            </c:forEach>
                        </tr>--%>
                        <tr>
                            <td align="right">
                                <a href="${basePath}band-INTRODUCE.htm?cate=V7VVre" alt="公司资质">
                                    <img src="${basePath}res/front/chec_cn/images/zz.jpg" alt="公司资质" border="0"/>
                                </a>
                            </td>
                            <td align="right" width="4%"></td>
                            <td align="left">
                                <a href="${basePath}band-INTRODUCE.htm?cate=yyMNj2" alt="公司荣誉">
                                    <img src="${basePath}res/front/chec_cn/images/ry.jpg" alt="公司荣誉" border="0"/>
                                </a>
                            </td>
                        </tr>
                    </table>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
