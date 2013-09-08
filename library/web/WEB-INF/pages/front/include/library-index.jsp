<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-9-9
  Time: 上午12:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="zixun">
    <c:forEach var="dto" items="${libraryInfoDTOList}" varStatus="libStatus">
        <%--整体方框div的布局设置开始--%>
        <%--第二个div方框--%>
        <c:if test="${libStatus.index == 1}">
            <c:set var="libListStyle" value=" style=\"margin-left:10px; _margin-left:10px;\""/>
        </c:if>
        <%--从第三个方框开始,并且是偶数的，主要是左侧方框--%>
        <c:if test="${libStatus.index > 1 && libStatus.index %2 == 0}">
            <c:set var="libListStyle" value=" style=\"margin-top:10px;\""/>
        </c:if>
        <%--从第四个方框开始,并且是奇数的，主要是右侧方框--%>
        <c:if test="${libStatus.index > 1 && libStatus.index %2 != 0}">
            <c:set var="libListStyle" value=" style=\"margin-top:10px; margin-left:10px; _margin-left:10px;\""/>
        </c:if>
        <%--整体方框div的布局设置结束--%>
        <c:if test="${libStatus.index % 2 == 0}">
            <c:set var="libTitleStyle" value=" class=\"zixun_kuang_tit\""/>
        </c:if>
        <c:if test="${libStatus.index % 2 != 0}">
            <c:set var="libTitleStyle" value=" class=\"zixun_kuang_tit2\""/>
        </c:if>
        <div class="zixun_kuang" ${libListStyle}>
            <div ${libTitleStyle}>
                <ul>
                    <li>${dto.category.name}</li>
                    <li  style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                        <a href="${basePath}library-list-${dto.category.id}.htm">更多</a>
                    </li>
                </ul>
            </div>
            <div class="zixun_kuang_con">
                <table cellspacing="0" cellpadding="0" border="0" width="100%">
                    <c:forEach var="cat_dto" items="${dto.libraryInfoDTOList}" varStatus="cate_status">
                        <tr valign="top" style="padding-left: 10px;">
                            <td width="15px;"></td>
                            <td  width="40%" style="font-weight: bolder">${cat_dto.category.name}</td>
                            <td align="right">
                                <a href="${basePath}library-list-${cat_dto.category.id}.htm"><img src="${basePath}res/front/library/images/zixun_more.jpg" /></a>
                            </td>
                        </tr>
                        <c:forEach var="lib" items="${cat_dto.libraryInfoList}" varStatus="statusIndex">
                            <tr>
                                <td width="15px;"></td>
                                <td colspan="2"><a href="${basePath}library-detail-${lib.id}.htm" title="${lib.name}">${fmtString:substringAppend(lib.name,25 ,'...' )}</a></td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                </table>
            </div>
        </div>
    </c:forEach>
</div>