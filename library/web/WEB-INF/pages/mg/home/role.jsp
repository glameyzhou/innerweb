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
        <li><a href="${basePath}mg/post/post-list.htm?categoryId=QbINfy" target="mainFrame">通知公告管理</a></li>
    </c:if>
    <%--行业资讯管理，已经废弃，转移到图书管理分类中--%>
    <%--<c:if test="${fmtString:hasRightsList(rightsList,'10')}">
        <li><a href="${basePath}mg/post/post-list.htm?categoryId=73aANz" target="mainFrame">行业资讯管理</a></li>
    </c:if>--%>


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
                <c:choose>
                    <c:when test="${dto.category.hasChild == 1}">
                        <li><a href="javascript:divDisplay('lib_p_c_${dto.category.id}_div');" target="mainFrame">${dto.category.name}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a href="${basePath}mg/library/library-list.htm?categoryId=${dto.category.id}" target="mainFrame">
                                <font style="font-size: 8px;">${dto.category.name}</font>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
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

    <%--滚动图片--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'09')}">
        <li><a href="${basePath}mg/links/${categoryRollingImages.aliasName}/category-list.htm" target="mainFrame">${categoryRollingImages.name} - 分类管理</a></li>
        <li><a href="javascript:divDisplay('${categoryRollingImages.id}_div');">${categoryRollingImages.name} - 链接管理</a></li>
        <ul id="${categoryRollingImages.id}_div" style="display: none">
            <c:forEach var="cate" items="${categoryRollingImagesList}">
                <li><a href="${basePath}mg/rolling/rolling-list.htm?categoryId=${cate.id}" target="mainFrame">${cate.name}</a></li>
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

    <%--accessLog--%>
    <c:if test="${fmtString:hasRightsList(rightsList,'11')}">
        <li><a href="${basePath}mg/sys/accessLog/list.htm" target="mainFrame">访问日志</a></li>
    </c:if>

    <li><a href="javascript:divDisplay('bbs_div');">论坛管理</a></li>
    <ul id="bbs_div" style="display: none">
        <li><a href="${basePath}mg/library/category-list.htm?pid=0&type=bbs" target="mainFrame">板块设置</a></li>
        <li><a href="${basePath}mg/bbs/brand-manager.htm" target="mainFrame">版主设置</a></li>
        <c:forEach var="bbs" items="${categoryBBSList}">
            <li><a href="${basePath}mg/bbs/post-list.htm?categoryId=${bbs.id}" target="mainFrame">${bbs.name}-主帖管理</a></li>
        </c:forEach>
    </ul>
</ul>
</body>
</html>