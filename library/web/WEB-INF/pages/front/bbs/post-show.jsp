<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="${basePath}"/>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电图书馆-您身边的能源行业情报秘书</title>
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
            <div class="right-top"><span class="colorbule">综合讨论区</span> >> 煤炭清洁利用 >> 发表新主题</div>
            <div class="right-meitan">
                <div class="right-meitan-tit">
                    <ul style="width:700px;">
                        <li><h2>发新主题</h2></li>
                    </ul>
                </div>
                <div class="right-tiezi-neirong right-paddingtop">
                    <ul>
                        <li>主题：<input name="" type="text" class="tiezi-text" /></li>
                        <li>
                            <link rel="stylesheet" href="${basePath}kindeditor/themes/default/default.css" />
                            <link rel="stylesheet" href="${basePath}kindeditor/plugins/code/prettify.css" />
                            <script charset="utf-8" src="${basePath}kindeditor/kindeditor.js"></script>
                            <script charset="utf-8" src="${basePath}kindeditor/lang/zh_CN.js"></script>
                            <script charset="utf-8" src="${basePath}kindeditor/plugins/code/prettify.js"></script>
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
                            </script>
                            <textarea name="content" style="width:100%;height:300px;visibility:hidden;"></textarea>
                        </li>
                    </ul>
                </div>
                <%--<div class="right-tiezi-neirong noboder right-paddingtop"><b>标签(Tags):</b>(用空格隔开多个标签，最多可填写 5 个)</div>
                <div class="right-tiezi-neirong noboder right-paddingtop">
                    <ul>
                        <li><input name="" type="text" class="tiezi-text" /><input name="" type="button" value="+可用标签" class="button-click" /></li>
                    </ul>
                </div>
                <div class="right-tiezi-neirong noboder right-paddingtop"><b>发帖选项</b></div>
                <div class="right-tiezi-neirong noboder boderdashed right-paddingtop">
                    <ul>
                        <li style="padding-left:0px;"><input name="" type="checkbox" value="" />html代码<br /><input name="" type="checkbox" value="" />[img]代码</li>
                        <li><input name="" type="checkbox" value="" />禁用 网址自动链接<br /><input name="" type="checkbox" value="" />禁用 表情<br /><input name="" type="checkbox" value="" />禁用 论坛代码</li>
                        <li><input name="" type="checkbox" value="" />使用个人签名</li>
                    </ul>
                </div>--%>
                <div class="clear"></div>
                <div class="tiezi-tijiao">
                    <input name="" type="button" value="发新主题" class="button-click"/>&nbsp;&nbsp;
                    <%--<a href="javascript:void(0)"><span class="colorbule">添加附件</span></a>&nbsp;&nbsp;
                    <a href="javascript:void(0)"><span class="colorbule">附件列表</span></a>--%>
                </div>
            </div>


        </div>
        <!--右半边代码结束-->
    </div>
    <!--底部代码开始-->
    <%@include file="../include/footer.jsp"%>
    <!--底部代码结束-->
</div>
</body>
</html>
