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
        function showUsers(deptId) {
            var url = '${basePath}mg/user/getUserByDeptId.htm?deptId=' + deptId;
            new Ajax.Request(url, {
                        method: 'get',
                        onSuccess: function (transport) {
                            var srcUserSelect = $('srcUserId');
                            srcUserSelect.innerHTML = transport.responseText;
                        }
                    }
            );
        }
    </script>
    <title>站内信添加</title>
</head>
<body onload="onPageLoad();">
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
                                <select id="srcUserId" name="srcUserId" multiple="multiple"  style="width: 200px;height: 300px;">
                                </select>
                            </td>
                            <td width="10%" align="center">
                                <input name="DoAdd" type="button" value=">>" onclick="javascript:DoAdd();"><br>
                                <input name="DoDel" type="button" value="<<" onClick="javascript:DoDel();">
                            </td>
                            <td width="45%" align="center">
                                <br/><br/>
                                <select id="destUserId" name="destUserId"  multiple="multiple"  style="width: 200px;height: 300px;">
                                </select>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="title" id="title" class="required" size="80" value="">
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
<script language="JavaScript">
    var MainSel = document.getElementById("srcUserId");
    var SlaveSel = document.getElementById("destUserId");
    MainSel.ondblclick = DoAdd ;
    SlaveSel.ondblclick = DoDel;
    var Item_org = new Array();
    var this_sel = null;
    for (var i = 0; i < MainSel.options.length; i++) {
        this_sel = MainSel.options[i];
        Item_org.push(new Array(this_sel.value, this_sel.text));
    }
    function DoAdd() {
        alert("asdfadf");
        var this_sel = null;
        for (var i = 0; i < MainSel.options.length; i++) {
            this_sel = MainSel.options[i];
            if (this_sel.selected) {
                SlaveSel.appendChild(this_sel);
                i--;
            }
        }
        sort_Main(SlaveSel);
    }
    function DoDel() {
        var this_sel = null;
        for (var i = 0; i < SlaveSel.options.length; i++) {
            this_sel = SlaveSel.options[i];
            if (this_sel.selected) {
                MainSel.appendChild(this_sel);
                i--;
            }
        }
        sort_Main(MainSel);
    }
    function sort_Main(the_Sel) {
        var this_sel = null;
        for (var i = 0; i < Item_org.length; i++) {
            for (var j = 0; j < the_Sel.options.length; j++) {
                this_sel = the_Sel.options[j];
                if (this_sel.value == Item_org[i][0] && this_sel.text == Item_org[i][1]) {
                    the_Sel.appendChild(this_sel);
                }
            }
        }
    }
    /*window.onload = function () {
        MainSel = srcUserId;
        SlaveSel = select2;
        MainSel.ondblclick = DoAdd;
        SlaveSel.ondblclick = DoDel;
        var this_sel = null;
        for (var i = 0; i < MainSel.options.length; i++) {
            this_sel = MainSel.options[i];
            Item_org.push(new Array(this_sel.value, this_sel.text));
        }
    }*/
</script>
</body>
</html>