<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/left-lanmu.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/job.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x" >
<div class="box">
    <%@include file="../include/header.jsp"%>
    <div class="content">
        <div class="neiye-left">
            <div class="left-tit">招聘公告</div>
            <div class="left-con lanmu">
                <ul>
                    <c:forEach var="category" items="${categoryList}">
                        <li>
                            <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/>
                            <a href="${basePath}band-${rootCategory.categoryType}.htm?cate=${category.id}">${category.name}</a>
                        </li>
                    </c:forEach>
                    <li class="lanmu-hover">
                        <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/><a href="${basePath}jobs.htm">招聘公告</a>
                    </li>
                </ul>
            </div>
            <%@include file="../include/frame-images.jsp"%>
        </div>
        <div class="neiye-right">
            <div class="weizhi">您所在的位置：<a href="${basePath}">首页</a>&nbsp;>&nbsp;<a href="${basePath}brand-${rootCategory.categoryType}.htm">${rootCategory.name}</a>&nbsp;>&nbsp;<a href="${basePath}jobs.htm">招聘公告</a></div>
            <div class="right-con">
                    <div class="job_k">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>按部门搜索：
                                    <select name="categoryId" onchange="javascript:searchJob(this.value);">
                                        <option value="">请选择部门</option>
                                        <c:forEach var="cate" items="${deptList}">
                                            <option value="${cate.id}" <c:if test="${cate.id eq query.categoryId}">selected="selected"</c:if>>${cate.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tableJob">
                            <tr>
                                <th>职位名称 </th>
                                <th>招聘人数 </th>
                                <th>工作地点 </th>
                                <th>招聘部门 </th>
                                <th>详 情</th>
                                <th>应聘该职位</th>
                            </tr>
                            <c:forEach var="job" items="${jobList}">
                                <tr>
                                    <td>${job.title}</td>
                                    <td>${job.person}</td>
                                    <td>${job.address}</td>
                                    <td>${job.category.name}</td>
                                    <td><a href="${basePath}jobs-${job.jobId}.htm">查看</a></td>
                                    <td><a href="${basePath}jobs-apply-${job.jobId}.htm">应聘</a></td>
                                </tr>
                            </c:forEach>
                        </table>
                        <p>
                            <c:set var="pageURL" value="${basePath}jobs.htm?categoryId=${query.categoryId}&"/>
                            <%@include file="../../common/pages.jsp"%>
                        </p>
                    </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp"%>
</div>
<script type="text/javascript">
    function searchJob(deptId){
        window.location = '${basePath}jobs.htm?categoryId=' + deptId;
    }
</script>
</body>
</html>
