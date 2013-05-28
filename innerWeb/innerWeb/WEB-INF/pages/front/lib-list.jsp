<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="Shortcut Icon" href="${basePath}${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${basePath}res/front/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/footer.css" rel="stylesheet" type="text/css"/>
    <title>内网管理系统 - 微型图书馆</title>
</head>
<body>
<div class="box">
    <%@include file="include/header.jsp" %>
    <!--中间内容部分代码开始-->
    <div class="body">
        <!--左半边代码开始-->
        <div class="body_left">
            <%@include file="include/links-out.jsp" %>
            <%@include file="include/links-in.jsp" %>
            <%--常用链接--%>
            <%@include file="include/popular_Links.jsp" %>
            <%--搜索框--%>
            <%@include file="include/searcher.jsp" %>
        </div>
        <!--左半边代码结束-->
        <%--右半边代码开始--%>
        <div class="right_neiye" style="display: block" id="div_img">
            <div class="body_right_tit" style="width:962px;">
                <ul class="tit_biao">
                    <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                    <li style="padding-left:15px;">图片链接&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:changeShow('img');">图片</a>&nbsp;&nbsp;
                        <a href="javascript:changeShow('text');">文字</a>
                    </li>
                </ul>
            </div>
            <div class="neiye_right_con" style="width:932px;">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="right_neiye" style="display: none" id="div_text">
            <div class="body_right_tit" style="width:962px;">
                <ul class="tit_biao">
                    <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                    <li style="padding-left:15px;">文字链接&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:changeShow('img');">图片</a>&nbsp;&nbsp;
                        <a href="javascript:changeShow('text');">文字</a>
                    </li>
                </ul>
            </div>
            <div class="neiye_right_con" style="width:932px;">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                    <tr>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                        <td width="25%">XXXXXX</td>
                        <td width="25%">YYYYYY</td>
                    </tr>
                </table>
            </div>
        </div>
        <%--右半边代码结束--%>
        <%--友情链接--%>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <!--中间内容部分代码结束-->
    <%@include file="include/footer.jsp" %>
</div>
<script type="text/javascript">
    function changeShow(typeId){
        if(typeId == '' ||  typeId == 'img'){
            document.getElementById("div_img").style.display = "block";
            document.getElementById("div_text").style.display = "none";
        }
        else{
            document.getElementById("div_img").style.display = "none";
            document.getElementById("div_text").style.display = "block";
        }
    }
</script>
</body>
</html>