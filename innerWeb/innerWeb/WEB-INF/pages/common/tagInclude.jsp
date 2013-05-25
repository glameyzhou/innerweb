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
