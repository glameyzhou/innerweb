<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="jiaodiantu">
    <div id="xxx">
        <script>
            var box = new PPTBox();
            box.width = 264; //宽度
            box.height = 272;//高度
            box.autoplayer = 8;//自动播放间隔时间
            <c:forEach var="fouceImage" items="${libraryInfoFouceImageList}">
                <c:if test="${fouceImage.type == 2}">
                    <c:set var="imageHref" value="${basePath}library-detail-${fouceImage.id}.htm"/>
                </c:if>
                <c:if test="${fouceImage.type == 3}">
                    <c:set var="imageHref" value="${fouceImage.url}"/>
                </c:if>
                box.add({"url": "${fouceImage.image}","href":"${imageHref}","title":"${fouceImage.name}"});
            </c:forEach>
            box.show();
        </script>
    </div>
</div>