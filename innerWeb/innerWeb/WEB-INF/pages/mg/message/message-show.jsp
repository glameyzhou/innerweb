<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<base href="${basePath}">
<script>
	KindEditor.ready(function(K) {
		var editor1 = K.create('textarea[name="content"]', {
			cssPath : '${basePath}kindeditor/plugins/code/prettify.css',
			uploadJson : '${basePath}kindeditor/jsp/upload_json.jsp',
			fileManagerJson : '${basePath}kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : true,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['jvForm'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['jvForm'].submit();
				});
			}
		});
		prettyPrint();
	});
	$(function() {
		$("#jvForm").validate();
	});
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
<title>站内信添加</title>
</head>
<body>
${messageDTOs}
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页 - 站内信 - 添加</div>
		<div class="clear"></div>
	</div>
	<form method="post" action="${basePath}mg/message/message-create.htm" id="jvForm" enctype="multipart/form-data">
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
			<tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>接收人:</td>
                <td width="85%" class="pn-fcontent">
                    <c:forEach var="dto" items="${messageDTOs}">
                        <c:out value="${dto.category.name}" /><br/>
                        <c:forEach var="user" items="${dto.userInfoList}">
                            <c:out value="${user.nickname}" />&nbsp;&nbsp;
                        </c:forEach>
                        <br/>
                    </c:forEach>
                </td>
            </tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="title" id="title" class="required" size="80" value="">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
				<td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
			</tr>
			<tr>
				<td width="100%" class="pn-fcontent" colspan="2" align="center">
					<textarea name="content" cols="100" rows="8" style="width:95%;height:300px;visibility:hidden;"></textarea>
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