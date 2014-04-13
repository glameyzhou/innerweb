<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    function search() {
        var kw = document.getElementById("kw").value;
        window.location = "${basePath}search.htm?kw=" + encodeURI(kw);
    }
</script>
<div class="header">
    <div class="header-logo">
        <div class="logo"><img src="${basePath}res/front/chec_cn/images/logo.jpg"/></div>
        <div class="logo-right">
            <div class="logo-nav">
                <ul>
                    <li><a href="javascript:void(0)">企业邮箱</a></li>
                    <li>|</li>
                    <li><a href="javascript:void(0)">VIP链接</a></li>
                    <li>|</li>
                    <li><a href="javascript:void(0)">华电内网</a></li>
                    <li style="margin-left:16px;_margin-left:16px;" class="bghui"><a href="javascript:void(0)">中文版</a>
                    </li>
                    <li><a href="http://en.chec.com.cn" target="_blank">ENGLISH</a></li>
                </ul>
            </div>
            <br/><br/><br/>
            <div class="search">
                关键词搜索<input name="" type="text" class="text"/>
                <input name="" class="go-btn" type="button"/>
            </div>
        </div>
    </div>
    <div class="menu">
        <div class="menu_left"></div>
        <TABLE>
            <TBODY>
            <TR>
                <TD><A href="${basePath}index.htm">首 页</A></TD>
                <TD class="line"></TD>
                <TD><A href="${basePath}default-INTRODUCE.htm">公司介绍</A></TD>
                <TD class="line"></TD>
                <TD><A href="${basePath}default-NEWS.htm">公司新闻</A></TD>
                <TD class="line"></TD>
                <TD><A href="${basePath}default-BUSINESS.htm">业务概况</A></TD>
                <TD class="line"></TD>
                <TD><A href="${basePath}default-PERFORMANCE.htm">公司业绩</A></TD>
                <TD class="line"></TD>
                <TD><A href="${basePath}default-CULTURE.htm">企业文化</A></TD>
                <TD class="line"></TD>
                <TD><A href="${basePath}default-HR.htm">人力资源</A></TD>
            </TR>
            </TBODY>
        </TABLE>
        <div class="menu_right"></div>
    </div>
</div>
<div class="nav">
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
            codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="1002"
            height="317">
        <param name="movie" value="${basePath}res/front/chec_cn/flash/top.swf"/>
        <param name="quality" value="high"/>
        <param name="wmode" value="transparent"/>
        <embed src="${basePath}res/front/chec_cn/flash/top.swf" width="1002" height="317" quality="high"
               pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"
               wmode="transparent"></embed>
    </object>
</div>
