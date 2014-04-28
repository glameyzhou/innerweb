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
        <div class="rpos">当前位置: 首页 - ${category.name} 描述设置</div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/category/root-category-update.do" id="jvForm">
        <div style="text-align: center;color: red;font-size: 13px;"><c:if test="${not empty message}">${message}</c:if></div>
        <input type="hidden" id="categoryId" name="categoryId" value="${category.id}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
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