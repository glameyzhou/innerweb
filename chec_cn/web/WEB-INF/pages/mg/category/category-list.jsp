<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(pid,id) {
            window.location = '${basePath}mg/category/category-show.do?pid=' + pid + '&id=' + id + '&type=${type}';
        }
        function del(pid,id) {
            layer.confirm('确定要删除此栏目？<br/>旗下的所有文章将删除.',function(index){
                layer.close(index);
                window.location = '${basePath}mg/category/category-del.do?pid=' + pid + '&id=' + id + '&type=${type}';
            });
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${pCategory.name} - 分类列表
        </div>
        <form class="ropt">
            <input type="button" value="添加"
                   onclick="window.location = '${basePath}mg/category/category-show.do?pid=${pid}&type=${type}';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/category/category-list.htm" method="get" style="padding-top:5px;">
        <div></div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <!-- <th>序列</th> -->
                <th>名称</th>
                <th>短名字</th>
                <%--<th>名字引用</th>--%>
                <th>显示方式</th>
                <%--<th>树形结构显示</th>--%>
                <%--<th align="center">树排序</th>--%>
                <th align="center">分类排序</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${categoryList}" var="cate" varStatus="status">
                <tr>
                    <%-- <td align="center"><input type="checkbox" id="id" name="id" value="${cate.id}"/></td> --%>
                    <td align="center">${cate.name}</td>
                    <td align=center>${cate.shortName}</td>
                    <%--<td align=center>${cate.aliasName}</td>--%>
                    <td align=center><c:choose><c:when test="${cate.showType == 0}">列表显示</c:when><c:otherwise>详情显示</c:otherwise></c:choose></td>
                    <%--<td align=center><c:choose><c:when test="${cate.showIndex == 0}">否</c:when><c:otherwise>是</c:otherwise></c:choose></td>--%>
                    <%--<td align=center><c:choose><c:when test="${cate.showInTree == 0}">否</c:when><c:otherwise>是</c:otherwise></c:choose></td>--%>
                    <%--<td align="center">${cate.treeOrder}</td>--%>
                    <td align="center">${cate.categoryOrder}</td>
                    <td align="center"><fmt:formatDate value="${cate.categoryTime}" type="both"/></td>
                    <td align=center>
                        <a href="javascript:edit('${cate.parentId}','${cate.id}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${cate.parentId}','${cate.id}');">删除</a>&nbsp;&nbsp;
                        <a href="${basePath}mg/category/category-list.do?pid=${cate.id}&type=${cate.categoryType}">子分类</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>