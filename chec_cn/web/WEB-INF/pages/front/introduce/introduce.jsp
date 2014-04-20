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
    <!--content-->
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
                            <a href="${basePath}introduce.htm?cate=${category.id}">
                                    ${category.name}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="left-con" style="background:none;">
                <ul>
                    <li><img src="${basePath}res/front/chec_cn/images/right1.jpg" width="165" /></li>
                    <li><img src="${basePath}res/front/chec_cn/images/right2.jpg" width="165" /></li>
                    <li><img src="${basePath}res/front/chec_cn/images/right3.jpg" width="165" /></li>
                </ul>
            </div>
        </div>
        <div class="neiye-right">
            <div class="weizhi">您所在的位置：<a href="${basePath}">首页</a>&nbsp;>&nbsp;<a href="${basePath}introduce.htm">${rootCategory.name}</a>&nbsp;>&nbsp;<a href="${basePath}introduce.htm?cate=${defaultCategory.id}">${defaultCategory.name}</a></div>
            <div class="right-con">
                <c:choose>
                    <c:when test="${defaultCategory.showType == 0}">
                        <ul style="padding:0px 30px 8px 30px">
                            <c:forEach var="post" items="${postList}">
                                <li><span style="float:right; color:#919191">[<fmt:formatDate value="${post.publishTime}" pattern="yyyy-MM-dd"/>]</span><img src="${basePath}res/front/chec_cn/images/liebiao-biao.png" align="middle" /><a href="#">${post.title}</a></li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <%--<p>
                            <h3>中国华电工程（集团）有限公司（简称华电工程，英文缩写CHEC）是中国华电集团公司下属的全资企业，是中国华电集团公司工程技术产业板块的重要组成部分和发展平台。</h3>
                        </p>--%>
                        <p>
                            <c:if test="${fn:length(postList) > 0}">
                                ${postList[0].content}
                            </c:if>
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <!--content END-->
    <!--footer-->
    <%@ include file="../include/footer.jsp"%>
    <!--footer END-->
</div>
</body>
</html>
