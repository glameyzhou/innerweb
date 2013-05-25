<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <title>系统角色<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></title>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 系统角色 -
            <c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose>
        </div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/user/role-${opt}.htm" id="jvForm">
        <input type="hidden" id="roleId" name="roleId" value="${roleInfo.roleId}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="roleName" id="roleName" class="required" size="80"
                           value="${roleInfo.roleName}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>描述:</td>
                <td width="85%" class="pn-fcontent">
                    <textarea rows="10" cols="50" name="roleDesc" id="roleDesc">${roleInfo.roleDesc}</textarea>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>功能点:</td>
                <td width="85%" class="pn-fcontent">
                    <br/>
                    <a href="javascript:checkAll('rightsId',true);">全选</a>&nbsp;&nbsp;
                    <a href="javascript:checkAll('rightsId',false);">取消</a>&nbsp;&nbsp;
                    <br/>
                    <table border="0" cellpadding="0" width="100%" id="allRights">
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="01"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'01')}">checked="checked"</c:if> />
                            </td>
                            <td>新闻动态 - 分类管理</td>
                        </tr>
                        <tr>
                            <td width="20%" style="font:bold;color: red;">新闻动态 - 内容管理</td>
                            <td align="left">
                              	<table width="300px" cellpadding="0" cellspacing="0">
                              	<tr><td colspan="4" height="5px"></td></tr>
                              	<c:forEach var="newsCate" items="${categoryNewsList}" varStatus="newsStatus">
                              		<tr>
                              			<td>${newsCate.name}</td>
                                        <c:set var="newsCreateId" value="01_news_${newsCate.id}_create" />
                                        <c:set var="newsDeleteId" value="01_news_${newsCate.id}_delete" />
                                        <c:set var="newsUpdateId" value="01_news_${newsCate.id}_update" />
                              			<td><input type="checkbox" id="rightsId" name="rightsId" value="01_news_${newsCate.id}_create"
                                                   <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,newsCreateId)}">checked="checked"</c:if>/>增加</td>
                              			<td><input type="checkbox" id="rightsId" name="rightsId" value="01_news_${newsCate.id}_delete"
                                                   <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,newsDeleteId)}">checked="checked"</c:if>/>删除</td>
                              			<td><input type="checkbox" id="rightsId" name="rightsId" value="01_news_${newsCate.id}_update"
                                                   <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,newsUpdateId)}">checked="checked"</c:if>/>修改</td>
                              		</tr>
                              	</c:forEach>
                              	<tr><td colspan="4" height="5px"></td></tr>
                              	</table>
                            </td>
                        </tr>
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="02"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'02')}">checked="checked"</c:if> />
                            </td>
                            <td>通知公告 - 分类管理</td>
                        </tr>
                        <tr>
                            <td width="20%" style="font:bold;color: red;">通知公告 - 内容管理</td>
                            <td align="left">
                              	<table width="300px" cellpadding="0" cellspacing="0">
                              	<tr><td colspan="5" height="5px"></td></tr>
                              	<c:forEach var="noticesCate" items="${categoryNoticesList}" varStatus="noticesStatus">
                              		<tr>
                              			<td>${noticesCate.name}</td>
                                        <c:set var="noticesCreateId" value="02_notices_${noticesCate.id}_create" />
                                        <c:set var="noticesDeleteId" value="02_notices_${noticesCate.id}_delete" />
                                        <c:set var="noticesUpdateId" value="02_notices_${noticesCate.id}_update" />
                                        <c:set var="noticesPermitId" value="02_notices_${noticesCate.id}_update" />
                              			<td><input type="checkbox" id="rightsId" name="rightsId" value="02_notices_${noticesCate.id}_create"
                                                   <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,noticesCreateId)}">checked="checked"</c:if>/>增加</td>
                              			<td><input type="checkbox" id="rightsId" name="rightsId" value="02_notices_${noticesCate.id}_delete"
                                                   <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,noticesDeleteId)}">checked="checked"</c:if>/>删除</td>
                              			<td><input type="checkbox" id="rightsId" name="rightsId" value="02_notices_${noticesCate.id}_update"
                                                   <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,noticesUpdateId)}">checked="checked"</c:if>/>修改</td>
                              			<td><input type="checkbox" id="rightsId" name="rightsId" value="02_notices_${noticesCate.id}_permit"
                                                   <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,noticesPermitId)}">checked="checked"</c:if>/>审核</td>
                              		</tr>
                              	</c:forEach>
                              	<tr><td colspan="5" height="5px"></td></tr>
                              	</table>
                            </td>
                        </tr>
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="03"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'03')}">checked="checked"</c:if>/>
                            </td>
                            <td>总院快捷入口 - 内容管理</td>
                        </tr>
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="04"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'04')}">checked="checked"</c:if>/>
                            </td>
                            <td>集团系统快捷入口 - 内容管理</td>
                        </tr>
                        
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="05"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'05')}">checked="checked"</c:if>/>
                            </td>
                            <td>友情链接管理</td>
                        </tr>
                        
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="06"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'06')}">checked="checked"</c:if>/>
                            </td>
                            <td>常用链接管理</td>
                        </tr>
                        
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="07"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'07')}">checked="checked"</c:if>/>
                            </td>
                            <td>站内信管理</td>
                        </tr>
                        
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="08"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'08')}">checked="checked"</c:if>/>
                            </td>
                            <td>集团部门管理</td>
                        </tr>
                        
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="09"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'09')}">checked="checked"</c:if>/>
                            </td>
                            <td>用户角色权限管理</td>
                        </tr>
                        <tr>
                            <td width="20%">
                                <input type="checkbox" id="rightsId" name="rightsId" value="10"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'10')}">checked="checked"</c:if>/>
                            </td>
                            <td>全局设置</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="pn-fbutton">
                    <input type="submit" value="提交"> &nbsp; <input type="reset" value="重置">
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>