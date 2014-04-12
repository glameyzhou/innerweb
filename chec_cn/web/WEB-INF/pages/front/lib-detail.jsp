<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css"/>
    <%--<script type="text/javascript" src="${basePath}res/ztree/js/jquery-1.4.4.min.js"></script>--%>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript">
        function collectIt(libId){
            $.ajax({
                url:'${basePath}library-collect.htm',
                type:'GET',
                data : 'libId=' + libId ,
                async : false, //默认为true 异步
                error:function(){
                    alert('收藏失败,请稍后重试.');
                },
                success:function(data){
                    var obj = document.getElementById("collecFont");
                    var result = "已收藏" ;
                    if(data != "OK"){
                        result = "请稍后重试";
                    }
                    obj.style.color = 'red' ;
                    obj.innerHTML = result ;
                }
            });
        }
    </script>
</head>
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
                <div class="neirong_tit" style="font-size: 14px;text-align: left;font-weight: normal;">${libraryInfo.category.categoryParent.name} >> ${libraryInfo.category.name}</div>
                <div class="seat" style="font-weight: bold;text-align: center;">${libraryInfo.name}</div>
                <p style="text-align: right">
                    <c:if test="${not empty libraryInfo.author}">发布人：${libraryInfo.author}</c:if>&nbsp;&nbsp;
                    <c:if test="${not empty libraryInfo.source}">来源：${libraryInfo.source}</c:if>&nbsp;&nbsp;
                    <fmt:formatDate value="${libraryInfo.time}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;
                    <c:choose>
                        <c:when test="${exist}"><font color="red">已收藏</font></c:when>
                        <c:otherwise>
                            <font color="#6495ed" id="collecFont"><a href="javascript:collectIt('${libraryInfo.id}');">收藏</a></font>
                        </c:otherwise>
                    </c:choose>
                </p>
                <div class="neirong_con">
                    ${libraryInfo.content}
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