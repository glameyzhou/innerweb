<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>${categoryParent.name}列表</title>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#jvForm").validate();
	});
    function edit(id) {
        window.location = '${basePath}mg/periodical/show.do?id=' + id;
    }
    function del(id) {
        layer.confirm('确定要删除所选的内容吗？', function (index) {
            layer.close(index);
            var locationURL = "${basePath}mg/periodical/del.do?id=" + id;
            window.location = locationURL;
        });
    }
    function delAll(itemName) {
        var all_checkbox = document.getElementsByName(itemName);
        var len = all_checkbox.length;
        if (isChecked(itemName) == false) {
            layer.alert('至少选择一项', 8);
        } else {
            layer.confirm('确认要执行操作？', function (index) {
                layer.close(index);
                var values = "";
                for (var i = 0; i < len; i++) {
                    if (all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if (values.length > 1)
                    values = values.substring(1);
                var opURL = "${basePath}mg/periodical/del.do?id=" + values;
                window.location = opURL;
            });
        }
    }
    function setSelectContent(itemName,category,type,categoryId) {
        var all_checkbox = document.getElementsByName(itemName);
        var len = all_checkbox.length;
        if (isChecked(itemName) == false) {
            layer.alert('至少选择一项', 8);
        } else {
            layer.confirm('确认要执行操作？',function(index){
                layer.close(index);
                var values = "";
                for (var i = 0; i < len; i++) {
                    if (all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if (values.length > 1)
                    values = values.substring(1);
                var opURL = "${basePath}mg/periodical/periodical-setSelectContent.do?id=" + values + "&category=" + category + "&type=" + type + "&categoryId=" + categoryId;
                window.location = opURL;
            });
        }
    }
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页 - 中国华电工程期刊 - 列表</div>
            <form class="ropt">
                <input type="button" value="添加" onclick="window.location='${basePath}mg/periodical/show.do';">
            </form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/periodical/list.do" method="get" style="padding-top:5px;">
		<div>
			关键字&nbsp;<input type="text" name="kw" id="kw" value="${query.kw}"/>&nbsp;&nbsp;
			开始年份&nbsp;<input type="text" maxlength="100" name="yearsStart" class="required" size="18" value="${query.yearsStart}" />&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="yearsEnd" class="required" size="18" value="${query.yearsEnd}" />&nbsp;&nbsp;
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('id',true);">全选</a>&nbsp;&nbsp;
            <a href="javascript:checkAll('id',false);">取消</a>&nbsp;&nbsp;
		    <a href="javascript:delAll('id');">删除所选</a>&nbsp;&nbsp;
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%">序列</th>
				<th>标题</th>
				<th width="10%">年份</th>
				<th width="10%">期数</th>
				<th width="10%">总期数</th>
				<%--<th width="10%">发布时间</th>--%>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${list}" var="periodical" varStatus="status">
			<tr>
				<td align="center"><input type="checkbox" id="id" name="id" value="${periodical.id}"/></td>
				<td title="${periodical.title}">${fmtString:substringAppend(periodical.title,35,'')}</td>
                <td align="center">${periodical.years}</td>
				<td align="center">${periodical.periodical}</td>
				<td align="center">${periodical.periodicalAll}</td>
				<%--<td align=center><fmt:formatDate value="${periodical.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
				<td align=center>
					    <a href="javascript:edit('${periodical.id}');">编辑</a>&nbsp;
                        <a href="javascript:del('${periodical.id}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/periodical/list.do?kw=${fmtString:encoder(query.kw)}&yearsStart=${query.yearsStart}&yearEnd=${query.yeasEnd}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>