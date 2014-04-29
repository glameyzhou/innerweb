<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/left-lanmu.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/periodical.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x" >
<div class="box">
    <%@include file="../include/header.jsp"%>
    <div class="content">
        <div class="neiye-left">
            <div class="left-tit">中国华电工程</div>
            <div class="left-con lanmu">
                <ul></ul>
            </div>
            <%@include file="../include/frame-images.jsp"%>
        </div>
        <div class="neiye-right">
            <div class="weizhi">您所在的位置：<a href="${basePath}">首页</a>&nbsp;>&nbsp;<a href="${basePath}periodical.htm">中国华电工程</a></div>
            <div class="right-con">
                <h4 class="acc_titleBar">华电工程</h4>
                <div class="acc_publ_Layout">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="130" valign="top"><img src="${basePath}${periodical.images}" width="87" height="111"/></td>
                            <td valign="top">
                                <h5 class="acc_pubListTit">${periodical.years}年第${periodical.periodical}期 总第${periodical.periodicalAll}期</h5>
                                <div class="acc_Brief"></div>
                                <div class="acc_more">
                                    <a href="${basePath}periodical-${periodical.id}.htm">了解更多</a>
                                </div>
                                <h6>往期杂志</h6>
                                <div class="acc_zzList">
                                    <table id="component1__ctl0_rptPublicationList__ctl0_LastPublicationList"
                                           cellspacing="0" cellpadding="0" border="0"
                                           style="border-width:0px;width:100%;border-collapse:collapse;">
                                        <tr>
                                            <c:forEach var="pc" items="${list}" varStatus="status">
                                                <td style="width:50%;">
                                                    <a href="${basePath}periodical-${pc.id}.htm">${pc.years}年第${pc.periodical}期 总第${pc.periodicalAll}期</a>
                                                </td>
                                                <c:if test="${status.count % 2 == 0}"></tr></tr></c:if>
                                            </c:forEach>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
