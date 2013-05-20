<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${basePath}res/front/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/footer.css" rel="stylesheet" type="text/css"/>
    <title>内网管理系统 - ${post.title}</title>
</head>
<body>
<div class="box">
    <%@include file="include/header.jsp" %>
    <!--中间内容部分代码开始-->
    <div class="body">
        <!--左半边代码开始-->
        <div class="body_left">
            <div class="body_left_1">
                <%@include file="include/links-out.jsp"%>
                <%@include file="include/links-in.jsp"%>
            <div class="body_left_1" style="margin-top:10px;">
                <div class="body_left_tit">
                    <ul class="tit_biao">
                        <li><img src="${basePath}res/front/images/left_tit_biao1.png"/></li>
                        <li style="padding-left:15px;">常用链接</li>
                    </ul>
                </div>
                <div class="body_left_con1">
                    <ul>
                        <li><select name="" class="xiala">
                            <option value="------集团系统网站链接------" selected="selected">------集团系统网站链接------</option>
                        </select></li>
                        <li><select name="" class="xiala">
                            <option value="------常用网站链接------" selected="selected">------常用网站链接------</option>
                        </select></li>
                    </ul>
                </div>
            </div>
            <div class="body_left_1" style="margin-top:10px;">
                <div class="body_left_tit">
                    <ul class="tit_biao">
                        <li><img src="${basePath}res/front/images/left_tit_biao2.png"/></li>
                        <li style="padding-left:15px;">全文检索</li>
                    </ul>
                </div>
                <div class="body_left_con1">
                    <ul>
                        <li><input name="" type="text" class="searchtext" value="请输入关键字"/></li>
                        <li><a href="#"><img src="${basePath}res/front/images/botton_search.jpg"/></a></li>
                    </ul>
                </div>
            </div>
            <div class="left_guanggao"><img src="${basePath}res/front/images/guanggao1.jpg"/></div>
            <div class="left_guanggao" style="margin-bottom:10px;"><img src="${basePath}res/front/images/guanggao1.jpg" /></div>
        </div>
        <%--左半边代码结束--%>
        <%--右半边代码开始--%>
            <div class="right_neiye">
                <div class="body_right_tit" style="width:962px;">
                    <ul class="tit_biao">
                        <li><img src="${basePath}res/front/images/right_tit_biao.png" /></li>
                        <li style="padding-left:15px;">${post.category.name}</li>
                    </ul>
                    <ul class="tit_biao_right">
                        <li><img src="${basePath}res/front/images/right_tit_biao2.png" /></li>
                        <li><a href="#">更&nbsp;多</a></li>
                    </ul>
                </div>
                <div class="neiye_right_con" style="width:932px;">
                    <div class="neirong_con" style="width:930px;">
                        <h2>${post.title}</h2>
                        <br />
                        <h3>作者：${post.author}&nbsp;&nbsp;&nbsp;时间：${post.time}&nbsp;&nbsp;&nbsp;来源：${post.source}</h3>
                        <br />
                        <div class="neirong_con">
                            ${post.content}
                        </div>
                        <br/><div class="neirong_con">
                           已经被XXX浏览过
                        </div>
                    </div>
                </div>
            </div>
        <%--右半边代码结束--%>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <!--中间内容部分代码结束-->
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>