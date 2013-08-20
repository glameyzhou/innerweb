<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>系统通讯录</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function setOrder(userId, order,index) {
            var orderInput = '<input type="text" name="showOrder" id="showOrder" value="' + order + '" size="2"/><input type="hidden" name="userId" id="userId" value="' + userId + '"/>';
            var orderOperationDiv = document.getElementById("orderOperationDiv_" + index);
            orderOperationDiv.innerHTML = orderInput + '&nbsp;<input type="button" name="orderOperation" id="orderOperation" value="保存" onclick="javascript:saveOrder();"/>';
        }
        function saveOrder() {
            var orderId = document.getElementById("showOrder").value;
            var userId = document.getElementById("userId").value;
            if (orderId != '' && !isNaN(orderId)) {
                window.location = '${basePath}mg/user/setContactOrder.htm?userId=' + userId + '&orderId=' + orderId;
            }
            else {
                alert('必须为数字');
                return;
            }
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 通讯录</div>
        <div class="clear"></div>
    </div>
    <div class="rhead">
        ${contactHeader.value}
    </div>
    <form action="${basePath}mg/user/contact.htm" method="get" style="padding-top:5px;">
        <div>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
            部门&nbsp;<select name="deptId" id="deptId">
            <option value="">请选择</option>
            <c:forEach var="dept" items="${deptInfoList}">
                <option value="${dept.id}"
                        <c:if test="${query.deptId eq dept.id}">selected="selected" </c:if>>${dept.name}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;
            <input type="submit" value="查询">
        </div>
        <table class="pn-ltable"  width="100%" cellspacing="1" cellpadding="0" border="0" id="resultsTable">
            <thead class="pn-lthead">
            <tr>
                <th width="4%">序号</th>
                <th width="7%">姓名</th>
                <th width="16%">部门</th>
                <th width="18%">职务</th>
                <th>电话</th>
                <th width="10%">固话</th>
                <th width="15%">邮箱</th>
                <th width="13%">地址</th>
                <c:if test="${isSuper}">
                    <th>操作</th>
                </c:if>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${userInfoList}" var="user" varStatus="status">
                <tr>
                    <td align=center>${(pageBean.curPage - 1) * pageBean.rowsPerPage +  status.count}</td>
                    <td align=center>${user.nickname}</td>
                    <td align=center>${user.category.name}</td>
                    <td align=center>${user.duties}</td>
                    <td align=center>${user.mobile}</td>
                    <td align=center>${user.phone}</td>
                    <td align=center>${user.email}</td>
                    <td>${user.address}</td>
                    <c:if test="${isSuper}">
                        <td align="center" id="orderOperationDiv_${status.count}">
                            <a href="javascript:setOrder('${user.userId}',${user.showOrder},'${status.count}');">排序</a>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/user/contact.htm?keyword=${fmtString:encoder(query.keyword)}&deptId=${query.deptId}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>
<script src="<%=projectBasePath%>res/common/js/jquery-1.9.0.min.js" type="text/javascript"></script>
<script type="text/javascript">
    var jQuery_1_9 = $.noConflict(true);
    jQuery_1_9(function ($) {
        var $table = $("#resultsTable>tbody");
        var tempTDHtml = $table.find("tr:eq(0)").find("td:eq(2)").text();
        var size = 1;
        var trIndex = 0;
        $("#resultsTable>tbody>tr").each(function (index) {
            if(index>0){
                var $td = $(this).find("td:eq(2)");
                if ($td.text() == tempTDHtml) {
                    $td.remove();
                    size++;
                } else {
                    $table.find("tr:eq(" + trIndex + ")").find("td:eq(2)").attr("rowspan", size);
                    tempTDHtml = $td.text();
                    size = 1;
                    trIndex = index;
                }
            }
            if(index == $table.find("tr").length-1 && size >1){
                $table.find("tr:eq(" + trIndex + ")").find("td:eq(2)").attr("rowspan", size);
            }
        })
    });
</script>