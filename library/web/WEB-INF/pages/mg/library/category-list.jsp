<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        function edit(pid,id) {
            window.location = '${basePath}mg/library/category-show.htm?pid=' + pid + '&id=' + id + '&type=${type}';
        }
        function del(pid,id) {
            layer.confirm('确定要删除此栏目？',function(index){
                layer.close(index);
                window.location = '${basePath}mg/library/category-del.htm?pid=' + pid + '&id=' + id + '&type=${type}';
            });
        }
    </script>
</head>
<body>
<c:choose>
    <c:when test="${type eq 'bbs'}">
        <c:set value="专题讨论区" var="cateTitle"/>
        <c:set value="true" var="isBBS"/>
    </c:when>
    <c:otherwise>
        <c:set value="微型图书馆" var="cateTitle"/>
        <c:set value="false" var="isBBS"/>
    </c:otherwise>
</c:choose>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${cateTitle} <c:if test="${!pid eq '0'}">-${pCategory.name}</c:if> - 分类列表
        </div>
        <form class="ropt">
            <input type="button" value="添加"
                   onclick="window.location = '${basePath}mg/library/category-show.htm?pid=${pid}&type=${type}';">
        </form>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/library/category-list.htm" method="get" style="padding-top:5px;">
        <div></div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <!-- <th>序列</th> -->
                <th>名称</th>
                <th>短名字</th>
                <%--<th>名字引用</th>--%>
                <c:if test="${!isBBS}">
                <th>首页显示</th>
                <th>树形结构显示</th>
                </c:if>
                <th align="center">树排序</th>
                <th align="center">分类排序</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${categoryList}" var="cate" varStatus="status">
                <tr>
                    <%-- <td align="center"><input type="checkbox" id="id" name="id" value="${cate.id}"/></td> --%>
                    <td align="center">${cate.name}</td>
                    <td align=center>${cate.shortName}</td>
                    <%--<td align=center>${cate.aliasName}</td>--%>
                    <c:if test="${!isBBS}">
                        <td align=center>
                            <c:choose>
                                <c:when test="${cate.showIndex == 0}">否</c:when><c:otherwise>是</c:otherwise>
                            </c:choose>
                        </td>
                        <td align=center>
                            <c:choose>
                                <c:when test="${cate.showInTree == 0}">否</c:when><c:otherwise>是</c:otherwise>
                            </c:choose>
                        </td>
                    </c:if>
                    <td align="center">${cate.treeOrder}</td>
                    <td align="center">${cate.categoryOrder}</td>
                    <td align="center">${fmtString:substring(cate.categoryTime,16)}</td>
                    <td align=center>
                        <a href="javascript:edit('${cate.parentId}','${cate.id}');">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del('${cate.parentId}','${cate.id}');">删除</a>&nbsp;&nbsp;
                        <c:if test="${!isBBS}">
                            <c:if test="${pid eq '0'}">
                                <a href="${basePath}mg/library/category-list.htm?pid=${cate.id}">子分类</a>
                            </c:if>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>