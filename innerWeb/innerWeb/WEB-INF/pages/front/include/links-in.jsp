<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="body_left_1" style="margin-top:10px;">
    <div class="body_left_tit">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/left_tit_biao.png"/></li>
            <li style="padding-left:15px;">${inCategory.name}</li>
        </ul>
    </div>
    <div class="body_left_con">
        <c:forEach var="inLinks" items="${inLinksList}" varStatus="inStatus">
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="${inLinks.url}" target="_blank">${inLinks.name}</a></li>
            </ul>
        </c:forEach>
    </div>
    <%--<div class="body_left_con_zilei">
        <ul>
            <li><img src="${basePath}res/front/images/left_con_biao1.png"/></li>
            <li><a href="#">工会管理信息系统</a></li>
        </ul>
    </div>--%>
</div>
