<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="header">
	<div class="topnav">
	  <div class="topbar">
	     <div class="toplink"><a href="${basePath}rss?lg=cn" target="_blank">RSS订阅</a>  |  <a href="${basePath}cn/siteMap">网站地图</a>  |  <a href="${basePath}cn/contactus">联系我们</a>  |  <a href="<%=request.getContextPath()%>/en/">English</a> |  <a href="#">内网系统</a></div>
	     <div class="search">
	     <form action="${basePath}${lg}/search" method="get" accept-charset="UTF-8" name="searchFrom">
	          <input name="kw" type="text" class="input" id="textfield" value="${kw}" /><input type="submit" name="button" id="button" value="" class="btn" />
	     </form>
	     </div>
	  </div>
	  <h1 class="logo"><a href="${basePath}cn/"><img src="${basePath}res/front/images/logo.gif" width="393" height="44"  alt="华电新能源"/></a></h1>
	</div>


	<ul class="menu">
	  <li><a href="${basePath}cn/">首   页</a></li>
	  <li>
	  	<a href="${basePath}cn/introduce">公司概况</a>
	    <div class="sonmenu">
	    	<c:forEach var="introduceHeader" items="${introduceHeaderList}">
		    <a href="${basePath}cn/introduce?cateId=${introduceHeader.cateId}">${introduceHeader.name}</a>
		    </c:forEach>
		</div>
	   </li>
	  <li>
	  	<a href="${basePath}cn/business">业务领域</a>
	    <div class="sonmenu">
	    	<c:forEach var="businessHeader" items="${businessHeaderList}">
		    <a href="${basePath}cn/bcat?cateId=${businessHeader.cateId}">${businessHeader.name}</a>
		    </c:forEach>
		</div>
	  </li>           
	  <li>
	  	<a href="${basePath}cn/performance">公司业绩</a>
	    <div class="sonmenu">
	    	<c:forEach var="performanceHeader" items="${performanceHeaderList}">
		    <a href="${basePath}cn/performance?cateId=${performanceHeader.cateId}">${performanceHeader.name}</a>
		    </c:forEach>
		</div>
	  </li>           
	  <li>
	  	<a href="${basePath}cn/news">信息动态</a>
	    <div class="sonmenu">
	    	<c:forEach var="newsHeader" items="${newsHeaderList}">
		    <a href="${basePath}cn/news?cateId=${newsHeader.cateId}">${newsHeader.name}</a>
		    </c:forEach>
		</div>
	  </li>           
	  <li>
	  	<a href="${basePath}cn/culture">企业文化</a>
	    <div class="sonmenu">
	    	<c:forEach var="cultureHeader" items="${cultureHeaderList}">
		    <a href="${basePath}cn/culture?cateId=${cultureHeader.cateId}">${cultureHeader.name}</a>
		    </c:forEach>
		</div>
	  </li>           
	  <li class="last">
	  	<a href="${basePath}cn/job?cateId=8">诚聘英才</a>
	    <!--显示招聘的栏目 
	    <div class="sonmenu">
	    	<c:forEach var="jobHeader" items="${jobHeaderList}">
		    	<c:choose>
        			<c:when test="${jobHeader.isJob == 1}">
        				<a href="${basePath}${lg}/job?cateId=${jobHeader.cateId}">${jobHeader.name}</a>
        			</c:when>
        			<c:otherwise>
         	 			<a href="${basePath}${lg}/hr?cateId=${jobHeader.cateId}">${jobHeader.name}</a>
        			</c:otherwise>
        		</c:choose>
		    </c:forEach>
		</div>--> 
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
