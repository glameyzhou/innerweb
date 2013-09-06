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
        /**
         *一次性增加两个板块
         * @param divName
         */
        function addArea(divName, index) {
            var selectContent = '&nbsp;&nbsp;<select id="area' + index + '" name="area' + index + '"><c:forEach var="cate" items="${categoryList}"><option value="${cate.id}">${cate.name} - <c:if test="${cate.showIndex==1}">首页显示</c:if><c:if test="${cate.showIndex==0}">首页不显示</c:if></option></c:forEach></select>';
            var ulObj = document.getElementById(divName);
            var len = ulObj.children.length;
            var li1 = document.createElement("li");
            var liId1 = divName + "_li_" + (len + 1);
            var content1 = "<a href=\"javascript:delArea('" + divName + "','" + liId1 + "');\">删除此板块</a>" + selectContent;
            li1.innerHTML = content1 ;
            li1.id = liId1;
            ulObj.appendChild(li1);

            /* len = ulObj.children.length;
            var li2 = document.createElement("li");
            var liId2 = divName + "_li_" + (len + 1);
            var content2 = "<a href=\"javascript:delArea('" + divName + "','" + liId2 + "');\">删除此板块</a>" + selectContent;
            li2.innerHTML = content2;
            li2.id = liId2;
            ulObj.appendChild(li2); */
            ulObj.appendHtml("<br/>")

        }
        /**
         *删除指定UL下的LI
         * @param divName
         * @param liId
         */
        function delArea(divName, liId) {
            var ulObj = document.getElementById(divName);
            var len = ulObj.children.length;
            var liObj = document.getElementById(liId);
            ulObj.removeChild(liObj);
        }
    </script>
</head>
<body>
<div class="body-box">
    <div class="rhead">
        <div class="rpos">当前位置: 首页 - 全局设置 - 首页内容板块设置</div>
        <%--<form class="ropt">
            <input type="button" value="添加" onclick="javascript:window.location='${basePath}mg/dept/dept-show.htm';">
        </form>--%>
        <form class="ropt">
            <font color="red" size="3">
                <c:if test="${not empty message}">
                    ${message}
                </c:if>
            </font>
        </form>
        <div class="clear"></div>
    </div>
    <form method="post" action="${basePath}mg/sys/area-update.htm" id="jvForm">
        <table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
            <tbody>
            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>第一板块:</td>
                <td width="85%" class="pn-fcontent">
                    <br/><a href="javascript:addArea('area1_div',1);">添加板块</a><br/>
                    <ul id="area1_div">
                        <%--1、模块分类循环输出 2、每个li打印出来所有的分类，选择命中上次修改的内容--%>
                        <c:forEach var="c" items="${categoryArea1List}" varStatus="status">
                            <li id="area1_div_li_${status.index}">
                                <a href="javascript:delArea('area1_div','area1_div_li_${status.index}')">删除此板块</a>&nbsp;&nbsp;
                                <select id="area1" name="area1">
                                    <c:forEach var="ca" items="${categoryList}">
                                        <c:choose>
                                            <c:when test="${ca.id eq c.id}">
                                                <option value="${ca.id}" selected="selected">${ca.name}
                                                    - <c:if test="${ca.showIndex==1}">首页显示</c:if><c:if
                                                            test="${ca.showIndex==0}">首页不显示</c:if></option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${ca.id}">${ca.name}
                                                    - <c:if test="${ca.showIndex==1}">首页显示</c:if><c:if
                                                            test="${ca.showIndex==0}">首页不显示</c:if></option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </li>
                            <br/>
                        </c:forEach>
                    </ul>
                </td>
            </tr>

            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>第二板块:</td>
                <td width="85%" class="pn-fcontent">
                    <br/><a href="javascript:addArea('area2_div',2);">添加板块</a><br/>
                    <ul id="area2_div">
                        <%--1、模块分类循环输出 2、每个li打印出来所有的分类，选择命中上次修改的内容--%>
                        <c:forEach var="c" items="${categoryArea2List}" varStatus="status">
                            <li id="area2_div_li_${status.index}">
                                <a href="javascript:delArea('area2_div','area2_div_li_${status.index}')">删除此板块</a>&nbsp;&nbsp;
                                <select id="area2" name="area2">
                                    <c:forEach var="ca" items="${categoryList}">
                                        <c:choose>
                                            <c:when test="${ca.id eq c.id}">
                                                <option value="${ca.id}" selected="selected">${ca.name}
                                                    - <c:if test="${ca.showIndex==1}">首页显示</c:if><c:if
                                                            test="${ca.showIndex==0}">首页不显示</c:if></option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${ca.id}">${ca.name}
                                                    - <c:if test="${ca.showIndex==1}">首页显示</c:if><c:if
                                                            test="${ca.showIndex==0}">首页不显示</c:if></option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </li>
                            <br/>
                        </c:forEach>
                    </ul>
                </td>
            </tr>

            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>第三板块:</td>
                <td width="85%" class="pn-fcontent">
                    <br/><a href="javascript:addArea('area3_div',3);">添加板块</a><br/>
                    <ul id="area3_div">
                        <%--1、模块分类循环输出 2、每个li打印出来所有的分类，选择命中上次修改的内容--%>
                        <c:forEach var="c" items="${categoryArea3List}" varStatus="status">
                            <li id="area3_div_li_${status.index}">
                                <a href="javascript:delArea('area3_div','area3_div_li_${status.index}')">删除此板块</a>&nbsp;&nbsp;
                                <select id="area3" name="area3">
                                    <c:forEach var="ca" items="${categoryList}">
                                        <c:choose>
                                            <c:when test="${ca.id eq c.id}">
                                                <option value="${ca.id}" selected="selected">${ca.name}
                                                    - <c:if test="${ca.showIndex==1}">首页显示</c:if><c:if
                                                            test="${ca.showIndex==0}">首页不显示</c:if></option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${ca.id}">${ca.name}
                                                    - <c:if test="${ca.showIndex==1}">首页显示</c:if><c:if
                                                            test="${ca.showIndex==0}">首页不显示</c:if></option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </li>
                            <br/>
                        </c:forEach>
                    </ul>
                </td>
            </tr>

            <tr>
                <td width="15%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>第四板块:</td>
                <td width="85%" class="pn-fcontent">
                    <br/><a href="javascript:addArea('area4_div',4);">添加板块</a><br/>
                    <ul id="area4_div">
                        <%--1、模块分类循环输出 2、每个li打印出来所有的分类，选择命中上次修改的内容--%>
                        <c:forEach var="c" items="${categoryArea4List}" varStatus="status">
                            <li id="area4_div_li_${status.index}">
                                <a href="javascript:delArea('area4_div','area4_div_li_${status.index}')">删除此板块</a>&nbsp;&nbsp;
                                <select id="area4" name="area4">
                                    <c:forEach var="ca" items="${categoryList}">
                                        <c:choose>
                                            <c:when test="${ca.id eq c.id}">
                                                <option value="${ca.id}" selected="selected">${ca.name}
                                                    - <c:if test="${ca.showIndex==1}">首页显示</c:if><c:if
                                                            test="${ca.showIndex==0}">首页不显示</c:if></option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${ca.id}">${ca.name}
                                                    - <c:if test="${ca.showIndex==1}">首页显示</c:if><c:if
                                                            test="${ca.showIndex==0}">首页不显示</c:if></option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </li>
                            <br/>
                        </c:forEach>
                    </ul>
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