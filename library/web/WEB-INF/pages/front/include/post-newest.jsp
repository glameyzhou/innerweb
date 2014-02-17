<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="notice">
    <div class="notice_top" onclick="javascript:window.location='${basePath}library-newest.htm?categoryId=EnQnii&src=left';"
         onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'" style="color: #0000ff;">最新荐读</div>
    <div class="notice_center">
        <ul>
            <%--<c:forEach var="p" items="${includePostList}">
                <li><a href="${basePath}p-${p.id}.htm" title="${p.title}">${fmtString:substringAppend(p.title,17,'...')}</a></li>
            </c:forEach>

            modify by zy 20140217 行业资讯从tbl_post转移到tbl_library中。
            --%>

            <c:forEach var="lib" items="${includePostList}" varStatus="statusIndex">
                <c:choose>
                    <c:when test="${sessionUserInfo.username eq 'lib_Tourist_uid'}">
                        <c:set var="libHref" value="href=\"#\""/>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${lib.type ==1 || lib.type == 3}">
                            <c:set var="libHref" value="href=\"${lib.url}\" target=\"_blank\""/>
                        </c:if>
                        <c:if test="${lib.type ==2}">
                            <c:set var="libHref" value="href=\"${basePath}library-detail-${lib.id}.htm\""/>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <%--1、正常情况，外链 2、自定义内容，内部使用 3、图片链接--%>
                <li><a ${libHref} title="${lib.name}">${fmtString:substringAppend(lib.name,17,'...')}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="notice_bottom"></div>
</div>