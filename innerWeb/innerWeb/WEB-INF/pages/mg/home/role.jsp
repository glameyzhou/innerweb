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
        function divDisplay(divName){
            var d = document.getElementById(divName);
            if(d.style.display == 'block'){
                d.style.display = 'none' ;
            }
            else{
                d.style.display = 'block';
            }
        }
    </script>
</head>
<body class="lbody">
<p>&nbsp;角色选择&nbsp;
    <select id="roleId" name="roleId">
        <c:forEach var="role"  items="${roleInfoList}">
            <option value="${role.roleId}">${role.roleName}</option>
        </c:forEach>
    </select>
</p>
<ul id="lmenu">
    <li><a href="${basePath}mg/home/webInfo.htm" target="mainFrame">欢迎界面</a></li>
    <li><a href="${basePath}mg/user/user-psersonal-show.htm?userId=${userInfo.userId}" target="mainFrame">个人信息管理</a></li>

    <%--新闻分类--%>
    <li><a href="${basePath}mg/post/${categoryNews.aliasName}/category-list.htm" target="mainFrame">${categoryNews.name} - 分类管理</a></li>
    <li><a href="javascript:divDisplay('${categoryNews.id}_div');">${categoryNews.name} - 内容管理</a> </li>
    <ul id="${categoryNews.id}_div" style="display: none">
        <c:forEach var="cate" items="${categoryNewsList}">
            <li><a href="${basePath}mg/post/${categoryNews.aliasName}/post-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
        </c:forEach>
    </ul>

    <%--通知公告管理--%>
    <li><a href="${basePath}mg/post/${categoryNotices.aliasName}/category-list.htm" target="mainFrame">${categoryNotices.name} - 分类管理</a></li>
    <li><a href="javascript:divDisplay('${categoryNotices.id}_div');">${categoryNotices.name} - 内容管理</a> </li>
    <ul id="${categoryNotices.id}_div" style="display: none">
        <c:forEach var="cate" items="${categoryNoticesList}">
            <li><a href="${basePath}mg/post/${categoryNotices.aliasName}/post-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
        </c:forEach>
    </ul>

    <%--集团快捷入口--%>
    <li><a href="${basePath}mg/links/${outLinksCategory.categoryType}/links-list.htm" target="mainFrame">${outLinksCategory.name} - 内容管理</a></li>
    <!-- 华电快捷入口 -->
    <li><a href="${basePath}mg/links/${inLinksCategory.categoryType}/links-list.htm" target="mainFrame">${inLinksCategory.name} - 内容管理</a></li>

    <%--友情链接分类管理--%>
    <li><a href="${basePath}mg/links/${categoryFriendlyLinks.aliasName}/category-list.htm" target="mainFrame">友情链接 - 分类管理</a></li>
    <li><a href="javascript:divDisplay('${categoryFriendlyLinks.id}_div');">${categoryFriendlyLinks.name} - 链接管理</a> </li>
    <ul id="${categoryFriendlyLinks.id}_div" style="display: none">
        <c:forEach var="cate" items="${categoryFriendlyLinksList}">
            <li><a href="${basePath}mg/links/${categoryFriendlyLinks.aliasName}/links-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
        </c:forEach>
    </ul>

    <%--常用链接--%>
    <li><a href="${basePath}mg/sys/meta/popular_Links/meta-show.htm" target="mainFrame">常用链接管理</a></li>

    <%--站内信管理--%>
    <li><a href="${basePath}mg/message/message-list.htm" target="mainFrame">站内信</a></li>
    <li><a href="${basePath}mg/message/message-show.htm" target="mainFrame">发送站内信</a></li>



    <%--全局配置--%>
    <li><a href="${basePath}mg/sys/sys-list.htm" target="mainFrame">全局配置</a></li>

    <%--部门管理--%>
    <li><a href="${basePath}mg/dept/dept-list.htm" target="mainFrame">部门管理</a></li>
    <%--系统功能权限配置--%>
    <li><a href="${basePath}mg/user/rights-list.htm" target="mainFrame">功能权限配置</a></li>
    <%--系统角色配置--%>
    <li><a href="${basePath}mg/user/role-list.htm" target="mainFrame">系统角色配置</a></li>
    <%--用户角色配置--%>
    <li><a href="${basePath}mg/user/user-list.htm" target="mainFrame">系统用户配置</a></li>

</ul>
</body>
</html>