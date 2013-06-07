<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="youlian">
    <div class="body_left_tit1">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/youlian.png"/></li>
            <li style="padding-left:15px;">友情链接</li>
        </ul>
    </div>
    <div style="padding-left:20px; width:1200px; float:left;">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <c:forEach items="${friendlyLinksDTOs}" var="fr">
                    <tr align="left">
                        <td width="10%">${fr.category.name}</td>
                        <c:forEach items="${fr.linksList}" var="links">
                            <td width="10%">
                                <c:if test="${!empty links.url}">
                                    <a href="${links.url}" target="_blank">${links.name}</a>
                                </c:if>
                            </td>
					</c:forEach>
                    </tr>
                </c:forEach>
            </table>
    </div>
</div>