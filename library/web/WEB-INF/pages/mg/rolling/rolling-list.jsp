<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>${categoryParent.name}列表</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(id,categoryId) {
            window.location = '${basePath}mg/rolling/rolling-show.htm?id=' + id + "&categoryId=" + categoryId;
        }
        function del(id,categoryId) {
            if (!confirm("确定要删除?")) {
                return;
            }
            var locationURL = "${basePath}mg/rolling/rolling-del.htm?id=" + id + "&categoryId=" + categoryId;
            window.location = locationURL;
        }
        function delSelect(itemName,categoryId) {
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
                var opURL = "${basePath}mg/rolling/rolling-del.htm?id=" + values + "&categoryId=" + categoryId;
                alert(opURL);
                window.location = opURL;
            }
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${categoryParent.name} <c:if
                test="${categoryParent.id eq category.parentId}">- ${category.name}</c:if> - 列表
        </div>
        <form class="ropt">
            <input type="button" value="添加"
                   onclick="javascript:window.location='${basePath}mg/rolling/rolling-show.htm?categoryId=${category.id}';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/rolling/rolling-list.htm" method="get" style="padding-top:5px;">
        <div>
            名称&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
            有效性&nbsp;<select id="valid" name="valid">
            <option value="-1">请选择</option>
            <option value="1" <c:if test="${query.valid ==1}">selected="selected" </c:if>>有效</option>
            <option value="0" <c:if test="${query.valid ==0}">selected="selected" </c:if>>无效</option>
        </select>&nbsp;&nbsp;
        <c:choose>
        <c:when test="${categoryParent.id eq category.parentId}">
        分类&nbsp;<select id="categoryId" name="categoryId">
            <option value="-1">请选择</option>
            <c:forEach var="cate" items="${categoryList}">
	            <option value="${cate.id}" <c:if test="${query.categoryId eq cate.id}">selected="selected" </c:if>>${cate.name}</option>
            </c:forEach>
        </select>
        </c:when>
        <c:otherwise>
        <input type="hidden" name="categoryId" id="categoryId" value="${query.categoryId}"/>
        </c:otherwise>
        </c:choose>
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('id',true);">全选</a>&nbsp;&nbsp;<a
                href="javascript:checkAll('id',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:delSelect('id','${category.id}');">删除所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="3%">序列</th>
                <th>名称</th>
                <th width="10%">是否有效</th>
                <th width="10%">发布时间</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${rollingImageInfoList}" var="rolling" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="id" name="id" value="${rolling.id}"/></td>
                    <td title="${rolling.name}">${rolling.name}</td>
                    <td align="center">
                        <c:if test="${rolling.valid == 0}">无效</c:if>
                        <c:if test="${rolling.valid == 1}">有效</c:if>
                    </td>
                    <td align=center>
                        <fmt:formatDate value="${rolling.rollingDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td align=center>
                        <a href="javascript:edit('${rolling.id}','${rolling.category.id}');">编辑</a>&nbsp;<a href="javascript:del('${rolling.id}','${rolling.category.id}');">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/rolling/rolling-list.htm?categoryId=${query.categoryId}&showIndex=${query.valid}&keyword=${fmtString:encoder(query.keyword)}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>