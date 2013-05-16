<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>${categoryParent.name}列表</title>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<script type="text/javascript">
	$(function() {
		$("#jvForm").validate();
	});
	function edit(linksId){
		window.location = '${basePath}mg/links/${categoryParent.categoryType}/links-show.htm?linksId='+linksId;
	}
	function del(linksId){
		if(!confirm("确定要删除?")){
			return ;
		}
        var locationURL = "${basePath}mg/links/${categoryParent.categoryType}/links-del.htm?linksId=" + linksId;
        alert(locationURL);
		window.location = locationURL ;
	}
	function delSelect(itemName){
		var all_checkbox = document.getElementsByName(itemName);
		var len = all_checkbox.length;
		if(isChecked(itemName) == false ){
			alert('至少选择一项');
		}else{
			if(!confirm('确认要执行操作?'))return;
			var values = "";
			for(var i=0;i<len ;i++){
				if(all_checkbox[i].checked)
					values += "," + all_checkbox[i].value;
			}
			if(values.length > 1)
				values = values.substring(1);
            var opURL = "${basePath}mg/links/${categoryParent.categoryType}/links-del.htm?linksId=" + values ;
            alert(opURL);
            window.location = opURL ;
		}
	}
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页   - ${categoryParent.name} - 列表</div>
		<form class="ropt">
			<input type="submit" value="添加" onclick="this.form.action='${basePath}mg/links/${categoryParent.categoryType}/links-show.htm';">
		</form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/links/${categoryParent.categoryType}/links-list.htm" method="get" style="padding-top:5px;">
		<div>
			名称、URL&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('linksId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('linksId',false);">取消</a>&nbsp;&nbsp;
			<a href="javascript:delSelect('linksId');">删除所选</a>&nbsp;&nbsp;
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>名称</th>
				<th>URL</th>
				<th width="5%">排序</th>
				<th width="10%">发布时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${linksList}" var="links" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="linksId" name="linksId" value="${links.id}"/></td>
				<td title="${links.name}">${links.name}</td>
				<td align="left">${links.url}</td>
				<td align="center">${links.order}</td>
				<td align=center>
					<%-- <fmt:formatDate value="${links.latestDate}" type="both"/> --%>
					<fmt:formatDate value="${links.latestDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td align=center>
					<a href="javascript:edit('${links.id}');">编辑</a>&nbsp;<a href="javascript:del('${links.id}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/links/${categoryParent.categoryType}/links-list.htm?keyword=${fmtString:encoder(query.keyword)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>