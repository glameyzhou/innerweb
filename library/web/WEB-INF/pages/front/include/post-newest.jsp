<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="notice">
    <div class="notice_top" onclick="javascript:window.location='${basePath}library-newest.htm?src=left';"
         onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'">最新荐读</div>
    <div class="notice_center">
        <ul>
            <c:forEach var="p" items="${includePostList}">
                <c:choose>
                    <c:when test="${sessionUserInfo.username eq 'lib_Tourist_uid'}">
                        <c:set var="libHref" value="href=\"#\""/>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${p.type ==1 || p.type == 3}">
                            <c:set var="libHref" value="href=\"${p.url}\" target=\"_blank\""/>
                        </c:if>
                        <c:if test="${p.type ==2}">
                            <c:set var="libHref" value="href='${basePath}library-detail-${p.id}.htm'"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <li><a ${libHref} title="${p.name}">${fmtString:substringAppend(p.name,17,'...')}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="notice_bottom"></div>
</div>