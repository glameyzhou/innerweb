<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page isELIgnored="false" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="java.util.List,java.util.ArrayList"%>
<%@ page import="cn.com.checne.model.domain.NewsInfo,cn.com.checne.model.domain.NewsCategory,cn.com.checne.model.dto.NewsQuery,cn.com.checne.dao.NewsCategoryDao,cn.com.checne.dao.NewsInfoDao"%>
<%@ page import="cn.com.checne.model.domain.IntroduceInfo,cn.com.checne.model.domain.IntroduceCategory,cn.com.checne.model.dto.IntroduceQuery,cn.com.checne.dao.IntroduceCategoryDao,cn.com.checne.dao.IntroduceInfoDao"%>
<%@ page import="cn.com.checne.model.domain.CultureInfo,cn.com.checne.model.domain.CultureCategory,cn.com.checne.model.dto.CultureQuery,cn.com.checne.dao.CultureCategoryDao,cn.com.checne.dao.CultureInfoDao"%>
<%@ page import="cn.com.checne.model.domain.BusinessInfo,cn.com.checne.model.domain.BusinessCategory,cn.com.checne.model.dto.BusinessQuery,cn.com.checne.dao.BusinessCategoryDao,cn.com.checne.dao.BusinessInfoDao"%>
<%@ page import="cn.com.checne.model.domain.PerformanceInfo,cn.com.checne.model.domain.PerformanceCategory,cn.com.checne.model.dto.PerformanceQuery,cn.com.checne.dao.PerformanceCategoryDao,cn.com.checne.dao.PerformanceInfoDao"%>
<%@ page import="cn.com.checne.model.domain.JobInfo,cn.com.checne.model.domain.JobCategory,cn.com.checne.model.domain.JobNewsInfo,cn.com.checne.model.domain.JobDept,cn.com.checne.model.dto.JobQuery,cn.com.checne.model.dto.JobNewsQuery,cn.com.checne.dao.JobCategoryDao,cn.com.checne.dao.JobInfoDao,cn.com.checne.dao.JobNewsInfoDao,cn.com.checne.dao.JobDeptDao"%>
<%@ page import="cn.com.checne.model.domain.CompanyInfo,cn.com.checne.dao.CompanyInfoDao"%>
<%@ page import="cn.com.checne.model.domain.FriendLinkInfo,cn.com.checne.dao.FriendLinkInfoDao"%>
<%@ page import="cn.com.checne.model.domain.GuestBookInfo,cn.com.checne.dao.GuestBookInfoDao"%>
<%@ page import="cn.com.checne.util.LanguageUtils,cn.com.checne.util.WebUtils,cn.com.checne.util.PageBean,cn.com.checne.util.StringTools,cn.com.checne.util.TimeUtils"%>
<%
String basePath = request.getContextPath() + "/" ;
String baseURI = request.getRequestURI() ;
String lg = "cn" ;
if(request.getContextPath().equals("/")){ // 根目录下的项目
	lg = request.getRequestURI().split("/")[1] ;
}else{
	lg = request.getRequestURI().split("/")[2] ;
}
System.out.println(lg);

String BASEPATH = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ request.getContextPath()+ "/";
String baseTitle = lg.equals("cn") ? "华电新能源技术开发公司" : "CHINA HUADIAN NEW ENERY DEV CO.,LTD"  ;
%>
