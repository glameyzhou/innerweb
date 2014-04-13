<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="new" style="border-color: red;">
    <script>
        var box = new PPTBox();
        box.width = 309; //宽度
        box.height = 199;//高度
        box.autoplayer = 8;//自动播放间隔时间
        <c:forEach var="focusImage" items="${focusImageList}">
            box.add({"url": "${focusImage.focusImage}","href":"${basePath}post-${focusImage.id}.htm","title":"${focusImage.title}"});
        </c:forEach>
        box.show();
    </script>
</div>