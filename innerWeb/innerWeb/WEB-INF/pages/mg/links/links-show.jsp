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
	function delImage(linksId){
		if(!confirm('确认要删除指定图片?'))return;
		var url = '${basePath}mg/links/${categoryParent.categoryType}/${categoryParent.id}/links-delImage.htm';
        var pars = 'linksId=' + linksId ;
        var myAjax = new Ajax.Request(
                    url,
                    {method: 'get', parameters: pars, onComplete: showResponse}
        );
    }
    function showResponse(originalRequest){
        $('imageOpr').innerHTML =  '<input type="file" maxlength="100" name="image" id="image" size="80" value="">' ;
    }
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
<title>${categoryParent.name }<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></title>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页 - 入口链接管理  - ${categoryParent.name } - 内容<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
		<div class="clear"></div>
	</div>
	<form method="POST" action="${basePath}mg/links/${categoryParent.categoryType}/${categoryParent.id}/links-${opt}.htm" id="jvForm" enctype="multipart/form-data">
		<input type="hidden" id="linksId" name="linksId" value="${links.id}"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
			<tbody>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="name" id="name" class="required" size="80" value="${links.name}">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>URL:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="url" id="url" class="required" size="80" value="${links.url}">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>链接图片:</td>
				<td width="85%" class="pn-fcontent" id="imageOpr">
					<c:choose>
					<c:when test="${opt == 'update'}">
						<c:choose>
							<c:when test="${!empty links.image}">
								<img src="${basePath}${links.image}" width="104" height="100" />&nbsp;<a href="javascript:delImage(${links.id});">删除</a>
							</c:when>
							<c:otherwise>
								<input type="file" maxlength="100" name="image" id="image" size="80" value="" />
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<input type="file" maxlength="100" name="image" id="image" size="80" value="" />
					</c:otherwise>
					</c:choose>
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