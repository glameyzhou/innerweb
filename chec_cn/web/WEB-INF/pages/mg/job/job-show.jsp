<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <base href="${basePath}">
    <script>
        KindEditor.ready(function (K) {
            var editor1 = K.create('textarea[name="requirement"]', {
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
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 招聘岗位 - 内容<c:choose><c:when
                test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/job/job-${opt}.do" id="jvForm" enctype="multipart/form-data">
        <input type="hidden" id="jobId" name="jobId" value="${job.jobId}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>招聘部门:</td>
                <td width="85%" class="pn-fcontent">
                    <select name="categoryId" id="categoryId" class="required">
                        <option value="">请选择</option>
                        <c:forEach var="dept" items="${deptList}">
                            <option value="${dept.id}" <c:if test="${dept.id eq job.categoryId}">selected="selected" </c:if>>${dept.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>职位名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="title" id="title" class="required" size="80"
                           value="${job.title}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>招聘人数:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="person" id="person" class="required" size="80"
                           value="${job.person}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>工作地点:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="address" id="address" class="required" size="80"
                           value="${job.address}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>联系方式:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="contact" id="contact" class="required" size="80"
                           value="${job.contact}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布时间:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="publishTime" id="publishTime" class="required"
                           value='<fmt:formatDate value="${job.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>工作职责:</td>
                <td width="85%" class="pn-fcontent">
                    <textarea rows="5" cols="50" name="responsibility" id="responsibility">${job.responsibility}</textarea>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>任职要求:</td>
                <td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
            </tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="requirement" cols="100" rows="8"
                              style="width:95%;height:300px;visibility:hidden;">${job.requirement}</textarea>
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