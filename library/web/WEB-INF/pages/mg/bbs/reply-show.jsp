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
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 论坛 - ${category.name} - ${bbsPost.title} 回帖修改</div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/bbs/reply-update.htm" id="jvForm" enctype="multipart/form-data">
        <input type="hidden" id="postId" name="postId" value="${bbsPost.id}"/>
        <input type="hidden" id="replyId" name="replyId" value="${bbsReply.id}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>主帖标题:</td>
                <td width="85%" class="pn-fcontent">${bbsPost.title}</td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>作者:</td>
                <td width="85%" class="pn-fcontent">${bbsReply.userInfo.nickname}
                    <input type="hidden" id="userId" name="userId" value="${bbsReply.userId}" class="required" readonly="readonly"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>楼层:</td>
                <td width="85%" class="pn-fcontent">${bbsReply.floor}楼</td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布时间:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="publishTime" id="publishTime" class="required" size="35"
                           value="${bbsReply.publishTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">
                </td>
            </tr>
            <%--<tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>更新时间:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="updateTime" id="updateTime" class="required" size="35"
                           value="${bbsReply.updateTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">
                </td>
            </tr>--%>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
                <td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
            </tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="content" cols="100" rows="8"
                              style="width:95%;height:300px;visibility:hidden;">${bbsReply.content}</textarea>
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