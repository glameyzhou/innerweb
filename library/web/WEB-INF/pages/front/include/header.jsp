<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css" />
<%--<script type="text/javascript" src="${basePath}res/common/js/jquery.js"></script>--%>
<script type="text/javascript" src="${basePath}res/common/js/header.js"></script>
<script type="text/javascript">
    function search(){
        var kw = document.getElementById("kw").value ;
        window.location = "${basePath}search.htm?kw=" + encodeURI(kw) ;
    }
</script>
<div class="header">
    <div class="logo">
        <img src="${basePath}res/front/library/images/logo.jpg" onclick="window.location='${basePath}index.htm';"
                           onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'"/>
    </div>
    <div class="logo_right">
        <ul>
            <li style="margin-left:10px;"><a href="${basePath}index.htm">返回首页</a></li>
            <li><a href="http://www.chdi.ac.cn" target="_blank">总院首页</a></li>
            <c:choose>
                <c:when test="${(not empty sessionUserInfo) && (sessionUserInfo.username != 'lib_Tourist_uid')}">
                            <li><b><a href="${basePath}mg/home.htm" target="_blank"><c:out value="${sessionUserInfo.nickname}"/></a></b></li>
                            <li><a href="${basePath}mg/logout.htm">退&nbsp;&nbsp;出</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${basePath}register.jsp">注&nbsp;&nbsp;册</a></li>
                    <li><a href="${basePath}login.htm">登&nbsp;&nbsp;录</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
        <ul class="logo_search">
            <li>搜索</li>
            <li><input name="kw" id="kw" value="${kw}" type="text" class="searchtext" /></li>
            <li><img src="${basePath}res/front/library/images/search_button.png" onclick="javascript:search();"/></li>
            <li><a href="${basePath}pl-news.htm">查看历史通知</a></li>
        </ul>
    </div>
</div>
<%--<div class="nav"><img src="${basePath}res/front/library/images/nav.jpg" /></div>--%>
<div class="nav">
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
            codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="1020"
            height="277">
        <param name="movie" value="${basePath}res/front/library/flash/top.swf"/>
        <param name="quality" value="high"/>
        <param name="wmode" value="transparent"/>
        <embed src="${basePath}res/front/library/flash/top.swf" width="1020" height="277" quality="high"
               pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"
               wmode="transparent"></embed>
    </object>
</div>
