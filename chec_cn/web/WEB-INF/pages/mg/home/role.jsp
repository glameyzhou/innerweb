<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>中国华电工程（集团）有限公司</title>
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
</p>
<ul id="lmenu">
    <hr style="color: gray;">
    现在时间：<%=DateFormatUtils.format(new Date(),"yyyy年MM月dd日")%>
    <hr style="color: gray;">
    <li><a href="${basePath}mg/home/webInfo.do" target="mainFrame">欢迎界面</a></li>

    <hr style="color: gray;">
    <li><a href="${basePath}mg/user/user-personal-show.do?userId=${userInfo.userId}" target="mainFrame">个人信息管理</a></li>

    <%--公司简介--%>
    <hr style="color: gray;"/>
    <li><a href="${basePath}mg/category/category-list.do?pid=${categoryIntroduce.id}&type=${categoryIntroduce.categoryType}" target="mainFrame">分类管理-公司介绍</a></li>
    <c:forEach var="introduce" items="${categoryList_introduce}">
        <c:choose>
            <c:when test="${introduce.hasChild == 1}">
                <li><a href="javascript:divDisplay('introduce_div_${introduce.id}');">${introduce.name}</a></li>
                <ul id="introduce_div_${introduce.id}" style="display: none;">
                    <c:forEach var="child" items="${introduce.children}">
                        <li>
                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="mainFrame">${child.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="${basePath}mg/post/post-list.do?categoryId=${introduce.id}&type=${introduce.categoryType}" target="mainFrame">${introduce.name}</a>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>


    <%--公司新闻--%>
    <hr style="color: gray;">
    <li><a href="${basePath}mg/category/category-list.do?pid=${categoryNews.id}&type=${categoryNews.categoryType}" target="mainFrame">分类管理-公司新闻</a></li>
    <c:forEach var="news" items="${categoryList_news}">
        <c:choose>
            <c:when test="${news.hasChild == 1}">
                <li><a href="javascript:divDisplay('news_div_${news.id}');">${news.name}</a></li>
                <ul id="news_div_${news.id}" style="display: none;">
                    <c:forEach var="child" items="${news.children}">
                        <li>
                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="mainFrame">${child.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="${basePath}mg/post/post-list.do?categoryId=${news.id}&type=${news.categoryType}" target="mainFrame">${news.name}</a>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <%--业务概况--%>
    <hr style="color: gray;">
    <li><a href="${basePath}mg/category/category-list.do?pid=${categoryBusiness.id}&type=${categoryBusiness.categoryType}" target="mainFrame">分类管理-业务概况</a></li>
    <c:forEach var="business" items="${categoryList_business}">
        <c:choose>
            <c:when test="${business.hasChild == 1}">
                <li><a href="javascript:divDisplay('business_div_${business.id}');">${business.name}</a></li>
                <ul id="business_div_${business.id}" style="display: none;">
                    <c:forEach var="child" items="${business.children}">
                        <li>
                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="mainFrame">${child.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="${basePath}mg/post/post-list.do?categoryId=${business.id}&type=${business.categoryType}" target="mainFrame">${business.name}</a>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <%--公司业绩--%>
    <hr style="color: gray;">
    <li><a href="${basePath}mg/category/category-list.do?pid=${categoryPerformance.id}&type=${categoryPerformance.categoryType}" target="mainFrame">分类管理-公司业绩</a></li>
    <c:forEach var="performance" items="${categoryList_performance}">
        <c:choose>
            <c:when test="${business.hasChild == 1}">
                <li><a href="javascript:divDisplay('performance_div_${performance.id}');">${performance.name}</a></li>
                <ul id="performance_div_${performance.id}" style="display: none;">
                    <c:forEach var="child" items="${performance.children}">
                        <li>
                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="mainFrame">${child.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="${basePath}mg/post/post-list.do?categoryId=${performance.id}&type=${performance.categoryType}" target="mainFrame">${performance.name}</a>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <%--企业文化--%>
    <hr style="color: gray;">
    <li><a href="${basePath}mg/category/category-list.do?pid=${categoryCulture.id}&type=${categoryCulture.categoryType}" target="mainFrame">分类管理-企业文化</a></li>
    <c:forEach var="culture" items="${categoryList_culture}">
        <c:choose>
            <c:when test="${culture.hasChild == 1}">
                <li><a href="javascript:divDisplay('culture_div_${culture.id}');">${culture.name}</a></li>
                <ul id="culture_div_${culture.id}" style="display: none;">
                    <c:forEach var="child" items="${culture.children}">
                        <li>
                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="mainFrame">${child.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="${basePath}mg/post/post-list.do?categoryId=${culture.id}&type=${culture.categoryType}" target="mainFrame">${culture.name}</a>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <%--人力资源--%>
    <hr style="color: gray;">
    <li><a href="${basePath}mg/category/category-list.do?pid=${categoryHr.id}&type=${categoryHr.categoryType}" target="mainFrame">分类管理-人力资源</a></li>
    <c:forEach var="hr" items="${categoryList_hr}">
        <c:choose>
            <c:when test="${hr.hasChild == 1}">
                <li><a href="javascript:divDisplay('hr_div_${hr.id}');">${hr.name}</a></li>
                <ul id="hr_div_${hr.id}" style="display: none;">
                    <c:forEach var="child" items="${hr.children}">
                        <li>
                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="mainFrame">${child.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="${basePath}mg/post/post-list.do?categoryId=${hr.id}&type=${hr.categoryType}" target="mainFrame">${hr.name}</a>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <li>
        <a href="${basePath}mg/category/category-list.do?pid=${categoryDept.id}&type=${categoryDept.categoryType}" target="mainFrame">分类管理-招聘部门</a>
    </li>
    <li>
        <a href="${basePath}mg/job/job-list.do" target="mainFrame">招聘岗位管理</a>
    </li>
    <li>
        <a href="${basePath}mg/job/resume-list.do" target="mainFrame">简历管理</a>
    </li>


    <%--链接管理--%>
    <hr style="color: gray;">
    <li><a href="${basePath}mg/category/category-list.do?pid=${categoryLinks.id}&type=${categoryLinks.categoryType}" target="mainFrame">分类管理-链接</a></li>
    <c:forEach var="links" items="${categoryList_links}">
        <c:choose>
            <c:when test="${links.hasChild == 1}">
                <li><a href="javascript:divDisplay('links_div_${links.id}');">${links.name}</a></li>
                <ul id="links_div_${links.id}" style="display: none;">
                    <c:forEach var="child" items="${links.children}">
                        <li>
                            <a href="${basePath}mg/links/links-list.do?categoryId=${child.id}" target="mainFrame">${child.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="${basePath}mg/links/links-list.do?categoryId=${links.id}" target="mainFrame">${links.name}</a>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>


    <hr style="color: gray;">
    <%--系统功能权限配置--%>
    <li><a href="${basePath}mg/user/role-list.do" target="mainFrame">系统角色配置</a></li>
    <li><a href="${basePath}mg/user/user-list.do" target="mainFrame">系统用户配置</a></li>

    <%--全局配置--%>
    <hr style="color: gray;">
    <li><a href="${basePath}mg/sys/meta/contact_us/meta-show.do" target="mainFrame">联系我们</a></li>
    <%--accessLog--%>
    <%--<li><a href="${basePath}mg/sys/accessLog/list.do" target="mainFrame">访问日志</a></li>--%>

</ul>
</body>
</html>