<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>系统用户列表</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(userId) {
            window.location = '${basePath}mg/user/user-show.htm?userId=' + userId;
        }
        function del(userId) {
            if (!confirm("确定要删除?")) {
                return;
            }
            window.location = '${basePath}mg/user/user-del.htm?userId=' + userId;
        }
        function resePasswd(userId) {
            if (!confirm("确定要重置密码?")) {
                return;
            }
            window.location = '${basePath}mg/user/user-resetPasswd.htm?userId=' + userId;
        }
        function delAll(itemName){
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if(isChecked(itemName) == false ){
                alert('至少选择一项');
            }else{
                if(!confirm('确认要执行操作?'))return;
                var values = "";
                for(var i=0;i<len ;i++){
                    if(all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if(values.length > 1)
                    values = values.substring(1);
                var opURL = '${basePath}mg/user/user-del.htm?userId=' + values;
                window.location = opURL ;
            }
        }
        function setLive(itemName,flag){
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if(isChecked(itemName) == false ){
                alert('至少选择一项');
            }else{
                if(!confirm('确认要执行操作?'))return;
                var values = "";
                for(var i=0;i<len ;i++){
                    if(all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if(values.length > 1)
                    values = values.substring(1);
                var opURL = '${basePath}mg/user/user-setLive.htm?userId=' + values + '&flag=' + flag;
                window.location = opURL ;
            }
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 系统用户 - 管理</div>
        <form class="ropt">
            <input type="submit" value="添加" onclick="this.form.action='${basePath}mg/user/user-show.htm';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/user/user-list.htm" method="get" style="padding-top:5px;">
        <div>
            <input type="hidden" id="brandId" name="brandId" value="${brandId}"/>
            关键字(姓名、单位、职务)&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
            用户状态&nbsp;<select name="isLive" id="isLive">
            <option value="">请选择</option>
            <option value="0" <c:if test="${query.isLive == 0}">selected="selected" </c:if>>禁用</option>
            <option value="1" <c:if test="${query.isLive == 1}">selected="selected" </c:if>>启用</option>
        </select>&nbsp;&nbsp;
            角色&nbsp;<select name="roleId" id="roleId">
            <option value="">请选择</option>
            <c:forEach var="role" items="${roleInfoList}">
            <option value="${role.roleId}" <c:if test="${query.roleId == role.roleId}">selected="selected" </c:if>>${role.roleName}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;<br/>
        注册开始时间&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.startTime}"
                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
        注册结束时间&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.endTime}"
                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('userId',true);">全选</a>&nbsp;&nbsp;<a href="javascript:checkAll('userId',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:delAll('userId');">删除所选</a>&nbsp;&nbsp;
            <a href="javascript:setLive('userId','0');">禁用所选</a>&nbsp;&nbsp;
            <a href="javascript:setLive('userId','1');">开启所选</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="3%">&nbsp;</th>
                <th width="7%">用户名</th>
                <th width="7%">真实姓名</th>
                <th width="5%">用户状态</th>
                <th>单位</th>
                <th width="10%">手机号</th>
                <th width="10%">固话</th>
                <th width="15%">邮箱</th>
                <th width="7%">注册时间</th>
                <th  width="20%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${userInfoList}" var="user" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="userId" name="userId" value="${user.userId}"/></td>
                    <td align="center">${user.username}</td>
                    <td align=center>${user.nickname}</td>
                    <td align=center>
                        <c:if test="${user.isLive == 1}">启用</c:if>
                        <c:if test="${user.isLive == 0}">禁用</c:if>
                    </td>
                    <td align=center>${user.company}</td>
                    <td align=center>${user.mobile}</td>
                    <td align=center>${user.phone}</td>
                    <td align=center>${user.email}</td>
                    <td align=center><fmt:formatDate value="${user.time}" type="both"/></td>
                    <td align=center>
                        <a href="javascript:edit('${user.userId}');">编辑</a>&nbsp;
                        <a href="javascript:del('${user.userId}');">删除</a>&nbsp;
                        <a href="${basePath}mg/user/user-detail.htm?userId=${user.userId}">详情</a>&nbsp;
                        <a href="javascript:resePasswd('${user.userId}');">密码重置</a>&nbsp;
                        <c:if test="${not empty brandId}">
                            <a href="${basePath}mg/bbs/brand-manager-set.htm?brandId=${brandId}&userId=${user.userId}">设置版主</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/user/user-list.htm?keyword=${fmtString:encoder(query.keyword)}&isLive=${query.isLive}&roleId=${query.roleId}&&startTime=${fmtString:encoder(query.startTime)}&endTime=${fmtString:encoder(query.endTime)}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>