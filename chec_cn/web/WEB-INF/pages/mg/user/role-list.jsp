<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>系统角色管理</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(roleId) {
            window.location = '${basePath}mg/user/role-show.do?roleId=' + roleId;
        }
        function del(roleId) {
            layer.confirm('确定要删除？',function(index){
                layer.close(index);
                window.location = '${basePath}mg/user/role-del.do?roleId=' + roleId;
            });
        }
        function detail(roleId) {
            window.location = '${basePath}mg/user/user-list.do?roleId=' + roleId;
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 系统角色 - 管理</div>
        <form class="ropt">
            <input type="submit" value="添加" onclick="this.form.action='${basePath}mg/user/role-show.do';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/user/role-list.do" method="get" style="padding-top:5px;">
        <div>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${keyword}"/>&nbsp;&nbsp
            <input type="submit" value="查询">
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th>名称</th>
                <th>描述</th>
                <th width="10%">时间</th>
                <th width="15%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${roleInfoList}" var="role" varStatus="status">
                <tr>
                    <td align="center">${role.roleName}</td>
                    <td>${role.roleDesc}</td>
                    <td align="center"><fmt:formatDate value="${role.roleTime}" type="both"></fmt:formatDate></td>
                    <td align=center>
                        <a href="javascript:detail('${role.roleId}');">成员</a>&nbsp;&nbsp;
                        <a href="javascript:edit('${role.roleId}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${role.roleId}');">删除</a>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/user/role-list.do?keyword=${fmtString:encoder(query.keyword)}&roleId=${query.roleId}&isLive=${query.isLive}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>