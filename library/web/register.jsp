<%--
  Created by IntelliJ IDEA.
  User: zy
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmtString" uri="/string-tag" %>
<c:set var="basePathPort" value="${pageContext.request.serverPort}"/>
<c:choose>
    <c:when test="${basePathPort eq '80' }">
        <c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/"/>
    </c:when>
    <c:otherwise>
        <c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/"/>
    </c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${basePath}res/front/library/css/register.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${basePath}res/ztree/js/jquery-1.4.4.min.js"></script>
    <title>华电图书馆-您身边的能源行业情报秘书-游客注册</title>
    <%--<script type="text/javascript" src="${basePath}res/common/js/register.js"></script>--%>
    <script type="text/javascript">
        var submitStatus = '0' ;
        function stringTrim(str) {
            return str.replace(/^\s*/g, "").replace(/\s*$/g, "");
        }
        function pageOnBlur(itemName){
            var obj = document.getElementById(itemName);
            var value = stringTrim(obj.value);
            if(value == ''){
                document.getElementById(itemName + '_li').innerText = '必填项' ;
                submitStatus = '0' ;
            }else{
                /*检测用户名*/
                if(itemName == 'username'){
                    $.ajax({
                        url: '${basePath}register_userExist.htm',
                        type: 'POST',
                        data: 'username=' + value,
                        cache: false,
                        async : false, //默认为true 异步
                        dataType : 'json' ,
                        error:function(a,b,c){
                            alert(a + " " + b + "  " + c);
                            document.getElementById('username_li').innerText = '检测超时,请稍后重试.';
                        },
                        success: function(data) {
//                            alert(JSON.stringify(data));
                            if(data.regStatus == 'empty' || data.regStatus == 'exist'){
                                $("#username_li").html(data.regMessage);
                                submitStatus = '0' ;
                            }else{
                                $("#username_li").html(data.regMessage);
                                submitStatus = '1' ;
                            }
                        }
                    });
                }
            }
        }
        function pageOnUp(itemName,length){
            var obj = document.getElementById(itemName);
            var value = stringTrim(obj.value);
            if(length > 0){
                if(value.length < length){
                    document.getElementById(itemName + '_li').innerText = '长度必须大于' + length ;
                    submitStatus = '0' ;
                }else{
                    document.getElementById(itemName + '_li').innerText = '' ;
                    submitStatus = '1' ;
                }
                if(itemName == 'passwdRp'){
                    var passwd = stringTrim(document.getElementById('passwd').value);
                    var passwdRp = stringTrim(document.getElementById('passwdRp').value);
                    if(passwd != passwdRp){
                        document.getElementById('passwdRp_li').innerText = '两次输入的密码不一致' ;
                        submitStatus = '0' ;
                    }
                }
            }else{
                document.getElementById(itemName + '_li').innerText = '' ;
                submitStatus = '1' ;
            }

        }
        function pageOnSubmit(){
            if(submitStatus == '0'){
                pageOnUp('username',2);
                pageOnUp('nickname',2);
                pageOnUp('passwd',6);
                pageOnUp('passwdRp',6);
                pageOnUp('company',0);
                pageOnUp('dept',0);
                pageOnUp('mobile',0);
                pageOnUp('phone',0);
                pageOnUp('email',0);
                return false;
            }
            else{
                /*var content = 'username=' + stringTrim($("#username").attr("value")) + '&nickname=' + stringTrim($("#nickname").attr("value"))
                        + '&passwd=' + stringTrim($("#passwd").attr("value")) + '&passwdRp=' + stringTrim($("#passwdRp").attr("value"))
                        + '&company=' + stringTrim($("#company").attr("value")) + '&dept=' + stringTrim($("#dept").attr("value"))
                        + '&mobile=' + stringTrim($("#mobile").attr("value")) + '&phone=' + stringTrim($("#phone").attr("value"))
                        + '&email=' + stringTrim($("#email").attr("value")) ;
                $.ajax({
                    url: '${basePath}register.htm',
                    type: 'POST',
                    data: content,
                    cache: false,
                    async : false, //默认为true 异步
                    error:function(a,b,c){
                        document.getElementById('username_li').innerText = '检测超时,请稍后重试.';
                    },
                    success: function(data) {
                        if(data == '1'){
                            window.location = 'http://www.sina.com' ;
                        }
                        else{
                            document.getElementById("resultDiv").style.display = 'block' ;
                            $("#register_message").html('注册失败');

                        }
                    }
                });*/
                alert("11");
                document.getElementById("registryForm").submit();
            }
        }
    </script>
</head>
<body background="${basePath}res/front/library/images/register_bg.jpg" style="background-repeat:repeat-x;">
<form action="${basePath}register.htm" method="post" id="registryForm">
<div class="register_logo"><img src="${basePath}res/front/library/images/register_logo.png"/></div>
<div class="register_con">
    <p>立刻注册微型图书馆帐号</p>
    <div style="width:375px; margin:0px auto; margin-top:80px;">
        <div class="register_con_1" style="height:20px;display: none" id="resultDiv">
            <ul>
                <li style="padding-left: 10px;color: #ff0000;font-weight: bold" id="register_message"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;用户名：</li>
                <li><input name="username" id="username" type="text" class="register_text"
                           onblur="pageOnBlur('username');" onkeyup="pageOnUp('username',2)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="username_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li class="liLeft">真实姓名：</li>
                <li><input name="nickname" id="nickname" type="text" class="register_text"
                           onblur="pageOnBlur('nickname');" onkeyup="pageOnUp('nickname',2)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="nickname_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;密码：</li>
                <li><input name="passwd" id="passwd" type="password" class="register_text"
                           onblur="pageOnBlur('passwd');" onkeyup="pageOnUp('passwd',6)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="passwd_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>确认密码：</li>
                <li><input name="passwdRp" id="passwdRp" type="password" class="register_text"
                           onblur="pageOnBlur('passwdRp');" onkeyup="pageOnUp('passwdRp',6)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="passwdRp_li"/>
            </ul>
        </div>

        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;单位：</li>
                <li><input name="company" id="company" type="text" class="register_text"
                           onblur="pageOnBlur('company');" onkeyup="pageOnUp('company',0)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="company_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;部门：</li>
                <li><input name="dept" id="dept" type="text" class="register_text"
                           onblur="pageOnBlur('dept');" onkeyup="pageOnUp('dept',0)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="dept_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;手机号：</li>
                <li><input name="mobile" id="mobile" type="text" class="register_text"
                           onblur="pageOnBlur('mobile');" onkeyup="pageOnUp('mobile',0)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="mobile_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;固话：</li>
                <li><input name="phone" id="phone" type="text" class="register_text"
                           onblur="pageOnBlur('phone');" onkeyup="pageOnUp('phone',0)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="phone_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;邮箱：</li>
                <li><input name="email" id="email" type="text" class="register_text"
                           onblur="pageOnBlur('email');" onkeyup="pageOnUp('email',0)"/></li>
                <li style="padding-left: 10px;color: #ff0000" id="email_li"/>
            </ul>
        </div>
        <div class="register_con_1">
            <ul>
                <li><input name="register_submit" id="register_submit" type="button" value="提交" class="register_botton" onclick="pageOnSubmit();"/></li>
                <li><input name="register_reset" type="reset" value="清空" class="register_botton"/></li>
            </ul>
        </div>
    </div>
</div>
</form>
</body>
</html>