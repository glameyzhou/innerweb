<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    <!--
    function jumpLinks(url) {
        if (url != '') {
            window.open(url, "");
        }
    }
    //-->
</script>
<div class="body_left_1" style="margin-top:10px;">
    <div class="body_left_tit">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/left_tit_biao1.png"/></li>
            <li style="padding-left:15px;">常用链接</li>
        </ul>
    </div>
    <div class="body_left_con1">
        <ul>
            <c:forEach items="${linksDTOs}" var="ol">
                <li>
                    <select name="" class="xiala" onchange="javascript:jumpLinks(this.value);">
                        <c:forEach items="${ol.linksList}" var="links">
                            <option value="${links.url}">------${links.name}------</option>
                        </c:forEach>
                    </select>
                </li>
            </c:forEach>

        </ul>
    </div>
</div>