<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:forEach var="dto2" items="${area2PostDTOList}" varStatus="status2">
    <c:choose>
        <c:when test="${status2.index % 2 == 0}"><c:set var="cssIndex" value="1"/></c:when>
        <c:otherwise><c:set var="cssIndex" value="2"/></c:otherwise>
    </c:choose>
    <div class="body_right_${cssIndex}">
        <div class="body_right_tit1">
            <ul class="tit_biao">
                <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                <li style="padding-left:15px;">${dto2.category.name}</li>
            </ul>
            <ul class="tit_biao_right">
                <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
                <li><a href="${basePath}pl-${dto2.category.categoryType}-${dto2.category.id}.htm">更&nbsp;多</a></li>
            </ul>
        </div>
        <div class="body_right_con">
            <c:forEach var="post" items="${dto2.postList}">
                <ul class="con_right">
                    <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
                    <li style="width: 360px;text-align: left;float: left;">
                        <a href="${basePath}p-${post.id}.htm" title="${post.title}">
                            <c:if test="${post.category.aliasName eq 'deptInnerNotices'}">[${post.deptCategory.name}]</c:if>
                            ${fmtString:substringAppend(post.title,24 ,'...' )}
                        </a>
                        <c:if test="${post.showisNew == 1}">
                            <img src="${basePath}res/front/images/new.gif" style="float: none;padding-left: 2px;" align="absmiddle" />
                        </c:if>
                    </li>
                    <li style="float:right;">${fmtString:substring(post.time,10)}</li>
                </ul>
            </c:forEach>
        </div>
    </div>
</c:forEach>