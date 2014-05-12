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
        $(function () {
            $("#jvForm").validate();
        });
        function edit(websiteId) {
            window.location = '${basePath}mg/websiteInfo/website/show.do?websiteId=' + websiteId;
        }
        function synchWebsite() {
            layer.confirm('确认要同步分站信息!<br/>确定后,会将分站所有信息同步至各个分站点,并且覆盖原有数据!', function (index) {
                layer.close(index);
                var locationURL = '${basePath}synch/websiteInfo/websiteInfoSend.do';
                window.location = locationURL;
            });
        }
    </script>
    <title>当前位置: 首页 - 站外消息 - 分站列表[<font color="red">★</font>标识自身]</title>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 站外消息 - 分站列表[<font color="red">★</font>标识自身]</div>
        <div class="clear"></div>
    </div>
    <form method="get" action="${basePath}mg/websiteInfo/website/list.do" id="jvForm">
        <div>
            &nbsp;&nbsp;<input type="button" value="分站信息同步" onclick="javascript:synchWebsite();">
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th width="20%">名称</th>
                <th>描述</th>
                <th width="20%">URL前缀</th>
                <th width="10%">密钥</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <c:forEach items="${websiteList}" var="website" varStatus="status">
                <tr>
                    <td align=center>${website.name}&nbsp;<c:if test="${website.isSelf==1 }"><font color="red">★</font></c:if></td>
                    <td align=center>${website.desc}</td>
                    <td>${website.url }</td>
                    <td>${website.sign }</td>
                    <td align=center><a href="javascript:edit('${website.id}');">编辑</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:set var="pageURL" value="${basePath}mg/websiteInfo/website-list.do?"/>
        <%@include file="../../common/pages.jsp" %>
    </form>
</div>
</body>
</html>