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
        /*function displayRights(id){
            if(id == "1"){
                document.getElementById("allRights").style.display = "block";
                document.getElementById("currentRights").style.display = "none";
                document.getElementById("optFlag").innerText = "1";
            }
            else{
                document.getElementById("allRights").style.display = "none";
                document.getElementById("currentRights").style.display = "block";
                document.getElementById("optFlag").innerText = "2";
            }
        }
        function onPageLoad(){
            var opt = ${opt};
            if(opt == "update"){
                displayRights("2");
            }
            else{
                displayRights("1");
            }
        }
        function formSub(){
            var optFlag = document.getElementById("optFlag").value ;
            var ids = "" ;
            if(optFlag == '1'){
                ids = getCheckBox("rightsId-all");
            }else{
                ids = getCheckBox("rightsId-current");
            }
            alert(ids);
            document.form.submit();
        }
        function getCheckBox(itemName){
            var all_checkbox = document.getElementsByName(itemName);
            var len = all_checkbox.length;
            if(len > 0){
                var values = "";
                for (var i = 0; i < len; i++) {
                    if (all_checkbox[i].checked)
                        values += "," + all_checkbox[i].value;
                }
                if (values.length > 1)
                    values = values.substring(1);
                return values ;
            }
        }*/
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
                    <%--<a href="javascript:displayRights('1');">显示所有</a>&nbsp;&nbsp;
                    <a href="javascript:displayRights('2');">当前权限</a>&nbsp;&nbsp;--%>
                    <br/>
                    <table border="0" cellpadding="0" width="100%" id="allRights">
                        <c:forEach var="ri" items="${rightsInfoList}">
                            <tr>
                                <td width="30%">
                                    <input type="checkbox" id="rightsId" name="rightsId" value="${ri.rightsId}"
                                           <c:if test="${fmtString:aContantsb(roleInfo.roleRightsIds,ri.rightsId)}">checked="checked"</c:if>/>
                                    &nbsp;${ri.rightsName}</td>
                                <td>${ri.rightsValue}</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <%--<table border="0" cellpadding="0" width="100%" id="allRights">
                        <c:forEach var="ri" items="${rightsInfoList}">
                            <tr>
                                <td width="30%">
                                    <input type="checkbox" id="rightsId-all" name="rightsId-all" value="${ri.rightsId}"
                                           <c:if test="${fmtString:aContantsb(roleInfo.roleRightsIds,ri.rightsId)}">checked="checked"</c:if>/>
                                    &nbsp;${ri.rightsName}</td>
                                <td>${ri.rightsValue}</td>
                            </tr>
                        </c:forEach>
                    </table>--%>
                    <%--<table border="0" cellpadding="0" width="100%" id="currentRights">
                        <c:forEach var="ri" items="${roleInfo.rightsInfoList}">
                            <tr>
                                <td width="30%">
                                    <input type="checkbox" id="rightsId-current" name="rightsId-current" value="${ri.rightsId}" checked="checked"/>&nbsp;${ri.rightsName}</td>
                                <td>${ri.rightsValue}</td>
                            </tr>
                        </c:forEach>
                    </table>--%>
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