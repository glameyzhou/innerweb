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
        function delImage(id) {
            if (!confirm('确认要删除指定图片?'))return;
            var url = '${basePath}mg/library/library-delImage.htm';
            var pars = 'id=' + id;
            var myAjax = new Ajax.Request(
                    url,
                    {method: 'get', parameters: pars, onComplete: showResponse}
            );
        }
        function showResponse(originalRequest) {
            $('imageOpr').innerHTML = '<input type="file" maxlength="100" name="image" id="image" size="80" value="">';
        }

        /**
        *  通过父ID获取对应的子分类列表，同时选中对应的子分类
        * @param pid
        * @param cateId
        */
        function showCateList(pid,cateId) {
            var url = '${basePath}mg/library/getCateListBypid.htm?pid=' + pid  + '&cateId=' + cateId;
            new Ajax.Request(url, {
                        method: 'get',
                        onSuccess: function (transport) {
                            var cateSelect = document.getElementById("categoryId");
                            var responseContent = transport.responseText;
//                            alert(responseContent);
                            cateSelect.innerHTML = responseContent;
                        }
                    }
            );
        }
        function showTypeContent(typeId) {
            if (typeId == '' || typeId == '-1') {
                typeId = '1';
            }
            if (typeId == '1') {
                dispContent("content1", "block");
                dispContent("content2", "none");
                dispContent("content3", "none");
                dispContent("showFouceImageDiv", "none");
            }
            else if (typeId == '2') {
                dispContent("content1", "none");
                dispContent("content2", "block");
                dispContent("content3", "none");
                dispContent("showFouceImageDiv", "block");
            }
            else if (typeId == '3') {
                dispContent("content1", "none");
                dispContent("content2", "none");
                dispContent("content3", "block");
                dispContent("showFouceImageDiv", "block");
            }
        }
        function dispContent(id, dis) {
            document.getElementById(id).style.display = dis;
        }
        function onPageLoad(typeId) {
            if (typeId == '' || typeId == '-1') {
                typeId = '1';
            }
            showTypeContent(typeId);
            var pid = '${lib.category.parentId}';
            var cateId = '${lib.category.id}';
//            alert("pid=" + pid + " cateId=" + cateId);
            showCateList(pid,cateId);
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body onload="onPageLoad('${lib.type}');">
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 微型图书馆 <c:choose><c:when
                test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose>
        </div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/library/library-${opt}.htm" id="jvForm" enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${lib.id}"/>

        <p>
            <font color="red">分类&nbsp;&nbsp;&nbsp;&nbsp;</font>
            根分类：<select id="pid" name="pid" onchange="javascript:showCateList(this.value,'');">
                        <option value="">请选择</option>
                        <c:forEach var="pcate" items="${categoryParentList}">
                            <option value="${pcate.id}" <c:if test="${pcate.id eq lib.category.parentId}">selected="selected"</c:if>>${pcate.name}</option>
                        </c:forEach>
                    </select>&nbsp;&nbsp;
            子分类：<select id="categoryId" name="categoryId"></select>
        </p>
        <p>
            <font color="red">是否首页显示</font>
            <select id="showIndex" name="showIndex">
                <option value="1" <c:if test="${lib.showIndex == 1}">selected="selected"</c:if>>是</option>
                <option value="0" <c:if test="${lib.showIndex == 0}">selected="selected"</c:if>>否</option>
            </select>
            <br/><br/>
            <%--<font color="red">最新荐读</font>
            <select id="showSugguest" name="showSugguest">
                <option value="1" <c:if test="${lib.showSugguest == 1}">selected="selected"</c:if>>是</option>
                <option value="0" <c:if test="${lib.showSugguest == 0}">selected="selected"</c:if>>否</option>
            </select>
            <br/><br/>--%>
            <font color="red">排序&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" name="order" id="order" value="${lib.order}"/><font color="red">数字越大越靠前</font>
            <br/><br/>
            <font color="red">时间&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" maxlength="100" name="time" id="time" class="required" size="35"
                   value='<fmt:formatDate value="${lib.time}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                   onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">
            <br/><br/>
            <font color="red">发布人&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" name="author" id="author" value="${lib.author}"/><font color="red">非必须</font>
            <br/><br/>
            <font color="red">来源&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" name="source" id="source" value="${lib.source}"/><font color="red">非必须</font>
        </p>
        <p>
            <font color="red">内容类型</font>
            <select id="type" name="type" onchange="showTypeContent(this.value);">
                <option value="1" <c:if test="${lib.type == 1}">selected="selected"</c:if>>正常(名称、URL)</option>
                <option value="2" <c:if test="${lib.type == 2}">selected="selected"</c:if>>自定义内容(名称、内容)</option>
                <option value="3" <c:if test="${lib.type == 3}">selected="selected"</c:if>>图片(图片、URL)</option>
            </select>
            <br/>
        </p>
        <p id="content1" style="display: none;">
            <font color="red">名称&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" maxlength="100" name="name" id="name" size="80" value="${lib.name}"/><br/><br/>
            <font color="red">URL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" maxlength="100" name="url" id="url" size="80" value="${lib.url}"/>
        </p>
        <p id="showFouceImageDiv" style="display: none;">
            <font color="red">焦点图显示</font>
            <input type="radio" name="showFouceImage" value="1" <c:if test="${lib.showFocusimage == 1}">checked="checked"</c:if> />&nbsp;显示&nbsp;&nbsp;
            <input type="radio" name="showFouceImage" value="0" <c:if test="${lib.showFocusimage == 0}">checked="checked"</c:if> />&nbsp;不显示
            <br/><br/>
        </p>
        <p id="content2" style="display: none;">
            <font color="red">名称&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" maxlength="100" name="contentName" id="contentName" size="80" value="${lib.name}"/><br/><br/>
            <textarea name="content" cols="100" rows="8" style="width:95%;height:300px;visibility:hidden;">${lib.content}</textarea>
        </p>

        <p id="content3" style="display: none;">
            <font color="red">名称&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" maxlength="100" name="imageName" id="imageName" size="80" value="${lib.name}"/><br/><br/>
            <font color="red">URL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <input type="text" maxlength="100" name="urlImage" id="urlImage" size="80" value="${lib.url}">
            <br/><br/>
            <font color="red">图片&nbsp;&nbsp;&nbsp;&nbsp;</font>
            <c:choose>
                <c:when test="${opt == 'update'}">
                    <p id="imageOpr" style="margin-left: 20px;">
                        <c:if test="${!empty lib.image}">
                            <img src="<%--${basePath}--%>${lib.image}" width="104"
                                 height="100"/>&nbsp;<a href="javascript:delImage('${lib.id}');">删除</a>
                        </c:if>
                        <c:if test="${empty lib.image}">
                            <input type="file" maxlength="100" name="image" id="image" size="80" value=""/>
                        </c:if>
                    </p>
                </c:when>
                <c:otherwise>
                    <input type="file" maxlength="100" name="image" id="image" size="80" value=""/>
                </c:otherwise>
            </c:choose>
        </p>
        <p align="left">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="提交"> &nbsp; <input type="reset" value="重置">
        </p>
    </form>
</div>
</body>
</html>