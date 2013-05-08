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
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 链接管理 - 根列表</div>
        <div class="clear"></div>
    </div>
    <form action="#" method="get" style="padding-top:5px;">
        <div></div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th>名称</th>
                <th>名字引用</th>
                <th>描述</th>
                <th>创建时间</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${categoryList}" var="cate" varStatus="status">
                <tr>
                    <td align="center">${cate.name}</td>
                    <td align=center>${cate.aliasName}</td>
                    <td align=center>${cate.describe}</td>
                    <td>${fmtString:substring(cate.categoryTime,16)}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>