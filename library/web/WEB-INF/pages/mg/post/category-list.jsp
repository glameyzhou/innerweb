<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>栏目-${categoryParent.name}</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(categoryId) {
            window.location = '${basePath}mg/post/${categoryParent.aliasName}/category-show.htm?categoryId=' + categoryId;
        }
        function del(categoryId) {
            if (!confirm("注意：删除栏目之后\r\n 分类下下的所有文章将无归类\r\n删除完毕，务必修改首页布局设置，以免影响首页布局显示\r\n是否确定?")) {
                return;
            }
            window.location = '${basePath}mg/post/${categoryParent.aliasName}/category-del.htm?categoryId=' + categoryId;
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${categoryParent.name} - 栏目列表</div>
        <form class="ropt">
            <input type="submit" value="添加" onclick="this.form.action='${basePath}mg/post/${categoryParent.aliasName}/category-show.htm';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/post/${categoryParent.aliasName}/category-list.htm" method="get" style="padding-top:5px;">
        <div></div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th>序列</th>
                <th>名称</th>
                <th>短名字</th>
                <th>名字引用</th>
                <th>是否首页显示</th>
                <th>是否列表显示</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${categoryList}" var="cate" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="categoryId" name="categoryId" value="${cate.id}"/>
                    </td>
                    <td align="center">${cate.name}</td>
                    <td align=center>${cate.shortName}</td>
                    <td align=center>${cate.aliasName}</td>
                    <td align=center>
                        <c:choose>
                            <c:when test="${cate.showIndex == 0}">否</c:when><c:otherwise>是</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${cate.showIndex == 0}">否</c:when><c:otherwise>是</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${fmtString:substring(cate.categoryTime,16)}</td>
                    <td align=center>
                        <a href="javascript:edit('${cate.id}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${cate.id}');">删除</a>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>