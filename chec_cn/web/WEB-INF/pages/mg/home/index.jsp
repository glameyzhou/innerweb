<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage=""%>
<%@ include file="../../common/tagInclude.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>后台管理中心--中国华电工程（集团）有限公司</title>
<link href="${basePath}res/jeecms/new/common.css" rel="stylesheet" type="text/css" />
<link href="${basePath}res/jeecms/new/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${basePath}res/jeecms/new/jquery.js"></script>
<style type="text/css">
* {
	font: 12px tahoma, Arial, Verdana, sans-serif;
}

html,body {
	width: 100%;
	height: 100%;
	overflow: hidden;
}
</style>
<script type="text/javascript">
    $().ready(function() {

        /*var $nav = $("#nav a:not(:last)");*/
        var $nav = $("#nav a");
        var $menu = $("#menu dl");
        var $menuItem = $("#menu a");

        $nav.click(function() {
            var $this = $(this);
            $nav.removeClass("current");
            $this.addClass("current");
            var $currentMenu = $($this.attr("href"));
            $menu.hide();
            $currentMenu.show();
            $('#iframe').attr('src',$($currentMenu.find("dd a")[0]).attr('href'));
            return true;
        });

        $menuItem.click(function() {
            var $this = $(this);
            $menuItem.removeClass("current");
            $this.addClass("current");
        });

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
<body>
	<script type="text/javascript">
		if (self != top) {
			top.location = self.location;
		};
	</script>
	<table class="main">
		<tr>
			<th class="logo"><a href="${ctx}" target="_blank"> <img src="${basePath}res/front/chec_cn/images/logo.jpg" width="160" height="47">
			</a></th>
			<th>
				<div id="nav" class="nav">
					<ul>
						<li><a href="#index">首页</a></li>
                        <c:if test="${fmtString:hasRightsList(rightsList,'1-')}">
                            <li><a href="#introduce">公司介绍</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'2-')}">
                            <li><a href="#news">公司新闻</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'3-')}">
                            <li><a href="#jcsj">监察审计</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'4-')}">
                            <li><a href="#business">业务概况</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'5-')}">
                            <li><a href="#performance">公司业绩</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'6-')}">
                            <li><a href="#culture">企业文化</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'7-')}">
                            <li><a href="#hr">人力资源</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'8-')}">
                            <li><a href="#links">系统链接</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'9-')}">
                            <li><a href="#periodical">华电期刊</a></li>
                        </c:if>
                        <c:if test="${fmtString:hasRightsList(rightsList,'10-')}">
                            <li><a href="#setting">系统管理</a></li>
                        </c:if>
                        <%--<c:if test="${fmtString:hasRightsList(rightsList,'10-')}">
                            <li><a href="#websiteInfo">站外消息</a></li>
                        </c:if>--%>
						<%--<li><a href="${basePath}front/index.do" target="_blank">前台预览</a></li>--%>
					</ul>
				</div>
				<div class="link">
					<strong>${userInfo.nickname}</strong> |
                    <a href="${basePath}" target="_blank">首页</a> |
                    <a href="${basePath}mg/logout.do" target="_top">[注销]</a>
				</div>
                <div class="link">
                    <input type="button" value="后退" onclick="javascript:history.go(-1);"/>&nbsp;&nbsp;
                    <%--<input type="button" value="刷新" onclick="javascript:history.go(0);"/>&nbsp;&nbsp;--%>
                    <input type="button" value="前进" onclick="javascript:history.go(1);"/>&nbsp;&nbsp;
                </div>
            </th>
		</tr>
		<tr>
			<td id="menu" class="menu">
				<dl id="index" class="default">
                    <dt>欢迎页面</dt>
					<dd>
                        <a href="${basePath}mg/home/webInfo.do" target="iframe">系统属性</a>
					</dd>
                    <dd>
                        <a href="${basePath}mg/user/user-personal-show.do?userId=${userInfo.userId}" target="iframe">个人信息管理</a>
					</dd>
				</dl>
				<dl id="introduce" class="default" style="display: none;">
					<dt>栏目管理</dt>
					<dd>
						<a href="${basePath}mg/category/category-list.do?pid=${categoryIntroduce.id}&type=${categoryIntroduce.categoryType}" target="iframe">公司介绍栏目管理</a>
					</dd>
					<dt>内容管理</dt>
                    <c:forEach var="introduce" items="${categoryList_introduce}">
                        <c:choose>
                            <c:when test="${introduce.hasChild == 1}">
                                <dd><a href="javascript:divDisplay('introduce_div_${introduce.id}');">${introduce.name}</a></dd>
                                <dl id="introduce_div_${introduce.id}" style="display: none;">
                                    <c:forEach var="child" items="${introduce.children}">
                                        <dd>
                                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="iframe">${child.name}</a>
                                        </dd>
                                    </c:forEach>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <dd>
                                    <a href="${basePath}mg/post/post-list.do?categoryId=${introduce.id}&type=${introduce.categoryType}" target="iframe">${introduce.name}</a>
                                </dd>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
				</dl>

                <dl id="news" class="default" style="display: none;">
					<dt>栏目管理</dt>
					<dd>
						<a href="${basePath}mg/category/category-list.do?pid=${categoryNews.id}&type=${categoryNews.categoryType}" target="iframe">新闻栏目管理</a>
					</dd>
					<dt>内容管理</dt>
                    <c:forEach var="news" items="${categoryList_news}">
                        <c:choose>
                            <c:when test="${news.hasChild == 1}">
                                <dd><a href="javascript:divDisplay('news_div_${news.id}');">${news.name}</a></dd>
                                <dl id="news_div_${news.id}" style="display: none;">
                                    <c:forEach var="child" items="${news.children}">
                                        <dd>
                                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="iframe">${child.name}</a>
                                        </dd>
                                    </c:forEach>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <dd>
                                    <a href="${basePath}mg/post/post-list.do?categoryId=${news.id}&type=${news.categoryType}" target="iframe">${news.name}</a>
                                </dd>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
				</dl>
                <dl id="jcsj" class="default" style="display: none;">
					<dt>栏目管理</dt>
					<dd>
						<a href="${basePath}mg/category/category-list.do?pid=${categoryJcsj.id}&type=${categoryJcsj.categoryType}" target="iframe">监察审计栏目管理</a>
					</dd>
					<dt>内容管理</dt>
                    <c:forEach var="news" items="${categoryList_jcsj}">
                        <c:choose>
                            <c:when test="${news.hasChild == 1}">
                                <dd><a href="javascript:divDisplay('news_div_${news.id}');">${news.name}</a></dd>
                                <dl id="news_div_${news.id}" style="display: none;">
                                    <c:forEach var="child" items="${news.children}">
                                        <dd>
                                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="iframe">${child.name}</a>
                                        </dd>
                                    </c:forEach>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <dd>
                                    <a href="${basePath}mg/post/post-list.do?categoryId=${news.id}&type=${news.categoryType}" target="iframe">${news.name}</a>
                                </dd>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
				</dl>
				<dl id="business" class="default" style="display: none;">
                    <dt>栏目管理</dt>
                    <dd>
                        <a href="${basePath}mg/category/category-list.do?pid=${categoryBusiness.id}&type=${categoryBusiness.categoryType}" target="iframe">业务概况栏目管理</a>
                        <a href="${basePath}mg/category/root-category-show.do?categoryId=${categoryBusiness.id}" target="iframe">业务概况描述设置</a>
                    </dd>
                    <dt>内容管理</dt>
                    <c:forEach var="business" items="${categoryList_business}">
                        <c:choose>
                            <c:when test="${business.hasChild == 1}">
                                <dd><a href="javascript:divDisplay('business_div_${business.id}');">${business.name}</a></dd>
                                <dl id="business_div_${business.id}" style="display: none;">
                                    <c:forEach var="child" items="${business.children}">
                                        <dd>
                                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="iframe">${child.name}</a>
                                        </dd>
                                    </c:forEach>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <dd>
                                    <a href="${basePath}mg/post/post-list.do?categoryId=${business.id}&type=${business.categoryType}" target="iframe">${business.name}</a>
                                </dd>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
				</dl>
                <dl id="performance" class="default" style="display: none;">
                    <dt>栏目管理</dt>
                    <dd>
                        <a href="${basePath}mg/category/category-list.do?pid=${categoryPerformance.id}&type=${categoryPerformance.categoryType}" target="iframe">公司业绩栏目管理</a>
                    </dd>
                    <dt>内容管理</dt>
                    <c:forEach var="performance" items="${categoryList_performance}">
                        <c:choose>
                            <c:when test="${business.hasChild == 1}">
                                <dd><a href="javascript:divDisplay('performance_div_${performance.id}');">${performance.name}</a></dd>
                                <dl id="performance_div_${performance.id}" style="display: none;">
                                    <c:forEach var="child" items="${performance.children}">
                                        <li>
                                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="iframe">${child.name}</a>
                                        </li>
                                    </c:forEach>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <dd>
                                    <a href="${basePath}mg/post/post-list.do?categoryId=${performance.id}&type=${performance.categoryType}" target="iframe">${performance.name}</a>
                                </dd>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </dl>
                <dl id="culture" class="default" style="display: none;">
                    <dt>栏目管理</dt>
                    <dd>
                        <a href="${basePath}mg/category/category-list.do?pid=${categoryCulture.id}&type=${categoryCulture.categoryType}" target="iframe">企业文化栏目管理</a>
                    </dd>
                    <dt>内容管理</dt>
                    <c:forEach var="culture" items="${categoryList_culture}">
                        <c:choose>
                            <c:when test="${culture.hasChild == 1}">
                                <dd><a href="javascript:divDisplay('culture_div_${culture.id}');">${culture.name}</a></dd>
                                <dl id="culture_div_${culture.id}" style="display: none;">
                                    <c:forEach var="child" items="${culture.children}">
                                        <dd>
                                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="iframe">${child.name}</a>
                                        </dd>
                                    </c:forEach>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <dd>
                                    <a href="${basePath}mg/post/post-list.do?categoryId=${culture.id}&type=${culture.categoryType}" target="iframe">${culture.name}</a>
                                </dd>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </dl>
                <dl id="hr" class="default" style="display: none;">
                    <dt>栏目管理</dt>
                    <dd>
                        <a href="${basePath}mg/category/category-list.do?pid=${categoryHr.id}&type=${categoryHr.categoryType}" target="iframe">人力资源栏目管理</a>
                    </dd>
                    <dt>内容管理</dt>
                    <c:forEach var="hr" items="${categoryList_hr}">
                        <c:choose>
                            <c:when test="${hr.hasChild == 1}">
                                <dd><a href="javascript:divDisplay('hr_div_${hr.id}');">${hr.name}</a></dd>
                                <dl id="hr_div_${hr.id}" style="display: none;">
                                    <c:forEach var="child" items="${hr.children}">
                                        <dd>
                                            <a href="${basePath}mg/post/post-list.do?categoryId=${child.id}&type=${child.categoryType}" target="iframe">${child.name}</a>
                                        </dd>
                                    </c:forEach>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <dd>
                                    <a href="${basePath}mg/post/post-list.do?categoryId=${hr.id}&type=${hr.categoryType}" target="iframe">${hr.name}</a>
                                </dd>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <dt>招聘管理</dt>
                    <dd>
                        <a href="${basePath}mg/category/category-list.do?pid=${categoryDept.id}&type=${categoryDept.categoryType}" target="iframe">招聘部门管理</a>
                    </dd>
                    <dd>
                        <a href="${basePath}mg/job/job-list.do" target="iframe">招聘岗位管理</a>
                    </dd>
                    <dd>
                        <a href="${basePath}mg/job/resume-list.do" target="iframe">简历管理</a>
                    </dd>
                </dl>
                <dl id="links" class="default" style="display: none;">
                    <dt>栏目管理</dt>
                    <dd>
                        <a href="${basePath}mg/category/category-list.do?pid=${categoryLinks.id}&type=${categoryLinks.categoryType}" target="iframe">链接分类管理</a>
                    </dd>
                    <dt>内容管理</dt>
                    <c:forEach var="links" items="${categoryList_links}">
                        <c:choose>
                            <c:when test="${links.hasChild == 1}">
                                <dd><a href="javascript:divDisplay('links_div_${links.id}');">${links.name}</a></dd>
                                <dl id="links_div_${links.id}" style="display: none;">
                                    <c:forEach var="child" items="${links.children}">
                                        <dd>
                                            <a href="${basePath}mg/links/links-list.do?categoryId=${child.id}" target="iframe">${child.name}</a>
                                        </dd>
                                    </c:forEach>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <dd>
                                    <a href="${basePath}mg/links/links-list.do?categoryId=${links.id}" target="iframe">${links.name}</a>
                                </dd>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </dl>
                <dl id="periodical" class="default" style="display: none;">
                    <dt>期刊管理</dt>
                    <dd><a href="${basePath}mg/periodical/list.do" target="iframe">期刊管理</a></dd>
                </dl>
                <dl id="setting" class="default" style="display: none;">
                    <dt>用户管理</dt>
                    <dd><a href="${basePath}mg/user/role-list.do" target="iframe">系统角色配置</a></dd>
                    <dd><a href="${basePath}mg/user/user-list.do" target="iframe">系统用户配置</a></dd>
                    <dt>全局配置</dt>
                    <dd><a href="${basePath}mg/sys/buildLucene.do" target="iframe">建立索引</a></dd>
                    <dd><a href="${basePath}mg/sys/meta/contact_us/meta-show.do" target="iframe">联系我们</a></dd>
                </dl>
                <%--<dl id="websiteInfo" class="default" style="display: none;">
                    <dd><a href="${basePath}mg/websiteInfo/website/list.do" target="iframe">分站信息</a></dd>
                    <dd><a href="${basePath}mg/websiteInfo/content/show.do" target="iframe">新增消息</a></dd>
                    <dd><a href="${basePath}mg/websiteInfo/content/list.do" target="iframe">消息列表</a></dd>
                </dl>--%>
			</td>
			<td>
                <iframe id="iframe" name="iframe" src="${basePath}mg/home/webInfo.do" frameborder="0"></iframe>
            </td>

		</tr>
	</table>
</body>
</html>