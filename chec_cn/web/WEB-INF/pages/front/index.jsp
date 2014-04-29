<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/index_v2.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function changeTabs(mainIndex,hIndex){
            var spanObj= document.getElementById('news-box-' + mainIndex + '-h').getElementsByTagName('span');
            for (var i = 0; i < spanObj.length; i++) {
                spanObj[i].className = i == hIndex ? "current" : "";
                document.getElementById('news-box-' + mainIndex + '-' + i).style.display = i == hIndex ? "block" : "none";
            }
        }
        function jump(url) {
            if(url != ''){
                if(url.substring(0,1).toLowerCase() =='/')
                    window.open(url, '');
                if(url.length > 7){
                    if(url.substring(0,7).toLowerCase() !='http://')
                        window.open('http://'+url, '');
                    else window.open(url, '');
                }
            }
        }
    </script>
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x" >
<div class="box">
    <%@include file="include/header.jsp"%>
    <!--content-->
    <div class="content">
        <div class="content-left">
            <div class="new">
                <c:set var="bcastrURL" value="${basePath}res/front/chec_cn/flash/bcastr4.xml"/>
                <object id="bcastr4"
                    data="${basePath}res/front/chec_cn/flash/bcastr4.swf?xml=${fmtString:encoder(bcastrURL)}"
                    type="application/x-shockwave-flash" width="305" height="195">
                    <param name="movie" value="${basePath}res/front/chec_cn/flash/bcastr4.swf?xml=${fmtString:encoder(bcastrURL)}" />
                </object>
            </div>
            <div class="Tab">
                <h2 id="news-box-0-h">
                    <span id="news-box-0-h-span-0" class="current">要闻快递</span>
                </h2>
                <div id="news-box-0-0" class="Tab_main" style="display: block;">
                    <a href="${basePath}band-NEWS.htm?cate=FnQNjm" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" />
                    </a>
                    <ul>
                         <c:if test="${fn:length(yaowenkuaidiList) > 0}">
                             <c:set var="yaowenkuaidiObj" value="${yaowenkuaidiList[0]}" />
                         </c:if>
                         <span>
                             <h1>${fmtString:substringAppend(yaowenkuaidiObj.title,25,'..' )}</h1>
                             <ul style="padding:3px;">
                                 <c:forEach var="yaowenkuaidi" items="${yaowenkuaidiList}">
                                     <li>
                                         <span style="float:right">[ <fmt:formatDate value="${yaowenkuaidi.publishTime}" pattern="yyyy-M-dd"/>]</span>
                                         <a href="${basePath}post-${yaowenkuaidi.categoryType}-${yaowenkuaidi.categoryId}-${yaowenkuaidi.id}.htm" title="${yaowenkuaidi.title}">${fmtString:substringAppend(yaowenkuaidi.title,27,'..' )}</a>
                                     </li>
                                 </c:forEach>
                             </ul>
                         </span>
                    </ul>
                </div>
            </div>
            <div class="Tab width390">
                <h2><span class="current">公司新闻</span></h2>
                <div class="Tab_mainm">
                    <a href="${basePath}band-NEWS.htm?cate=6ZBZRj" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" border="0"/></a>
                    <ul>
                        <%--<c:if test="${fn:length(gongsixinwenList) > 0}">
                            <c:set var="gongsixinwenObj" value="${gongsixinwenList[0]}" />
                        </c:if>--%>
                         <span>
                             <%--<h1>${fmtString:substringAppend(gongsixinwenObj.title,25,'..' )}</h1>--%>
                             <ul style="padding:3px;">
                                 <c:forEach var="gongsixinwen" items="${gongsixinwenList}">
                                     <li>
                                         <span style="float:right">[ <fmt:formatDate value="${gongsixinwen.publishTime}" pattern="yyyy-M-dd"/>]</span>
                                         <a href="${basePath}post-${gongsixinwen.categoryType}-${gongsixinwen.categoryId}-${gongsixinwen.id}.htm" title="${gongsixinwen.title}">${fmtString:substringAppend(gongsixinwen.title,22,'..' )}</a>
                                     </li>
                                 </c:forEach>
                             </ul>
                         </span>
                    </ul>
                </div>
            </div>
            <div class="Tab width390">
                <h2 id="news-box-1-h">
                    <span id="news-box-1-h-span-0" onMouseOver="changeTabs(1,0)" class="current">公司简介</span>
                    <span id="news-box-1-h-span-1" onMouseOver="changeTabs(1,1)" style="margin-left: -1px;">公司业绩</span>
                    <span id="news-box-1-h-span-2" onMouseOver="changeTabs(1,2)" style="margin-left: -1px;">发展战略</span>
                    <span id="news-box-1-h-span-3" onMouseOver="changeTabs(1,3)" style="margin-left: -1px;">资质荣誉</span>
                </h2>
                <div id="news-box-1-0" class="height115" style="display: block;">
                    <a href="${basePath}band-${gongsijianjie.categoryType}.htm?cate=${gongsijianjie.categoryId}" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" />
                    </a>
                    <ul>
                        <a href="${basePath}band-${gongsijianjie.categoryType}.htm?cate=${gongsijianjie.categoryId}" target="_blank">
                            <span>
                                <p>&nbsp;&nbsp;&nbsp;${fmtString:substringAppend(gongsijianjie.summary,200 ,'...' )}</p>
                            </span>
                        </a>
                    </ul>
                </div>
                <div id="news-box-1-1" class="height115" style="display: none;">
                    <a href="${basePath}business.htm" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" />
                    </a>
                    <ul>
                        <a href="${basePath}business.htm" target="_blank">
                            <span>
                                <p>&nbsp;&nbsp;&nbsp;${fmtString:substringAppend(rootBusiness.describe,200 ,'...' )}</p>
                            </span>
                        </a>
                    </ul>
                </div>
                <div id="news-box-1-2" class="height115" style="display: none;">
                    <a href="${basePath}band-${fazhanzhanlue.categoryType}.htm?cate=${fazhanzhanlue.id}" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" border="0"/>
                    </a>
                    <ul style="color:#616065;">
                        <a href="${basePath}band-${fazhanzhanlue.categoryType}.htm?cate=${fazhanzhanlue.categoryId}" target="_blank">
                            <span>
                                <p>&nbsp;&nbsp;&nbsp;${fmtString:substringAppend(fazhanzhanlue.summary,200 ,'...' )}</p>
                            </span>
                        </a>
                    </ul>
                </div>
                <div id="news-box-1-3" class="height115" style="display: none;">
                    <a href="${basePath}introduce-zzry.htm" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" border="0" /></a>
                    <ul style="color:#616065;">
                        <a href="${basePath}introduce-zzry.htm" target="_blank">
                            <span>
                                <p>&nbsp;&nbsp;&nbsp;${fmtString:substringAppend(zizhirongyu.describe,200 ,'...' )}</p>
                            </span>
                        </a>
                    </ul>
                </div>
            </div>
        </div>
        <div class="content-right">
            <ul>
                <li>
                    <a href="http://office.chec.com.cn/qzlx/index.asp" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/right2.jpg" border="0"/>
                    </a>
                </li>
                <li>
                    <a href="${basePath}periodical.htm">
                        <img src="${basePath}res/front/chec_cn/images/right1.jpg" />
                    </a>
                </li>
                <li>
                    <a href="${basePath}band-JCSJ.htm">
                        <img src="${basePath}res/front/chec_cn/images/right3.jpg" />
                    </a>
                </li>

                <c:forEach var="links" items="${linksMap}">
                    <c:set var="linksList" value="${links.value}"/>
                    <li>
                        <select name="" class="xiala" onchange="jump(this.value);">
                            <option value="">----${links.key.name}----</option>
                            <c:forEach var="l" items="${linksList}">
                                <option value="${l.url}">${l.name}</option>
                            </c:forEach>
                        </select>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!--content END-->
    <!--footer-->
    <%@ include file="include/footer.jsp"%>
    <!--footer END-->
</div>
</body>
</html>
