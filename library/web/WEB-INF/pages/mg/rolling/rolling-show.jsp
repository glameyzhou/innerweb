<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/front/js/prototype-1.6.0.3.js"></script>
    <base href="${basePath}">
    <script>
        KindEditor.ready(function (K) {
            var editor1 = K.create('textarea[name="content"]', {
                cssPath: '${basePath}kindeditor/plugins/code/prettify.css',
                uploadJson: '${basePath}kindeditor/jsp/upload_json.jsp',
                fileManagerJson: '${basePath}kindeditor/jsp/file_manager_json.jsp',
                allowFileManager: true,
                afterCreate: function () {
                    var self = this;
                    K.ctrl(document, 13, function () {
                        self.sync();
                        document.forms['jvForm'].submit();
                    });
                    K.ctrl(self.edit.doc, 13, function () {
                        self.sync();
                        document.forms['jvForm'].submit();
                    });
                }
            });
            prettyPrint();
        });
        $(function () {
            $("#jvForm").validate();
        });
        function delImage(id) {
            if (!confirm('确认要删除指定图片?'))return;
            var url = '${basePath}mg/rolling/rolling-delImage.htm';
            var pars = 'id=' + id;
            var myAjax = new Ajax.Request(
                    url,
                    {method: 'get', parameters: pars, onComplete: showResponse}
            );
        }
        function showResponse(originalRequest) {
            $('imageOpr').innerHTML = '<input type="file" maxlength="100" name="image" id="image" size="80" value="">';
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
    <title>${categoryParent.name }
    <c:choose>
    <c:when test="${opt == 'update'}">修改</c:when>
        <c:otherwise>添加</c:otherwise>
    </c:choose></title>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - ${categoryParent.name } <c:if
                test="${categoryParent.id eq category.parentId}">- ${category.name} - </c:if> 内容<c:choose><c:when
                test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose>
        </div>
        <div class="clear"></div>
    </div>
    <form method="POST" action="${basePath}mg/rolling/rolling-${opt}.htm" id="jvForm" enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${rolling.id}"/>
        <input type="hidden" id="categoryId" name="categoryId" value="${category.id}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="name" id="name" class="required" size="80"
                           value="${rolling.name}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否有效:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="valid" id="valid" value="0"
                           <c:if test="${rolling.valid == 0}">checked="checked"</c:if> />无效&nbsp;
                    <input type="radio" name="valid" id="valid" value="1"
                           <c:if test="${rolling.valid == 1}">checked="checked"</c:if> />有效&nbsp;
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>图片:</td>
                <td width="85%" class="pn-fcontent" id="imageOpr">
                    <c:choose>
                        <c:when test="${opt == 'update'}">
                            <c:choose>
                                <c:when test="${!empty rolling.image}">
                                    <img src="${basePath}${rolling.image}" width="104"
                                         height="100"/>&nbsp;<a href="javascript:delImage('${rolling.id}');">删除</a>
                                </c:when>
                                <c:otherwise>
                                    <input type="file" maxlength="100" name="image" id="image" size="80" value=""/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <input type="file" maxlength="100" name="image" id="image" size="80" value=""/>
                        </c:otherwise>
                    </c:choose>
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