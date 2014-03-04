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
                <span class="colorbule" style="color: #0099cc;"><a href="${basePath}bbs/index.htm">专题讨论区</a></span> >> <a href="${basePath}bbs/brand-${category.id}.htm">${category.name}</a> >> ${bbsPost.title}</div>
            <div class="right-meitan">
                <div class="right-meitan-tit tit-height">
                    <ul style="width:700px;">
                        <li><h2>${fmtString:substringAppend(bbsPost.title,35 ,'...' )}</h2></li>
                        <li style="padding-left:20px;">[<span class="colorju">${bbsPost.viewCount}</span> 查看 / <span class="colorju">${bbsPost.replyCount}</span> 回复 ]</li>
                    </ul>
                    <br /><br /><br />
                    <ul style="width:700px;">
                        <li>
                            <div class="menu menu-left">
                                <ul>
                                    <li><a class="hide" href="javascript:void(0)"></a>
                                        <ul>
                                            <li><a href="${basePath}bbs/post-${bbsPost.categoryId}-show.htm">只发文字</a></li>
                                            <li><a href="javascript:void(0)">发起投票</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="#replyArea" >
                                <img src="${basePath}res/front/library/images/right-4.jpg" style="margin-top:10px;"/>
                            </a>
                        </li>
                    </ul>
                </div>
                <%--楼主--%>
                <div class="right-tiezi-neirong">
                    <ul>
                        <li class="tiezi-mingcheng">
                            <img src="${basePath}res/front/library/images/right-5.jpg" align="absmiddle" style="margin-right:5px;"/>
                            <B style="padding-right:20px;">${bbsPost.userInfo.nickname}</B>
                            <span class="colorhui">
                                <fmt:formatDate value="${bbsPost.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/> |
                                <a class="colorhui" href="${basePath}bbs/post-${bbsPost.id}.htm?u=${bbsPost.userId}">只看楼主</a>
                            </span>
                            <span style="text-align: right;margin-left: 270px;">
                                <img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;"/>
                                <span class="colorhui">回复</span>&nbsp;&nbsp;
                                <a href="#top" class="colorhui">TOP</a>&nbsp;&nbsp;
                                <span class="colorhui" style="width: 20px;">楼主</span>
                            </span>
                        </li>
                        <li class="minheight">${bbsPost.content}</li>
                        <c:if test="${bbsPost.publishTime ne bbsPost.updateTime}">
                            <li style="margin-left: 10px;margin-top: 10px; color: #999;height: 20px;">
                                最后编辑&nbsp;<fmt:formatDate value="${bbsPost.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </li>
                        </c:if>
                        <%--<li class="tiezi-huifu">
                            <img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;"/>
                            <span class="colorhui">回复</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#top" class="colorhui">TOP</a>
                        </li>--%>
                    </ul>
                </div>
                <%--回帖--%>
                <c:forEach var="reply" items="${bbsReplyList}" varStatus="status">
                    <div class="right-tiezi-neirong">
                        <ul>
                            <li class="tiezi-mingcheng">
                                <img src="${basePath}res/front/library/images/right-5.jpg" align="absmiddle" style="margin-right:5px;"/>
                                <B style="padding-right:20px;">${reply.userInfo.nickname}</B>
                                <span class="colorhui">
                                    <fmt:formatDate value="${reply.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/> |
                                    <a class="colorhui" href="${basePath}bbs/post-${reply.postId}.htm?u=${reply.userId}">
                                        <c:choose>
                                            <c:when test="${reply.userId eq bbsPost.userId}">只看楼主</c:when>
                                            <c:otherwise>只看该用户</c:otherwise>
                                        </c:choose>
                                    </a>
                                </span>
                                <span style="text-align: right;margin-left: 270px;">
                                    <img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;"/>
                                    <span class="colorhui">回复</span>&nbsp;&nbsp;
                                    <a class="colorhui" href="#top">TOP</a>&nbsp;&nbsp;
                                    <span class="colorhui" style="width: 20px;">${status.index + 1 }楼</span>
                                </span>
                            </li>
                            <li class="minheight">${reply.content}</li>
                            <c:if test="${reply.publishTime ne reply.updateTime}">
                                <li style="margin-left: 10px;margin-top: 10px; color: #999;height: 20px;">
                                    最后编辑&nbsp;<fmt:formatDate value="${reply.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </li>
                            </c:if>
                            <%--<li class="tiezi-huifu">
                                <img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;"/>
                                <span class="colorhui">回复</span>&nbsp;&nbsp;
                                <a class="colorhui" href="#top">TOP</a>&nbsp;&nbsp;
                                <span class="colorhui">${status.index + 1 }楼</span>
                            </li>--%>
                        </ul>
                    </div>
                </c:forEach>
                <%--<div class="right-tiezi-neirong">
                    <ul>
                        <li class="tiezi-mingcheng"><img src="${basePath}res/front/library/images/right-5.jpg"
                                                         align="absmiddle" style="margin-right:5px;"/><b
                                style="padding-right:20px;">何巨</b><span class="colorhui">2012-12-03 12:10 | 只看该用户</span>
                        </li>
                        <li class="minheight"><b>回复1# 陈含的帖子</b><br/>和我去打野球吧哈哈</li>
                        <li class="tiezi-huifu"><img src="${basePath}res/front/library/images/right-6.jpg"
                                                     align="absmiddle" style="margin-right:5px;"/><span
                                class="colorhui">回复</span>&nbsp;&nbsp;&nbsp;&nbsp;<img
                                src="${basePath}res/front/library/images/right-7.jpg" align="absmiddle"
                                style="margin-right:5px;"/><span class="colorhui">引用</span>&nbsp;&nbsp;&nbsp;&nbsp;TOP
                        </li>
                    </ul>
                </div>--%>
                <c:if test="${pageBean.curPage > 1}">
                    <c:set var="pageURL" value="${basePath}bbs/post-${bbsPost.id}.htm?u=${query.userId}&"/>
                    <%@include file="../../common/pages-front.jsp" %>
                </c:if>
                <div class="tiezi-dibu">
                    <span class="colorbule kuang">
                        <a href="${basePath}bbs/brand-${bbsPost.categoryId}.htm" class="colorbule">返回列表</a>
                    </span>
                    <span class="colorbule">
                        <c:choose>
                            <c:when test="${postPre != null and postPre.id != null}">
                                <a href="${basePath}bbs/post-${postPre.id}.htm" class="colorbule">上一主题</a>
                            </c:when>
                            <c:otherwise>
                                <a href="##" class="colorbule">上一主题</a>
                            </c:otherwise>
                        </c:choose>
                    </span>
                    &nbsp;|&nbsp;
                    <span class="colorbule">
                        <c:choose>
                            <c:when test="${postSub != null and postSub.id != null}">
                                <a href="${basePath}bbs/post-${postSub.id}.htm" class="colorbule">下一主题</a>
                            </c:when>
                            <c:otherwise>
                                <a href="##" class="colorbule">下一主题</a>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <%--回帖区域--%>
                <input id="categoryId" name="categoryId" value="${bbsPost.categoryId}" type="hidden"/>
                <div class="tiezi-bianxie">
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
                        <a name="replyArea" id="replyArea"></a><%--锚点--%>
                        <textarea name="postContent" id="postContent" style="width:100%;height:250px;visibility:hidden;"></textarea>
                </div>
                <div class="tiezi-tijiao">
                    <input type="button" value="发表回复" class="button-click" onclick="javascript:postSubmit();"/>&nbsp;&nbsp;
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
<script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
<script type="text/javascript">
    var bastPath = '${basePath}';
    var categoryId = '${category.id}';
    var postId = '${bbsPost.id}';
    function postSubmit(){
        var content = $("#postContent").val();
        var errorMsg = '';
        if (content == 0) {
            errorMsg += '内容不能为空';
        }
        if (errorMsg.length > 0 ) {
            layer.alert(errorMsg, 8);
            return;
        }
        $.ajax({
            type: "post",
            url: bastPath + "bbs/reply-" + postId + "-submit.htm",
            data: "content=" + encodeURIComponent(content)
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
