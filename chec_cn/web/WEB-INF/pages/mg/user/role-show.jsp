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
    <form method="post" action="${basePath}mg/user/role-${opt}.do" id="jvForm">
        <input type="hidden" id="roleId" name="roleId" value="${roleInfo.roleId}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="roleName" id="roleName" class="required" size="80"
                           value="${roleInfo.roleName}">
                </td>
            </tr>
            <tr>
                <td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>描述:</td>
                <td width="85%" class="pn-fcontent">
                    <textarea rows="10" cols="50" name="roleDesc" id="roleDesc">${roleInfo.roleDesc}</textarea>
                </td>
            </tr>
            <tr>
                <td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>功能点:</td>
                <td width="85%" class="pn-fcontent">
                    <br/>
                    <a href="javascript:checkAll('rightsId',true);">全选</a>&nbsp;&nbsp;
                    <a href="javascript:checkAll('rightsId',false);">取消</a>&nbsp;&nbsp;
                    <br/>
                    <table border="0" cellpadding="0" width="100%" id="allRights">
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="1-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'1-')}">checked="checked"</c:if>/>
                            </td>
                            <td>公司介绍</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="2-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'2-')}">checked="checked"</c:if>/>
                            </td>
                            <td>公司新闻</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="3-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'3-')}">checked="checked"</c:if>/>
                            </td>
                            <td>监察审计</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="4-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'4-')}">checked="checked"</c:if>/>
                            </td>
                            <td>业务概况</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="5-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'5-')}">checked="checked"</c:if>/>
                            </td>
                            <td>公司业绩</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="6-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'6-')}">checked="checked"</c:if>/>
                            </td>
                            <td>企业文化</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="7-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'7-')}">checked="checked"</c:if>/>
                            </td>
                            <td>人力资源</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="8-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'8-')}">checked="checked"</c:if>/>
                            </td>
                            <td>系统链接</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="9-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'9-')}">checked="checked"</c:if>/>
                            </td>
                            <td>华电期刊</td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="10-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'10-')}">checked="checked"</c:if>/>
                            </td>
                            <td>系统管理</td>
                        </tr>
                        <%--<tr>
                            <td width="10%" align="right" >
                                <input type="checkbox" name="rightsId" value="11-"
                                       <c:if test="${fmtString:hasRightsList(roleInfo.rightsList,'11-')}">checked="checked"</c:if>/>
                            </td>
                            <td>站外消息</td>
                        </tr>--%>
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