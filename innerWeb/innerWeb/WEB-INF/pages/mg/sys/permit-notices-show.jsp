<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 全局设置 - 通知通告是否需要审核 - 设置</div>
        <%--<form class="ropt">
            <input type="button" value="添加" onclick="javascript:window.location='${basePath}mg/dept/dept-show.htm';">
        </form>--%>
        <form class="ropt">
            <font color="red">
                <c:if test="${not empty message}">
                    ${message}
                </c:if>
            </font>
        </form>

        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/sys/permit-notices-update.htm" id="jvForm">
        <input type="hidden" id="name" value="${metaInfo.name}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否需要审核:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="value" id="value" class="required" value="1"
                           <c:if test="${metaInfo.value eq '1'}">checked="checked"</c:if>>是&nbsp;
                    <input type="radio" name="value" id="value" class="required" value="0"
                           <c:if test="${metaInfo.value eq '0'}">checked="checked"</c:if>>否&nbsp;
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