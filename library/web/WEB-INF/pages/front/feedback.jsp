<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电图书馆-您身边的能源行业情报秘书</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${basePath}res/common/js/jquery.js"></script>
    <style type="text/css">
        .feedback_con{margin:0px auto; margin-top:2px;}
        .feedback_con_1{width:500px; float:left; height:40px;}
        .feedback_con_textarea{width:500px; float:left; height:80px;}
        .feedback_con_buuton{width:500px; float:left; height:60px;margin-top: 20px;padding-left: 140px;}
        .feedback_con li{float:left; height:20px; line-height:20px;}
        .feedback_text{border:#7f9cba 1px solid; width:260px; height:20px; line-height:20px;}
        .feedback_textarea{border:#7f9cba 1px solid; width:260px; height:80px; line-height:20px;}
        .feedback_botton{width:50px; height:25px; border:1px solid #7f9cba; font-weight:bold; margin-right:30px;}
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            var message = '${message}' ;
            if(message != ''){
                document.getElementById("showMessage").style.display = 'block' ;
                document.getElementById("message").innerText = message ;
            }
            $("#feedbackSubmit").click(function(){
                var params = 'username=' + document.getElementById("username").value + '&email=' + document.getElementById("email").value + '&content=' + document.getElementById("content").value ;
                $.ajax({
                    url: '${basePath}mg/feedback/feedback.htm',
                    type: 'POST',
                    data: params,
                    cache: false,
                    async : false, //默认为true 异步
                    error:function(a,b,c){
                        document.getElementById("showMessage").style.display = 'block' ;
                        document.getElementById("message").innerText = '访问超时，请超时重试!' ;
                    },
                    success: function(data) {
                        document.getElementById("showMessage").style.display = 'block' ;
                        if(data == 'E'){
                            document.getElementById("message").innerText = '不能为空' ;
                        }else{
                            document.getElementById("message").innerText = '留言成功' ;
                            $('#feedbackSubmit').attr('disabled','disabled');
                        }
                    }
                });
            });
        });
    </script>
</head>
<%--<body onload="onPageLoad();">--%>
<body>
<div class="box">
    <!--头部代码开始-->
    <%@include file="include/header.jsp"%>
    <!--头部代码结束-->
    <div class="center">
        <!--左半边代码开始-->
        <div class="center_left">
            <%@include file="include/post-newest.jsp"%>
            <%@include file="include/library-category.jsp"%>
            <%@include file="include/contact.jsp" %>
        </div>
        <!--左半边代码结束-->
        <!--右半边代码开始-->
        <div class="center_right">
            <div class="neirong">
                <div class="neirong_tit">在线留言</div>
                <div class="feedback_con">
                    <div style="width:375px;margin-top:20px;margin-left: 20px;">
                        <div class="feedback_con_1" style="display: none" id="showMessage">
                            <ul>
                                <li style="padding-left: 10px;color: #ff0000" id="message"/>
                            </ul>
                        </div>
                        <div class="feedback_con_1">
                            <ul>
                                <li>&nbsp;&nbsp;昵&nbsp;&nbsp;称：</li>
                                <li><input name="username" id="username" type="text" class="feedback_text" value="${userInfo.nickname}"/></li>
                                <li style="padding-left: 10px;color: #ff0000" id="username_li"/>
                            </ul>
                        </div>
                        <div class="feedback_con_1">
                            <ul>
                                <li>&nbsp;&nbsp;邮&nbsp;&nbsp;箱：</li>
                                <li><input name="email" id="email" type="text" class="feedback_text" value="${userInfo.email}"/></li>
                                <li style="padding-left: 10px;color: #ff0000" id="email_li"/>
                            </ul>
                        </div>
                        <div class="feedback_con_textarea">
                            <ul>
                                <li>&nbsp;&nbsp;内&nbsp;&nbsp;容：</li>
                                <li>
                                    <textarea class="feedback_textarea" id="content" name="content"></textarea>
                                </li>
                                <li style="padding-left: 10px;color: #ff0000" id="content_li"/>
                            </ul>
                        </div>
                        <div class="feedback_con_buuton">
                            <ul>
                                <li><input id="feedbackSubmit" type="button" value="提交" class="feedback_botton"/></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--右半边代码结束-->
    </div>
    <!--底部代码开始-->
    <%@include file="include/footer.jsp"%>
    <!--底部代码结束-->
</div>
</body>
</html>
