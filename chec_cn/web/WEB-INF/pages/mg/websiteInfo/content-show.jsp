<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <base href="${basePath}">
    <script>
        KindEditor.ready(function(K) {
            var editor1 = K.create('textarea[name="text"]', {
                cssPath : '${basePath}kindeditor/plugins/code/prettify.css',
                uploadJson : '${basePath}kindeditor/jsp/upload_json.jsp',
                fileManagerJson : '${basePath}kindeditor/jsp/file_manager_json.jsp',
                allowFileManager : true,
                afterCreate : function() {
                    var self = this;
                    K.ctrl(document, 13, function() {
                        self.sync();
                        document.forms['jvForm'].submit();
                    });
                    K.ctrl(self.edit.doc, 13, function() {
                        self.sync();
                        document.forms['jvForm'].submit();
                    });
                }
            });
            prettyPrint();
        });
    </script>
    <script type="text/javascript">
        $(function() {
            $("#jvForm").validate();
        });
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 站外消息 - 消息<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/websiteInfo/content/${opt}.do" id="jvForm">
        <input type="hidden" id="contentId" name="contentId" value="${content.contentId}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="title" id="title" class="required" size="80" value="${content.title}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>来源:</td>
                <td width="85%" class="pn-fcontent">
                    <select id="websiteId" name="websiteId" class="required"  disabled="disabled">
                        <option value="">请选择来源</option>
                        <c:forEach var="websiteInfo" items="${websiteInfoList}">
                            <option value="${websiteInfo.id}" <c:if test="${websiteInfo.isSelf == 1}">selected</c:if> >${websiteInfo.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布人:</td>
                <td width="85%" class="pn-fcontent">
                    <select id="userId" name="userId" class="required">
                        <c:forEach var="userInfo" items="${userInfoList}">
                            <c:choose>
                                <c:when test="${act == 'update'}">
                                    <option value="${userInfo.userId}" <c:if test="${userInfo.userId == content.userId}">selected</c:if> >${userInfo.nickname}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${userInfo.userId}" <c:if test="${userInfo.userId == userId}">selected</c:if> >${userInfo.nickname}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布时间:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="publishTime" id="publishTime" class="required" size="35" value="${content.publishTime}"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
                <td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
            </tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="text" cols="100" rows="8" style="width:95%;height:300px;visibility:hidden;">${content.text}</textarea>
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