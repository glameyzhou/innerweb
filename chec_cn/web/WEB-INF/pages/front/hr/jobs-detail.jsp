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
            <div class="left-tit">${defaultCategory.name}</div>
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
                <div class="acc_job_k" style="margin-left: 15px;">
                    <div class="cnt2">
                        <H2>${jobInfo.title}</H2>
                        <div class="zhaoxian_k">
                            <div class="shichang_box1 p_t7">
                                <div class="box1_cont">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="15%" height="24" class="grey">招聘人数：</td>
                                            <td width="28%" class="grey">${jobInfo.person}</td>
                                            <td width="15%" class="grey">工作地点：</td>
                                            <td width="42%" class="grey">${jobInfo.address}</td>
                                        </tr>
                                        <tr>
                                            <td height="24" class="grey">招聘部门：</td>
                                            <td class="grey">${jobInfo.category.name}</td>
                                            <td class="grey">联系方式：</td>
                                            <td class="grey">${jobInfo.contact}</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="acc_line"></div>
                            <div class="shichang_box1">
                                <h3>主要工作职责：</h3>
                                <div class="box1_cont zhaopin_content">${jobInfo.responsibility}</div>
                            </div>
                            <div class="acc_line"></div>
                            <div class="shichang_box1">
                                <h3>任职要求：</h3>
                                <div class="box1_cont zhaopin_content">${jobInfo.requirement}</div>
                            </div>
                        </div>
                    </div>
                    <div class="acc_btnapplication">
                        <span class="acc_button" onclick="javascript:applyJob('${jobInfo.jobId}');"></span>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="${basePath}jobs.htm"><span class="acc_view">查看所有职位</span></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp"%>
</div>
<script type="text/javascript">
    function applyJob(jobId){
        var url = '${basePath}jobs-apply-' + jobId + ".htm";
        window.location = url;
    }
</script>
</body>
</html>
