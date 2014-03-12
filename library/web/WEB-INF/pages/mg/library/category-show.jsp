<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
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
        <div class="rpos">当前位置: 首页 - ${cateTitle} - 栏目
            <c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/library/category-${opt}.htm" id="jvForm">
        <input type="hidden" id="id" name="id" value="${category.id}"/>
        <input type="hidden" id="pid" name="pid" value="${pid}"/>
        <input type="hidden" id="type" name="type" value="${type}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="name" id="name" class="required" size="80" value="${category.name}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>短名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="shortName" id="shortName" class="required" size="80" value="${category.shortName}">
                </td>
            </tr>
            <c:if test="${!isBBS}">
                <tr>
                    <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否首页显示:</td>
                    <td width="85%" class="pn-fcontent">
                        <input type="radio" name="showIndex" id="showIndex" value="0"
                               <c:if test="${category.showIndex == 0}">checked="checked"</c:if> />否&nbsp;
                        <input type="radio" name="showIndex" id="showIndex" value="1" <c:if test="${category.showIndex == 1}">checked="checked"</c:if> />是&nbsp;
                    </td>
                </tr>
            </c:if>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否显示在树形结构上:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showInTree" id="showInTree" value="0"
                           <c:if test="${category.showInTree == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showInTree" id="showInTree" value="1"
                           <c:if test="${category.showInTree == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>树排列顺序:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="treeOrder" id="treeOrder" class="required" size="80" value="${category.treeOrder}">
                    &nbsp;<font color="red">数字越小越靠前</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>分类排列顺序:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="categoryOrder" id="categoryOrder" class="required" size="80" value="${category.categoryOrder}">
                    &nbsp;<font color="red">数字越小越靠前</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>描述:</td>
                <td width="85%" class="pn-fcontent">
                    <textarea rows="10" cols="50" name="describe" id="describe">${category.describe}</textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="pn-fbutton">
                    <input type="submit" value="提交"> &nbsp; <input type="reset" value="重置">
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>