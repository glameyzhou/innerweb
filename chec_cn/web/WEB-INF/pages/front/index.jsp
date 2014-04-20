<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/index.css" rel="stylesheet" type="text/css" />
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
                <img src="${basePath}res/front/chec_cn/images/new.jpg" />
            </div>
            <div class="Tab">
                <h2 id="news-box-0-h">
                    <span id="news-box-0-h-span-0" onMouseOver="changeTabs(0,0);" class="current">要闻快递</span>
                    <span id="news-box-0-h-span-1" onMouseOver="changeTabs(0,1);" style="margin-left: -1px;">公司新闻</span>
                </h2>
                <div id="news-box-0-0" class="Tab_main" style="display: block;">
                    <a href="#" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" />
                    </a>
                    <ul>
                         <c:if test="${fn:length(yaowenkuaidiList) > 0}">
                             <c:set var="yaowenkuaidiObj" value="${yaowenkuaidiList[0]}" />
                         </c:if>
                         <span>
                             <h1>${yaowenkuaidiObj.title}</h1>
                             <ul style="padding:3px;">
                                 <c:forEach var="yaowenkuaidi" items="${yaowenkuaidiList}">
                                     <li><span style="float:right">[ <fmt:formatDate value="${yaowenkuaidi.publishTime}" pattern="yyyy-M-dd"/>]</span>${yaowenkuaidi.title}</li>
                                 </c:forEach>
                             </ul>
                         </span>
                    </ul>
                </div>
                <div id="news-box-0-1" class="Tab_main" style="display: none;">
                    <a href="#" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" />
                    </a>
                    <ul>
                        <c:if test="${fn:length(gongsixinwenList) > 0}">
                            <c:set var="gongsixinwenObj" value="${gongsixinwenList[0]}" />
                        </c:if>
                         <span>
                             <h1>${gongsixinwenObj.title}</h1>
                             <ul style="padding:3px;">
                                 <c:forEach var="gongsixinwen" items="${gongsixinwenList}">
                                     <li><span style="float:right">[ <fmt:formatDate value="${gongsixinwen.publishTime}" pattern="yyyy-M-dd"/>]</span>${gongsixinwen.title}</li>
                                 </c:forEach>
                             </ul>
                         </span>
                    </ul>
                </div>
            </div>
            <div class="Tab width390">
                <h2 style="margin-left:8px;"><span>公司简介</span></h2>
                <div class="height115">
                    <a href="#" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" /></a>
                    <ul>

                        <a href="#" target="_blank">
                            <span>
                                <p>&nbsp;&nbsp;&nbsp;&nbsp;${gongsijianjie.summary}</p>
                            </span>
                        </a>
                    </ul>
                </div>
            </div>
            <div class="Tab width390">
                <h2 id="news-box-1-h">
                    <span id="news-box-1-h-span-0" onMouseOver="changeTabs(1,0)" class="current"> 公司业绩</span>
                    <span id="news-box-1-h-span-1" onMouseOver="changeTabs(1,1)" style="margin-left: -1px;">发展战略</span>
                    <span id="news-box-1-h-span-2" onMouseOver="changeTabs(1,2)" style="margin-left: -1px;">资质</span>
                </h2>
                <div id="news-box-1-0" class="height115" style="display: block;">
                    <a href="#" class="more" target="_blank"><img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" /></a>
                    <ul>
                        <a href="#" target="_blank"><span><p>&nbsp;&nbsp;&nbsp;&nbsp; 华电工程主要从事重工、环保水务、工程总承包、、清洁能源、能源服务五大板块业务，产品和服务涵盖电力、煤炭、石油、化工、冶金、矿山、建材、市政、港口、进出口贸易等十多个领域，遍布全国31个省、市…</span></a>
                    </ul>
                </div>
                <div id="news-box-1-1" class="height115" style="display: none;">
                    <a href="#" class="more" target="_blank"><img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" /></a>
                    <ul style="color:#616065;">
                        <a href="/templates/T_Common/index.aspx?nodeid=8" target="_blank"><span><p>&nbsp;&nbsp;&nbsp; adawdqaweq华电工程已通过ISO9001, ISO14001, OHSAS18001体系认证，具有进出口权和外经权及对外承包工程经营资格。是国家级高新技术企业和3A级信用等级单位。</p></span></a>
                    </ul>
                </div>
                <div id="news-box-1-2" class="height115" style="display: none;">
                    <a href="#" class="more" target="_blank">
                        <img src="${basePath}res/front/chec_cn/images/more.jpg" alt="more" /></a>
                    <ul style="color:#616065;">
                        <a href="/templates/T_Common/index.aspx?nodeid=8" target="_blank"><span><p>&nbsp;&nbsp;&nbsp; 华电工程已通过ISO9001, ISO14001, OHSAS18001体系认证，具有进出口权和外经权及对外承包工程经营资格。是国家级高新技术企业和3A级信用等级单位。</p></span></a>
                    </ul>
                </div>
            </div>
        </div>
        <div class="content-right">
            <ul>
                <li><img src="${basePath}res/front/chec_cn/images/right1.jpg" /></li>
                <li><img src="${basePath}res/front/chec_cn/images/right2.jpg" /></li>
                <li><img src="${basePath}res/front/chec_cn/images/right3.jpg" /></li>

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
