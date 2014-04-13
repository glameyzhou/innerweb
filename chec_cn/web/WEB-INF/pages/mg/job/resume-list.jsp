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
	function del(resumeId){
        layer.confirm('确定要删除所选的内容吗？',function(index){
            layer.close(index);
            var locationURL = "${basePath}mg/job/resume-del.do?resumeId=" + resumeId;
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
                var opURL = "${basePath}mg/job/resume-del.do?resumeId=" + values;
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
		<div class="rpos">当前位置: 首页 - 简历管理 - 列表</div>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/job/resume-list.do" method="get" style="padding-top:5px;">
		<div>
			<%--关键字&nbsp;<input type="text" name="kw" id="kw" value="${query.kw}"/>&nbsp;&nbsp;--%>
			开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.startTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.endTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('resumeId',true);">全选</a>&nbsp;&nbsp;
            <a href="javascript:checkAll('resumeId',false);">取消</a>&nbsp;&nbsp;
		    <a href="javascript:delAll('resumeId');">删除所选</a>&nbsp;&nbsp;
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>职位名称</th>
				<th width="5%">姓名</th>
				<th width="5%">性别</th>
				<th width="15%">出生年月</th>
				<th width="15%">邮箱</th>
				<th width="10%">电话</th>
				<th width="10%">投递时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${resumeInfoList}" var="resume" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="resumeId" name="resumeId" value="${resume.resumeId}"/></td>
				<td>
                    <c:choose>
                        <c:when test="${resume.jobInfo != null || not empty resume.jobInfo.title}">
                            <a href="${basePath}mg/job/resume-preview.do?resumeId=${resume.resumeId}" target="_blank" title="查看简历">
                                ${fmtString:substringAppend(resume.jobInfo.title,35,'')}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <sub>岗位已删除</sub>
                        </c:otherwise>
                    </c:choose>
				</td>
                <td align="center">${resume.name}</td>
                <td align="center"><c:if test="${resume.gender == 1}">男</c:if><c:if test="${resume.gender == 2}">女</c:if></td>
				<td align="center">${resume.birthday}</td>
				<td align="center">${resume.email}</td>
				<td align="center">${resume.telephone}</td>
				<td align=center><fmt:formatDate value="${resume.resumeTime}" pattern="yyyy-MM-dd HH:mm:ss"  type="both" /></td>
				<td align=center>
					    <a href="${basePath}mg/job/resume-preview.do?resumeId=${resume.resumeId}" target="_blank">查看</a>&nbsp;
                        <a href="javascript:del('${resume.resumeId}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/job/resume-list.do?kw=${fmtString:encoder(query.kw)}&startTime=${fmtString:encoder(query.startTime)}&endTime=${fmtString:encoder(query.endTime)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>