<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function onPageLoad(){
            var value = '${metaInfo.value}';
            if(value == '1'){
                document.getElementById("roleDiv").style.display = "block";
            }
        }
        function showDept(type){
            if(type == '1'){
                document.getElementById("roleDiv").style.display = "block";
            }
            else{
                document.getElementById("roleDiv").style.display = "none";
            }
        }
    </script>
</head>
<body onload="onPageLoad();">
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 全局设置 - 各部门通知可见配置</div>
        <form class="ropt">
            <font color="red" size="3">
                <c:if test="${not empty message}">
                    ${message}
                </c:if>
            </font>
        </form>

        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/sys/notices-what-can-see-update.htm" id="jvForm">
        <input type="hidden" id="name" value="${metaInfo.name}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>各部门通知可见配置:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="value" id="value" class="required" value="0" onclick="showDept('0')"
                           <c:if test="${metaInfo.value eq '0'}">checked="checked"</c:if>>查看本部门内通告&nbsp;&nbsp;
                    <input type="radio" name="value" id="value" class="required" value="1" onclick="showDept('1')"
                           <c:if test="${metaInfo.value eq '1'}">checked="checked"</c:if>>指定角色可见所有通告&nbsp;&nbsp;
                    <br/>
                    <p id="roleDiv" style="display: none">
                        <c:forEach var="role" varStatus="status" items="${roleInfoList}">
                            <input type="checkbox" id="roleId" name="roleId" value="${role.roleId}"
                                    <c:if test="${fmtString:hasRightsList(allowedRoleList, role.roleId)}" >checked="checked" </c:if> />
                            ${role.roleName}<br/>
                        </c:forEach>
                    </p>
                </td>
            </tr>

            <tr>
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