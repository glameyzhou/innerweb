<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>列表</title>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#jvForm").validate();
	});
	function edit(jobId){
        window.location = '${basePath}mg/job/job-show.do?jobId=' + jobId;
    }
	function del(jobId){
        layer.confirm('确定要删除所选的内容吗？',function(index){
            layer.close(index);
            var locationURL = "${basePath}mg/job/job-del.do?jobId=" + jobId;
            window.location = locationURL ;
        });
	}
	function delAll(itemName){
		var all_checkbox = document.getElementsByName(itemName);
		var len = all_checkbox.length;
		if(isChecked(itemName) == false ){
            layer.alert('至少选择一项', 8);
		}else{
            layer.confirm('确认要执行操作？',function(index){
                layer.close(index);
                var values = "";
                for(var i=0;i<len ;i++){
                    if(all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if(values.length > 1)
                    values = values.substring(1);
                var opURL = "${basePath}mg/job/job-del.do?jobId=" + values;
                window.location = opURL ;
            });
		}
	}
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页 - 招聘岗位列表 - 列表</div>
            <form class="ropt">
                <input type="button" value="添加" onclick="window.location='${basePath}mg/job/job-show.do';">
            </form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/job/job-list.do" method="get" style="padding-top:5px;">
		<div>
			关键字&nbsp;<input type="text" name="kw" id="kw" value="${query.kw}"/>&nbsp;&nbsp;
            招聘部门&nbsp;<select name="categoryId" id="categoryId">
					<option value="">请选择</option>
                    <c:forEach var="dept" items="${deptList}">
                        <option value="${dept.id}" <c:if test="${dept.id eq query.categoryId}">selected="selected" </c:if>>${dept.name}</option>
                    </c:forEach>
				</select>&nbsp;&nbsp;
			开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.publishStartTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.publishEndTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('jobId',true);">全选</a>&nbsp;&nbsp;
            <a href="javascript:checkAll('jobId',false);">取消</a>&nbsp;&nbsp;
		    <a href="javascript:delAll('jobId');">删除所选</a>&nbsp;&nbsp;
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>职位名称</th>
				<th width="10%">招聘人数</th>
				<th width="15%">工作地点</th>
				<th width="15%">招聘部门</th>
				<th width="10%">发布时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${jobList}" var="job" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="jobId" name="jobId" value="${job.jobId}"/></td>
				<td title="${job.title}">${fmtString:substringAppend(job.title,35,'')}</td>
                <td align="center">${job.person}</td>
				<td align="center">${job.address}</td>
				<td align="center">${job.category.name}</td>
				<td align=center><fmt:formatDate value="${job.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"  type="both" /></td>
				<td align=center>
					    <a href="javascript:edit('${job.jobId}');">编辑</a>&nbsp;
                        <a href="javascript:del('${job.jobId}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/job/job-list.do?categoryId=${query.categoryId}&kw=${fmtString:encoder(query.kw)}&startTime=${fmtString:encoder(query.publishStartTime)}&endTime=${fmtString:encoder(query.publishEndTime)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>