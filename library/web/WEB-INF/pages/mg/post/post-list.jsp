<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
	function edit(postId){
		window.location = '${basePath}mg/post/post-show.htm?postId='+postId;
	}
	function del(postId){
		if(!confirm("确定要删除?")){
			return ;
		}
        var locationURL = "${basePath}mg/post/post-del.htm?postId=" + postId;
		window.location = locationURL ;
	}
	function delAll(itemName){
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
            var opURL = "${basePath}mg/post/post-del.htm?postId=" + values;
            window.location = opURL ;
		}
	}
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页  - 咨询公告 - 列表</div>
            <form class="ropt">
                <input type="button" value="添加" onclick="window.location='${basePath}mg/post/post-show.htm';">
            </form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/post/post-list.htm" method="get" style="padding-top:5px;">
		<div>
			关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
            是否有效&nbsp;<select name="isValid" id="isValid">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.isValid == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.isValid == 1}">selected="selected" </c:if>>是</option>
				</select>&nbsp;&nbsp;
			开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.startTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.endTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('postId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('postId',false);">取消</a>&nbsp;&nbsp;
		    <a href="javascript:delAll('postId');">删除所选</a>&nbsp;&nbsp;
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>标题</th>
				<th width="10%">发布人</th>
				<th width="10%">来源</th>
				<th width="5%">是否有效</th>
				<th width="10%">发布时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${postList}" var="post" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="postId" name="postId" value="${post.id}"/></td>
				<td title="${post.title}">${fmtString:substringAppend(post.title,35,'')}</td>
				<td align="center">${post.userInfo.nickname}</td>
				<td align="center">${post.source}</td>
				<td align=center><c:choose><c:when test="${post.isValid == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center>${post.time}</td>
				<td align=center>
					    <a href="javascript:edit('${post.id}');">编辑</a>&nbsp;
                        <a href="javascript:del('${post.id}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/post/post-list.htm?kw=${fmtString:encoder(query.keyword)}&isValid=${query.isValid}&startTime=${fmtString:encoder(query.startTime)}&endTime=${fmtString:encoder(query.endTime)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>