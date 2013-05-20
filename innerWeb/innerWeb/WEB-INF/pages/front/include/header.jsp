<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<script type="text/javascript">
    function sysLogout(){
        window.location = "${basePath}mg/logout.htm";
    }
</script>
<div class="header">
    <div class="header_top">
        <div class="header_top_logo"><img src="${basePath}res/front/images/logo.png"/></div>
        <div class="header_top_login">
            <p>
                <%--<iframe name="sinaWeatherTool"
                        src="http://weather.news.sina.com.cn/chajian/iframe/weatherStyle1.html?city=%E5%8C%97%E4%BA%AC"
                        width="200" height="20" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0"
                        scrolling="no"></iframe>--%>
                <iframe width="450" scrolling="no" height="20" frameborder="0" allowtransparency="true"
                        src="http://www.tianqi.com/index.php?c=code&id=1&icon=1&wind=1&num=2"></iframe>
            </p>

            <p style="margin-top:10px;">
            <ul>
                <li><img src="${basePath}res/front/images/header_login.png"/></li>
                <li>
                    <span>欢迎您：${userInfo.nickname}</span>
                </li>
                <li>|</li>
                <li><img src="${basePath}res/front/images/header_mail.png"/></li>
                <li>站内信</li>
                <li style="background-image:url(${basePath}res/front/images/botton_logout.png); margin-left:20px; margin-top:3px;">
                    <input type="button" value="退出" class="botton_logout" onclick="javascript:sysLogout();"/>
                </li>
            </ul>
            </p>
        </div>
    </div>
    <div class="menu">
        <ul>
            <li><a href="mg/home.htm" target="_blank">个人中心</a></li>
            <%--<li>|</li>
            <li><a href="rl-notices.htm">通知公告</a></li>--%>
            <li>|</li>
            <li><a href="pl-news-qQJvEz.htm">员工生活</a></li>
            <li>|</li>
            <li><a href="index.htm">首&nbsp;&nbsp;&nbsp;&nbsp;页</a></li>
        </ul>
    </div>
</div>
