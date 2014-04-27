<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        KindEditor.ready(function (K) {
            var editor1 = K.create('textarea[name="describe"]', {
                cssPath: '${basePath}kindeditor/plugins/code/prettify.css',
                uploadJson: '${basePath}kindeditor/jsp/upload_json.jsp',
                fileManagerJson: '${basePath}kindeditor/jsp/file_manager_json.jsp',
                allowFileManager: true,
                afterCreate: function () {
                    var self = this;
                    K.ctrl(document, 13, function () {
                        self.sync();
                        document.forms['jvForm'].submit();
                    });
                    K.ctrl(self.edit.doc, 13, function () {
                        self.sync();
                        document.forms['jvForm'].submit();
                    });
                }
            });
            prettyPrint();
        });
        $(function () {
            $("#jvForm").validate();
        });
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${pCategory.name}<c:if test="${not empty category.name}"> - ${category.name}</c:if> - 栏目
            <c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/category/category-${opt}.do" id="jvForm">
        <input type="hidden" id="id" name="id" value="${category.id}"/>
        <input type="hidden" id="pid" name="pid" value="${pid}"/>
        <input type="hidden" id="type" name="type" value="${type}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="name" id="name" class="required" size="80" value="${category.name}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>短名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="shortName" id="shortName" class="required" size="80" value="${category.shortName}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>显示方式:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showType" value="0" <c:if test="${category.showType == 0}">checked="checked"</c:if> />列表&nbsp;
                    <input type="radio" name="showType" value="1" <c:if test="${category.showType == 1}">checked="checked"</c:if> />详情&nbsp;
                </td>
            </tr>
            <%--<tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否首页显示:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showIndex" id="showIndex" value="0"
                           <c:if test="${category.showIndex == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showIndex" id="showIndex" value="1" <c:if test="${category.showIndex == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>--%>
            <%--<tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否显示在树形结构上:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showInTree" id="showInTree" value="0"
                           <c:if test="${category.showInTree == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showInTree" id="showInTree" value="1"
                           <c:if test="${category.showInTree == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>--%>
            <%--<tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>树排列顺序:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="treeOrder" id="treeOrder" class="required" size="80" value="${category.treeOrder}">
                    &nbsp;<font color="red">数字越小越靠前</font>
                </td>
            </tr>--%>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>分类排列顺序:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="categoryOrder" id="categoryOrder" class="required" size="80" value="${category.categoryOrder}">
                    &nbsp;<font color="red">数字越小越靠前</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>描述:</td>
                <td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
            </tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="describe" cols="100" rows="8"
                              style="width:95%;height:300px;visibility:hidden;">${category.describe}</textarea>
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