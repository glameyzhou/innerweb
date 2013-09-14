<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function detail(fbId) {
            window.location = "${basePath}mg/feedback/detail.htm?fbId=" + fbId;
        }
        function del(fbId) {
            if (!confirm("确定要删除?")) {
                return;
            }
            var locationURL = "${basePath}mg/feedback/delete.htm?fbId=" + fbId;
            window.location = locationURL;
        }
        /**
         *  页面列操作
         * @param itemName   操作的目标名字
         * @param opFlag      操作的种类 1=删除 2=设置已读 3=设置未读
         */
        function pageOperate(itemName, opFlag) {
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if (isChecked(itemName) == false) {
                alert('至少选择一项');
            } else {
                if (!confirm('确认要执行操作?'))return;
                var values = "";
                for (var i = 0; i < len; i++) {
                    if (all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if (values.length > 1)
                    values = values.substring(1);
                var opURL = "${basePath}mg/feedback/delete.htm?fbId=" + values;
                window.location = opURL;
            }
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 在线留言 - 管理</div>
        <form class="ropt">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/feedback/list.htm" method="get" style="padding-top:5px;">
        <div>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
            开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18"
                           value="${query.startTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18"
                           value="${query.endTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('fbId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('fbId',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:pageOperate('fbId','1');">删除所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="3%">序列</th>
                <th>昵称</th>
                <th>邮箱</th>
                <th width="10%">时间</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${feedBackInfoDaoList}" var="fb" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="fbId" name="fbId" value="${fb.fbId}"/></td>
                    <td>${fb.fbUsername}</td>
                    <td>${fb.fbEmail}</td>
                    <td align=center><fmt:formatDate value="${fb.fbTime}" type="both"/></td>
                    <td align=center>
                        <a href="javascript:detail('${fb.fbId}');">查看</a>&nbsp;
                        <a href="javascript:del('${fb.fbId}');">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/feedback/list.htm?kw=${fmtString:encoder(query.keyword)}&startTime=${fmtString:encoder(query.startTime)}&endTime=${fmtString:encoder(query.endTime)}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>