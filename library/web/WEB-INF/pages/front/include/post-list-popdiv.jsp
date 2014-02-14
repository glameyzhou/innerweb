<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <title>华电图书馆-您身边的能源行业情报秘书--最新公告</title>
    <link href="${basePath}res/front/library/css/index.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/library/css/footer.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function pop(postId) {
            window.parent.location = '${basePath}p-' + postId + '.htm';
        }
    </script>
</head>
<body>
<div class="box">
    <!--头部代码开始-->
    <!--头部代码结束-->
    <div class="center">
        <!--右半边代码开始-->
        <div class="center_right">
            <div class="neirong">
                <div class="neirong_tit">最新通知公告</div>
                <div class="neiye_right_con">
                    <c:choose>
                        <c:when test="${empty postList}">
                            <p>暂无最新通知公告</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="post" items="${postList}">
                                <ul class="con_neiye">
                                    <li><img src="${basePath}res/front/library/images/notice_list.png"/></li>
                                    <li><a href="javascript:pop('${post.id}');" title="${post.title}">${fmtString:substringAppend(post.title,50 ,'...' )}</a></li>
                                    <li style="float:right;">${fmtString:substring(post.time,10)}</li>
                                </ul>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <!--右半边代码结束-->
    </div>
</div>
</body>
</html>
