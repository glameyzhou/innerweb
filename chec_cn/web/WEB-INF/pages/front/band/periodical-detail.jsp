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
                <h1 class="acc_publicationTit"  style="margin-left: 30px;">华电工程</h1>
                <div class="acc_mainNav"  style="margin-left: 30px;">
                    <ul>
                        <li><a href="${basePath}periodical/summary-${periodical.id}.htm" class="selected">目 录</a></li>
                    </ul>
                </div>
                <div class="acc_publication_Layout"  style="margin-left: 30px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="160" valign="top"><table width="146" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <img id="component1__ctl0_periodicalImage" src="${basePath}${periodical.images}" border="0" style="height:191px;width:146px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" bgcolor="#E6E6E6" class="bookTit">${periodical.years}年第${periodical.periodical}期 总第${periodical.periodicalAll}期</td>
                                </tr>

                            </table>
                                <div id="component1__ctl0_plDownload" class="acc_zzList">

                                    <table width="146" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="50%" height="20" valign="bottom">
                                                <a href="${basePath}${periodical.filePath}" target="_blank">PDF下载（${periodical.fileShowSize}）</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table width="146" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center" height="40px;">
                                            <select name="component1:_ctl0:ddlOtherPeriodical" id="component1__ctl0_ddlOtherPeriodical" class="select" onchange="seeByYear(this.value)">
                                                <option value="">查看往期杂志</option>
                                                <c:forEach var="year" items="${yearsList}">
                                                    <option value="${year}">${year}年</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp"%>
</div>
<script type="text/javascript">
    function seeByYear(year) {
        window.location = '${basePath}periodical.htm?years=' + year;
    }
</script>
</body>
</html>
