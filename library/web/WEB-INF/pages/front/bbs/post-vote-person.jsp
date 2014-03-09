<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电迷你图书馆-您身边的能源情报站</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/bbs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
</head>
<body><a name="top" id="top"></a><%--锚点--%>
<div class="box">
    <!--头部代码开始-->
    <%@include file="../include/header.jsp"%>
    <!--头部代码结束-->
    <div class="center">
        <!--左半边代码开始-->
        <div class="center_left">
            <%@include file="../include/post-newest.jsp"%>
            <%@include file="../include/library-category.jsp"%>
            <%@include file="../include/contact.jsp" %>
        </div>
        <!--左半边代码结束-->
        <!--右半边代码开始-->
        <div class="center_right">
            <div class="right-top">
                <span class="colorbule" style="color: #0099cc;"><a href="${basePath}bbs/index.htm">专题讨论区</a></span> >>
                <a href="${basePath}bbs/brand-${category.id}.htm">${category.name}</a> >> <a href="${basePath}bbs/post-vote-${bbsPost.id}.htm">${bbsPost.title}</a></div>
            <div class="right-meitan">
                <div class="right-meitan-tit tit-height">
                    <ul style="width:700px;">
                        <li><h2>选项：${fmtString:substringAppend(voteProperty.propertyName,30 ,'...' )}</h2></li>
                        <li style="padding-left:20px;">[投票总量&nbsp;<span class="colorju">${voteProperty.propertyValue}</span>]</li>
                    </ul>
                    <br /><br /><br />
                    <ul style="width:700px;">
                        <li>
                            <div class="menu menu-left">
                                <ul>
                                    <li><a class="hide" href="javascript:void(0)"></a>
                                        <ul>
                                            <li><a href="${basePath}bbs/post-${bbsPost.categoryId}-show.htm">只发文字</a></li>
                                            <li><a href="${basePath}bbs/post-${bbsPost.categoryId}-voteShow.htm">发起投票</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <%--<li>
                            <a href="#replyArea" >
                                <img src="${basePath}res/front/library/images/right-4.jpg" style="margin-top:10px;"/>
                            </a>
                        </li>--%>
                    </ul>
                </div>
                <div class="right-tiezi-neirong">
                    <ul>
                        <li class="tiezi-mingcheng">
                            <B style="padding-right:20px;">以下是关于此选项的所有投票人</B>
                        </li>
                        <li class="minheight" style="margin-top: 5px; min-height: 5px;">
                            <table cellspacing="0" cellpadding="0" width="99%">
                                <tr>
                                    <c:forEach var="person" items="${votePersonList}" varStatus="staus">
                                        <td width="33%">${person.userInfo.nickname}&nbsp;<fmt:formatDate value="${person.voteTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <c:if test="${staus.count % 3 == 0}"></tr><tr></c:if>
                                    </c:forEach>
                            </table>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!--右半边代码结束-->
    </div>
    <!--底部代码开始-->
    <%@include file="../include/footer.jsp"%>
    <!--底部代码结束-->
</div>
</body>
</html>
