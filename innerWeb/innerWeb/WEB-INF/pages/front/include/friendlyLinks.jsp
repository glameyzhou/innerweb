<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/tagInclude.jsp" %>
<div class="youlian">
    <div class="body_left_tit1">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/youlian.png"/></li>
            <li style="padding-left:15px;">友情链接</li>
        </ul>
    </div>
    <div style="padding-left:20px; width:1200px; float:left;">
    	<c:forEach items="${friendlyLinksMap}" var="flmap">
    		<p>${flmap.key.name}：
    		<c:forEach items="${flmap.value}" var="links">
    			<a href="${links.url}" target="_blank"><c:out value="${links.name}" />&nbsp;</a>
    		</c:forEach>
    		</p>
    	</c:forEach>
    </div>
</div>