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
    <title>在线留言</title>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 在线留言 - 查看</div>
        <div class="clear"></div>
    </div>
    <form method="post" action="" id="jvForm">
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">操作:</td>
                <td width="85%" class="pn-fcontent"><a
                        href="${basePath}mg/feedback/delete.htm?fbId=${fb.fbId}">删除</a>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">昵称:</td>
                <td width="85%" class="pn-fcontent">${fb.fbUsername}</td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>邮箱:</td>
                <td width="85%" class="pn-fcontent">${fb.fbEmail}</td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
                <td width="85%" class="pn-fcontent">${fb.fbContent}</td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>时间:</td>
                <td width="85%" class="pn-fcontent"><fmt:formatDate value="${fb.fbTime}" type="both"/></td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>