<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="page" cellpadding="0" cellspacing="0">
	<tr>
		<td align="left">共${pageBean.maxRowCount}条 每页${pageBean.rowsPerPage}条 页次:${pageBean.curPage}/${pageBean.maxPage}</td>
		<td align="right">
			<c:choose>
				<c:when test="${pageBean.curPage > 1 }">
					<a href="${pageURL}curPage=1">首页</a> <a href="${pageURL}curPage=${pageBean.curPage-1}">上一页</a>
				</c:when>
				<c:otherwise>首页 上一页</c:otherwise>
			</c:choose>
			<c:forEach items="${pageBean.pageNoList}" var="i">
				<c:choose>
					<c:when test="${i==pageBean.curPage}">${i}</c:when>
					<c:otherwise><a href="${pageURL}curPage=${i}">${i}</a></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${pageBean.curPage < pageBean.maxPage }">
					<a href="${pageURL}curPage=${pageBean.curPage + 1 }">下一页</a> <a href="${pageURL}curPage=${pageBean.maxPage}">末页</a>
				</c:when>
				<c:otherwise>下一页 末页</c:otherwise>
			</c:choose>
  		</td>
	</tr>
</table>
