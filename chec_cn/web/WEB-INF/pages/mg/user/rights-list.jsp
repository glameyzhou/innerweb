<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>功能权限列表</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(rightsId) {
            window.location = '${basePath}mg/user/rights-show.do?rightsId=' + rightsId;
        }
        function del(rightsId) {
            layer.confirm('确定要删除？',function(index){
                layer.close(index);
                window.location = '${basePath}mg/user/rights-del.do?rightsId=' + rightsId;
            });
        }
        function delSel(itemName) {
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
                    var opURL = "${basePath}mg/user/rights-del.do?rightsId=" + values;
                    window.location = opURL;
                });
            }
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 功能权限 - 管理</div>
        <form class="ropt">
            <input type="submit" value="添加" onclick="this.form.action='${basePath}mg/user/rights-show.do';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/user/rights-list.do" method="get" style="padding-top:5px;">
        <div>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${keyword}"/>&nbsp;&nbsp
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('rightsId',true);">全选</a>&nbsp;&nbsp;<a
                href="javascript:checkAll('rightsId',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:delSel('rightsId');">删除所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="3%">序列</th>
                <th>权限名称</th>
                <th>操作点</th>
                <th>描述</th>
                <th width="10%">时间</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${rightsInfoList}" var="rights" varStatus="status">
                <tr>
                    <td align="center">
                        <input type="checkbox" id="rightsId" name="rightsId" value="${rights.rightsId}"/>
                    </td>
                    <td align="center">${rights.rightsName}</td>
                    <td>${rights.rightsValue}</td>
                    <td>${rights.rightsDesc}</td>
                    <td align="center"><fmt:formatDate value="${rights.rightsTime}" type="both"></fmt:formatDate></td>
                    <td align=center>
                        <a href="javascript:edit('${rights.rightsId}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${rights.rightsId}');">删除</a>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/user/rights-list.do?keyword=${fmtString:encoder(keyword)}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>