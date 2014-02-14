<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    <!--
    function jumpLinks(url) {
        if (url != '') {
            window.open(url, "");
        }
    }
    function selectNo(selectName) {
        var s1=document.getElementById(selectName);
        var sV=s1.options[s1.selectedIndex].value;
        alert("xxx");
        if (sV != '') {
            window.open(sV, "");
        }
    }
    //-->
</script>
<div class="fenlei" style="margin-top:10px;">
    <div class="fenlei_tit">
        <ul>
            <li>常用链接</li>
        </ul>
    </div>
    <div class="fenlei_con" style="float:left;">
        <%--<ul style="height:70px;">--%>
        <ul style="height:auto;">
            <c:forEach items="${linksDTOs}" var="ol">
                <li>
                    <select name="popularLinks" id="popularLinks" class="xiala" onchange="javascript:jumpLinks(this.value)">
                        <c:forEach items="${ol.linksList}" var="links">
                            <optgroup label=""></optgroup>
                            <option value="${links.url}">------${links.name}------<br/></option>
                        </c:forEach>
                    </select>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>