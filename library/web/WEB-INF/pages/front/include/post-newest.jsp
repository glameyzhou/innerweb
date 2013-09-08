<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="notice">
    <div class="notice_top" onclick="javascript:window.location='${basePath}pl-news.htm';"
         onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'">资讯公告</div>
    <div class="notice_center">
        <ul>
            <c:forEach var="p" items="${includePostList}">
                <li><a href="${basePath}p-${p.id}.htm" title="${p.title}">${fmtString:substringAppend(p.title,17,'...')}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="notice_bottom"></div>
</div>