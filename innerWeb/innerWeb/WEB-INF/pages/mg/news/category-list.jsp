<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>栏目-${categoryDomain.name}</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(categoryId) {
            window.location = '${basePath}mg/${category}/category-show.do?categoryId=' + categoryId;
        }
        function del(categoryId) {
            if (!confirm("确定要删除此栏目,删除后新闻讲没有分类?")) {
                return;
            }
            window.location = '${basePath}mg/${category}/category-del.do?cateId=' + categoryId;
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${categoryDomain.name} - 栏目列表</div>
        <form class="ropt">
            <input type="submit" value="添加" onclick="this.form.action='${basePath}mg/${category}/category-show.do';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/${category}/category-list.do" method="get" style="padding-top:5px;">
        <div></div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th>序列</th>
                <th>语种</th>
                <th>名称</th>
                <th>显示顺序</th>
                <th>描述</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${categoryList}" var="cate" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="cateId" name="cateId" value="${cate.cateId}"/></td>
                    <td align="center">${cate.languageInfo.name}</td>
                    <td align="center">${cate.name}</td>
                    <td align=center>${cate.order}</td>
                    <td>${cate.desc}</td>
                    <td align=center>
                        <a href="javascript:edit('${cate.cateId}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${cate.cateId}');">删除</a>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>