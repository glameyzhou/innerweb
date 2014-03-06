<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="youlian">
    <div class="body_left_tit1">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/youlian.png"/></li>
            <li style="padding-left:15px;">常用链接</li>
        </ul>
    </div>
    <div style="padding-left:20px; width:1200px;">
        <table cellpadding="0" cellspacing="0" border="0" width="1180px">
            <c:forEach items="${friendlyLinksDTOs}" var="fr">
                <tr>
                    <td width="100px"><span style="font-weight: bold;">${fr.category.name}</span></td>
                    <c:forEach items="${fr.linksList}" var="links" varStatus="frStatus">
                        <c:choose>
                            <c:when test="${frStatus.count == 10}">
                                <c:set var="width" value="witdh='30px' align='right'" /></c:when>
                            <c:otherwise><c:set var="width" value="witdh='120px'" /></c:otherwise>
                        </c:choose>
                        <td ${width}><a href="${links.url}" target="_blank">${links.name}</a></td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>