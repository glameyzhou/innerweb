<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="youlian">
    <div class="youlian_tit">
        <ul>
            <li>友情链接</li>
            <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                <%--<a href="#">更多</a>--%>
            </li>
        </ul>
    </div>
    <div class="youlian_con">
        <table width="98%" border="0" cellspacing="0" style="margin-left:20px; float:left;">
            <c:forEach items="${friendlyLinksDTOs}" var="fr">
                <tr>
                    <td style="font-weight: bold">${fr.category.name}</td>
                    <c:forEach items="${fr.linksList}" var="links" varStatus="frStatus">
                        <td><a href="${links.url}" target="_blank">${links.name}</a></td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>