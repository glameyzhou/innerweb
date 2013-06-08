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
	function edit(postId,categoryId){
		window.location = '${basePath}mg/post/${categoryParent.aliasName}/post-show.htm?postId='+postId + "&categoryId=" + categoryId;
	}
	function del(postId,categoryId){
		if(!confirm("确定要删除?")){
			return ;
		}
        var locationURL = "${basePath}mg/post/${categoryParent.aliasName}/post-pageOperate.htm?postId=" + postId + "&categoryId=" + categoryId + "&type=1&flag=1";
        alert(locationURL);
		window.location = locationURL ;
	}
    /**
    *  页面列操作
    * @param itemName   操作的目标名字
    * @param flag       执行的操作类型：1=设置 0=取消
    * @param type       操作的种类 1=删除 2=设置首页 3=设置列表 4=设置审核 5=设置焦点图
    * @param categoryId 操作的分类ID
     */
	function pageOperate(itemName,flag,type,categoryId){
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
            var opURL = "${basePath}mg/post/${categoryParent.aliasName}/post-pageOperate.htm?postId=" + values + "&categoryId=" + categoryId + "&flag=" + flag + "&type=" + type;
            window.location = opURL ;
		}
	}
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<c:if test="${categoryParent.aliasName eq 'news'}">
    <c:set value="01_news" var="typeId"/>
</c:if>
<c:if test="${categoryParent.aliasName eq 'notices'}">
    <c:set value="02_notices" var="typeId"/>
</c:if>
<c:set var="createId" value="${typeId}_${category.id}_create"/>
<c:set var="deleteId" value="${typeId}_${category.id}_delete"/>
<c:set var="updateId" value="${typeId}_${category.id}_update"/>
<c:set var="permitId" value="${typeId}_${category.id}_permit"/>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页  - ${categoryParent.name} - ${category.name} - 列表</div>
        <c:if test="${fmtString:hasRightsList(rightsList,createId )}">
            <form class="ropt">
                <input type="button" value="添加" onclick="window.location='${basePath}mg/post/${categoryParent.aliasName}/post-show.htm?categoryId=${category.id}';">
            </form>
        </c:if>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/post/${categoryParent.aliasName}/post-list.htm" method="get" style="padding-top:5px;">
		<div>
			关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
			<%--分类&nbsp;<select name="categoryId" id="categoryId">
					<option value="">请选择</option>
					<c:forEach var="cate" items="${categoryList}">
						<option value="${cate.id}" <c:if test="${query.categoryId == cate.id}">selected="selected" </c:if>>${cate.name}</option>
					</c:forEach>				
				</select>&nbsp;&nbsp;--%>
				<input id="categoryId" name="categoryId" value="${query.categoryId}" type="hidden"/>
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
				<c:if test="${categoryParent.categoryType eq 'notices' }">
          是否已审核&nbsp;<select name="apply" id="apply">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.apply == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.apply == 1}">selected="selected" </c:if>>是</option>
				</select>&nbsp;&nbsp;
				</c:if>
            <c:if test="${categoryParent.categoryType eq 'notices' }">
            焦点图&nbsp;<select name="focusImage" id="focusImage">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.focusImage == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.focusImage == 1}">selected="selected" </c:if>>是</option>
				</select><br/>
             </c:if>
			&nbsp;&nbsp;开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.startTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.endTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;		
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('postId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('postId',false);">取消</a>&nbsp;&nbsp;

            <c:if test="${fmtString:hasRightsList(rightsList,deleteId )}">
			    <a href="javascript:pageOperate('postId','1','1','${category.id}');">删除所选</a>&nbsp;&nbsp;
            </c:if>
			<a href="javascript:pageOperate('postId','1','2','${category.id}');">设置首页显示</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('postId','0','2','${category.id}');">取消首页显示</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('postId','1','3','${category.id}');">设置列表页显示</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('postId','0','3','${category.id}');">取消列表页显示</a>&nbsp;&nbsp;
			<c:if test="${categoryParent.categoryType eq 'notices' }">
                <c:if test="${fmtString:hasRightsList(rightsList,permitId )}">
                    <a href="javascript:pageOperate('postId','1','4','${category.id}');">审核通过</a>&nbsp;&nbsp;
                    <a href="javascript:pageOperate('postId','0','4','${category.id}');">审核未过</a>&nbsp;&nbsp;
                </c:if>
            </c:if>
            <%--<a href="javascript:pageOperate('postId','1','5','${category.id}');">设置焦点图</a>&nbsp;&nbsp;
            <a href="javascript:pageOperate('postId','0','5','${category.id}');">取消焦点图</a>&nbsp;&nbsp;--%>
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>标题</th>
				<th>发布部门</th>
				<th>发布人</th>
				<th>栏目</th>
				<th width="5%">首页</th>
				<th width="5%">列表</th>
				<c:if test="${categoryParent.categoryType eq 'notices' }">
				<th width="5%">审核</th>
				</c:if>
				<%--<th width="5%">焦点图</th>--%>
				<th width="10%">发布时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${postList}" var="post" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="postId" name="postId" value="${post.id}"/></td>
				<td title="${post.title}">${fmtString:substringAppend(post.title,35,'')}</td>
				<td align="center">${post.deptCategory.name}</td>
				<td align="center">${post.userInfo.nickname}</td>
				<td align=center>${post.category.name}</td>
				<td align=center><c:choose><c:when test="${post.showIndex == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${post.showList == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<c:if test="${categoryParent.categoryType eq 'notices' }">
				<td align=center><c:choose><c:when test="${post.apply == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				</c:if>
				<%--<td align=center><c:choose><c:when test="${post.focusImage == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>--%>
				<td align=center>${post.time}</td>
				<td align=center>
                    <c:if test="${fmtString:hasRightsList(rightsList,updateId )}">
					    <a href="javascript:edit('${post.id}','${post.categoryId}');">编辑</a>&nbsp;
                    </c:if>
                    <c:if test="${fmtString:hasRightsList(rightsList,deleteId )}">
                        <a href="javascript:del('${post.id}','${post.categoryId}');">删除</a>
                    </c:if>
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