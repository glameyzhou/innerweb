<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="${basePath}"/>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电迷你图书馆-您身边的能源情报站</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/bbs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
</head>
<body>
<div class="box">
    <!--头部代码开始-->
    <%@include file="../include/header.jsp"%>
    <!--头部代码结束-->
    <div class="center">
        <!--左半边代码开始-->
        <div class="center_left">
            <%@include file="../include/post-newest.jsp"%>
            <%@include file="../include/library-category.jsp"%>
            <%@include file="../include/contact.jsp" %>
        </div>
        <!--左半边代码结束-->
        <!--右半边代码开始-->
        <div class="center_right">
            <div class="right-top">
                <input type="hidden" id="categoryId" name="categoryId" value="${categoryId}"/>
                <span class="colorbule"><a href="${basePath}bbs/index.htm">专题讨论区</a></span> >> <a href="${basePath}bbs/brand-${category.id}.htm">${category.name}</a> >> 发表新主题
            </div>
            <div class="right-meitan">
                <div class="right-meitan-tit">
                    <ul style="width:700px;">
                        <li><h2>发新主题</h2></li>
                    </ul>
                </div>
                <div class="right-tiezi-neirong right-paddingtop">
                    <ul>
                        <li>主题：<input name="title" id="title" type="text" class="tiezi-text" style="width: 500px;" <%--onkeyup="javascript:checkInput('title');"--%>/></li>
                        <%--<li id="error_title" style="display: none;color: #ff0000;"></li>--%>
                        <li>
                            <link rel="stylesheet" href="${basePath}kindeditor/themes/default/default.css" />
                            <link rel="stylesheet" href="${basePath}kindeditor/plugins/code/prettify.css" />
                            <script charset="utf-8" src="${basePath}kindeditor/kindeditor.js"></script>
                            <script charset="utf-8" src="${basePath}kindeditor/lang/zh_CN.js"></script>
                            <script charset="utf-8" src="${basePath}kindeditor/plugins/code/prettify.js"></script>
                            <script>
                                KindEditor.ready(function (K) {
                                    K.create('textarea[name="postContent"]', {
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
                                        },
                                        afterBlur: function () {
                                            this.sync();
                                        }
                                    });
                                    prettyPrint();
                                });
                            </script>
                            <textarea name="postContent" id="postContent" style="width:100%;height:300px;visibility:hidden;"></textarea>
                        </li>
                    </ul>
                </div>
                <div class="clear"></div>
                <div class="tiezi-tijiao">
                    <input name="postSubmit" id="postSubmit" type="button" value="发新主题" class="button-click" onclick="javascript:postSubmit();"/>&nbsp;&nbsp;
                </div>
            </div>
        </div>
        <!--右半边代码结束-->
    </div>
    <!--底部代码开始-->
    <%@include file="../include/footer.jsp"%>
    <!--底部代码结束-->
</div>
<script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
<script type="text/javascript">
        var bastPath = '${basePath}';
        var categoryId = '${category.id}';
        /*var isOK = true;
        function checkInput(itemName){
            var title = $("#" + itemName).val();
            if(title == 0 || title.length < 10){
                $("#error_" + itemName).css('display','block');
                $("#error_" + itemName).html("长度必须大于10");
                isOK = false;
            } else{
                $("#error_" + itemName).css('display','none');
                $("#error_" + itemName).html("");
                isOK = true;
            }
        }*/
        function postSubmit(){
            var title = $("#title").val();
            var postContent = $("#postContent").val();
            var errorMsg = '';
            if ($.trim(title).length == 0) {
                errorMsg += '标题不能为空<br/>';
            }
            if ($.trim(postContent).length == 0) {
                errorMsg += '内容不能为空';
            }
            if (errorMsg.length > 0 ) {
                layer.alert(errorMsg, 8);
                return;
            }
            $.ajax({
                type: "post",
                url: bastPath + "bbs/post-submit.htm",
                data: "title=" + encodeURIComponent(title)
                        + "&postContent=" + encodeURIComponent(postContent)
                        + "&categoryId=" + categoryId
                        + "&r=" + Math.random(),
                /*dataType: "json",*/
                async: false,
                success: function (msg) {
                    var returnResult = '';
                    if (typeof(JSON) == 'undefined'){
                        returnResult = eval("(" + msg + ")");
                    }else{
                        returnResult = JSON.parse(msg);
                    }
                    var code = returnResult.pCode;
                    var data = returnResult.pData;
                    if (code == 0) {
                        var postId = returnResult.postId;
                        $.layer({
                            shade : [0.5 , '#000' , true],
                            area : ['auto','auto'],
                            dialog : {
                                msg: data,
                                btns : 1,
                                type : 4,
                                btn : ['查看'],
                                yes : function(){
                                    window.location =  bastPath + 'bbs/post-' + postId + '.htm';
                                }
                            }
                        });
                    } else {
                        layer.alert(data, 8);
                    }
                },
                 error:function(){
                     layer.alert('网络异常，请稍后重试。', 8);
                 }
            });
        }
</script>
</body>
</html>
