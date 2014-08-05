<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <base href="${basePath}">
    <script>
        KindEditor.ready(function (K) {
            var editor1 = K.create('textarea[name="summary"]', {
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
            var url = '${basePath}mg/periodical/periodical-delImage.htm';
            var pars = 'id=' + id;
            new Ajax.Request(
                    url,
                    {
                        method: 'get',
                        parameters: pars,
                        onComplete: showResponse
                    }
            );
        }
        function showResponse(originalRequest) {
            $('imageOpr').innerHTML = '<input type="file" maxlength="100" name="image" id="image" size="80" value="">';
        }
        function getPeriodicalMax(obj) {
            var url = '${basePath}mg/periodical/getMax.do';
            var pars = 'title=' + obj;
            new Ajax.Request(
                    url,
                    {
                        method: 'post',
                        parameters: pars,
                        onComplete: function(resp){
                            var result = resp.responseText;
                            var y = result.split(",")[0];
                            var p = result.split(",")[1];
                            var pa = result.split(",")[2];
                            document.getElementById("years").value = y;
                            document.getElementById("periodical").value = p;
                            document.getElementById("periodicalAll").value = pa;
                        }
                    }
            );
        }
    </script>
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${basePath}res/jeecms/js/prototype-1.6.0.3.js"></script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 中国华电工程期刊 - 内容<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/periodical/${opt}.do" id="jvForm" enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${periodical.id}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="title" class="required" size="80"
                           value="${periodical.title}"
                                <c:if test="${opt ne 'update'}">onblur="getPeriodicalMax(this.value);"</c:if>
                            />

                    <br/><font style="color: red;">标题内容需要包含"xxxx年"的字样，例如"2014年华电期刊"。<br/>(添加期刊时，会根据标题中的年份自动填充下边三个属性值)</font>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>年份:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="years" id="years" class="digits" min="2000" size="30" value="${periodical.years}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>期刊（第几期）:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="periodical" id="periodical" class="digits" min="1" size="30" value="${periodical.periodical}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>总期刊:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="periodicalAll" id="periodicalAll" class="digits" min="1" size="30" value="${periodical.periodicalAll}">
                </td>
            </tr>
            <c:choose>
                <c:when test="${opt eq 'update'}">
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h">封面图:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="file" name="pdfImage"/>
                            <c:if test="${not empty periodical.images}">
                                &nbsp;&nbsp;&nbsp;<a href="${basePath}${periodical.images}" target="_blank">点击查看大图</a>
                            </c:if>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>封面图:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="file" name="pdfImage" class="required"/>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${opt eq 'update'}">
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h">附件:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="file" name="pdfFile"/>
                            <c:if test="${not empty periodical.filePath}">
                                &nbsp;&nbsp;&nbsp;${periodical.fileName}(${periodical.fileShowSize})
                            </c:if>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>附件:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="file" name="pdfFile" class="required"/>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            <tr><td colspan="2" align="center" style="font-size: 14px;font-weight: bold;">目录内容(非必填项)</td></tr>
            <tr>
                <td width="100%" class="pn-fcontent" colspan="2" align="center">
                    <textarea name="summary" cols="100" rows="8" style="width:95%;height:300px;visibility:hidden;">${periodical.summary}</textarea>
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