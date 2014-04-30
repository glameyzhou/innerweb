<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/neiye.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/left-lanmu.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/chec_cn/css/job.css" rel="stylesheet" type="text/css"/>
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x">
<div class="box">
    <%@include file="../include/header.jsp" %>
    <div class="content">
        <div class="neiye-left">
            <div class="left-tit">网站地图</div>
            <div class="left-con lanmu">
                <%--<ul>
                    <li class="lanmu-hover">
                        <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/><a href="${basePath}jobs.htm">招聘公告</a>
                    </li>
                </ul>--%>
            </div>
            <%@include file="../include/frame-images.jsp" %>
        </div>
        <div class="neiye-right">
            <div class="weizhi">您所在的位置：<a href="${basePath}">首页</a>&nbsp;>&nbsp;<a href="${basePath}meta-website.htm">网站地图</a>
            </div>
            <div class="right-con">
                <div class="job_k">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tableJob">
                        <tr>
                            <td style="text-align: right;width: 30%;"><a href="${basePath}">首页</a>&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <a href="${basePath}brand-${categoryIntroduce.categoryType}.htm">${categoryIntroduce.name}</a>&nbsp;
                            </td>
                            <td style="text-align: left;" valign="middle">
                                <c:forEach var="cate" items="${categoryList_introduce}" varStatus="status">
                                    <a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a>
                                    <c:if test="${!status.last}"><br/><br/></c:if>
                                </c:forEach>
                            </td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <a href="${basePath}brand-${categoryNews.categoryType}.htm">${categoryNews.name}</a>&nbsp;
                            </td>
                            <td style="text-align: left;" valign="middle">
                                <c:forEach var="cate" items="${categoryList_news}" varStatus="status">
                                    <a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a>
                                    <c:if test="${!status.last}"><br/><br/></c:if>
                                </c:forEach>
                            </td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <a href="${basePath}brand-${categoryBusiness.categoryType}.htm">${categoryBusiness.name}</a>&nbsp;
                            </td>
                            <td style="text-align: left;" valign="middle">
                                <c:forEach var="cate" items="${categoryList_business}" varStatus="status">
                                    <a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a>
                                    <c:if test="${!status.last}"><br/><br/></c:if>
                                </c:forEach>
                            </td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <a href="${basePath}brand-${categoryPerformance.categoryType}.htm">${categoryPerformance.name}</a>&nbsp;
                            </td>
                            <td style="text-align: left;" valign="middle">
                                <c:forEach var="cate" items="${categoryList_performance}" varStatus="status">
                                    <a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a>
                                    <c:if test="${!status.last}"><br/><br/></c:if>
                                </c:forEach>
                            </td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <a href="${basePath}brand-${categoryCulture.categoryType}.htm">${categoryCulture.name}</a>&nbsp;
                            </td>
                            <td style="text-align: left;" valign="middle">
                                <c:forEach var="cate" items="${categoryList_culture}" varStatus="status">
                                    <a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a>
                                    <c:if test="${!status.last}"><br/><br/></c:if>
                                </c:forEach>
                            </td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <a href="${basePath}brand-${categoryHr.categoryType}.htm">${categoryHr.name}</a>&nbsp;
                            </td>
                            <td style="text-align: left;" valign="middle">
                                <c:forEach var="cate" items="${categoryList_hr}" varStatus="status">
                                    <a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a>
                                    <c:if test="${!status.last}"><br/><br/></c:if>
                                </c:forEach>
                            </td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <a href="${basePath}brand-${categoryHr.categoryType}.htm">${categoryHr.name}</a>&nbsp;
                            </td>
                            <td style="text-align: left;" valign="middle">
                                <c:forEach var="cate" items="${categoryList_hr}">
                                    <a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a><br/><br/>
                                </c:forEach>
                                <a href="${basePath}jobs.htm">招聘公告</a>
                            </td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <a href="${basePath}brand-${categoryJcsj.categoryType}.htm">${categoryJcsj.name}</a>&nbsp;
                            </td>
                            <td style="text-align: left;" valign="middle">
                                <c:forEach var="cate" items="${categoryList_jcsj}" varStatus="staus">
                                    <a href="${basePath}band-${cate.categoryType}.htm?cate=${cate.id}">${cate.name}</a>
                                    <c:if test="${!status.last}"><br/><br/></c:if>
                                </c:forEach>
                            </td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style=" text-align: right"><a href="http://office.chec.com.cn/qzlx/index.asp">党的群众路线教育实践活动</a>&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style=" text-align: right"><a href="${basePath}periodical.htm">中国华电工程</a>&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style=" text-align: right"><a href="${basePath}meta-contact_us.htm">联系我们</a>&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style=" text-align: right"><a href="${basePath}meta-website.htm">网站地图</a>&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                            <td style="text-align: left;">&nbsp;</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp" %>
</div>
<script type="text/javascript">
    function searchJob(deptId) {
        window.location = '${basePath}jobs.htm?categoryId=' + deptId;
    }
</script>
</body>
</html>
