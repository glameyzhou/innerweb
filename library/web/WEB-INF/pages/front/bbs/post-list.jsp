<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
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
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>

</head>
<body>
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
            <div class="neirong">
                <div class="neirong_tit">${category.name}&nbsp;<c:if test="${postType eq 'great'}"><font color="red">精华</font></c:if></div>
                <p style="margin-left: 20px;">
                    ${analyzer.postCount} 主题 / ${analyzer.postReplyCount} 帖子 / ${analyzer.todayPostReplyCount} 今日帖子&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="${basePath}bbs/brand-${category.id}.htm?postType=great">精华</a>&nbsp;&nbsp;&nbsp;&nbsp;版主：
                    <c:choose>
                        <c:when test="${empty bbsManager.nickname}">暂无</c:when>
                        <c:otherwise>${bbsManager.nickname}</c:otherwise>
                    </c:choose>
                </p>
                <div class="neiye_right_con">
                    <table cellpadding="0" cellspacing="0" border="1">
                        <tr align="center">
                            <th width="60%">标题</th>
                            <th width="15%">作者</th>
                            <th width="10%">回复/查看</th>
                            <th width="15%">最后发表</th>
                        </tr>
                        <c:forEach var="post" items="${bbsPostDTOList_top}">
                            <tr align="center">
                                <td>
                                    <a href="${basePath}bbs/post-${post.postId}.htm" title="${post.title}">${fmtString:substringAppend(post.title,30 ,'...' )}</a>
                                </td>
                                <td>${post.userInfo.nickname}<br/><fmt:formatDate value="${post.postUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                <td>${post.replyCount}/${post.viewCount}</td>
                                <td>${post.lastReplyUserInfo.nickname}<br/><fmt:formatDate value="${post.lastReplyUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            </tr>
                        </c:forEach>
                        <tr align="center">
                            <td colspan="4"></td>
                        </tr>
                        <c:forEach var="post" items="${bbsPostDTOList_normal}">
                            <tr align="center">
                                <td>
                                    <a href="${basePath}bbs/post-${post.postId}.htm" title="${post.title}">${fmtString:substringAppend(post.title,30 ,'...' )}</a>
                                </td>
                                <td>${post.userInfo.nickname}<br/><fmt:formatDate value="${post.postUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>${post.replyCount}/${post.viewCount}</td>
                                <td>${post.lastReplyUserInfo.nickname}<br/><fmt:formatDate value="${post.lastReplyUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:set var="pageURL" value="${basePath}bbs/brand-${category.id}.htm?postType=${postType}&"/>
                    <%@include file="../../common/pages-front.jsp" %>
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
