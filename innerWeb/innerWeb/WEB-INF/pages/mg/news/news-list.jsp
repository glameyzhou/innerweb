<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>新闻内容列表</title>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<script type="text/javascript">
	$(function() {
		$("#jvForm").validate();
	});
	function edit(newsId){
		window.location = '${basePath}super/news/news-show.do?newsId='+newsId;
	}
	function del(newsId){
		if(!confirm("确定要删除新闻信息?")){
			return ;
		}
		window.location = '${basePath}super/news/news-del.do?newsId='+newsId;
	}
	function delSel(itemName){
		var all_checkbox = document.getElementsByName(itemName);
		var len = all_checkbox.length;
		if(isChecked(itemName) == false ){
			alert('至少选择一项');
		}else{
			if(!confirm('确认要删除指定新闻?'))return;
			var values = "";
			for(var i=0;i<len ;i++){
				if(all_checkbox[i].checked)
					values += "," + all_checkbox[i].value;
			}
			if(values.length > 1)
				values = values.substring(1);
			window.location = '${basePath}super/news/news-del.do?newsId='+values;
		}
	}
	function setIndex(itemName,flag){
		var all_checkbox = document.getElementsByName(itemName);
		var len = all_checkbox.length;
		if(isChecked(itemName) == false ){
			alert('至少选择一项');
		}else{
			if(!confirm('确认要操作指定新闻?'))return;
			var values = "";
			for(var i=0;i<len ;i++){
				if(all_checkbox[i].checked)
					values += "," + all_checkbox[i].value;
			}
			if(values.length > 1)
				values = values.substring(1);
			window.location = '${basePath}super/news/news-setIndex.do?flag='+flag+'&newsId='+values;
		}
	}
	function setList(itemName,flag){
		var all_checkbox = document.getElementsByName(itemName);
		var len = all_checkbox.length;
		if(isChecked(itemName) == false ){
			alert('至少选择一项');
		}else{
			if(!confirm('确认要操作指定新闻?'))return;
			var values = "";
			for(var i=0;i<len ;i++){
				if(all_checkbox[i].checked)
					values += "," + all_checkbox[i].value;
			}
			if(values.length > 1)
				values = values.substring(1);
			window.location = '${basePath}super/news/news-setList.do?flag='+flag+'&newsId='+values;
		}
	}
	function showNewsSynch(newsId){
		window.location = '${basePath}super/news/news-showNewsSynch.do?newsId='+newsId;
	}
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页  - 新闻 - 新闻内容列表</div>
		<form class="ropt">
			<input type="submit" value="添加" onclick="this.form.action='${basePath}super/news/news-show.do';">
		</form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}super/news/news-list.do" method="get" style="padding-top:5px;">
		<div>
			关键字&nbsp;<input type="text" name="kw" id="kw" value="${query.kw}"/>&nbsp;&nbsp;
			<!-- 语种&nbsp;<select name="languageId" id="languageId">
					<option value="">请选择</option>
					<option value="1" <c:if test="${query.languageId == 1}">selected</c:if>>中文</option>
					<option value="2" <c:if test="${query.languageId == 2}">selected</c:if>>英文</option>
				</select>&nbsp;&nbsp;-->
			分类&nbsp;<select name="cateId" id="cateId">
					<option value="">请选择</option>
					<c:forEach var="cate" items="${cateList}">
						<option value="${cate.cateId}" <c:if test="${query.cateId == cate.cateId}">selected</c:if> >${cate.name}</option>
					</c:forEach>				
				</select>&nbsp;&nbsp;
			首页显示&nbsp;<select name="isShowIndex" id="isShowIndex">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.isShowIndex == 0}">selected</c:if>>否</option>
					<option value="1" <c:if test="${query.isShowIndex == 1}">selected</c:if>>是</option>		
				</select>&nbsp;&nbsp;
			列表显示&nbsp;<select name="isShowList" id="isShowList">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.isShowList == 0}">selected</c:if>>否</option>
					<option value="1" <c:if test="${query.isShowList == 1}">selected</c:if>>是</option>		
				</select>&nbsp;&nbsp;
			<!-- 
			置顶&nbsp;<select name="isTop" id="isTop">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.isTop == 0}">selected</c:if>>否</option>
					<option value="1" <c:if test="${query.isTop == 1}">selected</c:if>>是</option>		
				</select>&nbsp;&nbsp;
			 -->		
			开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.startTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.endTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;		
			<input type="submit" value="查询"><br/><br/>
			<a href="javascript:checkAll('newsId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('newsId',false);">取消</a>&nbsp;&nbsp;
			<a href="javascript:delSel('newsId');">删除所选</a>&nbsp;&nbsp;
			<a href="javascript:setIndex('newsId','1');">设置首页显示</a>&nbsp;&nbsp;
			<a href="javascript:setIndex('newsId','0');">取消首页显示</a>&nbsp;&nbsp;
			<a href="javascript:setList('newsId','1');">设置列表页显示</a>&nbsp;&nbsp;
			<a href="javascript:setList('newsId','0');">取消列表页显示</a>&nbsp;&nbsp;
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>标题</th>
				<th>来源</th>
				<th>发布人</th>
				<th width="5%">语种</th>
				<th>栏目</th>
				<th width="5%">首页</th>
				<th width="5%">列表</th>
				<th width="10%">发布时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${newsList}" var="news" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="newsId" name="newsId" value="${news.newsId}"/></td>
				<td title="${news.title}">${fmtString:substringAppend(news.title,35,'')}</td>
				<td align="center">${news.publishFrom}</td>
				<td align="center">${news.author}</td>
				<td align=center>${news.languageInfo.name}</td>
				<td align=center>${news.newsCategory.name}</td>
				<td align=center><c:choose><c:when test="${news.isShowIndex == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${news.isShowList == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center>${news.publishDate}</td>
				<td align=center>
					<a href="javascript:edit('${news.newsId}');">编辑</a>&nbsp;
					<a href="javascript:del('${news.newsId}');">删除</a>&nbsp;
					<a href="javascript:showNewsSynch('${news.newsId}');">同步</a>&nbsp;
					</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}super/news/news-list.do?languageId=${query.languageId}&cateId=${query.cateId}&isShowIndex=${query.isShowIndex}&isShowList=${query.isShowList}&kw=${fmtString:encoder(query.kw)}&startTime=${fmtString:encoder(query.startTime)}&endTime=${fmtString:encoder(query.endTime)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>