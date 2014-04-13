<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmtString" uri="/string-tag" %>
<c:set var="basePathPort" value="${pageContext.request.serverPort}"/>
<c:choose>
    <c:when test="${basePathPort eq '80' }">
        <c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/"/>
    </c:when>
    <c:otherwise>
        <c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/"/>
    </c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${basePath}" />
<link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico" />
<META http-equiv="content-type" content="text/html; charset=UTF-8">
	<style type="text/css">
	<!--
	body,input {
		font-size: 12px;
		margin: 0;
		padding: 0;
		font-family: verdana, Arial, Helvetica, sans-serif;
		color: #000
	}
	
	body {
		text-align: center;
		margin: 0 auto
	}
	
	.title {
		background-color: #35AEE3;
		font-weight: bold;
		color: #fff;
		padding: 6px 10px 8px 7px;
	}
	
	.errMainArea {
		width: 546px;
		margin: 140px auto 0 auto;
		text-align: left;
		border: 1px solid #aaa
	}
	
	.errTxtArea {
		padding: 30px 34px 0 110px;
	}
	
	.errTxtArea .txt_title {
		font-size: 120%;
		font-weight: bolder;
		font-family: "Microsoft JhengHei", "微軟正黑體", "Microsoft YaHei", "微软雅黑";
	}
	
	.errBtmArea {
		padding: 10px 8px 25px 8px;
		background-color: #fff;
		text-align: center;
	}
	
	.btnFn1 {
		cursor: pointer !important;
		cursor: hand;
		height: 30px;
		width: 101px;
		padding: 3px 5px 0 0;
		font-weight: bold;
	}
	-->
	</style>

</HEAD>
<div class="errMainArea">
	<div class="title">系统提示</div>
	<div class="errTxtArea">
		<p class="txt_title">游客禁止访问！</p>
		<c:choose>
			<c:when test="${empty href}">
				<p><input type="button" class="btnFn1" value="返回" onclick="javascript:history.go(-1);" /></p>
			</c:when>
			<c:otherwise>
				<p><input type="button" class="btnFn1" value="返回" onclick="javascript:window.location='${basePath}${href}';" /></p>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="errBtmArea">
	</div>
</div>
</html>