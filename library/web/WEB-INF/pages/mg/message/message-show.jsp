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
        function showUsers(deptId) {
            var url = '${basePath}mg/user/getUserByDeptId.htm?deptId=' + deptId;
            new Ajax.Request(url, {
                        method: 'get',
                        onSuccess: function (transport) {
                            var srcUserSelect = document.getElementById("sltSrc");
                            alert(transport.responseText);
                            ${'abc'}.innerHTML = transport.responseText;
                            srcUserSelect.innerHTML = transport.responseText;
                        }
                    }
            );
        }
        function removeItem(){
            var sltSrc=document.getElementById('sltSrc');
            var sltTarget=document.getElementById('sltTarget');
            for(var i=0;i<sltSrc.options.length;i++)
            {
                var tempOption=sltSrc.options[i];
                if(tempOption.selected){
                    sltSrc.removeChild(tempOption);
                    sltTarget.appendChild(tempOption);
                }
            }
        }

        function addItem(){
            var sltSrc=document.getElementById('sltSrc');
            var sltTarget=document.getElementById('sltTarget');
            for(var i=0;i<sltTarget.options.length;i++)
            {
                var tempOption=sltTarget.options[i];
                if(tempOption.selected){
                    sltTarget.removeChild(tempOption);
                    sltSrc.appendChild(tempOption);
                }
            }
        }
    </script>
    <title>站内信添加</title>
</head>
<body>
<p id="abc"></p>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 站内信 - 添加</div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/message/message-create.htm" id="jvForm">
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>接收人:</td>
                <td width="85%" class="pn-fcontent">
                    <table border="0" cellspacing="0" cellpDoAdding="0" align="left">
                        <tr>
                            <td width="45%" align="center" valign="top">
                                <select id="deptId" onchange="javascript:showUsers(this.value);" style="width: 200px;">
                                    <c:forEach var="dto" items="${messageDTOs}">
                                        <option value="${dto.category.id}">${dto.category.name}</option>
                                    </c:forEach>
                                </select><br/>
                                <select id="sltSrc" name="sltSrc" multiple="true"  style="width: 200px;height: 300px;" ondblclick="removeItem();"></select>
                            </td>
                            <td width="10%" align="center">
                                <input name="DoAdd" type="button" value=">>" onclick="removeItem();"><br>
                                <input name="DoDel" type="button" value="<<" onClick="addItem();">
                            </td>
                            <td width="45%" align="center">
                                <br/><br/>
                                <select id="sltTarget" name="sltTarget"  multiple="true"  style="width: 200px;height: 300px;" ondblclick="addItem();"></select>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="title" id="title" size="80" value="">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
                <td width="85%" class="pn-fcontent"><span class="pn-frequired">内容不能为空!</span></td>
            </tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="content" cols="100" rows="8"
                              style="width:95%;height:300px;visibility:hidden;"></textarea>
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