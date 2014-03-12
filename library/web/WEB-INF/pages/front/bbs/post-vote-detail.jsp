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
<body>
<a name="top" id="top"></a><%--锚点--%>
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
                        <li style="padding-left:20px;">[<span class="colorju">${bbsPost.viewCount}</span> 查看 / <span class="colorju">${bbsPost.replyCount}</span> 投票 ]</li>
                    </ul>
                    <br /><br /><br />
                    <ul style="width:700px;">
                        <li>
                            <div class="menu menu-left">
                                <ul>
                                    <li><a class="hide" href="javascript:void(0)"></a>
                                        <ul>
                                            <li><a href="${basePath}bbs/post-${bbsPost.categoryId}-show.htm">只发文字</a></li>
                                            <li><a href="${basePath}bbs/post-${bbsPost.categoryId}-voteShow.htm">发起投票</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <%--<li>
                            <a href="#replyArea" >
                                <img src="${basePath}res/front/library/images/right-4.jpg" style="margin-top:10px;"/>
                            </a>
                        </li>--%>
                    </ul>
                </div>
                <div class="right-tiezi-neirong">
                    <ul>
                        <li class="tiezi-mingcheng">
                            <img src="${basePath}res/front/library/images/right-5.jpg" align="absmiddle" style="margin-right:5px;"/>
                            <B style="padding-right:20px;">${bbsPost.userInfo.nickname}</B>
                            <span class="colorhui"><fmt:formatDate value="${bbsPost.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                        </li>
                        <c:if test="${not empty bbsPost.content}">
                            <li class="minheight" style="min-height:5px;">${bbsPost.content}</li>
                        </c:if>
                        <li class="minheight" style="margin-top: 5px;">
                            <b>投票属性</b><br/>
                            <p>
                                投票结束时间：${postVote.voteEndDate}<br/>
                                <c:if test="${postVote.seeAfterVote == 1}">提交投票后结果才可见<br/></c:if>
                                <c:choose>
                                    <c:when test="${postVote.isMultiVote == 0}">只能选择一个选项</c:when>
                                    <c:otherwise>可以选择<font style="color: #ff0000;">${postVote.multiVoteSize}</font>个选项</c:otherwise>
                                </c:choose>
                            </p><br/>
                            <b>投票选项</b>
                            <c:forEach var="property" items="${votePropertyList}" varStatus="status">
                                <p>
                                    <input type="checkbox" name="voteProperty" id="voteProperty" value="${property.propertyId}"/>&nbsp;
                                    ${status.index + 1}、${property.propertyName}
                                </p>
                            </c:forEach>
                            <div class="tiezi-tijiao">
                                <input type="button" value="提交投票" class="button-click" onclick="javascript:postSubmit();"/>&nbsp;&nbsp;
                            </div>
                        </li>
                        <%--不提交结果也可见 || 投票后结果才可见--%>
                        <c:if test="${(postVote.seeAfterVote == 1 && isVote) || postVote.seeAfterVote == 0}">
                            <li class="minheight" style="margin-top: 5px;min-height: 5px;">
                                <b>投票结果</b>&nbsp;&nbsp;投票总人数：<font style="color: red;font-weight: bold;">${votePersonTotal}</font>，投票总数：<font style="color: red;font-weight: bold;">${voteTotal}</font>
                                <c:forEach var="property" items="${votePropertyList}" varStatus="status">
                                    <p style="width: 100%">
                                        <fmt:formatNumber value="${property.propertyValue/voteTotal}" type="percent" minFractionDigits="1" var="votePercent" />
                                        <span style="width: 50%">${status.index + 1}、${property.propertyName}&nbsp;&nbsp;</span>
                                        <span class="poll-percent"><em style="width:${votePercent};">&nbsp;</em></span>
                                        <%--<font style="color: red;font-weight: bolder;">
                                            <c:choose>
                                                <c:when test="${postVote.votePersonOut == 1}">
                                                    <a href="${basePath}bbs/votePerson-${bbsPost.id}-${postVote.voteId}-${property.propertyId}.htm" style="color: red;font-weight: bolder;" title="查看投票人">${property.propertyValue}&nbsp;[<fmt:formatNumber value="${property.propertyValue/voteTotal}" type="percent" minFractionDigits="1" />]</a>
                                                </c:when>
                                                <c:otherwise>
                                                    ${property.propertyValue}&nbsp;[<fmt:formatNumber value="${property.propertyValue/voteTotal}" type="percent" minFractionDigits="1" />]
                                                </c:otherwise>
                                            </c:choose>
                                        </font>--%>
                                    </p>
                                </c:forEach>
                            </li>
                        </c:if>
                        <c:if test="${not empty bbsPost.lastedUpdateUserId and bbsPost.lastedUpdateUserInfo != null}">
                            <li style="margin-left: 10px;margin-top: 10px; color: #999;height: 20px;">
                                ${bbsPost.lastedUpdateUserInfo.nickname}&nbsp;最后编辑与&nbsp;<fmt:formatDate value="${bbsPost.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </li>
                        </c:if>
                    </ul>
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
        var data = "categoryId=" + categoryId
                + "&voteProperties=" + voteProperties
                + "&r=" + Math.random();
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
</script>
</body>
</html>
