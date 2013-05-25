<%@ page import="com.glamey.innerweb.model.domain.UserInfo" %>
<%@ page import="com.glamey.innerweb.constants.Constants" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<%
    UserInfo sessionUserInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
%>
<script type="text/javascript" src="${basePath}res/front/js/prototype-1.6.0.3.js"></script>
<script type="text/javascript">
    var url = '${basePath}weather.htm';
    new Ajax.Request(url, {
                method: 'get',
                onSuccess: function (transport) {
                    var weather = $('weather');
                    weather.innerHTML = transport.responseText;
                }
            }
    );
    function sysLogout() {
        window.location = "${basePath}mg/logout.htm";
    }
    function showMessage(){
     var url = "${basePath}mg/home.htm?opt=message" ;
     window.open(url, "");
     }
</script>
<div class="header">
    <div class="header_top">
        <div class="header_top_logo"><img src="${basePath}res/front/images/logo.png"/></div>
        <div class="header_top_login">
            <p id="weather"></p>
            <p style="margin-top:10px;">
            <ul>
                <li><img src="${basePath}res/front/images/header_login.png"/></li>
                <li>
                    <span>欢迎您：<%=sessionUserInfo.getNickname()%></span>
                </li>
                <li>|</li>
                <li><img src="${basePath}res/front/images/header_mail.png" onclick="javascript:showMessage();"/></li>
                <li><a href="${basePath}mg/home.htm?opt=message" target="_blank">站内信(${unReadMessage})</a></li>
                <li style="background-image:url(${basePath}res/front/images/botton_logout.png); margin-left:20px; margin-top:3px;">
                    <input type="button" value="退出" class="botton_logout" onclick="javascript:sysLogout();"/>
                </li>
            </ul>
            </p>
        </div>
    </div>
    <div class="menu">
        <ul>
            <li><a href="${basePath}mg/home.htm" target="_blank">个人中心</a></li>
            <%--<li>|</li>
            <li><a href="rl-notices.htm">通知公告</a></li>--%>
            <li>|</li>
            <li><a href="${basePath}pl-news-qQJvEz.htm">员工生活</a></li>
            <li>|</li>
            <li><a href="${basePath}index.htm">首&nbsp;&nbsp;&nbsp;&nbsp;页</a></li>
        </ul>
    </div>
</div>
