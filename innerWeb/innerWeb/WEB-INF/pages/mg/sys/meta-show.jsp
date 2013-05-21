<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <base href="${basePath}">
    <script>
        $(function () {
            $("#jvForm").validate();
        });
    </script>
    <title>${title}</title>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${title} </div>
        <%--<form class="ropt">
            <input type="button" value="添加" onclick="javascript:window.location='${basePath}mg/dept/dept-show.htm';">
        </form>--%>
        <form class="ropt">
            <font color="red" size="3">
                <c:if test="${not empty message}">
                    ${message}
                </c:if>
            </font>
        </form>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/sys/meta/${metaInfo.name}/meta-update.htm" id="jvForm">
        <input type="hidden" id="name" name="name" value="${metaInfo.name}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">内容:</td>
                <td width="85%" class="pn-fcontent"><span class="pn-frequired">根据具体情况，内容可以为空</span></td>
            </tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="value" cols="100" rows="8"
                              style="width:95%;height:300px;">${metaInfo.value}</textarea>
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