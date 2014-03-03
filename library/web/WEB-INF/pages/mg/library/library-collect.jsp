<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
        function delSelect(itemName) {
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if (isChecked(itemName) == false) {
                layer.alert('至少选择一项', 8);
            } else {
                layer.confirm('确定要删除所选的内容吗？',function(index){
                    layer.close(index);
                    var values = "";
                    for (var i = 0; i < len; i++) {
                        if (all_checkbox[i].checked)
                            values += "," + all_checkbox[i].value;
                    }
                    if (values.length > 1)
                        values = values.substring(1);
                    var opURL = "${basePath}mg/library/library-collect-del.htm?id=" + values ;
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
        <div class="rpos">当前位置: 首页 - 微型图书馆 - 收藏夹</div>
        <form class="ropt">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/library/library-collect.htm" method="get" style="padding-top:5px;">
        <div>
            开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.startTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.endTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('id',true);">全选</a>&nbsp;&nbsp;<a
                href="javascript:checkAll('id',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:delSelect('id');">删除所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="5%">选择框</th>
                <th width="10%">用户</th>
                <th>图书</th>
                <th width="5%">查看</th>
                <th width="15%">收藏时间</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${collectList}" var="collect" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="id" name="id" value="${collect.collectId}"/></td>
                    <td align="center">${collect.userInfo.nickname}</td>
                    <td align="left">
                        <c:if test="${collect.libraryInfo.type == 1 || collect.libraryInfo.type == 3}">
                            <c:set value="${collect.libraryInfo.url}" var="libHref"/>
                        </c:if>
                        <c:if test="${collect.libraryInfo.type == 2}">
                            <c:set value="${basePath}library-detail-${collect.libraryInfo.id}.htm" var="libHref"/>
                        </c:if>
                        <a href="${libHref}" target="_blank">${collect.libraryInfo.name}</a>
                    </td>
                    <td align="center"><a href="${libHref}" target="_blank">查看</a></td>
                    <td align="center"><fmt:formatDate value="${collect.time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td align="center">${lib.category.name}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/library/library-collect.htm?userId=${query.userId}&startTime=${fmtString:encoder(query.startTime)}&endTime=${fmtString:encoder(query.endTime)}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>