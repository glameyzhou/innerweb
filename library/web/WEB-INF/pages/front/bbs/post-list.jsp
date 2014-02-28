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
    <link href="${basePath}res/front/library/css/bbs.css" rel="stylesheet" type="text/css" />
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
            <div class="right-meitan">
                <div class="right-meitan-tit">
                    <ul>
                        <li style="text-align: left;width: 180px;">
                            <%--<h2 class="width180">--%>
                            <a href="${basePath}bbs/brand-${category.id}.htm" style="font-weight: bold;font-size: 15px;color: #444444; text-align: left;">${category.name}</a>
                            <%--</h2>--%>
                        </li>
                        <li class="width180">
                            [<span class="colorju">${analyzer.postCount}</span>主题/${analyzer.postReplyCount}帖子/${analyzer.todayPostReplyCount}今日帖子]
                        </li>
                        <li class="width100">
                            <img src="${basePath}res/front/library/images/right-2.jpg" align="absmiddle"/>
                            <a href="${basePath}bbs/brand-${category.id}.htm?type=great">精华</a>
                        </li>
                        <li class="width100">版主：
                                <span class="colorbule">
                                    <c:choose>
                                        <c:when test="${bbsManager == null or empty bbsManager.nickname}">空缺</c:when>
                                        <c:otherwise>${bbsManager.nickname}</c:otherwise>
                                    </c:choose>
                                </span>
                        </li>
                        <li>
                            <div class="menu">
                                <ul>
                                    <li><a class="hide" href="javascript:void(0)"></a>
                                        <ul>
                                            <li><a href="${basePath}bbs/post-${category.id}-show.htm">只发文字</a></li>
                                            <li><a href="javascript:void(0)">发起投票</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
                <p style="width: 700px;margin: 0 auto;background: #e6e7e1;height: 3px;"></p>
                <div class="clear"></div>
                <div class="right-tiezi">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <th style="padding-left:50px;">标题</th>
                            <th>作者</th>
                            <th>查看/回复</th>
                            <th>最后发表</th>
                        </tr>
                        <c:forEach var="post" items="${bbsPostDTOList_top}">
                            <tr>
                                <td>
                                    <a href="${basePath}bbs/post-${post.postId}.htm" title="${post.title}">${fmtString:substringAppend(post.title,30 ,'...' )}</a>
                                </td>
                                <td>${post.userInfo.nickname}<br/><span class="colorhui"><fmt:formatDate value="${post.postUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></td>
                                <td><span class="colorbule">${post.viewCount}</span>/${post.replyCount}</td>
                                <td>${post.lastReplyUserInfo.nickname}<br /><span class="colorhui"><fmt:formatDate value="${post.lastReplyUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></td>
                            </tr>
                        </c:forEach>

                        <c:forEach var="post" items="${bbsPostDTOList_normal}">
                            <tr>
                                <td>
                                    <a href="${basePath}bbs/post-${post.postId}.htm" title="${post.title}">${fmtString:substringAppend(post.title,30 ,'...' )}</a>
                                </td>
                                <td>${post.userInfo.nickname}<br/><span class="colorhui"><fmt:formatDate value="${post.postUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></td>
                                <td><span class="colorbule">${post.viewCount}</span>/${post.replyCount}</td>
                                <td>${post.lastReplyUserInfo.nickname}<br /><span class="colorhui"><fmt:formatDate value="${post.lastReplyUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${pageBean.curPage > 1}">
                        <c:set var="pageURL" value="${basePath}bbs/brand-${category.id}.htm?type=${type}&"/>
                        <%@include file="../../common/pages-front.jsp" %>
                    </c:if>
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
