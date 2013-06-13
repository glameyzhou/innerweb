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
        function divDisplay(divName) {
            var d = document.getElementById(divName);
            if (d.style.display == 'block') {
                d.style.display = 'none';
            }
            else {
                d.style.display = 'block';
            }
        }
    </script>
</head>
<body class="lbody">
<p style="font: bold;color: #ff0000;">&nbsp;角色选择&nbsp;${userInfo.roleInfo.roleName}</p>
<ul id="lmenu">

    <li><a href="${basePath}mg/home/webInfo.htm" target="mainFrame">欢迎界面</a></li>
    <li><a href="${basePath}mg/user/user-psersonal-show.htm?userId=${userInfo.userId}" target="mainFrame">个人信息管理</a></li>
    <li><a href="${basePath}mg/user/contact.htm" target="mainFrame">通讯录</a></li>

    <%--新闻分类--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'01')}">
        <li><a href="${basePath}mg/post/${categoryNews.aliasName}/category-list.htm" target="mainFrame">${categoryNews.name} - 分类管理</a></li>
    </c:if>
    
    <c:if test="${fmtString:hasRightsRegex(rightsList, '01_news*')}">
        <li><a href="javascript:divDisplay('${categoryNews.id}_div');">${categoryNews.name} - 内容管理</a></li>
        <ul id="${categoryNews.id}_div" style="display: none">
            <c:forEach var="cate" items="${categoryNewsList}">
                <c:set value="01_news_${cate.id}*" var="newsRi"/>
                <c:if test="${fmtString:hasRightsRegex(rightsList, newsRi)}">
                    <li><a href="${basePath}mg/post/${categoryNews.aliasName}/post-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
                </c:if>
            </c:forEach>
        </ul>
    </c:if>

    <%--通知公告管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'02')}">
        <li><a href="${basePath}mg/post/${categoryNotices.aliasName}/category-list.htm" target="mainFrame">${categoryNotices.name} - 分类管理</a></li>
    </c:if>
    <c:if test="${fmtString:hasRightsRegex(rightsList, '02_notices*')}">
        <li><a href="javascript:divDisplay('${categoryNotices.id}_div');">${categoryNotices.name} - 内容管理</a></li>
        <ul id="${categoryNotices.id}_div" style="display: none">
            <c:forEach var="cate" items="${categoryNoticesList}">
                <c:set value="02_notices_${cate.id}*" var="noticesRi"/>
                <c:if test="${fmtString:hasRightsRegex(rightsList, noticesRi)}">
                    <li><a href="${basePath}mg/post/${categoryNotices.aliasName}/post-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
                </c:if>
            </c:forEach>
        </ul>
    </c:if>

    <%--安全管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'12')}">
        <li><a href="${basePath}mg/post/${categorySafe.aliasName}/category-list.htm" target="mainFrame">${categorySafe.name} - 分类管理</a></li>
    </c:if>
    <c:if test="${fmtString:hasRightsRegex(rightsList, '12_safe*')}">
        <li><a href="javascript:divDisplay('${categorySafe.id}_div');">${categorySafe.name} - 内容管理</a></li>
        <ul id="${categorySafe.id}_div" style="display: none">
            <c:forEach var="cate" items="${categorySafeList}">
                <c:set value="12_safe_${cate.id}*" var="safeRi"/>
                <c:if test="${fmtString:hasRightsRegex(rightsList, safeRi)}">
                    <li><a href="${basePath}mg/post/${categorySafe.aliasName}/post-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
                </c:if>
            </c:forEach>
        </ul>
    </c:if>

    <%--总院快捷入口--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'03')}">
        <li><a href="${basePath}mg/links/${outLinksCategory.categoryType}/links-list.htm" target="mainFrame">${outLinksCategory.name} - 内容管理</a></li>
    </c:if>
    <!-- 华电快捷入口 -->
    <c:if test="${fmtString:hasRightsList(rightsList,'04')}">
        <li><a href="${basePath}mg/links/${inLinksCategory.categoryType}/links-list.htm" target="mainFrame">${inLinksCategory.name} - 内容管理</a></li>
    </c:if>

    <%--友情链接分类管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'05')}">
        <li><a href="${basePath}mg/links/${categoryFriendlyLinks.aliasName}/category-list.htm" target="mainFrame">友情链接 - 分类管理</a></li>
        <li><a href="javascript:divDisplay('${categoryFriendlyLinks.id}_div');">${categoryFriendlyLinks.name} - 链接管理</a></li>
        <ul id="${categoryFriendlyLinks.id}_div" style="display: none">
            <c:forEach var="cate" items="${categoryFriendlyLinksList}">
                <li><a href="${basePath}mg/links/${categoryFriendlyLinks.aliasName}/links-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
            </c:forEach>
        </ul>
    </c:if>

    <%--常用链接管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'06')}">
        <li><a href="${basePath}mg/links/${categoryOfenLinks.aliasName}/category-list.htm" target="mainFrame">常用链接 - 分类管理</a></li>
        <li><a href="javascript:divDisplay('${categoryOfenLinks.id}_div');">${categoryOfenLinks.name} - 链接管理</a></li>
        <ul id="${categoryOfenLinks.id}_div" style="display: none">
            <c:forEach var="cate" items="${categoryOfenLinksList}">
                <li><a href="${basePath}mg/links/${categoryOfenLinks.aliasName}/links-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
            </c:forEach>
        </ul>
    </c:if>

    <%--站内信管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'07')}">
        <li><a href="${basePath}mg/message/message-list.htm" target="mainFrame">站内信</a></li>
        <li><a href="${basePath}mg/message/message-show.htm" target="mainFrame">发送站内信</a></li>
    </c:if>

    <%--部门管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'08')}">
        <li><a href="${basePath}mg/dept/dept-list.htm" target="mainFrame">部门管理</a></li>
    </c:if>

    <%--系统功能权限配置
    <li><a href="${basePath}mg/user/rights-list.htm" target="mainFrame">功能权限配置</a></li>--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'09')}">
        <%--系统角色配置--%>
        <li><a href="${basePath}mg/user/role-list.htm" target="mainFrame">系统角色配置</a></li>
        <%--用户角色配置--%>
        <li><a href="${basePath}mg/user/user-list.htm" target="mainFrame">系统用户配置</a></li>
    </c:if>

    <%--全局配置--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'10')}">
        <li><a href="${basePath}mg/sys/sys-list.htm" target="mainFrame">全局配置</a></li>
    </c:if>

    <%--微型图书馆管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'11')}">
        <li><a href="${basePath}mg/library/category-list.htm?pid=0" target="mainFrame">微型图书馆&nbsp;-&nbsp;分类管理</a></li>
    	<li><a href="javascript:divDisplay('lib_p_div');" target="mainFrame">微型图书馆&nbsp;-&nbsp;内容管理</a></li>
        <ul id="lib_p_div" style="display: none">
            <c:forEach var="dto" items="${libraryInfoDTOList}">
                <li><a href="javascript:divDisplay('lib_p_c_${dto.category.id}_div');" target="mainFrame">${dto.category.name}</a></li>
                <ul id="lib_p_c_${dto.category.id}_div" style="display: none">
                    <c:forEach var="dtocate" items="${dto.libraryInfoDTOList}">
                        <li><a href="${basePath}mg/library/library-list.htm?categoryId=${dtocate.category.id}" target="mainFrame">${dtocate.category.name}</a></li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </ul>
    </c:if>

</ul>
</body>
</html>