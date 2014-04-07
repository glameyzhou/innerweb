<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="tagInclude.jsp" %>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	<tr>
		<td align="center" class="pn-sp">
			共:<font color=red>${pageBean.maxRowCount}</font>条&nbsp;每页:<font color=red>${pageBean.rowsPerPage}</font>条
			&nbsp;当前页:<font color=red>${pageBean.curPage}</font>&nbsp;最大页:<font color=red>${pageBean.maxPage}</font>&nbsp;
			<c:choose>
				<c:when test="${pageBean.curPage > 1 }">
					<a href="${pageURL}curPage=1">[首页]</a>&nbsp;
					<a href="${pageURL}curPage=${pageBean.curPage-1}">[上一页]</a>
				</c:when>
				<c:otherwise>
					[首页]&nbsp;[上一页]
				</c:otherwise>
			</c:choose>
			<c:forEach items="${pageBean.pageNoList}" var="i">
				<a href="${pageURL}curPage=${i}">${i}&nbsp;</a>
			</c:forEach>
			<c:choose>
				<c:when test="${pageBean.curPage < pageBean.maxPage }">
					<a href="${pageURL}curPage=${pageBean.curPage + 1 }">[下一页]</a>&nbsp;
					<a href="${pageURL}curPage=${pageBean.maxPage}">[末页]</a>
				</c:when>
				<c:otherwise>
					[下一页]&nbsp;[末页]
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	</tbody>
</table>