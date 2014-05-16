<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <base href="${basePath}">
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function edit(contentId){
            window.location = '${basePath}mg/websiteInfo/content/show.do?contentId='+contentId;
        }
        function del(contentId){
            layer.confirm('确定要删除内容信息?', function (index) {
                layer.close(index);
                window.location = '${basePath}mg/websiteInfo/content/del.do?contentId='+contentId;
            });
        }
        function delSel(itemName){
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if(isChecked(itemName) == false ){
                layer.alert('至少选择一项', 8);
            }else{
                layer.confirm('确认要删除指定内容？',function(index){
                    layer.close(index);
                    var values = "";
                    for (var i = 0; i < len; i++) {
                        if (all_checkbox[i].checked)
                            values += "," + all_checkbox[i].value;
                    }
                    if (values.length > 1)
                        values = values.substring(1);
                    window.location = '${basePath}mg/websiteInfocontent/del.do?contentId='+values;
                    window.location = opURL;
                });

            }
        }
        function synch(contentId){
            window.location = '${basePath}mg/websiteInfo/content/showSynch.do?contentId='+contentId;
        }
        function contentSynch(itemName){
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if(isChecked(itemName) == false ){
                layer.alert('至少选择一项', 8);
            }else{
                layer.confirm('确认要同步指定内容？',function(index){
                    layer.close(index);
                    var values = "";
                    for (var i = 0; i < len; i++) {
                        if (all_checkbox[i].checked)
                            values += "," + all_checkbox[i].value;
                    }
                    if (values.length > 1)
                        values = values.substring(1);
                    window.location = '${basePath}mg/websiteInfo/content/showSynch.do?contentId=' + values;
                    window.location = opURL;
                });
            }
        }
        function editForUse(websiteId,contentId){
            layer.confirm('确认要编辑此内容并且进行使用？',function(index){
                layer.close(index);
                window.location = '${basePath}synch/contentInfo/contentReadSend.do?websiteId=' + websiteId + '&contentId=' + contentId;
            });
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 站外消息 - 消息列表</div>
        <form class="ropt">
            <input type="submit" value="添加" onclick="this.form.action='${basePath}mg/websiteInfo/content/show.do';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/websiteInfo/content/list.do" method="get" style="padding-top:5px;">
        <div>
            关键字&nbsp;<input type="text" name="kw" id="kw" value="${content.kw}"/>&nbsp;&nbsp;
            发布人&nbsp;<select name="userId" id="userId">
            <option value="">请选择</option>
            <c:forEach var="userInfo" items="${userInfoList}">
                <option value="${userInfo.userId}" <c:if test="${(content.userId + '') eq userInfo.userId}">selected</c:if> >${userInfo.nickname}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;
            来源&nbsp;<select name="websiteId" id="websiteId">
            <option value="">请选择</option>
            <c:forEach var="website" items="${websiteInfoList}">
                <option value="${website.id}" <c:if test="${content.websiteId == website.id}">selected</c:if> >${website.name}</option>
            </c:forEach>
        </select>
            <input type="submit" value="查询"><br/><br/>
            <a href="javascript:checkAll('contentId',true);">全选</a>&nbsp;&nbsp;
            <a href="javascript:checkAll('contentId',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:contentSynch('contentId');">同步所选</a>&nbsp;&nbsp;
            <a href="javascript:delSel('contentId');">删除所选</a>&nbsp;&nbsp;<br/>
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="5%">标识</th>
                <th>标题</th>
                <th width="10%">来源</th>
                <th width="10%">发布人</th>
                <th width="15%">发布时间</th>
                <th width="8%">编辑采用</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${contentInfoList}" var="content" varStatus="status">
                <tr class="${css}">
                    <td width="5%" align="center"><input type="checkbox" id="contentId" name="contentId" value="${content.contentId}"/></td>
                    <td>${content.title}</td>
                    <td width="10%" align="center">${content.websiteInfo.name}</td>
                    <td width="10%" align="center">
                        <c:if test="${content.websiteInfo.isSelf==1}">${content.userInfo.nickname}</c:if>
                    </td>
                    <td width="15%" align="center">${content.publishTime}</td>
                    <td width="8%" align="center"><a href="javascript:editForUse('${content.websiteId}','${content.contentId}');">编辑采用</a></td>
                    <td width="10%" align="center">
                        <a href="javascript:edit('${content.contentId}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${content.contentId}');">删除</a>&nbsp;&nbsp;
                        <a href="javascript:synch('${content.contentId}');">同步</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL" value="${basePath}mg/websiteInfo/content/list.do?kw=${fmtString:encoder(content.kw)}&userId=${content.userId}&websiteId=${content.websiteId}&"/>
        <%@include file="../../common/pages.jsp"%>
    </form>
</div>
</body>
</html>