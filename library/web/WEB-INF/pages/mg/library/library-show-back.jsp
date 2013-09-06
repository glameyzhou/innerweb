<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/front/js/prototype-1.6.0.3.js"></script>
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
        function showCateList(pid) {
            var url = '${basePath}mg/library/getCateListBypid.htm?pid=' + pid;
            alert(url);
            new Ajax.Request(url, {
                        method: 'get',
                        onSuccess: function (transport) {
                            var cateSelect = document.getElementById("categoryId");
                            var responseContent = transport.responseText;
                            alert(responseContent);
                            cateSelect.innerHTML = responseContent;
                        }
                    }
            );
        }
        function showTypeContent(typeId) {
            if(typeId == '' || typeId == '-1'){
                typeId = '1' ;
            }
            if (typeId == '1') {
                dispContent("content1", "block");
                dispContent("content2", "none");
                dispContent("content3", "none");
            }
            else if (typeId == '2') {
                dispContent("content1", "none");
                dispContent("content2", "block");
                dispContent("content3", "none");
            }
            else if (typeId == '3') {
                dispContent("content1", "none");
                dispContent("content2", "none");
                dispContent("content3", "block");
            }
        }
        function dispContent(id, dis) {
            document.getElementById(id).style.display = dis;
        }
        function onPageLoad(typeId) {
            if (typeId == '' || typeId == '-1') {
                typeId = '1';
            }
            alert(typeId);
            showTypeContent(typeId);
            <%--var pid = '${lib.category.id}';--%>
            <%--showCateList(pid);--%>
        }
    </script>
</head>
<body onload="onPageLoad('${lib.type}');">
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 微型图书馆 <c:choose><c:when
                test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose>
        </div>
        <div class="clear"></div>
    </div>
    <form method="POST" action="${basePath}mg/library/library-${opt}.htm" id="jvForm" enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${lib.id}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>分类:</td>
                <td width="85%" class="pn-fcontent">
                    根分类：<select id="pid" name="pid" class="required" onchange="javascript:showCateList(this.value);">
                    <option value="">请选择</option>
                    <c:forEach var="pcate" items="${categoryParentList}">
                        <option value="${pcate.id}">${pcate.name}</option>
                    </c:forEach>
                </select>
                    &nbsp;&nbsp;子分类：<select id="categoryId" name="categoryId" class="required"></select>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>类型:</td>
                <td width="85%" class="pn-fcontent">
                    <select id="type" name="type" class="required" onchange="showTypeContent(this.value);">
                        <option value="1" <c:if test="${lib.type == 1}">selected="selected"</c:if>>正常(名称、URL)</option>
                        <option value="2" <c:if test="${lib.type == 2}">selected="selected"</c:if>>自定义内容(名称、内容)</option>
                        <option value="3" <c:if test="${lib.type == 3}">selected="selected"</c:if>>图片(图片、URL)</option>
                    </select>
                </td>
            </tr>
            <div id="content1" style="display: none;">
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="name" id="name" class="required" size="80"
                           value="${lib.name}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>URL:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="url" id="url" class="required" size="80"
                           value="${lib.url}">
                </td>
            </tr>
            </div>
            <div id="content2" style="display: none;">
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="content" cols="100" rows="8"
                              style="width:95%;height:300px;visibility:hidden;">${lib.content}</textarea>
                </td>
            </tr>
            </div>
            <div id="content3" style="display: none;">
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>链接图片:</td>
                <td width="85%" class="pn-fcontent" id="imageOpr">
                    <c:choose>
                        <c:when test="${opt == 'update'}">
                            <c:choose>
                                <c:when test="${!empty lib.image}">
                                    <img src="${basePath}${lib.image}" width="104"
                                         height="100"/>&nbsp;<a href="javascript:delImage(${lib.id});">删除</a>
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
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>URL:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="urlImage" id="urlImage" class="required" size="80"
                           value="${lib.url}">
                </td>
            </tr>
            </div>
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