<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="footer">
   <div class="foot_nav"><a href="<%=request.getContextPath()%>/en/aboutus">About Us</a>   |  <a href="<%=request.getContextPath()%>/en/contactus"> Contact Us</a>   |  <a href="<%=request.getContextPath()%>/en/gb" > GuestBook</a>   |  <a href="<%=request.getContextPath()%>/en/siteMap"> SiteMap</a></div>
   <%
   cn.com.checne.model.domain.CompanyInfo footCompany = new cn.com.checne.dao.CompanyInfoDao().getCompanyInfo(3,2);
   out.print(footCompany.getContent());
   %>
</div>