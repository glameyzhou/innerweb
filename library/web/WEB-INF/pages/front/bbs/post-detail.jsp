<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电迷你图书馆-您身边的能源情报站</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/bbs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <style type="text/css">
        .poll-percent {
            float: left;
            margin: 4px 10px 3px 0;
            width: 164px;
            height: 11px;
            background: #F1F1F1;
            overflow: hidden;
        }
        .poll-percent em {
            float: left;
            width: 0;
            height: 9px;
            border: 1px solid #71A322;
            background-color: #71A322;
            background-position: 0 -251px;
            overflow: hidden;
        }
    </style>
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
        <div class="center_right">
            <div class="right-top">
                <span class="colorbule" style="color: #0099cc;"><a href="${basePath}bbs/index.htm">专题讨论区</a></span> >> <a href="${basePath}bbs/brand-${category.id}.htm">${category.name}</a> >> ${bbsPost.title}</div>
            <div class="right-meitan">
                <div class="right-meitan-tit tit-height">
                    <ul style="width:700px;">
                        <li><h2>${fmtString:substringAppend(bbsPost.title,30 ,'...' )}</h2></li>
                        <li style="padding-left:20px;">[<span class="colorju">${bbsPost.viewCount}</span> 查看 / <span class="colorju">${bbsPost.replyCount}</span> 回复 ]</li>
                    </ul>
                    <br /><br /><br />
                    <ul style="width:700px;">
                        <li>
                            <div class="menu">
                                <ul>
                                    <li><a class="hide" href="${basePath}bbs/post-${category.id}-show.htm"></a>
                                        <ul>
                                            <li><a href="${basePath}bbs/post-${category.id}-voteShow.htm">发起投票</a></li>
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
                <%--楼主 如果是非第一页的话，不再显示楼主信息--%>
                <c:if test="${pageBean.curPage == 1}">
                    <div class="right-tiezi-neirong">
                        <ul>
                            <li class="tiezi-mingcheng">
                                <img src="${basePath}res/front/library/images/right-5.jpg" align="absmiddle" style="margin-right:5px;"/>
                                <B style="padding-right:20px;">${bbsPost.userInfo.nickname}</B>
                                <span class="colorhui">
                                    <fmt:formatDate value="${bbsPost.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/> |
                                    <a class="colorhui" href="${basePath}bbs/post-${bbsPost.id}.htm?u=${bbsPost.userId}&t=${t}">只看楼主</a>
                                </span>
                                <span style="text-align: right;margin-left: 270px;">
                                    <img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;margin-bottom: 1px;"/>
                                    <span class="colorhui"><a href="#replyArea" class="colorhui">回复</a></span>&nbsp;&nbsp;
                                    <a href="#top" class="colorhui">TOP</a>&nbsp;&nbsp;
                                    <span class="colorhui" style="width: 20px;">1<sup class="colorhui">#</sup></span>
                                </span>
                            </li>
                            <li class="minheight" style="min-height: 10px;" id="content_0">${bbsPost.content}</li>
                            <%--如果是投票的话，显示这些内容--%>
                            <c:if test="${not empty t}">
                                <%--不提交结果也可见 || 投票后结果才可见--%>
                                <c:if test="${(postVote.seeAfterVote == 1 && isVote) || postVote.votePersonOut == 1}">
                                    <li class="minheight" style="margin-top: 5px;min-height: 5px;">
                                        <b>投票结果</b>&nbsp;&nbsp;投票总人数：<font style="color: red;font-weight: bold;">${votePersonTotal}</font>，投票总数：<font style="color: red;font-weight: bold;">${voteTotal}</font>
                                        <table width="100%" cellspacing="0" cellpadding="0">
                                            <c:forEach var="property" items="${votePropertyList}" varStatus="status">
                                                <c:if test="${voteTotal == 0}">
                                                    <c:set value="1" var="voteTotal"/>
                                                </c:if>
                                                <fmt:formatNumber value="${property.propertyValue/voteTotal}" type="percent" minFractionDigits="1" var="votePercent" />
                                                <tr>
                                                    <td style="width: 50%">${property.propertyName}</td>
                                                    <td style="width: 27%">
                                                        <span class="poll-percent"><em style="width:${votePercent};">&nbsp;</em></span>
                                                    </td>
                                                    <td style="width: 5%;">${votePercent}</td>
                                                    <td style="width: 18%"><a href="javascript:person('${bbsPost.id}','${postVote.voteId}','${property.propertyId}');">查看投该选项的会员</a></td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </li>
                                </c:if>
                                <li class="minheight" style="margin-top: 5px;min-height: 5px;">
                                    <b>投票属性</b><br/>
                                    <p>
                                        投票结束时间：${postVote.voteEndDate}<br/>
                                        <c:if test="${postVote.seeAfterVote == 1}">提交投票后结果才可见<br/></c:if>
                                        <c:choose>
                                            <c:when test="${postVote.isMultiVote == 0}">只能选择一个选项</c:when>
                                            <c:otherwise>可以选择<font style="color: #ff0000;">${postVote.multiVoteSize}</font>个选项</c:otherwise>
                                        </c:choose>
                                    </p>
                                    <b>投票选项</b>
                                    <c:forEach var="property" items="${votePropertyList}" varStatus="status">
                                        <p>
                                            <input type="checkbox" name="voteProperty" id="voteProperty" value="${property.propertyId}"/>&nbsp;
                                                ${status.index + 1}、${property.propertyName}
                                        </p>
                                    </c:forEach>
                                    <div class="tiezi-tijiao">
                                        <input type="button" value="提交投票" class="button-click" onclick="javascript:voteSubmit();"/>&nbsp;&nbsp;
                                    </div>
                                </li>
                            </c:if>
                            <c:if test="${not empty bbsPost.lastedUpdateUserId and bbsPost.lastedUpdateUserInfo != null}">
                                <li style="margin-left: 10px;margin-top: 10px; color: #999;height: 20px;">
                                    ${bbsPost.lastedUpdateUserInfo.nickname}&nbsp;最后编辑与&nbsp;<fmt:formatDate value="${bbsPost.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </c:if>
                <%--回帖--%>
                <c:forEach var="reply" items="${bbsReplyList}" varStatus="status">
                    <c:set var="replyFloor" value="${(pageBean.curPage - 1) * pageBean.rowsPerPage + (status.index + 2)}"/>
                    <div class="right-tiezi-neirong">
                        <ul>
                            <li class="tiezi-mingcheng">
                                <img src="${basePath}res/front/library/images/right-5.jpg" align="absmiddle" style="margin-right:5px;"/>
                                <B style="padding-right:20px;">${reply.userInfo.nickname}</B>
                                <span class="colorhui">
                                    <fmt:formatDate value="${reply.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/> |
                                    <a class="colorhui" href="${basePath}bbs/post-${reply.postId}.htm?u=${reply.userId}&t=${t}">
                                        <c:choose>
                                            <c:when test="${reply.userId eq bbsPost.userId}">只看楼主</c:when>
                                            <c:otherwise>只看该用户</c:otherwise>
                                        </c:choose>
                                    </a>
                                </span>
                                <span style="text-align: right;margin-left: 270px;">
                                    <img src="${basePath}res/front/library/images/right-6.jpg" align="absmiddle" style="margin-right:5px;margin-bottom: 1px;"/>
                                    <span class="colorhui">
                                        <a href="javascript:floorReply('${reply.id}','${replyFloor}');" class="colorhui">回复</a>
                                    </span>&nbsp;&nbsp;
                                    <a class="colorhui" href="#top">TOP</a>&nbsp;&nbsp;
                                    <span class="colorhui" style="width: 20px;">${replyFloor}<sup class="colorhui">#</sup></span>
                                </span>
                            </li>
                            <li class="minheight" id="content_${replyFloor}">
                                <c:if test="${reply.postReplyRef != null}">
                                    <b>回复${replyFloor}楼 ${reply.userInfo.nickname}的帖子</b><br/>
                                </c:if>
                            ${reply.content}
                            </li>
                            <c:if test="${not empty reply.lastedUpdateUserId and reply.lastedUpdateUserInfo != null}">
                                <li style="margin-left: 10px;margin-top: 10px; color: #999;height: 20px;">
                                    ${reply.lastedUpdateUserInfo.nickname}&nbsp;最后编辑与&nbsp;<fmt:formatDate value="${reply.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </c:forEach>
                <c:if test="${pageBean.maxPage > 1}">
                    <c:set var="pageURL" value="${basePath}bbs/post-${bbsPost.id}.htm?u=${query.userId}&t=${t}&"/>
                    <%@include file="../../common/pages-front.jsp" %>
                </c:if>
                <div class="tiezi-dibu">
                    <span class="colorbule kuang">
                        <a href="${basePath}bbs/brand-${bbsPost.categoryId}.htm" class="colorbule" id="returnBBSIndex">返回列表</a>
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
                <div class="tiezi-bianxie" style="float: left;margin-left: 10px;">
                        <link rel="stylesheet" href="${basePath}kindeditor/themes/default/default.css" />
                        <link rel="stylesheet" href="${basePath}kindeditor/plugins/code/prettify.css" />
                        <script charset="utf-8" src="${basePath}kindeditor/kindeditor.js"></script>
                        <script charset="utf-8" src="${basePath}kindeditor/lang/zh_CN.js"></script>
                        <script charset="utf-8" src="${basePath}kindeditor/plugins/code/prettify.js"></script>
                        <script>
                            var kindEditor;
                            KindEditor.ready(function (K) {
                                 kindEditor = K.create('textarea[name="postContent"]', {
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
                        <input type="hidden" id="replyId" name="replyId" value=""/>
                        <textarea name="postContent" id="postContent" style="width:100%;height:250px;visibility:hidden;"></textarea>
                </div>
                <div class="tiezi-tijiao">
                    <input type="button" value="发表回复" class="button-click" onclick="javascript:postSubmit();" style="margin-top: 5px;"/>&nbsp;&nbsp;
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
    var postId = '${bbsPost.id}';

    var voteId = '${postVote.voteId}';
    var isMultiVote = '${postVote.isMultiVote}';
    var multiVoteSize = '${postVote.multiVoteSize}';

    function postSubmit(){
        var content = $("#postContent").val();
        var errorMsg = '';
        if ($.trim(content).length == 0) {
            errorMsg += '内容不能为空';
        }
        if (errorMsg.length > 0 ) {
            layer.alert(errorMsg, 8);
            return;
        }
        var data = "content=" + encodeURIComponent(content)
                + "&categoryId=" + categoryId
                + "&replyId=" + $("#replyId").val()
                + "&r=" + Math.random();
        $.ajax({
            type: "post",
            url: bastPath + "bbs/reply-" + postId + "-submit.htm",
            data: data,
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
                                window.location =  bastPath + 'bbs/post-' + postId + '.htm?t=${t}';
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
    function floorReply(replyId,replyFloor){
        layer.confirm('确定要回复' + replyFloor + '楼吗？',function(index){
            layer.close(index);
        });
        $.layer({
            shade : [0.5 , '#000' , true],
            area : ['auto','auto'],
            dialog : {
                msg:'确定要回复' + replyFloor + '楼吗？',
                btns : 2,
                type : 4,
                btn : ['确定','取消'],
                yes : function(){
                    layer.closeAll();
                    $("#replyId").val(replyId);
                    //跳转到回复区域
                    location.hash="replyArea";
                },
                no : function(){
                    $("#replyId").val("");
                    layer.closeAll();
                }
            }
        });
     }

    /**
    *   返回列表页面
     */
    $('#returnBBSIndex').on('mouseover', function(){
        layer.tips(
                '跳转至<br/><a href="${basePath}bbs/index.htm"><b>专题讨论区</b></a><br/><a href="${basePath}bbs/brand-${category.id}.htm"><b>${category.name}</b></a>',
                this,
                {
                    style: ['background-color:#0FA6D8; color:#fff', '#0FA6D8'],
                    maxWidth: 150,
                    time: 2
                }
        );
    });
    function voteSubmit(){
        var voteProperties = "";
        $("input[name='voteProperty']:checked").each(function () {
            voteProperties += "," + this.value;
        });
        if (voteProperties.length == 0) {
            layer.alert('请选择一个', 8);
            return;
        }
        voteProperties = voteProperties.substring(1);
        var checkedSize = $("input[name='voteProperty']:checked").length;
        if (isMultiVote == '1' && checkedSize > parseInt(multiVoteSize)) {
            layer.alert('最多选择' + multiVoteSize + '项', 8);
            return;
        }
        var data = "categoryId=" + categoryId + "&voteProperties=" + voteProperties + "&r=" + Math.random();
        $.ajax({
            type: "post",
            url: bastPath + "bbs/post-vote-" + postId + "-" + voteId + "-submit.htm",
            data: data,
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
                                window.location =  bastPath + 'bbs/post-vote-' + postId + '.htm';
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
    function person(postId,voteId,propertyId) {
        var seeAfterVote = '${postVote.seeAfterVote}';
        var isVote = '${isVote}';
        var personOut = '${postVote.votePersonOut}';
        if (seeAfterVote == '1' && isVote == 'true') {
            window.location = '${basePath}bbs/votePerson-' + postId + '-' + voteId + '-' + propertyId + '.htm';
        }
        else if (personOut == '0') {
            layer.alert('无权查看投票人', 8);
        }
        else {
            layer.alert('投票之后才能查看投票人', 8);
        }
    }
</script>
</body>
</html>
