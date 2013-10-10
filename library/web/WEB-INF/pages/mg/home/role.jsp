<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>华电图书馆-您身边的能源行业情报秘书</title>
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
<p style="font: bold;color: #ff0000;">
    <%--&nbsp;角色&nbsp;
    <c:forEach var="role" items="${userInfo.roleInfoList}">
        ${role.roleName}<br/>
    </c:forEach>--%>
</p>
<ul id="lmenu">

    <li><a href="${basePath}mg/home/webInfo.htm" target="mainFrame">欢迎界面</a></li>
    <li><a href="${basePath}mg/user/user-psersonal-show.htm?userId=${userInfo.userId}" target="mainFrame">个人信息管理</a></li>
    <li><a href="${basePath}mg/library/library-collect.htm?userId=${userInfo.userId}" target="mainFrame">个人收藏夹</a></li>

    <%--咨询公告--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'01')}">
        <li><a href="${basePath}mg/post/post-list.htm" target="mainFrame">咨询公告管理</a></li>
    </c:if>


    <%--微型图书馆管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'05_category_manage')}">
        <li><a href="${basePath}mg/library/category-list.htm?pid=0" target="mainFrame">微型图书馆&nbsp;-&nbsp;分类栏目管理</a></li>
    </c:if>
    <c:if test="${fmtString:hasRightsList(rightsList,'05_category_move')}">
        <li><a href="${basePath}mg/library/library-merge-show.htm" target="mainFrame">微型图书馆&nbsp;-&nbsp;分类转移合并</a></li>
    </c:if>

    <li><a href="javascript:divDisplay('lib_p_div');" target="mainFrame">微型图书馆&nbsp;-&nbsp;内容管理</a></li>
    <ul id="lib_p_div" style="display: none;">
        <c:forEach var="dto" items="${libraryInfoDTOList}">
            <c:set var="libId" value="05_${dto.category.id}"/>
            <c:if test="${fmtString:hasRightsList(rightsList,libId)}">
                <li><a href="javascript:divDisplay('lib_p_c_${dto.category.id}_div');" target="mainFrame">${dto.category.name}</a></li>
                <ul id="lib_p_c_${dto.category.id}_div" style="display: none">
                    <c:forEach var="dtocate" items="${dto.libraryInfoDTOList}">
                        <li>
                            <a href="${basePath}mg/library/library-list.htm?categoryId=${dtocate.category.id}" target="mainFrame">
                        <font style="font-size: 8px;">${dtocate.category.name}</font>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </c:forEach>
    </ul>

    <%--友情链接分类管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'02')}">
        <li><a href="${basePath}mg/links/${categoryFriendlyLinks.aliasName}/category-list.htm" target="mainFrame">友情链接 - 分类管理</a></li>
        <li><a href="javascript:divDisplay('${categoryFriendlyLinks.id}_div');">${categoryFriendlyLinks.name} - 链接管理</a></li>
        <ul id="${categoryFriendlyLinks.id}_div" style="display: none">
            <c:forEach var="cate" items="${categoryFriendlyLinksList}">
                <li><a href="${basePath}mg/links/${categoryFriendlyLinks.aliasName}/links-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
            </c:forEach>
        </ul>
    </c:if>

    <%--常用链接管理--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'08')}">
        <li><a href="${basePath}mg/links/${categoryOfenLinks.aliasName}/category-list.htm" target="mainFrame">常用链接 - 分类管理</a></li>
        <li><a href="javascript:divDisplay('${categoryOfenLinks.id}_div');">${categoryOfenLinks.name} - 链接管理</a></li>
        <ul id="${categoryOfenLinks.id}_div" style="display: none">
            <c:forEach var="cate" items="${categoryOfenLinksList}">
                <li><a href="${basePath}mg/links/${categoryOfenLinks.aliasName}/links-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
            </c:forEach>
        </ul>
    </c:if>


    <c:if test="${fmtString:hasRightsList(rightsList,'07')}">
        <li><a href="${basePath}mg/feedback/list.htm" target="mainFrame">在线留言管理</a></li>
    </c:if>

    <%--系统功能权限配置
    <li><a href="${basePath}mg/user/rights-list.htm" target="mainFrame">功能权限配置</a></li>--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'03')}">
        <li><a href="${basePath}mg/user/role-list.htm" target="mainFrame">系统角色配置</a></li>
    </c:if>
    <c:if test="${fmtString:hasRightsList(rightsList,'04')}">
        <li><a href="${basePath}mg/user/user-list.htm" target="mainFrame">系统用户配置</a></li>
    </c:if>

    <%--全局配置--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'06')}">
        <li><a href="${basePath}mg/sys/sys-list.htm" target="mainFrame">全局配置</a></li>
    </c:if>

</ul>
</body>
</html>