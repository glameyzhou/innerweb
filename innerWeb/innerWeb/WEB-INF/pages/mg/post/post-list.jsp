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
	function edit(postId){
		window.location = '${basePath}mg/post/${categoryParent.aliasName}/post-show.htm?postId='+postId;
	}
	function del(postId){
		if(!confirm("确定要删除?")){
			return ;
		}
        var locationURL = "${basePath}mg/post/${categoryParent.aliasName}/post-pageOperate.htm?postId=" + postId + "&type=1&flag=1";
        alert(locationURL);
		window.location = locationURL ;
	}
    /**
    *  页面列操作
    * @param itemName   操作的目标名字
    * @param flag       执行的操作类型：1=设置 0=取消
    * @param type       操作的种类 1=删除 2=设置首页 3=设置列表 4=设置审核 5=设置焦点图
     */
	function pageOperate(itemName,flag,type){
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
            var opURL = "${basePath}mg/post/${categoryParent.aliasName}/post-pageOperate.htm?postId=" + values + "&flag=" + flag + "&type=" + type;
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
		<div class="rpos">当前位置: 首页  - ${categoryParent.name} - ${categoryParent.name}列表</div>
		<form class="ropt">
			<input type="submit" value="添加" onclick="this.form.action='${basePath}mg/post/${categoryParent.aliasName}/post-show.htm';">
		</form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/post/${categoryParent.aliasName}/post-list.htm" method="get" style="padding-top:5px;">
		<div>
			关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
			分类&nbsp;<select name="categoryId" id="categoryId">
					<option value="">请选择</option>
					<c:forEach var="cate" items="${categoryList}">
						<option value="${cate.id}" <c:if test="${query.categoryId == cate.id}">selected="selected" </c:if>>${cate.name}</option>
					</c:forEach>				
				</select>&nbsp;&nbsp;
			首页显示&nbsp;<select name="showIndex" id="showIndex">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.showIndex == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.showIndex == 1}">selected="selected" </c:if>>是</option>
				</select>&nbsp;&nbsp;
			列表显示&nbsp;<select name="showList" id="showList">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.showList == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.showList == 1}">selected="selected" </c:if>>是</option>
				</select>&nbsp;&nbsp;
            是否已审核&nbsp;<select name="apply" id="apply">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.apply == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.apply == 1}">selected="selected" </c:if>>是</option>
				</select>&nbsp;&nbsp;
            焦点图&nbsp;<select name="focusImage" id="focusImage">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.focusImage == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.focusImage == 1}">selected="selected" </c:if>>是</option>
				</select><br/>
			开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.startTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.endTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;		
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('postId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('postId',false);">取消</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('postId','1','1');">删除所选</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('postId','1','2');">设置首页显示</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('postId','0','2');">取消首页显示</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('postId','1','3');">设置列表页显示</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('postId','0','3');">取消列表页显示</a>&nbsp;&nbsp;
            <a href="javascript:pageOperate('postId','1','4');">审核</a>&nbsp;&nbsp;
            <a href="javascript:pageOperate('postId','0','4');">取消审核</a>&nbsp;&nbsp;
            <a href="javascript:pageOperate('postId','1','5');">设置焦点图</a>&nbsp;&nbsp;
            <a href="javascript:pageOperate('postId','0','5');">取消焦点图</a>&nbsp;&nbsp;
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>标题</th>
				<th>来源</th>
				<th>发布人</th>
				<th>栏目</th>
				<th width="5%">首页</th>
				<th width="5%">列表</th>
				<th width="5%">审核</th>
				<th width="5%">焦点图</th>
				<th width="10%">发布时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${postList}" var="post" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="postId" name="postId" value="${post.id}"/></td>
				<td title="${post.title}">${fmtString:substringAppend(post.title,35,'')}</td>
				<td align="center">${post.source}</td>
				<td align="center">${post.author}</td>
				<td align=center>${post.category.name}</td>
				<td align=center><c:choose><c:when test="${post.showIndex == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${post.showList == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${post.apply == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${post.focusImage == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center>${post.time}</td>
				<td align=center>
					<a href="javascript:edit('${post.id}');">编辑</a>&nbsp;<a href="javascript:del('${post.id}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/post/${categoryParent.aliasName}/post-list.htm?kw=${fmtString:encoder(query.keyword)}&categoryId=${query.categoryId}&showIndex=${query.showIndex}&showList=${query.showList}&apply=${query.apply}&focusImage=${query.focusImage}&startTime=${fmtString:encoder(query.startTime)}&endTime=${fmtString:encoder(query.endTime)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>