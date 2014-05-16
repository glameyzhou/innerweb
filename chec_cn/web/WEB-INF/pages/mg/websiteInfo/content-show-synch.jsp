<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
    <base href="${basePath}">
    <script type="text/javascript">
        $(function() {
            $("#jvForm").validate();
        });
        function contentSendCheck(){
            var all_checkbox = document.getElementsByName("websiteId");
            if(isChecked("websiteId") == false ){
                layer.alert('至少选择一个同步地址', 8);
            }else{

                layer.confirm('确认要同步？',function(index){
                    layer.close(index);
                    var websiteIds = "";
                    var websiteLen = all_checkbox.length;
                    for(var i=0;i<websiteLen ;i++){
                        if(all_checkbox[i].checked)
                            websiteIds += "," + all_checkbox[i].value;
                    }
                    if(websiteIds.length > 1)
                        websiteIds = websiteIds.substring(1);

                    var all_checkbox_contentId = document.getElementsByName("contentId");
                    var contentIds = "" ;
                    var contentLen = all_checkbox_contentId.length;
                    for(var i=0;i<contentLen ;i++){
                        if(all_checkbox_contentId[i].checked)
                            contentIds += "," + all_checkbox_contentId[i].value;
                    }
                    if(contentIds.length > 1)
                        contentIds = contentIds.substring(1);
                    window.location = '${basePath}mg/websiteInfo/contentSend.do?contentId=' + contentIds + "&websiteId=" + websiteIds ;
                });
            }
        }
    </script>
</head>
<body>
<div class="body-box">
    <form action="" method="get" style="padding-top:5px;">
        <div class="rhead">
            <div class="rpos">当前位置: 首页 - 站外消息 - 消息同步列表</div>
            <div class="clear"></div>
        </div>
        <div class="rhead">
            <div><B>文章同步列表</B><br/></div>
            <table width="100%" border="0" cellspacing="1">
                <c:forEach var="content" items="${contentInfoList}">
                    <tr height="25px">
                        <td height="23" width="10%">标题:${content.title}
                            <div style="display:none"><input type="checkbox" name="contentId" id="contentId" value="${content.contentId}" checked="checked"/>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <div class="clear"></div>
        </div>

        <div class="rhead">
            <div><B>同步地址选择(不能同步给自身)</B><br/></div>
            <table width="100%" border="0" cellspacing="1">
                <c:forEach var="websiteInfo" items="${websiteInfoList}">
                    <c:choose>
                        <c:when test="${websiteInfo.isSelf == 1 }">
                            <input type="checkbox" name="testId" id="testId" value="${websiteInfo.id}" disabled="disabled">${websiteInfo.name}&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <input type="checkbox" name="websiteId" id="websiteId" value="${websiteInfo.id}">${websiteInfo.name}&nbsp;&nbsp;
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </table>
            <div class="clear"></div>
        </div>
        <p align="center"><input type="button" value="提交" onclick="javascript:contentSendCheck();"> &nbsp; <input type="reset" value="重置"></p>
    </form>
</div>
</body>
</html>