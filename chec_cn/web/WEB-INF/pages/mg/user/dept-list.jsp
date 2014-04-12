<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>栏目-${categoryParent.name}</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(categoryId) {
            window.location = '${basePath}mg/dept/dept-show.htm?categoryId=' + categoryId;
        }
        function del(categoryId) {
            layer.confirm('确定要删除此部门？',function(index){
                layer.close(index);
                window.location = '${basePath}mg/dept/dept-del.htm?categoryId=' + categoryId;
            });
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${categoryParent.name} - 部门列表</div>
        <form class="ropt">
            <input type="button" value="添加" onclick="javascript:window.location='${basePath}mg/dept/dept-show.htm';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/dept/dept-list.htm" method="get" style="padding-top:5px;">
        <div>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
            <input type="submit" value="查询">
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th>部门名称</th>
                <th>旗下成员</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${deptList}" var="cate" varStatus="status">
                <tr>
                    <td align="center">${cate.name}</td>
                    <td align="center"><a href="${basePath}mg/user/user-list.htm?deptId=${cate.id}">详情</a></td>
                    <td align="center">${fmtString:substring(cate.categoryTime,16)}</td>
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