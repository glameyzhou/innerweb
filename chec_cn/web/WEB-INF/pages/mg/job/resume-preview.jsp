<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico" />
<link href="${basePath}res/jeecms/css/resume/resume.css" rel="stylesheet" type="text/css"/>
<link href="${basePath}res/jeecms/css/resume/resume-layout.css" rel="stylesheet" type="text/css"/>
<title>${resume.name} -- 简历预览</title>
</head>
<body>
<div class="resumesLook" style="margin-left:50px;">
		<!-- 个人简介 -->
		<div class="resumesLookTop">
			<div class="resLookTopleft">
				<div class="lookLeftname">${resume.name}</div>
				<div class="lookLeftList">
					<ul>
						<li><c:if test="${resume.gender == 1}">男</c:if><c:if test="${resume.gender == 2}">女</c:if></li>
						<li>${fmtString:substring(resume.birthday,10)}</li>
						<li><c:if test="${resume.marriageStatus == 1}">已婚</c:if><c:if test="${resume.marriageStatus == 0}">未婚</c:if></li>
						<li><c:if test="${resume.politicsStatus == 1}">群众</c:if><c:if test="${resume.politicsStatus == 0}">党员</c:if></li>
						<li class="lookBordernone">身高${resume.height}CM</li>
					</ul>
				</div>
				<div class="lookLeftMain">${resume.email}</div>
				<div class="lookLeftMain">${resume.areaCode}-${resume.telephone}</div>
				<div class="lookLeftMain"></div>
			</div>
   			<c:set var="isHttpImage" value="${fn:startsWith(resume.image,'http')}"/>
			<div class="resLookTopright">
				<div class="resLookToprightimg">
					<c:choose>
						<c:when test="${empty resume.image}"><img src="" width="70" height="90" /></c:when>
						<c:otherwise>
							<img src="<c:if test="${!isHttpImage}">${basePath}</c:if>${resume.image}" width="70" height="90" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	<div class="resumesLookAll">
		
		<!-- 教育经历-->
		<div class="resumesLookMain">
			<div class="resumesLookTitle">教育经历</div>
		</div>
		<c:if test="${fn:length(resume.resumeEducationList) > 0}">
			<c:forEach var="ed" items="${resume.resumeEducationList}">
				<div class="resumesLookMain">
					<div class="resumesLookTips">${ed.start} -- ${ed.end}</div>
					<div class="lookLeftList lookLeftListStrong">
						<ul>
							<li class="lookBordernone">${ed.school}</li>
						</ul>
					</div>
					<div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">专业：</div>
							<div class="detailsMain">${ed.profession}</div>
						</div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">学历：</div>
							<div class="detailsMain">${ed.background}</div>
						</div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">学位：</div>
							<div class="detailsMain">${ed.egree}</div>
						</div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">学习形式：</div>
							<div class="detailsMain">${ed.category}</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	
		<!-- 工作经历 -->
		<div class="resumesLookMain">
			<div class="resumesLookTitle">工作经历</div>
		</div>
		<c:if test="${fn:length(resume.resumeWorkList) > 0}">
			<c:forEach var="wk" items="${resume.resumeWorkList}">
				<div class="resumesLookMain">
					<div class="resumesLookTips">${wk.start} -- ${wk.end}</div>
					<div class="lookLeftList lookLeftListStrong">
						<ul>
							<li class="lookBordernone">${wk.company}</li>
						</ul>
					</div>
					<div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">工作岗位：</div>
							<div class="detailsMain">${wk.station}</div>
						</div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">证明人：</div>
							<div class="detailsMain">${wk.provePerson}</div>
						</div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">联系方式：</div>
							<div class="detailsMain">${wk.contact}responsibility</div>
						</div>
					</div>
					<div class="resumesLookDetails">
						<div class="resumesLookWord">工作职责：</div>
						<div class="detailsMain">${wk.responsibility}</div>
					</div>
			
					<div class="resumesLookDetails">
						<div class="resumesLookWord">离职原因：</div>
						<div class="detailsMain">${wk.leaveReason}</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		
		<!--所获证书-->
		<div class="resumesLookMain">
			<div class="resumesLookTitle">所获证书</div>
		</div>
		<c:if test="${fn:length(resume.resumeCertificaeList) > 0}">
			<c:forEach var="cf" items="${resume.resumeCertificaeList}">
				<div class="resumesLookMain">
					<div class="resumesLookTips">${cf.time}</div>
					<div class="lookLeftList lookLeftListStrong">
						<ul>
							<li class="lookBordernone">${cf.name}</li>
							<li class="lookBordernone">${cf.company}</li>
						</ul>
					</div>
				</div>
			</c:forEach>
		</c:if>
		
	
		<!--培训经历-->
		<div class="resumesLookMain">
			<div class="resumesLookTitle">培训经历</div>
		</div>
		<c:if test="${fn:length(resume.resumeTrainList) > 0}">
			<c:forEach var="tr" items="${resume.resumeTrainList}">
				<div class="resumesLookMain">
					<div class="resumesLookTips">${tr.start} 至   ${tr.end}</div>
					<div class="lookLeftList lookLeftListStrong">
						<ul>
							<li class="lookBordernone">${tr.company}</li>
						</ul>
					</div>
					<div class="resumesLookDetails">
						<div class="resumesLookWord">培训内容：</div>
						<div class="detailsMain">${tr.content}</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		
		<!-- 家庭情况 -->
	    <div class="resumesLookMain"  ><div class="resumesLookTitle">家庭情况</div></div>
		<c:if test="${fn:length(resume.resumeFamilyList) > 0}">
			<c:forEach var="fa" items="${resume.resumeFamilyList}">
				<div class="resumesLookMain resumesLookBorder">
					<div class="lookLeftList lookLeftListStrong">
						<ul>
							<li class="lookBordernone">${fa.relation}</li>
						</ul>
					</div>
					<div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">姓名：</div>
							<div class="detailsMain">${fa.name}</div>
						</div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">工作单位：</div>
							<div class="detailsMain">${fa.company}</div>
						</div>
						<div class="resumesLookDetails">
							<div class="resumesLookWord">职位：</div>
							<div class="detailsMain">${fa.station}</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		
		<!-- 工作业绩 -->
	    <div class="resumesLookMain" >
		   <div class="resumesLookTitle">工作业绩</div>
		   <c:if test="${not empty resume.performance}">
				<div class="resumesLookMain mainIntro">${resume.performance}</div>
		   </c:if>
		</div>
		
		<!-- 奖惩经历 -->
	    <div class="resumesLookMain" >
		   <div class="resumesLookTitle">奖惩经历</div>
		   <c:if test="${not empty resume.rewardsPunishment}">
		   		<div class="resumesLookMain mainIntro">${resume.rewardsPunishment}</div>
		   </c:if>
		</div>
		
		<!-- 职业生涯规划 -->
	    <div class="resumesLookMain" >
		   <div class="resumesLookTitle">职业生涯规划</div>
		   <c:if test="${not empty resume.careerPlanning}">
		   		<div class="resumesLookMain mainIntro">${resume.careerPlanning}</div>
		   </c:if>
		</div>
		
		<!-- 个人简介 -->
	    <div class="resumesLookMain" >
		   <div class="resumesLookTitle">个人简介</div>
		   <c:if test="${not empty resume.personalHobbies}">
		   <div class="resumesLookMain mainIntro">${resume.personalHobbies}</div>
		   </c:if>
		</div>
	</div>
</div>
</body>
</html>