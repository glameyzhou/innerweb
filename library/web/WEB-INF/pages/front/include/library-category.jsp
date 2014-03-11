<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-9-7
  Time: 下午10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="${basePath}res/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<%--<script type="text/javascript" src="${basePath}res/ztree/js/jquery-1.4.4.min.js"></script>--%>
<script type="text/javascript" src="${basePath}res/ztree/js/jquery.ztree.core-3.5.js"></script>
<div class="fenlei" style="width: 255px;height: 50px;padding-bottom:0px;border:5px solid #efefef; background-color: #F7F7F7;">
    <div class="fenlei_tit">
        <ul>
            <li><img src="${basePath}res/front/library/images/fenlei_tit.png"/></li>
            <li>图书类目导航</li>
        </ul>
    </div>
</div>
<div class="fenlei" style="background-color:#F7F7F7;">
    <div style="width: 250px;height: auto;text-align: left;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<SCRIPT type="text/javascript">
    <!--
    var setting = {
        data: {
            simpleData: {
                enable: true
            }
        }
    };
    var zNodes = [
        <c:forEach var="lib" items="${libraryCategoryList}" varStatus="vStatus">
        <c:choose>
        <c:when test="${lib.hasChild == 1}">
        { id: "${lib.id}", pId: "${lib.parentId}", name: "${fmtString:substringAppend(lib.name,20,'..')}", open: false, url: "${basePath}${accessUrl}",target:"_self",icon:"${basePath}res/front/library/images/fenlei_con1.jpg"}<c:if test="${!vStatus.last}">,</c:if>
        </c:when>
        <c:otherwise>
        { id: "${lib.id}", pId: "${lib.parentId}", name: "${fmtString:substringAppend(lib.name,20,'..')}", url: "${basePath}${accessUrl}",target:"_self", icon:"${basePath}res/front/library/images/notice_list.png"}<c:if test="${!vStatus.last}">,</c:if>
        </c:otherwise>
        </c:choose>
        </c:forEach>
    ];
    $(document).ready(function () {
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    });
    //-->
</SCRIPT>
<style type="text/css">
    .ztree li span.button.pIcon01_ico_open {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/1_open.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }

    .ztree li span.button.pIcon01_ico_close {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/1_close.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }

    .ztree li span.button.pIcon02_ico_open, .ztree li span.button.pIcon02_ico_close {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/2.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }

    .ztree li span.button.icon01_ico_docu {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/3.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }

    .ztree li span.button.icon02_ico_docu {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/4.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }

    .ztree li span.button.icon03_ico_docu {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/5.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }

    .ztree li span.button.icon04_ico_docu {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/6.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }

    .ztree li span.button.icon05_ico_docu {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/7.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }

    .ztree li span.button.icon06_ico_docu {
        margin-right: 2px;
        background: url(${basePath}res/ztree/css/zTreeStyle/img/diy/8.png) no-repeat scroll 0 0 transparent;
        vertical-align: top;
        *vertical-align: middle
    }
</style>