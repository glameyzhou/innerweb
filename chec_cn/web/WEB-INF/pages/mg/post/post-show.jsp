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
        function delImage(postId) {
            if (!confirm('确认要删除指定图片?'))return;
            var url = '${basePath}mg/post/post-delImage.htm';
            var pars = 'postId=' + postId;
            var myAjax = new Ajax.Request(
                    url,
                    {method: 'get', parameters: pars, onComplete: showResponse}
            );
        }
        function showResponse(originalRequest) {
            $('imageOpr').innerHTML = '<input type="file" maxlength="100" name="image" id="image" size="80" value="">';
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 <c:if test="${not empty pCategory.name}">- ${pCategory.name}</c:if><c:if test="${not empty category.name}">- ${category.name}</c:if> - 内容<c:choose><c:when
                test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/post/post-${opt}.do" id="jvForm" enctype="multipart/form-data">
        <input type="hidden" id="postId" name="postId" value="${post.id}"/>
        <input type="hidden" id="categoryId" name="categoryId" value="${category.id}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="title" id="title" class="required" size="80"
                           value="${post.title}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>来源:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" id="source" name="source" value="${post.source}" class="required"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>发布人:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" name="author" id="author" value="${post.author}">&nbsp;
                    <font color="red">默认为当前用户</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布时间:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="publishTime" id="publishTime" class="required"
                           value='<fmt:formatDate value="${post.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>首页显示:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showIndex" value="0"
                           <c:if test="${post.showIndex == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showIndex" value="1"
                           <c:if test="${post.showIndex == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>列表页显示:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showList" value="0"
                           <c:if test="${post.showList == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showList" value="1"
                           <c:if test="${post.showList == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>焦点图显示:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showFocusImage" value="0"
                           <c:if test="${post.showFocusImage == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showFocusImage" value="1"
                           <c:if test="${post.showFocusImage == 1}">checked="checked"</c:if> />是&nbsp;
                    <font color="red">选中"是"后，会从正文中提取第一张图片作为焦点图</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>摘要描述:</td>
                <td width="85%" class="pn-fcontent">
                    <textarea rows="5" cols="50" name="summary" id="summary">${post.summary}</textarea>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
                <td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
            </tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="content" cols="100" rows="8"
                              style="width:95%;height:300px;visibility:hidden;">${post.content}</textarea>
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