<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>左侧菜单栏目</title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            Cms.lmenu('lmenu');
        });
        function changeRole(){

        }
    </script>
</head>
<body class="lbody">
<p>&nbsp;角色选择&nbsp;
    <select id="roleId" name="roleId">
        <option value="1">超级管理员</option>
    </select>
</p>
<ul id="lmenu">
    <li><a href="${basePath}mg/home/webInfo.htm" target="mainFrame">欢迎界面</a></li>
    <li><a href="${basePath}mg/home/webInfo.htm" target="mainFrame">个人信息管理</a></li>
    <%--新闻分类--%>
    <li><a href="${basePath}mg/post/${categoryNews.aliasName}/category-list.htm" target="mainFrame">分类管理--${categoryNews.name}</a></li>
    <c:forEach var="cate" items="${categoryNewsList}">
        <li><a href="${basePath}mg/post/${categoryNews.aliasName}/post-list.htm?categoryId=${cate.id}" target="mainFrame">内容管理--${cate.name}</a></li>
    </c:forEach>

    <%--通知公告管理--%>
    <li><a href="${basePath}mg/post/${categoryNotices.aliasName}/category-list.htm" target="mainFrame">分类管理--${categoryNotices.name}</a></li>
    <c:forEach var="cate" items="${categoryNoticesList}">
        <li><a href="${basePath}mg/post/${categoryNotices.aliasName}/post-list.htm?categoryId=${cate.id}" target="mainFrame">内容管理--${cate.name}</a></li>
    </c:forEach>

    <%--集团快捷入口--%>
    <li><a href="${basePath}mg/links/outfastentrance/links-list.htm" target="mainFrame">集团快捷入口管理</a></li>
    <!-- 华电快捷入口 -->
    <li><a href="${basePath}mg/links/infastentrance/links-list.htm" target="mainFrame">华电快捷入口管理</a></li>

    <%--友情链接分类管理--%>
    <li><a href="${basePath}mg/links/${categoryFriendlyLinks.aliasName}/category-list.htm" target="mainFrame">分类管理--友情链接</a></li>
    <c:forEach var="cate" items="${categoryFriendlyLinksList}">
        <li><a href="${basePath}mg/links/${categoryFriendlyLinks.aliasName}/links-list.htm?categoryId=${cate.id}" target="mainFrame">友情链接--${cate.name}</a></li>
    </c:forEach>

    <%--站内信管理--%>
    <li><a href="${basePath}mg/message/message-list.htm" target="mainFrame">站内信</a></li>
    <li><a href="${basePath}mg/message/message-show.htm" target="mainFrame">发送站内信</a></li>

    <%--部门管理--%>
    <li><a href="${basePath}mg/dept/dept-list.htm" target="mainFrame">通讯录</a></li>

</ul>
</body>
</html>