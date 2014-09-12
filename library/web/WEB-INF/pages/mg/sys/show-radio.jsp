<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <base href="${basePath}">
    <script>
        KindEditor.ready(function (K) {
            var editor1 = K.create('textarea[name="content"]', {
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
    <title>${title}</title>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 全局设置 - ${title} </div>
        <form class="ropt"></form>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/sys/meta/radio/${meta}/update.htm" id="jvForm" enctype="multipart/form-data">
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>${title}:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="content" value="1" <c:if test="${content.value eq '1'}">checked="checked" </c:if> />是 &nbsp;
                    <input type="radio" name="content" value="0" <c:if test="${content.value eq '0'}">checked="checked" </c:if> />否
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