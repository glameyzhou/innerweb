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
        function edit(id) {
            window.location = '${basePath}mg/library/library-show.htm?id=' + id;
        }
        function setOrder(id) {
            window.location = '${basePath}mg/library/library-show.htm?id=' + id;
        }
        function del(id) {
            if (!confirm("确定要删除?")) {
                return;
            }
            var locationURL = "${basePath}mg/library/library-del.htm?id=" + id ;
            window.location = locationURL;
        }
        function delSelect(itemName) {
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
                var opURL = "${basePath}mg/library/library-del.htm?id=" + values ;
                //alert(opURL);
                window.location = opURL;
            }
        }
        function move2Cate(itemName) {
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
                var opURL = "${basePath}mg/library/library-move2Cate-show.htm?id=" + values ;
                //alert(opURL);
                window.location = opURL;
            }
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 微型图书馆 - 内容列表</div>
        <form class="ropt">
            <input type="button" value="添加" onclick="javascript:window.location='${basePath}mg/library/library-show.htm';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/library/library-list.htm" method="get" style="padding-top:5px;" enctype="multipart/form-data">
        <div>
        关键字&nbsp;<input type="text" name="keyword" id="keyword" value="${query.keyword}"/>&nbsp;&nbsp;
        是否首页显示&nbsp;<select id="showIndex" name="showIndex">
            <option value="-1">请选择</option>
            <option value="1" <c:if test="${query.showIndex == 1}">selected="selected"</c:if>>显示</option>
            <option value="0" <c:if test="${query.showIndex == 0}">selected="selected"</c:if>>不显示</option>
        </select>&nbsp;&nbsp;
        内容类型&nbsp;<select id="type" name="type">
            <option value="-1">请选择</option>
            <option value="1" <c:if test="${query.type == 1}">selected="selected"</c:if>>正常(名称、URL)</option>
            <option value="2" <c:if test="${query.type == 2}">selected="selected"</c:if>>自定义内容(名称、内容)</option>
            <option value="3" <c:if test="${query.type == 3}">selected="selected"</c:if>>图片(图片、URL)</option>
        </select>&nbsp;&nbsp;
        焦点图&nbsp;<select id="showFocusimage" name="showFocusimage">
            <option value="-1">请选择</option>
            <option value="0" <c:if test="${query.isFocusImage == 0}">selected="selected"</c:if>>否</option>
            <option value="1" <c:if test="${query.isFocusImage == 1}">selected="selected"</c:if>>是</option>
        </select>&nbsp;&nbsp;
        最新荐读&nbsp;<select id="showSugguest" name="showSugguest">
            <option value="-1">请选择</option>
            <option value="0" <c:if test="${query.showSugguest == 0}">selected="selected"</c:if>>否</option>
            <option value="1" <c:if test="${query.showSugguest == 1}">selected="selected"</c:if>>是</option>
        </select>&nbsp;&nbsp;<br/>
        栏目分类&nbsp;<select id="categoryId" name="categoryId">
        <option value="">请选择</option>
        <c:forEach var="cate" items="${children}">
            <c:forEach var="child" items="${cate.children}">
                <option value="${child.id}" <c:if test="${query.categoryId == child.id}">selected="selected"</c:if>>${cate.name} - ${child.name}</option>
            </c:forEach>
        </c:forEach>
        </select>&nbsp;&nbsp;
            <input type="submit" value="查询">
            <br/><br/>
            <a href="javascript:checkAll('id',true);">全选</a>&nbsp;&nbsp;<a
                href="javascript:checkAll('id',false);">取消</a>&nbsp;&nbsp;
            <a href="javascript:delSelect('id');">删除所选</a>&nbsp;&nbsp;
            <a href="javascript:move2Cate('id');">转移到分类</a>&nbsp;&nbsp;
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="3%"></th>
                <th width="3%">排序</th>
                <th width="5%">首页显示</th>
                <th width="7%">类型</th>
                <th width="15%">分类</th>
                <th>名称</th>
                <th>URL</th>
                <th width="7%">发布时间</th>
                <th width="12%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${libraryList}" var="lib" varStatus="status">
                <tr>
                    <td align="center"><input type="checkbox" id="id" name="id" value="${lib.id}"/></td>
                    <td align="center">${lib.order}</td>
                    <td align="center">
                        <c:if test="${lib.showIndex==1}">是</c:if><c:if test="${lib.showIndex==0}">否</c:if>
                    </td>
                    <td align="center">
                        <c:if test="${lib.type == 1}">正常</c:if>
                        <c:if test="${lib.type == 2}">自定义内容</c:if>
                        <c:if test="${lib.type == 3}">图片</c:if>
                    </td>
                    <td align="center">${lib.category.name}</td>
                    <td>${lib.name}</td>
                    <td align="left">
                    	<c:if test="${lib.type ==1 or lib.type == 3}">${lib.url}</c:if>
                    	<c:if test="${lib.type ==2}">${basePath}library-detail-${lib.id}.htm</c:if>
                    </td>
                    <td align="center">
                        <fmt:formatDate value="${lib.time}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td align="center">
                        <a href="javascript:edit('${lib.id}');">编辑</a>&nbsp;
                        <a href="javascript:del('${lib.id}');">删除</a>&nbsp;
                        <a href="javascript:setOrder('${lib.id}');">排序处理</a>&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL"
               value="${basePath}mg/library/library-list.htm?showIndex=${query.showIndex}&categoryId=${query.categoryId}&keyword=${fmtString:encoder(query.keyword)}&type=${query.type}&showSugguest=${query.showSugguest}&"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>