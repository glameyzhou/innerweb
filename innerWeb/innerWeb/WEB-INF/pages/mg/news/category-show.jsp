<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<title>新闻栏目<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></title>
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
		<div class="rpos">当前位置: 首页 - 新闻 - 栏目<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
		<div class="clear"></div>
	</div>
	<form method="post" action="${basePath}super/news/category-${opt}.do" id="jvForm">
		<input type="hidden" id="cateId" name="cateId" value="${cate.cateId}"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
			<tbody>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>语种:</td>
				<td width="85%" class="pn-fcontent">
					<select id="languageId" name="languageId" class="required"  onfocus="this.languageId=this.selectedIndex;" onchange="this.selectedIndex=this.languageId;">
						<option value="">请选择来源</option>
						<option value="1" <c:if test="${cate.languageId == 1}">selected</c:if> >中文</option>
						<option value="2" <c:if test="${cate.languageId == 2}">selected</c:if> >英文</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="name" id="name" class="required" size="80" value="${cate.name}">
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>排列顺序:</td>
				<td width="85%" class="pn-fcontent">
					<input type="text" maxlength="100" name="order" id="order" class="required" size="80" value="${cate.order}">
					&nbsp;<font color="red">数字越小越靠前</font>
				</td>
			</tr>
			<tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>描述:</td>
				<td width="85%" class="pn-fcontent">
					<textarea rows="10" cols="50" name="desc">${cate.desc}</textarea>
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