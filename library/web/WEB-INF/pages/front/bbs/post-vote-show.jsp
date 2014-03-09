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
                <span class="colorbule"><a href="${basePath}bbs/index.htm">专题讨论区</a></span> >> <a href="${basePath}bbs/brand-${category.id}.htm">${category.name}</a> >> 发起新投票
            </div>
            <div class="right-meitan">
                <div class="right-meitan-tit">
                    <ul style="width:700px;">
                        <li><h2>发起投票</h2></li>
                    </ul>
                </div>
                <div class="right-tiezi-neirong right-paddingtop">
                    <ul>
                        <li>主题：<input name="title" id="title" type="text" class="tiezi-text" style="width: 500px;"/></li>
                        <%--<li id="error_title" style="display: none;color: #ff0000;"></li>--%>
                        <br/>
                        <li>
                            选项：每行填写 1 个选项（最多10项，最少2项）。&nbsp;
                            <a href="javascript:void(0);" class="colorbule" id="addVoteProperties">+增加投票项</a>&nbsp;
                            <a href="javascript:void(0);" class="colorbule" id="delVoteProperties">-删除投票项</a>
                        </li>
                        <ul id="voteProperties">
                            <li style="float: none;margin-left: 35px;" id="li_VoteProperties_1"><input name="input_properties_1" id="input_properties_1" type="text" class="tiezi-text" style="width: 500px;"/><img src="${basePath}res/front/library/images/bbs_del.gif" title="删除投票项" id="delImage_1" onmousemove='$(this).attr("src","${basePath}res/front/library/images/bbs_del_hover.gif");' onmouseout='$(this).attr("src","${basePath}res/front/library/images/bbs_del.gif");' onclick="deLiVoteProperties('1');" /></li>
                            <li style="float: none;margin-left: 35px;" id="li_VoteProperties_2"><input name="input_properties_2" id="input_properties_2" type="text" class="tiezi-text" style="width: 500px;"/><img src="${basePath}res/front/library/images/bbs_del.gif" title="删除投票项" id="delImage_2" onmousemove='$(this).attr("src","${basePath}res/front/library/images/bbs_del_hover.gif");' onmouseout='$(this).attr("src","${basePath}res/front/library/images/bbs_del.gif");' onclick="deLiVoteProperties('2');" /></li>
                        </ul>
                        <br/>
                        <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
                        <li>
                            投票结束时间：<input type="text" maxlength="100" name="voteEndDate" id="voteEndDate" size="15" value="${voteEndDate}"
                                          onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',errDealMode:1,minDate:'${curDate}',isShowClear:false})" class="Wdate" readonly="readonly">
                        </li>
                        <br/>
                        <li>
                            <input type="checkbox" id="isMultiVote"/>&nbsp;多选投票&nbsp;
                            <span id="multiVoteItem" style="display: none;">
                                最多可选项数：<input id="multiVoteSize" type="text" class="tiezi-text" style="width:30px;"/>
                            </span>
                        </li>
                        <br/>
                        <li>
                            <input type="checkbox" id="seeAfterVote"/>&nbsp;提交投票后结果才可见
                        </li>
                        <br/>
                        <li>
                            <input type="checkbox" id="votePersonOut"/>&nbsp;公开投票参与人
                        </li>
                        <br/>
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
                    <input name="postSubmit" id="postSubmit" type="button" value="发布投票" class="button-click" onclick="javascript:postSubmit();"/>&nbsp;&nbsp;
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
        var votePropertiesSize = 2;
        var voteProperties = $("#voteProperties");
        var addVoteProperties = $("#addVoteProperties");
        var delVoteProperties = $("#delVoteProperties");
        var bastPath = '${basePath}';
        var categoryId = '${category.id}';
        function postSubmit(){
            var title = $("#title").val();
            var errorMsg = '';
            if ($.trim(title).length == 0) {
                errorMsg += '标题不能为空<br/>';
            }
            for (var i = 1 ; i <= votePropertiesSize ; i ++) {
                if ($.trim($("#input_properties_" + i).val()).length == 0) {
                    errorMsg += '投票选项不能为空<br/>';
                    alert($("#input_properties_" + i).val());
                    break;
                }
            }
            if ($("#isMultiVote").attr('checked') && $("#multiVoteSize").val() == 0) {
                errorMsg += '可选项数总量不能为空<br/>';
            }
            if (errorMsg.length > 0 ) {
                layer.alert(errorMsg, 8);
                return;
            }
            /*设置post值*/
            var votePropertiesValue = "";
            for (var i = 1 ; i <= votePropertiesSize ; i ++) {
                votePropertiesValue += "&input_properties_" + i + "=" + encodeURIComponent($("#input_properties_" + i).val());
            }
            var postData = "categoryId=" + categoryId
                    + "&title=" + encodeURIComponent(title)
                    + "&votePropertiesValueSize=" + votePropertiesSize + "&" + votePropertiesValue
                    + "&voteEndDate=" + $("#voteEndDate").val()
                    + ($("#isMultiVote").attr('checked') ? ("&isMultiVote=1&multiVoteSize=" + $("#multiVoteSize").val()) : "&isMultiVote=0")
                    + ($("#seeAfterVote").attr('checked') ? "&seeAfterVote=1" : "&seeAfterVote=0")
                    + ($("#votePersonOut").attr('checked') ? "&votePersonOut=1" : "&votePersonOut=0")
                    + "&content=" + encodeURIComponent($("#postContent").val())
                    + "&r=" + Math.random();
            $.ajax({
                type: "post",
                url: bastPath + "bbs/post-vote-submit.htm",
                data: postData,
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
                                    window.location = bastPath + 'bbs/post-vote-' + postId + '.htm';
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
        addVoteProperties.click(function(){
            if (votePropertiesSize == 10) {
                layer.alert('投票项不能多于10项', 8);
                return;
            }
            votePropertiesSize ++;
            var html = '<li style="float: none;margin-left: 35px;" id="li_VoteProperties_' + votePropertiesSize + '">'
                    + '<input name="input_properties_' + votePropertiesSize + '" id="input_properties_' + votePropertiesSize + '" type="text" class="tiezi-text" style="width: 500px;"/>'
                    + '<img src="${basePath}res/front/library/images/bbs_del.gif" title="删除投票项" id="delImage_' + votePropertiesSize + '" '
                    + 'onmousemove=\'$(this).attr("src","${basePath}res/front/library/images/bbs_del_hover.gif");\' '
                    + 'onmouseout=\'$(this).attr("src","${basePath}res/front/library/images/bbs_del.gif");\' '
                    + 'onclick="deLiVoteProperties(' + votePropertiesSize + ');" />'
                    + '</li>';
            voteProperties.append(html);
        });
        delVoteProperties.click(function(){
            if (votePropertiesSize <= 2) {
                layer.alert('投票项不能少于2项', 8);
                return;
            }
            $("#li_VoteProperties_" + votePropertiesSize).remove();
            votePropertiesSize --;
        });
        function deLiVoteProperties(index) {
            if (votePropertiesSize <= 2) {
                layer.alert('投票项不能少于2项', 8);
                return;
            }
            $("#li_VoteProperties_" + index).remove();
            votePropertiesSize --;
        }
        /*投票项目数量设置*/
        $("#multiVoteSize").keyup(function(){
            var value = $(this).val();
            if (value.length == 0) {
                layer.alert('投票可选项目数量不能为空',8);
                return;
            }
            var regex = /\d*/i;
            var result = value.match(regex);
            if (result != value) {
                $("#multiVoteSize").val("");
                layer.alert('投票可选项目数量必须为正整数',8);
                return;
            }
            if (parseInt(value) > votePropertiesSize) {
                $("#multiVoteSize").val("");
                layer.alert('投票可选项目数量大于投票设置项',8);
                return;
            }
        });
        /*投票项目数量设置是否可见*/
        $("#isMultiVote").click(function(){
            if ($(this).attr('checked')) {
                $("#multiVoteSize").val("");
                /*div 是block元素，默认自动换行，须转换成span的inline元素或者加display：inline；转换成行内元素，或者用float:left；自动转换成inline-block元素*/
                $("#multiVoteItem").css("display","inline-block");
            }else {
                $("#multiVoteSize").val("");
                $("#multiVoteItem").css("display","none");
            }
        });
</script>
</body>
</html>
