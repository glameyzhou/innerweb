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
	function edit(linkId){
		window.location = '${basePath}mg/link/${categoryParent.aliasName}/link-show.htm?linkId='+linkId;
	}
	function del(linkId){
		if(!confirm("确定要删除?")){
			return ;
		}
        var locationURL = "${basePath}mg/link/${categoryParent.aliasName}/link-pageOperate.htm?linkId=" + linkId + "&type=1&flag=1";
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
            var opURL = "${basePath}mg/link/${categoryParent.aliasName}/link-pageOperate.htm?linkId=" + values + "&flag=" + flag + "&type=" + type;
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
			<input type="submit" value="添加" onclick="this.form.action='${basePath}mg/link/${categoryParent.categoryType}/${categoryParent.id}/link-show.htm';">
		</form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/link/${categoryParent.categoryType}/${categoryParent.id}/link-list.htm" method="get" style="padding-top:5px;">
		<div>
			名称、URL&nbsp;<input type="text" name="keyword" id="keyword" value="${keyword}"/>&nbsp;&nbsp;
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('linksId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('linksId',false);">取消</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('linksId','1','1');">删除所选</a>&nbsp;&nbsp;
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
			<c:forEach items="${linkList}" var="link" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="linkId" name="linkId" value="${link.id}"/></td>
				<td title="${link.title}">${fmtString:substringAppend(link.title,35,'')}</td>
				<td align="center">${link.source}</td>
				<td align="center">${link.author}</td>
				<td align=center>${link.category.name}</td>
				<td align=center><c:choose><c:when test="${link.showIndex == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${link.showList == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${link.apply == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${link.focusImage == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center>${link.time}</td>
				<td align=center>
					<a href="javascript:edit('${link.id}');">编辑</a>&nbsp;<a href="javascript:del('${link.id}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/link/${categoryParent.aliasName}/link-list.htm?kw=${fmtString:encoder(query.keyword)}&categoryId=${query.categoryId}&showIndex=${query.showIndex}&showList=${query.showList}&apply=${query.apply}&focusImage=${query.focusImage}&startTime=${fmtString:encoder(query.startTime)}&endTime=${fmtString:encoder(query.endTime)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>