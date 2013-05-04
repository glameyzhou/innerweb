<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
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
</script>
<base href="${basePath}">
<title>新闻内容<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></title>
<script type="text/javascript">
	$(function() {
		$("#jvForm").validate();
	});
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页 - 新闻 - 新闻内容<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
		<div class="clear"></div>
	</div>
	<form method="post" action="${basePath}super/news/news-${opt}.do" id="jvForm">
		<input type="hidden" id="newsId" name="newsId" value="${news.newsId}"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
			<tbody>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>语种:</td>
				<td width="85%" class="pn-fcontent">
					<select id="languageId" name="languageId" class="required"  onfocus="this.languageId=this.selectedIndex;" onchange="this.selectedIndex=this.languageId;">
						<option value="">请选择来源</option>
						<option value="1" <c:if test="${news.languageId == 1}">selected</c:if>>中文</option>
						<option value="2" <c:if test="${news.languageId == 2}">selected</c:if>>英文</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>栏目:</td>
				<td width="85%" class="pn-fcontent">
					<select id="cateId" name="cateId" class="required">
						<option value="">请选择栏目</option>
						<c:forEach items="${cateList}" var="cate">
							<option value="${cate.cateId}"  <c:if test="${news.cateId == cate.cateId}">selected</c:if>>${cate.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="title" id="title" class="required" size="80" value="${news.title}">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>来源:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="publishFrom" id="publishFrom" class="required" size="80" value="${news.publishFrom}">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布人:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="author" id="author" class="required" size="80" value="${news.author}">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布时间:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="publishDate" id="publishDate" class="required" size="35" value="${news.publishDate}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>关键字:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="metaKeyword" id="metaKeyword" size="80" value="${news.metaKeyword}">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>摘要描述:</td>
				<td width="85%" class="pn-fcontent">
					<textarea rows="5" cols="50" name="metaContent" id="metaContent" >${news.metaContent}</textarea>
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
				<td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
			</tr>
			<tr>
				<td width="100%" class="pn-fcontent" colspan="2" align="center">
					<textarea name="content" cols="100" rows="8" style="width:95%;height:300px;visibility:hidden;">${news.content}</textarea>
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