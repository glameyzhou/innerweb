<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="header">
	<div class="topnav">
	  <div class="topbar">
	     <div class="toplink"><a href="${basePath}rss?lg=en" target="_blank">RSS</a>  |  <a href="${basePath}en/siteMap">SiteMap</a>  |  <a href="${basePath}en/contactus">Contact US</a>  |  <a href="<%=request.getContextPath()%>/cn/">中文</a> |  <a href="#">Inner System</a></div>
	     <div class="search">
	     <form action="${basePath}${lg}/search" method="get" accept-charset="UTF-8" name="searchFrom">
	          <input name="kw" type="text" class="input" id="textfield" value="${kw}" /><input type="submit" name="button" id="button" value="" class="btn" />
	     </form>
	     </div>
	  </div>
	  <h1 class="logo"><a href="${basePath}en/"><img src="${basePath}res/front/images/logo_en.jpg" width="393" height="44"  alt="HuaDian"/></a></h1>
	</div>


	<ul class="menu">
	  <li><a href="${basePath}en/">Home</a></li>
	  <li>
	  	<a href="${basePath}en/introduce">Company Introduce</a>
	    <div class="sonmenu">
	    	<c:forEach var="introduceHeader" items="${introduceHeaderList}">
		    <a href="${basePath}en/introduce?cateId=${introduceHeader.cateId}">${introduceHeader.name}</a>
		    </c:forEach>
		</div>
	   </li>
	  <li>
	  	<a href="${basePath}en/business">Business Scope</a>
	    <div class="sonmenu">
	    	<c:forEach var="businessHeader" items="${businessHeaderList}">
		    <a href="${basePath}en/bcat?cateId=${businessHeader.cateId}">${businessHeader.name}</a>
		    </c:forEach>
		</div>
	  </li>           
	  <li>
	  	<a href="${basePath}en/performance">Performance</a>
	    <div class="sonmenu">
	    	<c:forEach var="performanceHeader" items="${performanceHeaderList}">
		    <a href="${basePath}en/performance?cateId=${performanceHeader.cateId}">${performanceHeader.name}</a>
		    </c:forEach>
		</div>
	  </li>           
	  <li>
	  	<a href="${basePath}en/news">News Information</a>
	    <div class="sonmenu">
	    	<c:forEach var="newsHeader" items="${newsHeaderList}">
		    <a href="${basePath}en/news?cateId=${newsHeader.cateId}">${newsHeader.name}</a>
		    </c:forEach>
		</div>
	  </li>           
	  <li>
	  	<a href="${basePath}en/culture">Company Culture</a>
	    <div class="sonmenu">
	    	<c:forEach var="cultureHeader" items="${cultureHeaderList}">
		    <a href="${basePath}en/culture?cateId=${cultureHeader.cateId}">${cultureHeader.name}</a>
		    </c:forEach>
		</div>
	  </li>           
	  <li class="last">
	  	<a href="${basePath}en/hr">Join us</a>
	    <div class="sonmenu">
	    	<c:forEach var="jobHeader" items="${jobHeaderList}">
		    	<c:choose>
        			<c:when test="${jobHeader.isJob == 1}">
        				<!-- <a href="${basePath}${lg}/job?cateId=${jobHeader.cateId}">${jobHeader.name}</a> -->
        			</c:when>
        			<c:otherwise>
         	 			<a href="${basePath}${lg}/hr?cateId=${jobHeader.cateId}">${jobHeader.name}</a>
        			</c:otherwise>
        		</c:choose>
		    </c:forEach>
		</div>
	  </li> 
	</ul>
</div>

<div class="ggw">
        <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"  width="1002" height="276">
	  <param name="movie" value="${basePath}res/front/flash/top.swf" />
	  <param name="quality" value="high" />
	  <param name="wmode" value="transparent" />
	  <embed src="${basePath}res/front/flash/top.swf" quality="high" wmode="transparent" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"  width="1002" height="276"></embed>
	</object>
</div>
