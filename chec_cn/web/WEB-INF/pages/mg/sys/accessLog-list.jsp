<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>系统日志</title>
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
        var locationURL = "${basePath}mg/post/post-del.htm?postId=" + postId + '&categoryId=${category.id}';
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
            var opURL = "${basePath}mg/post/post-del.htm?postId=" + values + '&categoryId=${category.id}';
            window.location = opURL ;
		}
	}
    function setSelectContent(itemName,category,type,categoryId) {
        var all_checkbox = document.getElementsByName(itemName);
        var len = all_checkbox.length;
        if (isChecked(itemName) == false) {
            alert('至少选择一项');
        } else {
            if (!confirm('确认要执行操作?'))return;
            var values = "";
            for (var i = 0; i < len; i++) {
                if (all_checkbox[i].checked)
                    values += "," + all_checkbox[i].value;
            }
            if (values.length > 1)
                values = values.substring(1);
            var opURL = "${basePath}mg/post/post-setSelectContent.htm?id=" + values + "&category=" + category + "&type=" + type + "&categoryId=" + categoryId;
            window.location = opURL;
        }
    }
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页  - 系统管理 - 访问日志 &nbsp;
            <c:if test="${query.userId > 0}">
                (<font color="red">${userInfo.nickname}</font>)
            </c:if>
        </div>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/sys/accessLog/list.htm" method="get" style="padding-top:5px;">
		<div>
            <input type="hidden" name="userId" id="userId" value="${query.userId}"/>
            <input type="hidden" name="categoryId" id="categoryId" value="${query.categoryId}"/>
			开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.accessStartTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.accessEndTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			<input type="submit" value="查询">
            <c:if test="${query.userId > 0}">
                &nbsp;&nbsp;<input type="button" value="所有人" onclick="javascript:window.location='${basePath}mg/sys/accessLog/list.htm';">
            </c:if>
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="10%">用户</th>
				<th width="10%">单位</th>
                <th width="10%">访问时间</th>
				<th width="10%">栏目分类</th>
				<th width="15%">访问页面URL</th>
				<th>标题</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${accessLogList}" var="log" varStatus="status">
			<tr>
				<%--<td align="center">${log.id}</td>--%>
				<td align="center">
                    <c:if test="${log.userId > 0}">
                        <a href="${basePath}mg/sys/accessLog/list.htm?userId=${log.userId}&categoryId=${query.categoryId}&startTime=${fmtString:encoder(query.accessStartTime)}&endTime=${fmtString:encoder(query.accessEndTime)}">${log.userInfo.nickname}</a>
                    </c:if>
				</td>
				<td align="center">${log.userInfo.company}</td>
				<td align="center"><fmt:formatDate value="${log.accessTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td align="center">${log.category.name}</td>
                <td align="center"><a href="${basePath}${log.pageUrl}" target="_blank">${basePath}${log.pageUrl}</a></td>
				<td title="${log.pageTitle}">${fmtString:substringAppend(log.pageTitle,35,'')}</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/sys/accessLog/list.htm?categoryId=${query.categoryId}&userId=${query.userId}&startTime=${fmtString:encoder(query.accessStartTime)}&endTime=${fmtString:encoder(query.accessEndTime)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>