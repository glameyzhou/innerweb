<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>分类栏目管理</title>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<script type="text/javascript">
	$(function() {
		$("#jvForm").validate();
	});
	function edit(id){
		window.location = '${basePath}manager/category/category-show.htm?id='+id;
	}
	function del(cateId){
		if(!confirm("确定要删除此栏目,删除后内容将没有分类?")){
			return ;
		}
		window.location = '${basePath}manager/category/category-del.htm?id='+id;
	}
</script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页  -新闻分类 - 栏目列表 </div>
		<form class="ropt">
			<input type="submit" value="添加" onclick="this.form.action='${basePath}manager/category/category-show.htm';">
		</form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}manager/category/list.htm" method="get" style="padding-top:5px;">
		<div>
			<!-- 语种&nbsp;<select name="languageId" id="languageId">
					<option value="">请选择</option>
					<option value="1" <c:if test="${languageId == 1}" >selected</c:if>>中文</option>
					<option value="2" <c:if test="${languageId == 2}" >selected</c:if>>英文</option>
				</select>
			&nbsp;&nbsp;<input type="submit" value="查询"><br/><br/>-->
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th>序列</th>
				<th>名称</th>
				<th>展现形式</th>
				<th>首页显示</th>
				<th>描述</th>
				<th>操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${categoryList}" var="cate" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="id" name="id" value="${cate.id}"/></td>
				<td align="center">${cate.name}</td>
				<td align="center">${cate.showType}</td>
				<td align=center>${cate.showIndex}</td>
				<td>${cate.desc}</td>
				<td align=center>
					<a href="javascript:edit('${cate.id}');">编辑</a>&nbsp;&nbsp;
					<a href="javascript:del('${cate.id}');">删除</a>&nbsp;&nbsp;
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</form>
</div>
</body>
</html>