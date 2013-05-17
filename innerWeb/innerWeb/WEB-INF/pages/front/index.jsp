<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tagInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="Shortcut Icon" href="${basePath}res/ico/favicon.ico" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${basePath}res/front/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}res/front/css/footer.css" rel="stylesheet" type="text/css"/>
    <title>内网管理系统</title>
</head>
<body>
<div class="box">
<!--头部代码开始-->
<div class="header">
    <div class="header_top">
        <div class="header_top_logo"><img src="${basePath}res/front/images/logo.png"/></div>
        <div class="header_top_login">
            <p>
                <%--<iframe name="sinaWeatherTool"
                        src="http://weather.news.sina.com.cn/chajian/iframe/weatherStyle1.html?city=%E5%8C%97%E4%BA%AC"
                        width="200" height="20" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0"
                        scrolling="no"></iframe>--%>
                    <iframe width="450" scrolling="no" height="20" frameborder="0" allowtransparency="true"
                            src="http://www.tianqi.com/index.php?c=code&id=1&icon=1&wind=1&num=2"></iframe>
            </p>

            <p style="margin-top:10px;">
            <ul>
                <li><img src="${basePath}res/front/images/header_login.png"/></li>
                <li>
                    <span>欢迎您：${sessionScope.SESSION_USERID}</span>
                </li>
                <li>|</li>
                <li><img src="${basePath}res/front/images/header_mail.png"/></li>
                <li>站内信</li>
                <li style="background-image:url(${basePath}res/front/images/botton_logout.png); margin-left:20px; margin-top:3px;">
                    <input type="button" value="退出" class="botton_logout"/>
                </li>
            </ul>
            </p>
        </div>
    </div>
    <div class="menu">
        <ul>
            <li><a href="mg/home.htm" target="_blank">个人中心</a></li>
            <li>|</li>
            <li><a href="#">员工生活</a></li>
            <li>|</li>
            <li><a href="${basePath}/index.htm">首&nbsp;&nbsp;&nbsp;&nbsp;页</a></li>
        </ul>
    </div>
</div>
<!--头部代码结束-->
<!--中间内容部分代码开始-->
<div class="body">
<!--左半边代码开始-->
<div class="body_left">
    <div class="body_left_1">
        <div class="body_left_tit">
            <ul class="tit_biao">
                <li><img src="${basePath}res/front/images/left_tit_biao.png"/></li>
                <li style="padding-left:15px;">总院快捷入口</li>
            </ul>
        </div>
        <div class="body_left_con">
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">通讯录</a></li>
            </ul>
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">邮件系统</a></li>
            </ul>
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">OA系统</a></li>
            </ul>
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">视频会议系统（在建）</a></li>
            </ul>
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">科研项目管理系统（在建）</a></li>
            </ul>
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">档案管理系统（在建）</a></li>
            </ul>
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">后勤服务（在建）</a></li>
            </ul>
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">科技成果发布（在建）</a></li>
            </ul>
        </div>
    </div>
    <div class="body_left_1" style="margin-top:10px;">
        <div class="body_left_tit">
            <ul class="tit_biao">
                <li><img src="${basePath}res/front/images/left_tit_biao.png"/></li>
                <li style="padding-left:15px;">集团系统快捷入口</li>
            </ul>
        </div>
        <div class="body_left_con">
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">集团通讯录</a></li>
            </ul>
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao.png"/></li>
                <li><a href="#">集团信息门户</a></li>
            </ul>
        </div>
        <div class="body_left_con_zilei">
            <ul>
                <li><img src="${basePath}res/front/images/left_con_biao1.png"/></li>
                <li><a href="#">工会管理信息系统</a></li>
            </ul>
        </div>
    </div>
    <div class="body_left_1" style="margin-top:10px;">
        <div class="body_left_tit">
            <ul class="tit_biao">
                <li><img src="${basePath}res/front/images/left_tit_biao1.png"/></li>
                <li style="padding-left:15px;">常用链接</li>
            </ul>
        </div>
        <div class="body_left_con1">
            <ul>
                <li><select name="" class="xiala">
                    <option value="------集团系统网站链接------" selected="selected">------集团系统网站链接------</option>
                </select></li>
                <li><select name="" class="xiala">
                    <option value="------常用网站链接------" selected="selected">------常用网站链接------</option>
                </select></li>
            </ul>
        </div>
    </div>
    <div class="body_left_1" style="margin-top:10px;">
        <div class="body_left_tit">
            <ul class="tit_biao">
                <li><img src="${basePath}res/front/images/left_tit_biao2.png"/></li>
                <li style="padding-left:15px;">全文检索</li>
            </ul>
        </div>
        <div class="body_left_con1">
            <ul>
                <li><input name="" type="text" class="searchtext" value="请输入关键字"/></li>
                <li><a href="#"><img src="${basePath}res/front/images/botton_search.jpg"/></a></li>
            </ul>
        </div>
    </div>
    <div class="left_guanggao">
        <img src="${basePath}res/front/images/guanggao1.jpg"/></div>
    <div class="left_guanggao"><img src="${basePath}res/front/images/guanggao1.jpg"/></div>
</div>
<!--左半边代码结束-->
<!--右半边代码开始-->
<div class="body_right">
<div class="body_right_1">
    <div class="body_right_tit">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_2">
    <div class="body_right_tit">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_1">
    <div class="body_right_tit1">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_2">
    <div class="body_right_tit1">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_1">
    <div class="body_right_tit1">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_2">
    <div class="body_right_tit1">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_1">
    <div class="body_right_tit2">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_2">
    <div class="body_right_tit2">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_1">
    <div class="body_right_tit2">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_2">
    <div class="body_right_tit2">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_1">
    <div class="body_right_tit3">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
<div class="body_right_2">
    <div class="body_right_tit3">
        <ul class="tit_biao">
            <li><img src="${basePath}res/front/images/right_tit_biao.png"/></li>
            <li style="padding-left:15px;">公司通知公告</li>
        </ul>
        <ul class="tit_biao_right">
            <li><img src="${basePath}res/front/images/right_tit_biao2.png"/></li>
            <li><a href="#">更&nbsp;多</a></li>
        </ul>
    </div>
    <div class="body_right_con">
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
        <ul class="con_right">
            <li><img src="${basePath}res/front/images/right_tit_biao3.png"/></li>
            <li><a href="#">关于西直门宾馆停车场恢复使用通知</a></li>
            <li style="float:right;">2013-3-21</li>
        </ul>
    </div>
</div>
</div>
<!--右半边代码结束-->
	<!-- 友情链接 -->
	<%@include file="include/friendlyLinks.jsp" %>
</div>
<!--中间内容部分代码结束-->
	<!-- 底部 -->
    <%@include file="include/footer.jsp" %>
</div>
</body>
</html>