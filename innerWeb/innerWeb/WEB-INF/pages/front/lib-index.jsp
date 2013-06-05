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
    <title>内网管理系统 - 微型图书馆</title>
</head>
<body>
<c:forEach var="dto" items="${libraryInfoDTOList}" varStatus="libStatus">
    一级分类：${dto.category.name}<br/>
    <c:forEach var="cat_dto" items="${dto.libraryInfoDTOList}" varStatus="cate_status">
        二级分类：${cat_dto.category.name}<br/>
        <c:forEach var="lib" items="${cat_dto.libraryInfoList}">
            分类内容：${lib.id} -- ${lib.name} <br/>
        </c:forEach>
        <br/><br/>
    </c:forEach>
    <br/><br/><br/><br/>
</c:forEach>


<div class="box">
    <%@include file="include/header.jsp" %>
    <div class="body">
        <div class="body_left">
            <%@include file="include/links-out.jsp" %>
            <%@include file="include/links-in.jsp" %>
            <%@include file="include/popular_Links.jsp" %>
            <%@include file="include/searcher.jsp" %>
        </div>
        <c:forEach var="dto" items="${libraryInfoDTOList}" varStatus="libStatus">
            <div class="right_neiye">
                <div class="body_right_tit" style="width:962px;">
                    <ul class="tit_biao">
                        <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                        <li style="padding-left:15px;">${dto.category.name}</li>
                    </ul>
                    <%--<ul class="tit_biao_right">
                        <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
                        <li><a href="#">更&nbsp;多</a></li>
                    </ul>--%>
                </div>
                <div class="neiye_right_con" style="width:932px;">
                    <c:forEach var="cat_dto" items="${dto.libraryInfoDTOList}" varStatus="cate_status">
                    ${cat_dto.category.name}<br/>
                    <c:forEach var="lib" items="${cat_dto.libraryInfoList}">
                        <ul class="con_neiye">
                            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
                            <li><a href="#">${lib.name}</a></li>
                            <li style="float:right;">2013-3-21</li>
                        </ul>
                    </c:forEach>
                    </c:forEach>
                </div>

            </div>
        </c:forEach>
        <div class="right_neiye">
            <div class="body_right_tit1" style="width:962px;">
                <ul class="tit_biao">
                    <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
                    <li style="padding-left:15px;">公司通知公告</li>
                </ul>
                <ul class="tit_biao_right">
                    <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
                    <li><a href="#">更&nbsp;多</a></li>
                </ul>
            </div>
            <div class="neiye_right_con" style="width:932px;">
                <ul class="con_neiye">
                    <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
                    <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
                    <li style="float:right;">2013-3-21</li>
                </ul>
            </div>
        </div>
        <%@include file="include/friendlyLinks.jsp" %>
    </div>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>