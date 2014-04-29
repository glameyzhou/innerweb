<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="../../common/tagInclude.jsp" %>
    <%@include file="../../common/headerInclude.jsp" %>
    <title>用户<c:choose><c:when test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></title>
    <script type="text/javascript">
        $(function () {
            $("#jvForm").validate();
        });
        function removeItem(){
            var sltSrc=document.getElementById('sltSrc');
            var sltTarget=document.getElementById('sltTarget');
            for(var i=0;i<sltSrc.options.length;i++)
            {
                var tempOption=sltSrc.options[i];
                if(tempOption.selected){
                    sltSrc.removeChild(tempOption);
                    sltTarget.appendChild(tempOption);
                }
            }
        }
        function addItem(){
            var sltSrc=document.getElementById('sltSrc');
            var sltTarget=document.getElementById('sltTarget');
            for(var i=0;i<sltTarget.options.length;i++)
            {
                var tempOption=sltTarget.options[i];
                if(tempOption.selected){
                    sltTarget.removeChild(tempOption);
                    sltSrc.appendChild(tempOption);
                }
            }
        }

        /*function pageLoad(){
            var opt = ${opt};
            if(opt == 'update'){
                alert("asdfasfd");
                var content = '' ;
                var srcUserSelect = document.getElementById("sltTarget");
                <c:forEach var="destRole" items="${destRoleInfoList}">
                content +='<option value="${destRole.roleId}">${destRole.roleName}</option>';
                </c:forEach>
                alert(content);
                srcUserSelect.innerHTML = content ;
            }
        }*/
        function onFormSubmit() {
            var sltTarget = document.getElementById('sltTarget');
            for (var i = 0; i < sltTarget.options.length; i++) {
                var tempOption = sltTarget.options[i];
                if (!tempOption.selected) {
                    tempOption.selected = true;
                }

                /*alert(tempOption.text + " " + tempOption.value);*/
            }
            document.getElementById("jvForm").submit();
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 用户管理 - <c:choose><c:when
                test="${opt == 'update'}">修改</c:when><c:otherwise>添加</c:otherwise></c:choose></div>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/user/user-${opt}.do" id="jvForm" onsubmit="onFormSubmit();">
        <input type="hidden" id="userId" name="userId" value="${userInfo.userId}"/>
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>角色:</td>
                <td width="85%" class="pn-fcontent">
                    <table border="0" cellspacing="0" cellpDoAdding="0" align="left">
                        <tr>
                            <td width="45%" align="center" valign="top">
                                <B>待选区：</B><br/>
                                <select id="sltSrc" name="sltSrc" multiple="true"  style="width: 200px;height: 350px;" ondblclick="removeItem();">
                                    <c:forEach var="srcRole" items="${srcRoleInfoList}">
                                        <option value="${srcRole.roleId}">${srcRole.roleName}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td width="10%" align="center">
                                <input name="DoAdd" type="button" value=">>" onclick="removeItem();"><br>
                                <input name="DoDel" type="button" value="<<" onClick="addItem();">
                            </td>
                            <td width="45%" align="center" valign="top">
                                <B>已选择：</B><br/>
                                <select id="sltTarget" name="sltTarget"  multiple="true"  style="width: 200px;height: 350px;" ondblclick="addItem();">
                                    <c:forEach var="destRole" items="${destRoleInfoList}">
                                        <option value="${destRole.roleId}">${destRole.roleName}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户名:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="username" id="username" class="required" size="80"
                           value="${userInfo.username}"
                           <c:if test="${opt eq 'update'}">readonly="readonly" </c:if> />&nbsp;<font color="red">唯一标识</font>
                </td>
            </tr>
            <c:choose>
                <c:when test="${opt eq 'update'}">
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="text" maxlength="100" name="passwd" id="passwd" size="80"
                                   value="">&nbsp;<font color="red">留空不更新密码</font>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="password" maxlength="100" name="passwd" id="passwd" class="required" size="80"
                                   value="">
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>确认密码:</td>
                        <td width="85%" class="pn-fcontent">
                            <input type="password" maxlength="100" name="passwdRp" id="passwdRp" class="required"
                                   size="80"
                                   value="">
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>

            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>真实姓名:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="nickname" id="nickname" class="required" size="80"
                           value="${userInfo.nickname}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>单位:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="company" id="company" class="required" size="80"
                           value="${userInfo.company}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">部门:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="dept" id="dept" size="80"
                           value="${userInfo.dept}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">职务:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="duty" id="duty" size="80"
                           value="${userInfo.duty}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h">单位地址:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="address" id="address" size="80"
                           value="${userInfo.address}">
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>手机号:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="mobile" id="mobile" size="80" class="required"
                           value="${userInfo.mobile}"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>固话:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="phone" id="phone" size="80" value="${userInfo.phone}" class="required"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>邮箱:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="text" maxlength="100" name="email" id="email" size="80" value="${userInfo.email}" class="required"/>
                </td>
            </tr>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户状态:</td>
                <td width="85%" class="pn-fcontent">
                    <input type="radio" name="isLive" id="isLive" value="0"
                           <c:if test="${userInfo.isLive == 0}">checked="checked"</c:if> />禁用&nbsp;
                    <input type="radio" name="isLive" id="isLive" value="1"
                           <c:if test="${userInfo.isLive == 1}">checked="checked"</c:if> />启用&nbsp;
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