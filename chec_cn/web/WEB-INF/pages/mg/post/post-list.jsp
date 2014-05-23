<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>${categoryParent.name}列表</title>
<%@include file="../../common/tagInclude.jsp" %>
<%@include file="../../common/headerInclude.jsp" %>
<script type="text/javascript" src="${basePath}res/common/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${basePath}res/common/js/layer/layer.min.js"></script>
<script type="text/javascript">
	$(function() {
        $('#helpTips').on('mouseover', function () {
            layer.tips(
                    '先按照"序列"倒序排列，如果"序列"相同按照"时间"倒序排列',
                    this, {
                        style: ['background-color:#0FA6D8; color:#fff', '#0FA6D8'],
                        maxWidth: 150
                    }
            );
        });
        $('#helpTips').on('mouseout', function () {
            layer.closeAll();
        });
        $("#jvForm").validate();
	});
	function edit(postId){
		window.location = '${basePath}mg/post/post-show.do?postId='+postId + "&categoryId=${category.id}";
	}
	function del(postId){
        layer.confirm('确定要删除所选的内容吗？',function(index){
            layer.close(index);
            var locationURL = "${basePath}mg/post/post-del.do?postId=" + postId + '&categoryId=${category.id}&type=${category.categoryType}';
            window.location = locationURL ;
        });
	}
	function delAll(itemName){
		var all_checkbox = document.getElementsByName(itemName);
		var len = all_checkbox.length;
		if(isChecked(itemName) == false ){
            layer.alert('至少选择一项', 8);
		}else{
            layer.confirm('确认要执行操作？',function(index){
                layer.close(index);
                var values = "";
                for(var i=0;i<len ;i++){
                    if(all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if(values.length > 1)
                    values = values.substring(1);
                var opURL = "${basePath}mg/post/post-del.do?postId=" + values + '&categoryId=${category.id}&type=${category.categoryType}';
                window.location = opURL ;
            });
		}
	}
    function setSelectContent(itemName,category,type,categoryId) {
        var all_checkbox = document.getElementsByName(itemName);
        var len = all_checkbox.length;
        if (isChecked(itemName) == false) {
            layer.alert('至少选择一项', 8);
        } else {
            layer.confirm('确认要执行操作？',function(index){
                layer.close(index);
                var values = "";
                for (var i = 0; i < len; i++) {
                    if (all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if (values.length > 1)
                    values = values.substring(1);
                var opURL = "${basePath}mg/post/post-setSelectContent.do?id=" + values + "&category=" + category + "&type=" + type + "&categoryId=" + categoryId;
                window.location = opURL;
            });
        }
    }

    /**
     * 文章排序
     *
    * @param postId
    * @param orderType
    */
    function setOrder(postId,orderType,categoryId,categoryType) {
        var msg = "确定要将文章<font color='red'>" + (orderType == "up" ? "上移" : "下移"  + "</font>？");
        layer.confirm(msg,function(index){
            layer.close(index);
            var jumpUrl = "${basePath}mg/post/post-setOrder.do?postId=" + postId + "&orderType=" + orderType + "&categoryId=" + categoryId + "&categoryType=" + categoryType;
            /*alert(jumpUrl);*/
            window.location = jumpUrl;
        });
    }
</script>
<script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="body-box">
	<div class="rhead">
		<div class="rpos">当前位置: 首页  <c:if test="${not empty pCategory.name}">- ${pCategory.name}</c:if><c:if test="${not empty category.name}">- ${category.name}</c:if> - 列表</div>
            <form class="ropt">
                <input type="button" value="添加" onclick="window.location='${basePath}mg/post/post-show.do?categoryId=${category.id}';">
            </form>
		<div class="clear"></div>
	</div>
	<form action="${basePath}mg/post/post-list.do" method="get" style="padding-top:5px;">
        <input name="categoryId" id="categoryId" value="${category.id}" type="hidden"/>
		<div>
			关键字&nbsp;<input type="text" name="kw" id="kw" value="${query.kw}"/>&nbsp;&nbsp;
            首页显示&nbsp;<select name="showIndex" id="showIndex">
					<option value="-1" <c:if test="${query.showIndex == -1}">selected="selected" </c:if>>请选择</option>
					<option value="0" <c:if test="${query.showIndex == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.showIndex == 1}">selected="selected" </c:if>>是</option>
				</select>&nbsp;&nbsp;
            列表页&nbsp;<select name="showList" id="showList">
					<option value="-1" <c:if test="${query.showList == -1}">selected="selected" </c:if>>请选择</option>
					<option value="0" <c:if test="${query.showList == 0}">selected="selected" </c:if>>否</option>
					<option value="1" <c:if test="${query.showList == 1}">selected="selected" </c:if>>是</option>
				</select>&nbsp;&nbsp;
            <c:choose>
                <c:when test="${'NEWS' eq category.categoryType and 'FnQNjm' eq category.id}">
                    焦点图&nbsp;<select name="showFocusImage" id="showFocusImage">
                    <option value="" <c:if test="${query.showFocusImage == -1}">selected="selected" </c:if>>请选择</option>
                    <option value="0" <c:if test="${query.showFocusImage == 0}">selected="selected" </c:if>>否</option>
                    <option value="1" <c:if test="${query.showFocusImage == 1}">selected="selected" </c:if>>是</option>
                    </select>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="showFocusImage" value="-1"/>
                </c:otherwise>
            </c:choose>
            <input type="hidden" name="showFocusImage" value="-1"/>
			开始&nbsp;<input type="text" maxlength="100" name="startTime" id="startTime" class="required" size="18" value="${query.publishStartTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			结束&nbsp;<input type="text" maxlength="100" name="endTime" id="endTime" class="required" size="18" value="${query.publishEndTime}"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" readonly="readonly">&nbsp;&nbsp;
			<input type="submit" value="查询">
			<br/><br/>
			<a href="javascript:checkAll('postId',true);">全选</a>&nbsp;&nbsp;
            <a href="javascript:checkAll('postId',false);">取消</a>&nbsp;&nbsp;
		    <a href="javascript:delAll('postId');">删除所选</a>&nbsp;&nbsp;
            <%--<a href="javascript:setSelectContent('postId','valid',1,'${category.id}');">设置${categoryNameType}</a>&nbsp;&nbsp;
            <a href="javascript:setSelectContent('postId','valid',0,'${category.id}');">取消${categoryNameType}</a>&nbsp;&nbsp;--%>
		</div>
		<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
			<thead class="pn-lthead">
			<tr>
				<th width="3%"></th>
				<th width="3%">序列</th>
				<th>标题</th>
				<th width="10%">发布人</th>
				<%--<th width="10%">来源</th>--%>
				<th width="5%">首页显示</th>
				<th width="8%">列表页显示</th>
                <c:if test="${'NEWS' eq category.categoryType and 'FnQNjm' eq category.id}">
                    <th width="5%">焦点图</th>
                </c:if>
                <c:if test="${'NEWS' eq category.categoryType}">
                    <th width="5%">排序&nbsp;<img src="${basePath}res/front/chec_cn/images/help_tips.jpg" alt="" id="helpTips"/></th>
                </c:if>
                <%--<c:if test="${'NEWS' eq category.categoryType}">
                    <th width="5%">排序</th>
                </c:if>--%>
				<th width="10%">发布时间</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody class="pn-ltbody">
			<c:forEach items="${postList}" var="post" varStatus="status">
			<tr onmousemove="this.style.backgroundColor='#a9a9a9'" onmouseout="this.style.backgroundColor=''">
				<td align="center"><input type="checkbox" id="postId" name="postId" value="${post.id}"/></td>
                <td align="center">${post.postOrder}</td>
				<td title="${post.title}">${fmtString:substringAppend(post.title,35,'')}</td>
                <td align="center">${post.author}</td>
				<%--<td align="center">${post.source}</td>--%>
				<td align=center><c:choose><c:when test="${post.showIndex == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
				<td align=center><c:choose><c:when test="${post.showList == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
                <c:if test="${'NEWS' eq category.categoryType and 'FnQNjm' eq category.id}">
                    <td align=center><c:choose><c:when test="${post.showFocusImage == 1}">是</c:when><c:otherwise>否</c:otherwise></c:choose></td>
                </c:if>
                <c:if test="${'NEWS' eq category.categoryType}">
                    <%--<td align=center>${post.postOrder}</td>--%>
                    <td align="center">
                        <c:choose>
                            <c:when test="${pageBean.curPage == 1 and status.first}">
                                <a href="javascript:setOrder('${post.id}','down','${post.categoryId}','${post.categoryType}');"><img src="${basePath}res/front/chec_cn/images/down.gif" border="0" title="下移"/></a>&nbsp;&nbsp;
                            </c:when>
                            <c:when test="${pageBean.curPage == pageBean.maxPage and status.last}">
                                <a href="javascript:setOrder('${post.id}','up','${post.categoryId}','${post.categoryType}');"><img src="${basePath}res/front/chec_cn/images/up.gif" border="0" title="上移"/></a>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:setOrder('${post.id}','up','${post.categoryId}','${post.categoryType}');"><img src="${basePath}res/front/chec_cn/images/up.gif" border="0" title="上移"/></a>
                                &nbsp;&nbsp;
                                <a href="javascript:setOrder('${post.id}','down','${post.categoryId}','${post.categoryType}');"><img src="${basePath}res/front/chec_cn/images/down.gif" border="0" title="下移"/></a>
                            </c:otherwise>
                        </c:choose>

                    </td>
                </c:if>
				<td align=center><fmt:formatDate value="${post.publishTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td align=center>
					    <a href="javascript:edit('${post.id}');">编辑</a>&nbsp;
                        <a href="javascript:del('${post.id}');">删除</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:set var="pageURL" value="${basePath}mg/post/post-list.do?categoryId=${query.categoryId}&kw=${fmtString:encoder(query.kw)}&showIndex=${query.showIndex}&showList=${query.showList}&showFocusImage=${query.showFocusImage}&showTop=${query.showTop}&startTime=${fmtString:encoder(query.publishStartTime)}&endTime=${fmtString:encoder(query.publishEndTime)}&"/>
		<%@include file="../../common/pages.jsp"%>
	</form>
</div>
</body>
</html>