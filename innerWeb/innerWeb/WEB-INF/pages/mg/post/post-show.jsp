<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
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
        function delImage(postId) {
            if (!confirm('确认要删除指定图片?'))return;
            var url = '${basePath}mg/post/${categoryParent.aliasName}/post-delImage.htm';
            var pars = 'postId=' + postId;
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
        <div class="rpos">当前位置: 首页 - ${categoryParent.name } - ${category.name} - 内容<c:choose><c:when
                test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/post/${categoryParent.aliasName}/post-${opt}.htm" id="jvForm"
          enctype="multipart/form-data">
        <input type="hidden" id="postId" name="postId" value="${post.id}"/>
        <input type="hidden" id="categoryType" name="categoryType" value="${categoryParent.categoryType}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>栏目:</td>
                <td width="85%" class="pn-fcontent">
                    <%-- <select id="categoryId" name="categoryId" class="required">
                        <option value="">请选择栏目</option>
                        <c:forEach items="${categoryList}" var="cate">
                            <option value="${cate.id}"
                                    <c:if test="${post.categoryId == cate.id}">selected</c:if>>${cate.name}
                                - ${cate.aliasName}</option>
                        </c:forEach>
                    </select> --%>
                    <input id="categoryId" name="categoryId" value="${category.id}" type="hidden"/>
                    ${categoryParent.name} - ${category.name }
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="title" id="title" class="required" size="80"
                           value="${post.title}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布部门:</td>
                <td width="85%" class="pn-fcontent">
                    <%--<select id="source" name="source" class="required">
                        <option value="">请选择栏目</option>
                        <c:forEach items="${deptList}" var="dept">
                            <option value="${dept.id}" <c:if test="${post.source eq dept.id}">selected</c:if>>${dept.name}</option>
                        </c:forEach>
                    </select>--%>
                    <input type="hidden" id="source" name="source" value="${post.source}" />
                    ${post.deptCategory.name}
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">发布人:</td>
                <td width="85%" class="pn-fcontent">
                    <%--<select id="author">
                        <c:forEach var="au" items="${userInfoList}">
                            <c:choose>
                                <c:when test="${isSuper}">
                                    <option value="${au.userId}" <c:if test="${post.author eq au.userId}">selected="selected"</c:if> >${au.nickname}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${au.userId}">${au.nickname}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>--%>
                    <c:choose>
                        <c:when test="${empty post.nickname}">
                            <c:set var="postName" value="${post.userInfo.nickname}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="postName" value="${post.nickname}"/>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${isSuper}">
                            <input type="text" id="nickname" name="nickname" value="${postName}" />(如果为空，默认为当前用户的姓名)
                        </c:when>
                        <c:otherwise>
                            <input type="text" id="nickname" name="nickname" value="${postName}" readonly="readonly"/>
                        </c:otherwise>
                    </c:choose>
                    <input type="hidden" id="author" name="author" value="${post.author}" readonly="readonly"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布时间:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="time" id="time" class="required" size="35"
                           value="${post.time}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否首页显示:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showIndex" id="showIndex" value="0"
                           <c:if test="${post.showIndex == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showIndex" id="showIndex" value="1"
                           <c:if test="${post.showIndex == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否列表显示:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="showList" id="showList" value="0"
                           <c:if test="${post.showList == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="showList" id="showList" value="1"
                           <c:if test="${post.showList == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>
            <c:choose>
            	<c:when test="${noticesPermit == 1 }"><%//需要审核，默认设置为0 %>
	            	<tr style="display: none">
		                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否通过审核:</td>
		                <td width="85%" class="pn-fcontent">
		                   <input type="radio" name="apply" id="apply" value="0"/>
		                </td>
	            	</tr>
            	</c:when>
            	<c:otherwise><%//需要不需要审核，默认设置为1，表名已经审核过 %>
	            	<tr style="display: none">
		                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否通过审核:</td>
		                <td width="85%" class="pn-fcontent">
		                    <input type="radio" name="apply" id="apply" value="1" />已通过审核
		                </td>
	            	</tr>
            	</c:otherwise>
            </c:choose>
            <%--<tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否最新:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="hot" id="hot" value="0"
                           <c:if test="${post.hot == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="hot" id="hot" value="1"
                           <c:if test="${post.hot == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>--%>
            <%--<tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>是否为焦点图片:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="focusImage" id="focusImage" value="0"
                           <c:if test="${post.focusImage == 0}">checked="checked"</c:if> />否&nbsp;
                    <input type="radio" name="focusImage" id="focusImage" value="1"
                           <c:if test="${post.focusImage == 1}">checked="checked"</c:if> />是&nbsp;
                </td>
            </tr>--%>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>摘要描述:</td>
                <td width="85%" class="pn-fcontent">
                    <textarea rows="5" cols="50" name="summary" id="summary">${post.summary}</textarea>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>分类图片:</td>
                <td width="85%" class="pn-fcontent" id="imageOpr">
                    <c:choose>
                        <c:when test="${opt == 'update'}">
                            <c:choose>
                                <c:when test="${!empty post.image}">
                                    <img src="${basePath}${post.image}" width="104"
                                         height="100"/>&nbsp;<a href="javascript:delImage(${post.id});">删除</a>
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
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
                <td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
            </tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="content" cols="100" rows="8"
                              style="width:95%;height:300px;visibility:hidden;">${post.content}</textarea>
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