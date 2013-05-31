<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>栏目-${pCategory.name}</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(categoryId) {
            window.location = '${basePath}mg/library/category-show.htm?id=' + categoryId;
        }
        function del(categoryId) {
            if (!confirm("确定要删除此栏目?")) {
                return;
            }
            window.location = '${basePath}mg/library/category-del.htm?categoryId=' + categoryId;
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${pCategory.name} - <c:if test="${!pid eq '0'}">${category.name}</c:if> 分类列表</div>
        <form class="ropt">
            <input type="button" value="添加"
                   onclick="window.location = '${basePath}mg/library/category-show.htm?pid=${pid}&id=${id}';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/library/category-list.htm" method="get" style="padding-top:5px;">
        <div></div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th>序列</th>
                <th>名称</th>
                <th>短名字</th>
                <th>名字引用</th>
                <th>是否首页显示</th>
                <th>排序</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${categoryList}" var="cate" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="id" name="id" value="${cate.id}"/></td>
                    <td align="center">${cate.name}</td>
                    <td align=center>${cate.shortName}</td>
                    <td align=center>${cate.aliasName}</td>
                    <td align=center>
                        <c:choose>
                            <c:when test="${cate.showIndex == 0}">否</c:when><c:otherwise>是</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${cate.categoryOrder}</td>
                    <td align="center">${fmtString:substring(cate.categoryTime,16)}</td>
                    <td align=center>
                        <a href="javascript:edit('${cate.parentId}','${cate.id}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${cate.parentId}','${cate.id}');">删除</a>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>