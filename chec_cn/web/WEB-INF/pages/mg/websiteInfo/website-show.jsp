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
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 站外消息 - 分站列表 - 分站更新<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/websiteInfo/website/${opt}.do" id="jvForm">
        <input type="hidden" id="id" name="id" value="${website.id}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="name" id="name" class="required" size="80" value="${website.name}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标明自身:</td>
                <td width="85%" class="pn-fcontent">
                    <select id="isSelf" name="isSelf" class="required" disabled="disabled">
                        <option value="1" <c:if test="${website.isSelf == '1'}">selected</c:if>>是</option>
                        <option value="0" <c:if test="${website.isSelf == '0'}">selected</c:if>>否</option>
                    </select>&nbsp;&nbsp;<span class="pn-frequired">(传输数据中标识自身)</span>&nbsp;&nbsp;<font color='red'>*</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>描述:</td>
                <td width="85%" class="pn-fcontent">
                    <textarea rows="5" cols="50" name="desc" id="desc" >${website.desc}</textarea>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>URL前缀:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="url" id="url" class="required" size="80" value="${website.url}" disabled="disabled" />
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密钥:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="sign" id="sign" class="required" size="80" value="${website.sign}" />
                    &nbsp;&nbsp;<font color='red'>(对传输的数据进行加密的密钥)</font>
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