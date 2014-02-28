<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function deleteSingle(replyId,postId,categoryId) {
            if (!confirm('确定要删除吗？')) return;
            var opURL = "${basePath}mg/bbs/reply-setSelectContent.htm?categoryId=" + categoryId + "&replyId=" + replyId + "&postId=" + postId;
            window.location = opURL;
        }
        function setSelectContent(itemName,categoryId) {
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if (isChecked(itemName) == false) {
                alert('至少选择一项');
            } else {
                var msg = '确认要删除操作?';
                if (!confirm(msg)) return;
                var values = "";
                alert(len);
                for (var i = 0; i < len; i++) {
                    alert(all_checkbox[i].checked + '  ' + all_checkbox[i].value);
                    if (all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if (values.length > 1)
                    values = values.substring(1);
                var opURL = "${basePath}mg/bbs/reply-setSelectContent.htm?categoryId=" + categoryId + "&replyId=" + values;
                alert(opURL);
                window.location = opURL;
            }
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 论坛 - ${category.name} - 回复列表</div>
        <form class="ropt">
            <input type="button" value="回帖" onclick="window.location='${basePath}bbs/reply-show.htm?categoryId=${category.id}&postId=${query.postId}';">
        </form>
        <div class="clear">
        </div>
    </div>
    <form action="${basePath}mg/bbs/reply-list.htm" method="get" style="padding-top:5px;">
        <div>
            <input type="hidden" id="postId" name="postId" value="${query.postId}"/>
            <input type="hidden" id="categoryId" name="categoryId" value="${category.id}"/>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.kw}"/>&nbsp;&nbsp;
            开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.publishStartTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.publishEndTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('replyId',true);">全选</a>&nbsp;&nbsp;<a
                href="javascript:checkAll('replyId',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:setSelectContent('replyId','${category.id}');">删除所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="4%"></th>
                <th width="23%">作者</th>
                <th width="23%">发布时间</th>
                <th width="23%">更新时间</th>
                <th width="23%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${bbsReplyList}" var="reply" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="replyId" name="replyId" value="${reply.id}"/></td>
                    <td align="center">${reply.userInfo.nickname}</td>
                    <td align="center"><fmt:formatDate value="${reply.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td align="center"><fmt:formatDate value="${reply.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td align="center">
                        <a href="${basePath}mg/bbs/reply-show.htm?replyId=${reply.id}&categoryId=${category.id}&postId=${reply.postId}">编辑</a>&nbsp;
                        <a href="javascript:deleteSingle('${reply.id}','${reply.postId}','${reply.categoryId}');">删除</a>&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/bbs/reply-list.htm?categoryId=${category.id}&postId=${query.postId}&keyword=${fmtString:encoder(query.kw)}&startTime=${fmtString:encoder(query.publishStartTime)}&endTime=${fmtString:encoder(query.publishEndTime)}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>