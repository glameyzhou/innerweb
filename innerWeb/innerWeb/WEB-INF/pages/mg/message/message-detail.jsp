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
    <title>阅读站内信</title>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 站内信 - 查看</div>
        <div class="clear"></div>
    </div>
    <form method="post" action="" id="jvForm">
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">操作:</td>
                <td width="85%" class="pn-fcontent"><a href="${basePath}mg/message/message-pageOperate.htm?messageId=${messageInfo.id}&opFlag=1">删除</a> </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">标题:</td>
                <td width="85%" class="pn-fcontent">${messageInfo.title}</td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>来源:</td>
                <td width="85%" class="pn-fcontent">${messageInfo.from}</td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否已读:</td>
                <td width="85%" class="pn-fcontent">
                    <c:if test="${messageInfo.flag == 1}">已读</c:if>
                    <c:if test="${messageInfo.flag == 0}">未读</c:if>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>时间:</td>
                <td width="85%" class="pn-fcontent"><fmt:formatDate value="${msg.time}" type="both"/></td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
                <td width="85%" class="pn-fcontent">${messageInfo.content}</td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>