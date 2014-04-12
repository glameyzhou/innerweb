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
        function edit(id) {
            window.location = '${basePath}mg/library/library-show.htm?id=' + id;
        }
        function deleteSingle(postId,categoryId) {
            layer.confirm('确定要删除吗？主帖和所有回帖将都被删除。',function(index){
                layer.close(index);
                var opURL = "${basePath}mg/bbs/post-setSelectContent.htm?categoryId=" + categoryId + "&id=" + postId + "&type=delete&itemValue=1&isPersonal=y";
                window.location = opURL;
            });
        }
        /**
        *
        * @param itemName  操作目标选择器名称
        * @param type      操作类型：delete showTop showGreat
        * @param itemValue 更改到到的值
        * @param categoryId 栏目分类ID
         */
        function setSelectContent(itemName,type,itemValue,categoryId) {
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if (isChecked(itemName) == false) {
                layer.alert('至少选择一项', 8);
            } else {
                var msg = '确认要执行操作?';
                if  ( type == 'delete') {
                    msg = '确定要删除吗？主帖和所有回帖将都被删除。';
                } else if (type == 'showTop' && itemValue == 1) {
                    msg = '确定要把所选的主帖设置为置顶吗？';
                }if (type == 'showTop' && itemValue == 0) {
                    msg = '确定要把所选的主帖的置顶取消吗？';
                } else if (type == 'showGreat' && itemValue == 1) {
                    msg = '确定要把所选的主帖设置为精华吗？';
                } else if (type == 'showGreat' && itemValue == 0) {
                    msg = '确定要把所选的主帖的精华取消吗？';
                }
                layer.confirm(msg,function(index){
                    layer.close(index);
                    var values = "";
                    for (var i = 0; i < len; i++) {
                        alert(all_checkbox[i].checked + '  ' + all_checkbox[i].value);
                        if (all_checkbox[i].checked)
                            values += "," + all_checkbox[i].value;
                    }
                    if (values.length > 1)
                        values = values.substring(1);
                    var opURL = "${basePath}mg/bbs/post-setSelectContent.htm?categoryId=" + categoryId + "&id=" + values + "&type=" + type + "&itemValue=" + itemValue;
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
        <div class="rpos">当前位置: 首页 - 论坛 - 个人主帖管理 - 列表</div>
        <%--<form class="ropt">
            <input type="button" value="发布主题" onclick="window.location='${basePath}bbs/post-show.htm?categoryId=${category.id}';">
        </form>--%>
        <div class="clear">
        </div>
    </div>
    <form action="${basePath}mg/bbs/personal/post-list.htm" method="get" style="padding-top:5px;" enctype="multipart/form-data">
        <div>
            <input type="hidden" id="categoryId" name="categoryId" value="${query.categoryId}"/>
            <input type="hidden" id="userId" name="userId" value="${query.userId}"/>
            关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.kw}"/>&nbsp;&nbsp;
            是否置顶&nbsp;<select id="showTop" name="showTop">
                <option value="-1">请选择</option>
                <option value="1" <c:if test="${query.showTop == 1}">selected="selected"</c:if>>是</option>
                <option value="0" <c:if test="${query.showTop == 0}">selected="selected"</c:if>>否</option>
            </select>&nbsp;&nbsp;
            是否精华&nbsp;<select id="showGreat" name="showGreat">
                <option value="-1">请选择</option>
                <option value="1" <c:if test="${query.showGreat == 1}">selected="selected"</c:if>>是</option>
                <option value="0" <c:if test="${query.showGreat == 0}">selected="selected"</c:if>>否</option>
            </select>&nbsp;&nbsp;
            开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.publishStartTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.publishEndTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('postId',true);">全选</a>&nbsp;&nbsp;<a
                href="javascript:checkAll('postId',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:setSelectContent('postId','delete',1,'${category.id}');">删除所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="4%"></th>
                <th>标题</th>
                <th width="8%">作者</th>
                <th width="12%">发布/更新时间</th>
                <th width="4%">置顶</th>
                <th width="4%">精华</th>
                <th width="8%">浏览/回复</th>
                <th width="12%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${bbsPostList}" var="post" varStatus="status">
                <c:choose>
                    <c:when test="${post.postType == 1}">
                        <c:set var="hrefParam" value="?t=isVote"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="hrefParam" value=""/>
                    </c:otherwise>
                </c:choose>
                <tr>
                    <td align="center"><input type="checkbox" id="postId" name="postId" value="${post.id}"/></td>
                    <td align="left"><a href="${basePath}bbs/post-${post.id}.htm${hrefParam}" target="_blank" title="${post.title}">${post.title}</a></td>
                    <td align="center">${post.userInfo.nickname}</td>
                    <td align="center">
                        <fmt:formatDate value="${post.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/><br/>
                        <fmt:formatDate value="${post.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td align="center">
                        <c:if test="${post.showTop == 1 }">是</c:if><c:if test="${post.showTop == 0}">否</c:if>
                    </td>
                    <td align="center">
                        <c:if test="${post.showGreat == 1 }">是</c:if><c:if test="${post.showGreat == 0}">否</c:if>
                    </td>
                    <td align="center">${post.viewCount}/${post.replyCount}</td>
                    <td align="center">
                        <a href="${basePath}mg/bbs/post-show.htm?categoryId=${post.categoryId}&postId=${post.id}&isPersonal=y">编辑</a>&nbsp;
                        <a href="javascript:deleteSingle('${post.id}','${post.categoryId}');">删除</a>&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/bbs/post-list.htm?userId=${query.userId}&categoryId=${query.categoryId}&keyword=${fmtString:encoder(query.kw)}&showTop=${query.showTop}&showGreat=${query.showGreat}&startTime=${fmtString:encoder(query.publishStartTime)}&endTime=${fmtString:encoder(query.publishEndTime)}&"/>
        <%@include file="../../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>