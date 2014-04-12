<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
    </script>
    <link rel="stylesheet" href="${basePath}res/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <%--<script type="text/javascript" src="${basePath}res/ztree/js/jquery-1.4.4.min.js"></script>--%>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <script type="text/javascript" src="${basePath}res/ztree/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${basePath}res/ztree/js/jquery.ztree.excheck-3.5.js"></script>
    <SCRIPT type="text/javascript">
        var setting = {
            view: {
              selectedMulti:false
            },
            check: {
                enable: true,
                chkStyle: "radio",
                radioType: "all"
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeCheck: beforeCheck,
                onCheck: onCheck
            }
        };
        var zNodes = [
            <c:forEach var="lib" items="${libCateList}" varStatus="vStatus">
                <c:choose>
                    <c:when test="${lib.hasChild == 1}">
                        { id: "${lib.id}", pId: "${lib.parentId}", name: "${fmtString:substringAppend(lib.name,20,'..')}",icon:"${basePath}res/front/library/images/fenlei_con1.jpg",doCheck:false}<c:if test="${!vStatus.last}">,</c:if>
                    </c:when>
                    <c:otherwise>
                        { id: "${lib.id}", pId: "${lib.parentId}", name: "${fmtString:substringAppend(lib.name,20,'..')}", icon:"${basePath}res/front/library/images/notice_list.png"}<c:if test="${!vStatus.last}">,</c:if>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        ];


        var code;
        function setCheck() {
            var type = $("#level").attr("checked")? "level":"all";
            setting.check.radioType = type;
            showCode('setting.check.radioType = "' + type + '";');
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        }
        function showCode(str) {
            if (!code) code = $("#code");
            code.empty();
            code.append("<li>"+str+"</li>");
        }
        function beforeCheck(treeId, treeNode) {
            return (treeNode.doCheck !== false);
        }
        function onCheck(e, treeId, treeNode) {
//            alert(e + "  " + treeId + " id=" + treeNode.id + " pId=" + treeNode.pId + " name=" + treeNode.name);
            document.getElementById("cateId").value = treeNode.id ;
        }
        $(document).ready(function(){
            setCheck();
            $("#level").bind("change", setCheck);
            $("#all").bind("change", setCheck);
        });
        function onFormSubmit(){
            var obj = document.getElementById("cateId").value;
            obj = obj.replace(/^\s*/g, "").replace(/\s*$/g, "") ;
            if(obj == ''){
                layer.alert('请选择目标分类', 8);
                return ;
            }
        }
    </SCRIPT>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 微型图书馆 - 分类转移 </div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/library/library-move2Cate-do.htm" id="jvForm" onsubmit="return onFormSubmit();">
        <input type="hidden" id="libIds" name="libIds" value="${libIds}"/>
        <input type="hidden" id="cateId" name="cateId" value=""/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>目标分类:</td>
                <td width="85%" class="pn-fcontent">
                    <div style="width: 250px;height: auto;text-align: left">
                        <ul id="treeDemo" class="ztree"></ul>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="pn-fbutton">
                    <input type="submit" value="提交"> &nbsp; <input type="reset" value="重置">
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>