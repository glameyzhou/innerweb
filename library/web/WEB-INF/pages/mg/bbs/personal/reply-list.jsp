<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../../common/tagInclude.jsp" %>
    <%@include file="../../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function deleteSingle(replyId,postId,categoryId) {
            layer.confirm('确定要删除吗',function(index){
                layer.close(index);
                var opURL = "${basePath}mg/bbs/reply-setSelectContent.htm?categoryId=" + categoryId + "&replyId=" + replyId + "&postId=" + postId + "&isPersonal=y";
                window.location = opURL;
            });
        }
        function setSelectContent(itemName,categoryId,postId) {
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if (isChecked(itemName) == false) {
                layer.alert('至少选择一项', 8);
            } else {
                layer.confirm('确认要删除操作？',function(index){
                    layer.close(index);
                    var values = "";
                    for (var i = 0; i < len; i++) {
                        if (all_checkbox[i].checked)
                            values += "," + all_checkbox[i].value;
                    }
                    if (values.length > 1)
                        values = values.substring(1);
                    var opURL = "${basePath}mg/bbs/reply-setSelectContent.htm?categoryId=" + categoryId + "&postId=" + postId + "&replyId=" + values;
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
        <div class="rpos">当前位置: 首页 - 论坛 - 个人回复管理 - 回复列表</div>
        <div class="clear">
        </div>
    </div>
    <form action="${basePath}mg/bbs/personal/reply-list.htm" method="get" style="padding-top:5px;">
        <div>
            关键字(回帖关键字)&nbsp;<input type="text" name="keyword" id="keyword" value="${query.kw}"/>&nbsp;&nbsp;
            是否已删除&nbsp;
            <select name="isDelete" id="isDelete">
                <option value="-1">所有</option>
                <option value="1" <c:if test="${query.isDelete == 1}">selected="selected"</c:if>>是</option>
                <option value="0" <c:if test="${query.isDelete == 0}">selected="selected"</c:if>>否</option>
            </select>&nbsp;&nbsp;
            开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.publishStartTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.publishEndTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('replyId',true);">全选</a>&nbsp;&nbsp;<a
                href="javascript:checkAll('replyId',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:setSelectContent('replyId','${category.id}','${query.postId}');">删除所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="5%"></th>
                <th>主帖标题</th>
                <th width="10%">主帖作者</th>
                <th width="15%">回帖发布时间</th>
                <th width="15%">回帖更新时间</th>
                <th width="5%">楼层</th>
                <th width="10%">是否已删除</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:if test="${fn:length(bbsReplyList) > 0}">
                <c:set var="categoryId" value="${bbsReplyList[0].categoryId}"/>
            </c:if>
            <c:forEach items="${bbsReplyList}" var="reply" varStatus="status">
                <c:set var="replyFloor" value="${(pageBean.curPage - 1) * pageBean.rowsPerPage + (status.index + 2)}"/>
                <c:choose>
                    <c:when test="${reply.postType == 1}">
                        <c:set var="hrefParam" value="?t=isVote"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="hrefParam" value=""/>
                    </c:otherwise>
                </c:choose>
                <tr>
                    <td align="center"><input type="checkbox" id="replyId" name="replyId" value="${reply.id}"/></td>
                    <td align="center"><a href="${basePath}bbs/post-${reply.postId}.htm${hrefParam}" target="_blank" title="${reply.postTitle}">${reply.postTitle}</a></td>
                    <td align="center">${reply.postUserName}</td>
                    <td align="center"><fmt:formatDate value="${reply.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td align="center"><fmt:formatDate value="${reply.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td align="center">${replyFloor}</td>
                    <td align="center">
                        <c:choose>
                            <c:when test="${reply.isDelete == 1}">是</c:when>
                            <c:otherwise>否</c:otherwise>
                        </c:choose>
                    </td>
                    <td align="center">
                        <c:choose>
                            <c:when test="${reply.isDelete == 0}">
                                <a href="${basePath}mg/bbs/reply-show.htm?replyId=${reply.id}&categoryId=${reply.categoryId}&postId=${reply.postId}&isPersonal=y">编辑</a>&nbsp;
                                <a href="javascript:deleteSingle('${reply.id}','${reply.postId}','${reply.categoryId}');">删除</a>&nbsp;
                            </c:when>
                            <c:otherwise>回帖已删除，无法操作</c:otherwise>
                        </c:choose>

                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/bbs/personal/reply-list.htm?keyword=${fmtString:encoder(query.kw)}&startTime=${fmtString:encoder(query.publishStartTime)}&endTime=${fmtString:encoder(query.publishEndTime)}&"/>
        <%@include file="../../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>