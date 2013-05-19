<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="body_left_1">
    <div class="body_left_tit">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/left_tit_biao.png"/></li>
            <li style="padding-left:15px;">${outCategory.name}</li>
        </ul>
    </div>
    <div class="body_left_con">
        <c:forEach var="outLinks" items="${outLinksList}" varStatus="instatus">
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="${outLinks.url}">${outLinks.name}</a></li>
            </ul>
        </c:forEach>
    </div>
</div>