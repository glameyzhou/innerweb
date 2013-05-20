<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<script type="text/javascript">
	$(function() {
		$("#jvForm").validate();
	});
	function edit(messageId){
		window.location = '${basePath}mg/message/message-show.htm?messageId='+messageId;
	}
    function detail(messageId){
        window.location = "${basePath}mg/message/message-detail.htm?messageId=" + messageId;
    }
	function del(messageId){
		if(!confirm("确定要删除?")){
			return ;
		}
        var locationURL = "${basePath}mg/message/message-pageOperate.htm?messageId=" + messageId + "&opFlat=1";
        alert(locationURL);
		window.location = locationURL ;
	}
    /**
    *  页面列操作
    * @param itemName   操作的目标名字
    * @param opFlag      操作的种类 1=删除 2=设置已读 3=设置未读
     */
	function pageOperate(itemName,opFlag){
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
            var opURL = "${basePath}mg/message/message-pageOperate.htm?messageId=" + values + "&opFlag=" + opFlag;
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
		<div class="rpos">当前位置: 首页  - 站内信 - 管理</div>
		<form class="ropt">
			<input type="submit" value="添加" onclick="this.form.action='${basePath}mg/message/message-show.htm';">
		</form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/message/message-list.htm" method="get" style="padding-top:5px;">
		<div>
			关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
			已读&nbsp;<select name="flag" id="flag">
					<option value="">请选择</option>
					<option value="0" <c:if test="${query.flag == 0}">selected="selected" </c:if>>未读</option>
					<option value="1" <c:if test="${query.flag == 1}">selected="selected" </c:if>>已读</option>
				</select>&nbsp;&nbsp;
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('messageId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('messageId',false);">取消</a>&nbsp;&nbsp;
			<a href="javascript:pageOperate('messageId','1','1');">删除所选</a>&nbsp;&nbsp;
            <a href="javascript:pageOperate('messageId','1','2');">设置已读</a>&nbsp;&nbsp;
            <a href="javascript:pageOperate('messageId','0','3');">取消未读</a>&nbsp;&nbsp;
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>标题</th>
				<th>来源</th>
				<th width="8%">是否已读</th>
				<th width="10%">时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${messageList}" var="msg" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="messageId" name="messageId" value="${msg.id}"/></td>
				<td title="${msg.title}">${fmtString:substringAppend(msg.title,35,'')}</td>
				<td>${msg.from}</td>
				<td align="center">
                    <c:if test="${msg.flag == 0}">未读</c:if>
                    <c:if test="${msg.flag == 1}">已读</c:if>
				</td>
				<td align=center><fmt:formatDate value="${msg.time}" type="both" /></td>
				<td align=center>
					<a href="javascript:detail('${msg.id}');">查看</a>&nbsp;
                    <a href="javascript:del('${msg.id}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/message/message-list.htm?kw=${fmtString:encoder(query.keyword)}&flag=${query.flag}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>