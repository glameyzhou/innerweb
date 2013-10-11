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
                        <a href="#" style="padding-left:10px;">更多</a></li>
                </ul>
            </div>
            <div class="fenlei_con" style="padding-left:10px; width:235px;overflow:hidden;"><img
                    src="${basePath}res/front/library/images/zhanhui.jpg"/>
            </div>
            <div class="fenlei_con" style="padding-left:10px; width:235px;overflow:hidden; margin-top:10px;"><img
                    src="${basePath}res/front/library/images/zhanhui.jpg"/></div>
            <div class="fenlei_con" style="padding-left:10px; width:235px;overflow:hidden; margin-top:10px;"><img
                    src="${basePath}res/front/library/images/zhanhui.jpg"/></div>
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
                <div class="focus_news">
                    <%--<ul>
                        <li>主管：中国华电集团公司</li>
                        <li>主办：中国华电集团科学技术研究总院</li>
                        <li>协作单位：XX 能源网<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;XX 能源研究中心</li>
                        <li>阅读须知：如需深度阅读馆藏资料，请在本站首页进行注册。</li>
                        <li>资料复制：如需下载复制本站有关资料，请按下面联系方式联系。</li>
                        <li>委托订阅：如需委托订阅能源行业信息情报资料，请按下面联系方式联系。</li>
                        <li>联系方式：电话：010-5196 6662; 18911803600;</li>
                        <li>联系人：张锋</li>
                        <li>委托订阅：如需委托订阅能源行业信息情报资料，请按下面联系方式联系。</li>
                    </ul>--%>
                        ${libraryHeadContent}
                </div>
            </div>
        </div>
        <div class="zixun">
            <%@include file="include/library-newest.jsp"%>
            <div class="zixun_kuang" style="margin-top:10px;">
                <div class="zixun_kuang_tit1">
                    <ul>
                        <li>规划及政策、法规</li>
                        <li class="tit_erji">国家规划|国家政策、法规|地方规划|地方政策</li>
                        <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                            <a href="#">更多</a></li>
                    </ul>
                </div>
                <div class="zixun_kuang_con">
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="zixun_kuang" style="margin-top:10px;">
                <div class="zixun_kuang_tit2">
                    <ul>
                        <li>期刊、报纸</li>
                        <li class="tit_erji">国家规划|国家政策、法规|地方规划|地方政策</li>
                        <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                            <a href="#">更多</a></li>
                    </ul>
                </div>
                <div class="zixun_kuang_con">
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                    <div style="width:350px; float:left;">
                        <p>国家级规划<span style="float:right;"><a href="#"><img
                                src="${basePath}res/front/library/images/zixun_more.jpg"/></a></span></p>
                        <ul>
                            <li><a href="#">读览天下-专版应用平台正式开通</a></li>
                            <li><a href="#">国际货币基金组织在线图书馆</a></li>
                            <li><a href="#">Springer Protocols数据库正式开</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="zixun_kuang" style="margin-top:10px;">
                <div class="zixun_kuang_tit3">
                    <ul>
                        <li>世界500强中的能源企业</li>
                        <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                            <a href="#">更多</a></li>
                    </ul>
                </div>
                <div>
                    <p>知名跨国能源公司</p>
                    <table width="98%" border="0" cellspacing="0" style="margin-left:20px; float:left;">
                        <tr>
                            <td><a href="#"><img src="${basePath}res/front/library/images/1.jpg"/></a></td>
                            <td><a href="#"><img src="${basePath}res/front/library/images/2.jpg"/></a></td>
                        </tr>
                        <tr>
                            <td><a href="#"><img src="${basePath}res/front/library/images/1.jpg"/></a></td>
                            <td><a href="#"><img src="${basePath}res/front/library/images/2.jpg"/></a></td>
                        </tr>
                        <tr>
                            <td><a href="#"><img src="${basePath}res/front/library/images/1.jpg"/></a></td>
                            <td><a href="#"><img src="${basePath}res/front/library/images/2.jpg"/></a></td>
                        </tr>
                        <tr>
                            <td><a href="#"><img src="${basePath}res/front/library/images/1.jpg"/></a></td>
                            <td><a href="#"><img src="${basePath}res/front/library/images/2.jpg"/></a></td>
                        </tr>
                        <tr>
                            <td><a href="#"><img src="${basePath}res/front/library/images/1.jpg"/></a></td>
                            <td><a href="#"><img src="${basePath}res/front/library/images/2.jpg"/></a></td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>

    </div>
<!--右半边代码结束-->
</div>
    <%@include file="include/friendlyLinks_lastest.jsp"%>
    <%@include file="include/rollingImages.jsp"%>
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>