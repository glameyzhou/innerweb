<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="page" cellpadding="0" cellspacing="0">
	<tr>
		<td align="left">Total:${pageBean.maxRowCount} RowsPerPage:${pageBean.rowsPerPage} CurPage:${pageBean.curPage}/${pageBean.maxPage}</td>
		<td align="right">
			<c:choose>
				<c:when test="${pageBean.curPage > 1 }">
					<a href="${pageURL}curPage=1">First</a> <a href="${pageURL}curPage=${pageBean.curPage-1}">Previous</a>
				</c:when>
				<c:otherwise>First Previous</c:otherwise>
			</c:choose>
			<c:forEach items="${pageBean.pageNoList}" var="i">
				<c:choose>
					<c:when test="${i==pageBean.curPage}">${i}</c:when>
					<c:otherwise><a href="${pageURL}curPage=${i}">${i}</a></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${pageBean.curPage < pageBean.maxPage }">
					<a href="${pageURL}curPage=${pageBean.curPage + 1 }">Next</a> <a href="${pageURL}curPage=${pageBean.maxPage}">Last</a>
				</c:when>
				<c:otherwise>Next Last</c:otherwise>
			</c:choose>
  		</td>
	</tr>
</table>

