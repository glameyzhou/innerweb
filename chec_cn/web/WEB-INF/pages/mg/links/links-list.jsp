<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>${category.name}列表</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(linksId,categoryId) {
            window.location = '${basePath}mg/links/links-show.do?linksId=' + linksId;
        }
        function del(linksId,categoryId) {
            layer.confirm('确定要删除？',function(index){
                layer.close(index);
                var locationURL = "${basePath}mg/links/links-del.do?linksId=" + linksId + "&categoryId=" + categoryId;
                window.location = locationURL;
            });
        }
        function delSelect(itemName,categoryId) {
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
                    var opURL = "${basePath}mg/links/links-del.do?linksId=" + values + "&categoryId=" + categoryId;
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
        <div class="rpos">当前位置: 首页 - 链接管理 - ${category.name} - 列表</div>
        <form class="ropt">
            <input type="button" value="添加" onclick="javascript:window.location='${basePath}mg/links/links-show.do?categoryId=${category.id}';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/links/links-list.do" method="get" style="padding-top:5px;">
        <input type="hidden" name="categoryId" value="${category.id}"/>
        <div>
            名称、URL&nbsp;<input type="text" name="kw" id="keyword" value="${query.kw}"/>&nbsp;&nbsp;
            <%--链接分类&nbsp;<select id="categoryId" name="v">
                <option value="-1">请选择</option>
                    <c:forEach var="cate" items="${categoryList}">
                        <option value="${cate.id}" <c:if test="${cate.id eq query.categoryId}">selected="selected" </c:if>>${cate.name}</option>
                    </c:forEach>
                </select>&nbsp;&nbsp;--%>
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('linksId',true);">全选</a>&nbsp;&nbsp;<a
                href="javascript:checkAll('linksId',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:delSelect('linksId','${category.id}');">删除所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="3%">序列</th>
                <th>名称</th>
                <th>URL</th>
                <th width="5%">排序</th>
                <th width="10%">发布时间</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${linksList}" var="links" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="linksId" name="linksId" value="${links.id}"/></td>
                    <td title="${links.name}">${links.name}</td>
                    <td align="left">${links.url}</td>
                    <td align="center">${links.order}</td>
                    <td align=center><fmt:formatDate value="${links.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td align=center>
                        <a href="javascript:edit('${links.id}','${links.category.id}');">编辑</a>&nbsp;
                        <a href="javascript:del('${links.id}','${links.category.id}');">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/links/links-list.do?categoryId=${query.categoryId}&kw=${fmtString:encoder(query.kw)}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>