<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
<body><a name="top" id="top"></a><%--锚点--%>
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
        <form>
        <div class="center_right">
            <div class="right-top">
                <span class="colorbule">专题讨论区</span> >> <a href="${basePath}bbs/brand-${category.id}.htm">${category.name}</a> >> ${bbsPost.title}</div>
            <div class="right-meitan">
                <div class="right-meitan-tit tit-height">
                    <ul style="width:700px;">
                        <li><h2>${bbsPost.title}</h2></li>
                        <li style="padding-left:20px;">[<span class="colorju">${bbsPost.viewCount}</span> 查看 / <span class="colorju">${bbsPost.replyCount}</span> 回复 ]</li>
                    </ul>
                    <br /><br /><br />
                    <ul style="width:700px;">
                        <li>
                            <div class="menu menu-left">
                                <ul>
                                    <li><a class="hide" href="javascript:void(0)"></a>
                                        <ul>
                                            <li><a href="javascript:void(0)">只发文字</a></li>
                                            <li><a href="javascript:void(0)">发起投票</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li><a href="javascript:void(0)" ><img src="${basePath}res/front/library/images/right-4.jpg" style="margin-top:10px;"/></a></li>
                    </ul>
                </div>
                <%--楼主--%>
                <div class="right-tiezi-neirong">
                    <ul>
                        <li class="tiezi-mingcheng">
                            <img src="${basePath}res/front/library/images/right-5.jpg" align="absmiddle" style="margin-right:5px;"/>
                                <B style="padding-right:20px;">${bbsPost.userInfo.nickname}</B>
                                <span class="colorhui"><fmt:formatDate value="${bbsPost.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/> | 只看楼主</span>
                        </li>
                        <li class="minheight">${bbsPost.content}
                        </li>
                        <li class="tiezi-huifu">
                            <img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;"/>
                            <span class="colorhui">回复</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#top">TOP</a>
                        </li>
                    </ul>
                </div>
                <%--回帖--%>
                <c:forEach var="reply" items="${bbsReplyList}">
                    <div class="right-tiezi-neirong">
                        <ul>
                            <li class="tiezi-mingcheng">
                                <img src="${basePath}res/front/library/images/right-5.jpg" align="absmiddle" style="margin-right:5px;"/>
                                <B style="padding-right:20px;">${reply.userInfo.nickname}</B>
                                <span class="colorhui"><fmt:formatDate value="${reply.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/> | 只看该用户</span>
                            </li>
                            <li class="minheight">${reply.content}</li>
                            <li class="tiezi-huifu">
                                <img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;"/>
                                <span class="colorhui">回复</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#top">TOP</a>
                            </li>
                        </ul>
                    </div>
                </c:forEach>
                <%--<div class="right-tiezi-neirong">
                    <ul>
                        <li class="tiezi-mingcheng"><img src="${basePath}res/front/library/images/right-5.jpg" align="absmiddle" style="margin-right:5px;"/><b style="padding-right:20px;">何巨</b><span class="colorhui">2012-12-03 12:10 | 只看该用户</span></li>
                        <li class="minheight"><b>回复1# 陈含的帖子</b><br />和我去打野球吧哈哈</li>
                        <li class="tiezi-huifu"><img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;"/><span class="colorhui">回复</span>&nbsp;&nbsp;&nbsp;&nbsp;<img src="${basePath}res/front/library/images/right-7.jpg" align="absmiddle" style="margin-right:5px;"/><span class="colorhui">引用</span>&nbsp;&nbsp;&nbsp;&nbsp;TOP</li>
                    </ul>
                </div>--%>
                <c:set var="pageURL" value="${basePath}bbs/post-${bbsPost.id}.htm?"/>
                <%@include file="../../common/pages-front.jsp" %>
                <div class="tiezi-dibu">
                    <span class="colorbule kuang" onclick="javascript:window.location='${basePath}bbs/brand-${bbsPost.categoryId}.htm';">返回列表</span>
                    <span class="colorbule">上一主题</span>&nbsp;|&nbsp;
                    <span class="colorbule">下一主题</span>
                </div>
                <%--回帖区域--%>
                <div class="tiezi-bianxie">
                    <%--<img src="${basePath}res/front/library/images/right-9.jpg" />--%>
                        <link rel="stylesheet" href="${basePath}kindeditor/themes/default/default.css" />
                        <link rel="stylesheet" href="${basePath}kindeditor/plugins/code/prettify.css" />
                        <script charset="utf-8" src="${basePath}kindeditor/kindeditor.js"></script>
                        <script charset="utf-8" src="${basePath}kindeditor/lang/zh_CN.js"></script>
                        <script charset="utf-8" src="${basePath}kindeditor/plugins/code/prettify.js"></script>
                        <script>
                            KindEditor.ready(function (K) {
                                K.create('textarea[name="content"]', {
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
                        <textarea name="content" style="width:100%;height:250px;visibility:hidden;"></textarea>
                </div>
                <div class="tiezi-tijiao">
                    <input name="" type="button" value="发表回复" class="button-click" />
                </div>
            </div>
        </div>
        </form>
        <!--右半边代码结束-->
    </div>
    <!--底部代码开始-->
    <%@include file="../include/footer.jsp"%>
    <!--底部代码结束-->
</div>
</body>
</html>
