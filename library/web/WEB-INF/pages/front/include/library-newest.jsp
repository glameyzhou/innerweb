<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="zixun_kuang">
    <div class="zixun_kuang_tit">
        <ul>
            <li style="color: #ff0000;">近期收录</li>
            <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                <a href="${basePath}library-newest.htm">更多</a></li>
        </ul>
    </div>
    <div class="zixun_kuang_con">
        <%--<table width="100%" cellpadding="0" cellspacing="0" style="margin-left: 15px;">
            <tr align="left">
                <c:forEach var="libNewest" items="${libraryInfoNewestList}" varStatus="index">
                    <c:choose>
                        <c:when test="${sessionUserInfo.username eq 'lib_Tourist_uid'}">
                            <c:set var="libHref" value="href=\"#\""/>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${libNewest.type ==1 || libNewest.type == 3}">
                                <c:set var="libHref" value="href=\"${libNewest.url}\" target=\"_blank\""/>
                            </c:if>
                            <c:if test="${libNewest.type ==2}">
                                <c:set var="libHref" value="href=\"${basePath}library-detail-${libNewest.id}.htm\""/>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                    <td width="50%" class="libNews">
                        <img src="${basePath}res/front/library/images/notice_list.png" alt="">&nbsp;
                        <a title="${libNewest.name}" ${libHref} class="libNews">${libNewest.name}</a>
                    </td>
                    <c:if test="${index.count % 2 == 0}">
                        </tr><tr align="left" style="margin-left: 15px;">
                    </c:if>
                </c:forEach>
            </tr>
        </table>--%>
        <div style="width:350px; float:left; margin-top:10px;">
            <ul>
            <c:forEach var="libNewest" items="${libraryInfoNewestList}" varStatus="index">
                <c:choose>
                    <c:when test="${sessionUserInfo.username eq 'lib_Tourist_uid'}">
                        <c:set var="libHref" value="href=\"#\""/>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${libNewest.type ==1 || libNewest.type == 3}">
                            <c:set var="libHref" value="href=\"${libNewest.url}\" target=\"_blank\""/>
                        </c:if>
                        <c:if test="${libNewest.type ==2}">
                            <c:set var="libHref" value="href='${basePath}library-detail-${libNewest.id}.htm'"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <li style="height: 25px;padding-left: 6px;width:260px;">
                    <img src="${basePath}res/front/library/images/notice_list.png" style="float: left;"/>&nbsp;<a style="float: left;display:block;width: 205px;white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow:ellipsis;" title="${libNewest.name}" ${libHref}>${libNewest.name}</a>
                    <c:if test="${libNewest.showisNew == 1}"><img src="${basePath}res/front/library/images/new.gif" style="float: left;"/></c:if>
                </li>
                <c:if test="${index.count % 5 == 0}">
                    </ul></div><div style="width:350px; float:left;  margin-top:10px;"><ul>
                </c:if>
            </c:forEach>
            </ul>
        </div>
    </div>
</div>