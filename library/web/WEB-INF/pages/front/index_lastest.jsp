<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${basePath}res/front/library/css/index_lastest.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${basePath}res/front/library/js/pptBox.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/jquery.js"></script>
    <script type="text/javascript" src="${basePath}/res/common/js/library-showDiv.js"></script>
    <style type="text/css">
        .zixun_kuang_con li {
            height: 25px;
            padding-left: 6px;
            width:260px;
            white-space:nowrap;
            word-break:keep-all;
            overflow:hidden;
            text-overflow:ellipsis;
        }
        .libIntroduct {
            height: 23px;
        }
     </style>
    <title>华电图书馆-您身边的能源行业情报秘书</title>
</head>
<body>
<div class="box">
    <%@include file="include/header.jsp" %>
    <div class="center">
    <!--左半边代码开始-->
    <div class="center_left">
        <%@include file="include/focusImages.jsp" %>
        <%@include file="include/post-newest.jsp" %>
        <%@include file="include/library-category.jsp" %>
        <div class="fenlei" style="margin-top:10px;">
            <div class="fenlei_tit">
                <ul>
                    <li>近期展会</li>
                    <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体';  margin-top:8px; padding-right:10px;">
                        <a href="${basePath}library-list-beqiMn.htm" style="padding-left:10px;">更多</a></li>
                </ul>
            </div>
            <c:forEach var="jinqihuizhan" items="${jinqihuizhan_libs}" varStatus="index">
                <c:if test="${jinqihuizhan.type ==1 || jinqihuizhan.type == 3}">
                    <c:set var="libHref" value="href=\"${jinqihuizhan.url}\" target=\"_blank\""/>
                </c:if>
                <c:if test="${jinqihuizhan.type ==2}">
                    <c:set var="libHref" value="href=\"${basePath}library-detail-${jinqihuizhan.id}.htm\""/>
                </c:if>
                <div class="fenlei_con" style="padding-left:10px; width:235px;overflow:hidden;<c:if test='${index.index>0}'> margin-top:10px;</c:if>">
                    <a ${libHref}>
                        <img src='<c:out value="${jinqihuizhan.image}" default="${basePath}res/front/library/images/zhanhui.jpg"/>' width="243" height="82"/>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="fenlei" style="margin-top:10px;">
            <div class="fenlei_tit">
                <ul>
                    <li>华电技术</li>
                    <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体';  margin-top:8px; padding-right:10px;">
                        <a href="${basePath}library-list-3AzAv2.htm" style="padding-left:10px;">更多</a></li>
                </ul>
            </div>
            <c:forEach var="huadianjishu" items="${huadianjishu_libs}" varStatus="index">
                <c:if test="${huadianjishu.type ==1 || huadianjishu.type == 3}">
                    <c:set var="libHref" value="href=\"${huadianjishu.url}\" target=\"_blank\""/>
                </c:if>
                <c:if test="${huadianjishu.type ==2}">
                    <c:set var="libHref" value="href=\"${basePath}library-detail-${huadianjishu.id}.htm\""/>
                </c:if>
                <div class="fenlei_con" style="padding-left:10px; width:235px;overflow:hidden;<c:if test='${index.index>0}'> margin-top:10px;</c:if>">
                    <a ${libHref}>
                        <img src='${huadianjishu.image}' width="218" height="218"/>
                    </a>
                </div>
            </c:forEach>
            <div class="fenlei_tit">
                <ul>
                    <li>中国华电科研</li>
                    <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体';  margin-top:8px; padding-right:10px;">
                        <a href="${basePath}library-list-6zyeYj.htm" style="padding-left:10px;">更多</a></li>
                </ul>
            </div>
            <c:forEach var="huadiankayan" items="${huadiankeyan_libs}" varStatus="index">
                <c:if test="${huadiankayan.type ==1 || huadiankayan.type == 3}">
                    <c:set var="libHref" value="href=\"${huadiankayan.url}\" target=\"_blank\""/>
                </c:if>
                <c:if test="${huadiankayan.type ==2}">
                    <c:set var="libHref" value="href=\"${basePath}library-detail-${huadiankayan.id}.htm\""/>
                </c:if>
                <div class="fenlei_con" style="padding-left:10px; width:235px;overflow:hidden;<c:if test='${index.index>0}'> margin-top:10px;</c:if>">
                    <a ${libHref}>
                        <img src='${huadiankayan.image}' width="218" height="218"/>
                    </a>
                </div>
            </c:forEach>
        </div>
        <%@include file="include/ofenLinks.jsp" %>
        <%@include file="include/contact.jsp" %>
    </div>
    <!--左半边代码结束-->
    <!--右半边代码开始-->
    <div class="center_right">
        <div class="focus">
            <div class="focus_title">
                <ul>
                    <li><img src="${basePath}res/front/library/images/focus_title1.jpg"/></li>
                    <li>图书馆简介&nbsp;ABOUTS</li>
                    <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; margin-top:5px; padding-left:15px;">
                        <a href="${basePath}library-aboutus.htm">更多</a></li>
                </ul>
            </div>
            <div class="focus_content">
                <div class="focus_pic"><img src="${basePath}res/front/library/images/focus_pic1.jpg"/></div>
                <div class="focus_news">${libraryHeadContent}</div>
            </div>
        </div>
        <div class="zixun">
            <%@include file="include/library-newest.jsp"%>
            <c:forEach var="libDTO" items="${libraryInfoDTOList}" varStatus="lib_status">
                <c:choose><c:when test="${lib_status.count%2==0}"><c:set var="titleCSS" value="zixun_kuang_tit1"/></c:when><c:otherwise><c:set var="titleCSS" value="zixun_kuang_tit2"/></c:otherwise></c:choose>
                <%--如果是"知名能源企业" or "行业研究机构、协会"--%>
                <c:choose>
                    <c:when test="${libDTO.category.id == 'mMN7Vz' or libDTO.category.id == 'ZjYZR3'}">
                        <div class="zixun_kuang" style="margin-top:10px;">
                            <div class="${titleCSS}">
                                <ul>
                                    <li>${libDTO.category.name}</li>
                                    <li class="tit_erji">
                                        <c:forEach var="libCate" items="${libDTO.childrenCategory}" varStatus="libcate_status">
                                            <a href="${basePath}library-list-${libCate.id}.htm">${libCate.shortName}</a><c:if test="${!libcate_status.last}">|</c:if>
                                        </c:forEach>
                                    </li>
                                    <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                                        <a href="${basePath}library-list-${libDTO.category.id}.htm">更多</a></li>
                                </ul>
                            </div>
                            <c:forEach var="libCateDetail" items="${libDTO.libraryInfoDTOList}" varStatus="libcatedetail_status">
                                <div>
                                    <p>${libCateDetail.category.name}</p>
                                        <table width="98%" border="0" cellspacing="0" style="margin-left:20px; float:left;">
                                            <tr>
                                                <c:forEach var="libCateDetail2" items="${libCateDetail.libraryInfoList}" varStatus="libCate2_status">
                                                <c:if test="${libCateDetail2.type == 3}">
                                                    <td>
                                                        <a href="${libCateDetail2.url}" target="_blank">
                                                            <img width="283" height="57" src="${basePath}${libCateDetail2.image}" onmouseout="closeTxDiv();" onmouseover="showTxDiv(this,'${libCateDetail2.image}','${libCateDetail2.name}');"/>
                                                        </a>
                                                    </td>
                                                    <c:if test="${libCate2_status.count % 2 == 0}"></tr><tr><td colspan="2"></td></tr><tr></c:if>
                                                </c:if>
                                            </c:forEach>
                                        </table>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="zixun_kuang" style="margin-top:10px;">
                            <div class="${titleCSS}">
                                <ul>
                                    <li>${libDTO.category.name}</li>
                                    <li class="tit_erji">
                                        <c:forEach var="libCate" items="${libDTO.childrenCategory}" varStatus="libcate_status">
                                            <a href="${basePath}library-list-${libCate.id}.htm">${libCate.shortName}</a><c:if test="${!libcate_status.last}">|</c:if>
                                        </c:forEach>
                                    </li>
                                    <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                                        <a href="${basePath}library-list-${libDTO.category.id}.htm">更多</a></li>
                                </ul>
                            </div>
                            <div class="zixun_kuang_con">
                                <c:forEach var="libCateDetail" items="${libDTO.libraryInfoDTOList}" varStatus="libcatedetail_status">
                                    <div style="width:350px; float:left;">
                                            <%--<p>${libCateDetail.category.name}<span style="float:right;">
                                                <a href="#"><img src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span>
                                            </p>--%>
                                        <p>
                                            <c:if test="${not empty libCateDetail.category.name}">
                                                <span style="float: left;width: 250px;">${libCateDetail.category.name}</span>
                                            <span style="float:right;">
                                                <a href="${basePath}library-list-${libCateDetail.category.id}.htm">
                                                    <img src="${basePath}res/front/library/images/zixun_more.jpg"/>
                                                </a>
                                            </span>
                                            </c:if>
                                            <c:if test="${empty libCateDetail.category.name}">
                                            <span style="float:right;">
                                                <a href="#"><img src="${basePath}res/front/library/images/zixun_more.jpg" style="display: none;"/></a>
                                            </span>
                                            </c:if>
                                        </p>
                                        <c:if test="${empty cat_dto.category.name}">
                                        <span style="float:right;">
                                            <a href="#"><img src="${basePath}res/front/library/images/zixun_more.jpg" style="display: none;"/></a>
                                        </span>
                                        </c:if>
                                        <ul>
                                            <c:forEach var="libCateDetail2" items="${libCateDetail.libraryInfoList}">
                                                <c:choose>
                                                    <c:when test="${sessionUserInfo.username eq 'lib_Tourist_uid'}">
                                                        <c:set var="libHref" value="href=\"#\""/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${libCateDetail2.type ==1 || libCateDetail2.type == 3}">
                                                            <c:set var="libHref" value="href=\"${libCateDetail2.url}\" target=\"_blank\""/>
                                                        </c:if>
                                                        <c:if test="${libCateDetail2.type ==2}">
                                                            <c:set var="libHref" value="href=\"${basePath}library-detail-${libCateDetail2.id}.htm\""/>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                                <%--<li>
                                                        &lt;%&ndash;1、正常情况，外链 2、自定义内容，内部使用 3、图片链接&ndash;%&gt;
                                                    <c:if test="${libCateDetail2.type == 1}">
                                                        <a title="${libCateDetail2.name}" ${libHref}>${fmtString:substringPreciseAppend(libCateDetail2.name,18,'..' )}</a>
                                                    </c:if>
                                                    <c:if test="${libCateDetail2.type == 2}">
                                                        <a title="${libCateDetail2.name}" ${libHref}>${fmtString:substringPreciseAppend(libCateDetail2.name,18,'..' )}</a>
                                                    </c:if>
                                                    <c:if test="${libCateDetail2.type == 3}">
                                                        <a ${libHref}>
                                                            <img width="130px;" height="35px" border="0" src="${basePath}${libCateDetail2.image}"
                                                                 onmouseout="closeTxDiv();" onmouseover="showTxDiv(this,'${libCateDetail2.image}','${libCateDetail2.name}');"/>
                                                        </a>
                                                    </c:if>
                                                </li>--%>

                                                <li>
                                                        <%--1、正常情况，外链 2、自定义内容，内部使用 3、图片链接--%>
                                                    <c:if test="${libCateDetail2.type == 1}">
                                                        <a title="${libCateDetail2.name}" ${libHref}>${libCateDetail2.name}</a>
                                                    </c:if>
                                                    <c:if test="${libCateDetail2.type == 2}">
                                                        <a title="${libCateDetail2.name}" ${libHref}>${libCateDetail2.name}</a>
                                                    </c:if>
                                                    <c:if test="${libCateDetail2.type == 3}">
                                                        <a ${libHref}>
                                                            <img width="130px;" height="35px" border="0" src="${basePath}${libCateDetail2.image}"
                                                                 onmouseout="closeTxDiv();" onmouseover="showTxDiv(this,'${libCateDetail2.image}','${libCateDetail2.name}');"/>
                                                        </a>
                                                    </c:if>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

    </div>
<!--右半边代码结束-->
</div>
    <%@include file="include/friendlyLinks_lastest.jsp"%>
    <%@include file="include/rollingImages.jsp"%>
    <%@include file="include/footer.jsp" %>
    <%--图片弹出层--%>
    <%@include file="include/library-showDiv.jsp" %>
</div>
</body>
</html>