<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国华电工程（集团）有限公司</title>
    <link href="${basePath}res/front/chec_cn/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/neiye.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/left-lanmu.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}res/front/chec_cn/css/footer.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${basePath}res/common/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body bgcolor="#e3e8ec" background="${basePath}res/front/chec_cn/images/bg.jpg" style="background-repeat:repeat-x" >
<div class="box">
    <%@include file="../include/header.jsp"%>
    <div class="content">
        <div class="neiye-left">
            <div class="left-tit">招聘公告</div>
            <div class="left-con lanmu">
                <ul>
                    <c:forEach var="category" items="${categoryList}">
                        <li>
                            <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/>
                            <a href="${basePath}band-${rootCategory.categoryType}.htm?cate=${category.id}">${category.name}</a>
                        </li>
                    </c:forEach>
                    <li class="lanmu-hover">
                        <img src="${basePath}res/front/chec_cn/images/daiti-biao1.png"/><a href="${basePath}jobs.htm">招聘公告</a>
                    </li>
                </ul>
            </div>
            <%@include file="../include/frame-images.jsp"%>
        </div>
        <div class="neiye-right">
            <div class="weizhi">您所在的位置：<a href="${basePath}">首页</a>&nbsp;>&nbsp;<a href="${basePath}brand-${rootCategory.categoryType}.htm">${rootCategory.name}</a>&nbsp;>&nbsp;<a href="${basePath}jobs.htm">招聘公告</a></div>
            <div class="right-con">
            <form id="resumeForm" name="resumeForm" method="post" action="${basePath}jobs-doapply-${jobInfo.jobId}.htm" class="danxuan" enctype="multipart/form-data">
            <table width="96%" align="center" border="0" cellpadding="3" cellspacing="2">
            <tr>
                <td colspan="2" height="50" align="center"><b style="font-size:14px;">个人简历</b></td>
            </tr>
            <tr>
                <td colspan="2" align="right" style="border-bottom:1px solid #c6c6c6;">注：带<span>*</span>为必填项</td>
            </tr>
            <tr>
                <td class="bg1" width="120" align="right"><span>*</span>&nbsp;姓名：</td>
                <td class="bg2"><input name="name" type="text" class="text"/></td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;出生日期：</td>
                <td class="bg2">
                    <input type="text" name="birthday" id="birthday" class="text text60" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly="readonly" value="${resume.birthday}" />
                </td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;性别：</td>
                <td class="bg2">
                    <input type="radio" name="gender" value="1"/>男&nbsp;&nbsp;
                    <input type="radio" name="gender" value="2"/>女
                    <%--<label for="gender"></label>--%>
                </td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;政治面貌：</td>
                <td class="bg2">
                    <select name="politicsStatus" class="xiala1">
                        <option value="1">群众</option>
                        <option value="2">党员</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="bg1" width="120" align="right"><span>*</span>&nbsp;民族：</td>
                <td class="bg2"><input name="nation" type="text" class="text text60"/></td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;婚姻状况：</td>
                <td class="bg2">
                    <input type="radio" name="marriageStatus" value="1"/>已婚&nbsp;&nbsp;
                    <input type="radio" name="marriageStatus" value="0"/>未婚
                    <%--<label for="marriageStatus"></label>--%>
                </td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;生育状况：</td>
                <td class="bg2"><input name="bearStatus" type="text" class="text"/></td>
            </tr>
            <tr>
                <td class="bg1" align="right">身高：</td>
                <td class="bg2"><input name="height" type="text" class="text text60"/>CM</td>
            </tr>
            <tr>
                <td class="bg1" align="right">上传照片：</td>
                <td class="bg2">
                    <input type="file" name="image" id="image" />
                    <font color="red">（大小：80*110，1寸,图片格式为jpg, gif, bmp, png, ico）</font>
                </td>
            </tr>

            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;户口所在地：</td>
                <td class="bg2"><input name="" type="text" class="text"/></td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;家庭居住地址：</td>
                <td class="bg2"><input name="" type="text" class="text"/></td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;所学专业：</td>
                <td class="bg2"><input name="" type="text" class="text"/></td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;学历：</td>
                <td class="bg2"><select name="" class="xiala1">
                    <option>大专</option>
                    <option>本科</option>
                    <option>硕士</option>
                </select></td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;电子邮箱：</td>
                <td class="bg2"><input name="email" type="text" class="text text60"/></td>
            </tr>
            <tr>
                <td class="bg1" align="right"><span>*</span>&nbsp;固定电话：</td>
                <td class="bg2"><input name="areaCode" type="text" class="text"/></td>
            </tr>

            <tr>
                <td class="bg1 padding3" colspan="2"><span>*</span>&nbsp;教育经历：（请按照从上到下顺序填写）</td>
            </tr>
            <tr>
                <td class="bg2" colspan="2">
                    <table width="96%" cellspacing="5" align="center" border="0" style="padding:10px;">
                        <tr>
                            <td>期间:(例如：2008-02)</td>
                            <td>院校名称</td>
                            <td>专业</td>
                            <td>学历</td>
                            <td>学位</td>
                            <td>学习形式</td>
                        </tr>
                        <tr>
                            <td><input name="edStart" type="text" class="text text50"/>—<input name="edEnd" type="text" class="text text50"/></td>
                            <td><input name="edSchool" type="text" class="text text90"/></td>
                            <td><input name="edProfession" type="text" class="text text90"/></td>
                            <td><input name="edBackground" type="text" class="text text90"/></td>
                            <td><input name="edEgree" type="text" class="text text90"/></td>
                            <td><input name="edCategory" type="text" class="text text90"/></td>
                        </tr>
                        <tr>
                            <td><input name="edStart" type="text" class="text text50"/>—<input name="edEnd" type="text" class="text text50"/></td>
                            <td><input name="edSchool" type="text" class="text text90"/></td>
                            <td><input name="edProfession" type="text" class="text text90"/></td>
                            <td><input name="edBackground" type="text" class="text text90"/></td>
                            <td><input name="edEgree" type="text" class="text text90"/></td>
                            <td><input name="edCategory" type="text" class="text text90"/></td>
                        </tr>
                        <tr>
                            <td><input name="edStart" type="text" class="text text50"/>—<input name="edEnd" type="text" class="text text50"/></td>
                            <td><input name="edSchool" type="text" class="text text90"/></td>
                            <td><input name="edProfession" type="text" class="text text90"/></td>
                            <td><input name="edBackground" type="text" class="text text90"/></td>
                            <td><input name="edEgree" type="text" class="text text90"/></td>
                            <td><input name="edCategory" type="text" class="text text90"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="bg1 padding3" colspan="2"><span>*</span>&nbsp;工作经历：（请按照从上到下顺序填写）</td>
            </tr>
            <tr>
                <td class="bg2" colspan="2">
                    <table width="96%" cellspacing="5" align="center" border="0" style="padding:10px;">
                        <tr>
                            <td>期间:(例如：2008-02)</td>
                            <td>工作单位</td>
                            <td>岗位名称</td>
                            <td>证明人</td>
                            <td>联系方式</td>
                            <td>主要工作职责</td>
                            <td>离职原因</td>
                        </tr>
                        <tr>
                            <td><input name="wkStart" type="text" class="text text50"/>—<input name="wkEnd" type="text" class="text text50"/></td>
                            <td><input name="wkCompany" type="text" class="text text60"/></td>
                            <td><input name="wkStation" type="text" class="text text60"/></td>
                            <td><input name="wkProvePerson" type="text" class="text text60"/></td>
                            <td><input name="wkContact" type="text" class="text text60"/></td>
                            <td><input name="wkResponsibility" type="text" class="text text60"/></td>
                            <td><input name="wkLeaveReason" type="text" class="text text60"/></td>
                        </tr>
                        <tr>
                            <td><input name="wkStart" type="text" class="text text50"/>—<input name="wkEnd" type="text" class="text text50"/></td>
                            <td><input name="wkCompany" type="text" class="text text60"/></td>
                            <td><input name="wkStation" type="text" class="text text60"/></td>
                            <td><input name="wkProvePerson" type="text" class="text text60"/></td>
                            <td><input name="wkContact" type="text" class="text text60"/></td>
                            <td><input name="wkResponsibility" type="text" class="text text60"/></td>
                            <td><input name="wkLeaveReason" type="text" class="text text60"/></td>
                        </tr>
                        <tr>
                            <td><input name="wkStart" type="text" class="text text50"/>—<input name="wkEnd" type="text" class="text text50"/></td>
                            <td><input name="wkCompany" type="text" class="text text60"/></td>
                            <td><input name="wkStation" type="text" class="text text60"/></td>
                            <td><input name="wkProvePerson" type="text" class="text text60"/></td>
                            <td><input name="wkContact" type="text" class="text text60"/></td>
                            <td><input name="wkResponsibility" type="text" class="text text60"/></td>
                            <td><input name="wkLeaveReason" type="text" class="text text60"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="bg1 padding3" colspan="2">所获证书：</td>
            </tr>
            <tr>
                <td class="bg2" colspan="2">
                    <table width="96%" cellspacing="5" align="center" border="0" style="padding:10px;">
                        <tr>
                            <td>获得时间:(例如：2008-02)</td>
                            <td>发证/注册单位</td>
                            <td>证书名称</td>
                        </tr>
                        <tr>
                            <td><input name="cfTime" type="text" class="text margin0"/></td>
                            <td><input name="cfCompany" type="text" class="text margin0"/></td>
                            <td><input name="cfName" type="text" class="text margin0"/></td>
                        </tr>
                        <tr>
                            <td><input name="cfTime" type="text" class="text margin0"/></td>
                            <td><input name="cfCompany" type="text" class="text margin0"/></td>
                            <td><input name="cfName" type="text" class="text margin0"/></td>
                        </tr>
                        <tr>
                            <td><input name="cfTime" type="text" class="text margin0"/></td>
                            <td><input name="cfCompany" type="text" class="text margin0"/></td>
                            <td><input name="cfName" type="text" class="text margin0"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="bg1 padding3" colspan="2">培训经历：</td>
            </tr>
            <tr>
                <td class="bg2" colspan="2">
                    <table width="96%" cellspacing="5" align="center" border="0" style="padding:10px;">
                        <tr>
                            <td>期间：(例如：2008-02)</td>
                            <td>培训机构</td>
                            <td>培训内容</td>
                        </tr>
                        <tr>
                            <td><input name="trStart" type="text" class="text text50"/>—<input name="trEnd" type="text" class="text text50"/></td>
                            <td><input name="trCompany" type="text" class="text margin0"/></td>
                            <td><input name="trContent" type="text" class="text margin0"/></td>
                        </tr>
                        <tr>
                            <td><input name="trStart" type="text" class="text text50"/>—<input name="trEnd" type="text" class="text text50"/></td>
                            <td><input name="trCompany" type="text" class="text margin0"/></td>
                            <td><input name="trContent" type="text" class="text margin0"/></td>
                        </tr>
                        <tr>
                            <td><input name="trStart" type="text" class="text text50"/>—<input name="trEnd" type="text" class="text text50"/></td>
                            <td><input name="trCompany" type="text" class="text margin0"/></td>
                            <td><input name="trContent" type="text" class="text margin0"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="bg1 padding3" colspan="2">家庭情况：</td>
            </tr>
            <tr>
                <td class="bg2" colspan="2">
                    <table width="96%" cellspacing="5" align="center" border="0" style="padding:10px;">
                        <tr>
                            <td>姓名</td>
                            <td>与本人关系</td>
                            <td>工作单位</td>
                            <td>职位</td>
                        </tr>
                        <tr>
                            <td><input name="faName" type="text" class="text margin0"/></td>
                            <td><input name="faRelation" type="text" class="text margin0"/></td>
                            <td><input name="faCompany" type="text" class="text margin0"/></td>
                            <td><input name="faStation" type="text" class="text margin0"/></td>
                        </tr>
                        <tr>
                            <td><input name="faName" type="text" class="text margin0"/></td>
                            <td><input name="faRelation" type="text" class="text margin0"/></td>
                            <td><input name="faCompany" type="text" class="text margin0"/></td>
                            <td><input name="faStation" type="text" class="text margin0"/></td>
                        </tr>
                        <tr>
                            <td><input name="faName" type="text" class="text margin0"/></td>
                            <td><input name="faRelation" type="text" class="text margin0"/></td>
                            <td><input name="faCompany" type="text" class="text margin0"/></td>
                            <td><input name="faStation" type="text" class="text margin0"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="bg1 padding5">工作业绩：(1000字以内)(备注：为避免格式出错，请先将简历粘贴至记事本，再由记事本粘贴至此框中)</td>
                <td align="center" class="bg2"><textarea name="performance" cols="" rows="" class="textarea"></textarea></td>
            </tr>
            <tr>
                <td class="bg1 padding5">奖惩经历：(1000字以内)( 备注：为避免格式出错，请先将简历粘贴至记事本，再由记事本粘贴至此框中)</td>
                <td align="center" class="bg2"><textarea name="rewardsPunishment" cols="" rows="" class="textarea"></textarea></td>
            </tr>
            <tr>
                <td class="bg1 padding3" colspan="2">未处理事项表：</td>
            </tr>
            <tr>
                <td class="bg2" colspan="2">
                    <table align="center" cellspacing="2" cellpadding="1" width="98%" border="0">
                        <tr>
                            <td><input name="unHandleThing" type="radio" value="1"/>&nbsp;劳动合同</td>
                            <td><input name="unHandleThing" type="radio" value="2"/>&nbsp;保密协议</td>
                            <td><input name="unHandleThing" type="radio" value="3"/>&nbsp;培训费用补偿</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="bg1 padding5">个人简介（包括特长、爱好等）：(1000字以内)(备注：为避免格式出错，请先将简历粘贴至记事本，再由记事本粘贴至此框中)</td>
                <td align="center" class="bg2"><textarea name="personalHobbies" cols="" rows="" class="textarea"></textarea></td>
            </tr>
            <tr>
                <td class="bg1 padding5">职业生涯规划：(1000字以内)(备注：为避免格式出错，请先将简历粘贴至记事本，再由记事本粘贴至此框中)</td>
                <td align="center" class="bg2"><textarea name="careerPlanning" cols="" rows="" class="textarea"></textarea></td>
            </tr>
            <tr>
                <td height="50" colspan="2" align="center" class="bg2">
                    <input name="" type="button" class="button_submit" onclick="onSubmit();"/>
                    <input name="" type="button" class="button_reset" onclick="onReset();"/>
                </td>
            </tr>
            </table>
            </form>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jsp"%>
</div>
<script type="text/javascript">
    function onSubmit(){
        document.getElementById("resumeForm").submit();
    }
    function onReset(){
        document.getElementById("resumeForm").reset();
    }
</script>
</body>
</html>
