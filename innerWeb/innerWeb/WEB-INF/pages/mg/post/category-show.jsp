<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <title>${categoryParent.name}栏目<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></title>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function delImage(categoryId){
    		if(!confirm('确认要删除指定图片?'))return;
    		var url = '${basePath}mg/post/${categoryParent.aliasName}/category-delImage.htm';
            var pars = 'categoryId=' + categoryId ;
            var myAjax = new Ajax.Request(
                        url,
                        {method: 'get', parameters: pars, onComplete: showResponse}
            );
        }
        function showResponse(originalRequest){
            $('imageOpr').innerHTML =  '<input type="file" maxlength="100" name="image" id="image" size="80" value="">' ;
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${categoryParent.name} - 栏目<c:choose><c:when
                test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/post/${categoryParent.aliasName}/category-${opt}.htm" id="jvForm"	enctype="multipart/form-data">
        <input type="hidden" id="categoryId" name="categoryId" value="${category.id}"/>
        <input type="hidden" id="categoryType" name="categoryType" value="${categoryParent.categoryType}"/>
        <input type="hidden" id="parentId" name="parentId" value="${categoryParent.id}"/>
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
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>引用名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="aliasName" id="aliasName" class="required" size="80" value="${category.aliasName}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否首页显示:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showIndex" id="showIndex" value="0" <c:if test="${category.showIndex == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showIndex" id="showIndex" value="1" <c:if test="${category.showIndex == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>分类模式:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showType" id="showType" value="0" <c:if test="${category.showType == 0}">checked="checked"</c:if> />列表形式&nbsp;
                    <input type="radio" name="showType" id="showType" value="1" <c:if test="${category.showType == 1}">checked="checked"</c:if> />内容形式&nbsp;
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>排列顺序:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="categoryOrder" id="categoryOrder" class="required" size="80" value="${category.categoryOrder}">
                    &nbsp;<font color="red">数字越小越靠前</font>
                </td>
            </tr>
            <tr>
				<td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>分类图片:</td>
				<td width="85%" class="pn-fcontent" id="imageOpr">
					<c:choose>
					<c:when test="${opt == 'update'}">
						<c:choose>
							<c:when test="${!empty category.categoryImage}">
								<img src="${basePath}${category.categoryImage}" width="104" height="100" />&nbsp;<a href="javascript:delImage(${category.id});">删除</a>
							</c:when>
							<c:otherwise>
								<input type="file" maxlength="100" name="image" id="image" size="80" value="">
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<input type="file" maxlength="100" name="image" id="image" size="80" value="">
					</c:otherwise>
					</c:choose>
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