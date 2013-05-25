<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:forEach var="dto4" items="${area4PostDTOList}" varStatus="status4">
    <c:choose>
        <c:when test="${status4.index % 2 == 0}"><c:set var="cssIndex" value="1"/></c:when>
        <c:otherwise><c:set var="cssIndex" value="2"/></c:otherwise>
    </c:choose>
    <div class="body_right_${cssIndex}">
        <div class="body_right_tit3">
            <ul class="tit_biao">
                <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                <li style="padding-left:15px;">${dto4.category.name}</li>
            </ul>
            <ul class="tit_biao_right">
                <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
                <li><a href="${basePath}pl-${dto4.category.categoryType}-${dto4.category.id}.htm">更&nbsp;多</a></li>
            </ul>
        </div>
        <div class="body_right_con">
            <c:forEach var="post" items="${dto4.postList}">
                <ul class="con_right">
                    <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
                    <li><a href="${basePath}p-${post.id}.htm"><c:if test="${post.category.aliasName eq 'deptInnerNotices'}">[${post.userInfo.category.name}]</c:if>${post.title}</a></li>
                    <li style="float:right;">${fmtString:substring(post.time, 10)}</li>
                </ul>
            </c:forEach>

        </div>
    </div>
</c:forEach>