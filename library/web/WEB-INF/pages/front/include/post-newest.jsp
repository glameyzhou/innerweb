<%@ page import="com.glamey.library.util.DateUtils" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.glamey.library.model.domain.LibraryInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.glamey.library.model.domain.UserInfo" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.glamey.framework.utils.StringTools" %>
<%@ page import="com.glamey.library.constants.Constants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style type="text/css">
    /*.postTitle_li {
        width: 260px;
    }*/
    .postTitle_a{
        display:block;
        float: left;
        width: 215px;
        white-space: nowrap;
        word-break: keep-all;
        overflow: hidden;
        text-overflow: ellipsis;
    }
</style>
<div class="notice">
    <div class="notice_top" onclick="javascript:window.location='${basePath}library-newest.htm?categoryId=EnQnii&src=left';"
         onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'" style="color: rgb(0, 0, 255); font-weight: bold;">最新荐读</div>
    <div class="notice_center">
        <ul>
            <%--<c:forEach var="p" items="${includePostList}">
                <li><a href="${basePath}p-${p.id}.htm" title="${p.title}">${fmtString:substringAppend(p.title,17,'...')}</a></li>
            </c:forEach>

            modify by zy 20140217 行业资讯从tbl_post转移到tbl_library中。
            --%>
            <%
                String basePath = request.getScheme() + "://" + request.getServerName() + (request.getServerPort() == 80 ? "" : ":" + request.getServerPort()) + request.getContextPath() + "/";
                List<LibraryInfo> includePostList = (List<LibraryInfo>) request.getAttribute("includePostList");
                UserInfo userInfo = (UserInfo) session.getAttribute(Constants.SESSIN_USERID);
                String libHref = "";
                for (LibraryInfo info : includePostList) {
                    if (info.getType() == 1 || info.getType() == 3) {
                        libHref = "href=\"" + info.getUrl() + "\" target=\"_blank\"";
                    }
                    else {
                        libHref = "href=\"" + basePath + "library-detail-" + info.getId() + ".htm\"";
                    }
             %>
                <li><a class="postTitle_a" <%=libHref%> title="<%=info.getName()%>"><%=info.getName()%></a></li>
             <%
                }
            %>
        </ul>
    </div>
    <div class="notice_bottom"></div>
</div>