<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <base href="${basePath}">
    <script>
        $(function () {
            $("#jvForm").validate();
        });
        function onCheck(){
            layer.confirm('确定要建立索引？',function(index){
                layer.close(index);
                var locationURL = "${basePath}mg/sys/buildLuceneDo.do";
                window.location = locationURL ;
            });
        }
    </script>
    <title>全局配置 - 索引建立</title>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 全局配置 - 索引建立</div>
        <form class="ropt">
            <font color="red" size="3">
                <c:if test="${not empty message}">
                    ${message}
                </c:if>
            </font>
        </form>
        <div class="clear"></div>
    </div>
    <form method="post" action="" id="jvForm">
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td colspan="2" class="pn-fbutton" style="height: 40px;">
                    <input type="button" value="建立索引" onclick="onCheck();">
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>