<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>中国华电工程（集团）有限公司</title>
<link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css" />
<link href="${basePath}res/front/chec_cn/css/neiye.css" rel="stylesheet" type="text/css" />
<link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css" />
<link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x" >
<div class="box">
    <!--head-->
    <%@include file="include/header.jsp"%>
    <!--content-->
    <div class="content">
        <div class="neiye-left">
            <div class="left-tit">${root.name}</div>
            <div class="left-con lanmu">
                <ul>
                    <c:forEach var="category" items="${categoryList}" varStatus="status">
                        <li <c:if test="${status.first}">class="lanmu-hover"</c:if>><img src="${basePath}res/front/chec_cn/images/daiti-biao1.png" />${category.name}</li>
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
            <div class="weizhi">
                您所在的位置：<a href="${basePath}">首页</a>&nbsp;>&nbsp;
                <a href="${basePath}default-${root.aliasName}.htm">${root.name}</a>&nbsp;>&nbsp;
                <a href="#">${firstCategory.name}</a>
            </div>
            <c:choose>
                <c:when test="${firstCategory.showType == 1}">
                    <div class="right-con">
                        <c:if test="${fn:length(postList)>0}">
                            ${postList[0].content}
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <ul style="padding-top:8px;margin-left: 10px;">
                        <c:forEach var="post" items="${postList}">
                            <li>
                                <span style="float:right; color:#919191">[<fmt:formatDate value="${post.publishTime}" pattern="yyyy-MM-dd"/>]</span>
                                <a href="#" title="${post.title}">${post.title}</a>
                            </li>
                        </c:forEach>
                    </ul>
                    <ul>
                        <p>
                            <c:set var="pageURL" value="${basePath}plist-${root.categoryType}-${firstCategory.id}&"/>
                            <%@include file="include/frontPages.jsp"%>
                        </p>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <!--content END-->
    <%@include file="include/footer.jsp"%>
</div>
</body>
</html>