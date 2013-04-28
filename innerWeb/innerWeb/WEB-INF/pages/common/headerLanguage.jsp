<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int languageId = (String)request.getSession().getAttribute(cn.com.checne.constants.Constants.SESSIONLANGUAGE) != null ? Integer.parseInt((String)request.getSession().getAttribute(cn.com.checne.constants.Constants.SESSIONLANGUAGE)) : 1 ;
%>
