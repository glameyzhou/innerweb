<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>栏目-${categoryParent.name}</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript" src="${basePath}res/front/js/prototype-1.6.0.3.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function buildLucene(){
            var url = '${basePath}lucene/build.htm';
            new Ajax.Request(url, {
                        method: 'get',
                        onSuccess: function (transport) {
                            var resultDiv = $('luceneDiv');
                            //weather.innerHTML = transport.responseText;
                            if(transport.responseText.indexOf("ok") > -1){
                                resultDiv.innerHTML = "<font color='red'>建立完毕</font>&nbsp;&nbsp;<a href='javascript:buildLucene();'>建立</a>" ;
                            }
                            else{
                                resultDiv.innerHTML = "<font color='red'>建立失败,请重新</font>&nbsp;&nbsp;<a href='javascript:buildLucene();'>建立</a>" ;
                            }
                        }
                    }
            );
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 全局设置</div>
        <%--<form class="ropt">
            <input type="button" value="添加" onclick="javascript:window.location='${basePath}mg/dept/dept-show.htm';">
        </form>--%>
        <div class="clear"></div>
    </div>
    <form action="${basePath}mg/dept/dept-list.htm" method="get" style="padding-top:5px;">
        <div>
        </div>
        <table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
            <thead class="pn-lthead">
            <tr>
                <th>配置项</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody class="pn-ltbody">
            <tr>
                <td align="left">通告是否需要审核</td>
                <td align=center><a href="${basePath}mg/sys/permit-notices-show.htm">设置</a></td>
            </tr>
            <tr>
                <td align="left">各部门通知可见配置</td>
                <td align=center><a href="${basePath}mg/sys/notices-what-can-see.htm">设置</a></td>
            </tr>
            <tr>
                <td align="left">首页结构设置</td>
                <td align=center><a href="${basePath}mg/sys/area-show.htm">设置</a></td>
            </tr>
            <%--<tr>
                <td align="left">图片是否使用水印</td>
                <td align=center><a href="javascript:void(0);" onclick="jump('1')">设置</a></td>
            </tr>--%>
            <tr>
                <td align="left">页尾内容</td>
                <td align=center><a href="${basePath}mg/sys/meta/page_foot/meta-show.htm">设置</a></td>
            </tr>
            <tr>
                <td align="left">全文索引建立</td>
                <td align=center id="luceneDiv"><a href="javascript:buildLucene();">建立</a></td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>