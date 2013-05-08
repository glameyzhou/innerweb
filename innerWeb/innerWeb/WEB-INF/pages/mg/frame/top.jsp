<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/tagInclude.jsp"%>
<%@include file="../../common/headerInclude.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>头部信息--导航条</title>
<style type="text/css">
*{margin:0;padding:0}
html{height:100%;overflow:hidden;}
body{height:100%;}
#welcome{color:#FFF;padding-left:5px;}
#unReadMessage{color:#FFF;padding-left:5px;}
#unReadMsgCount{color:#FFF;padding-left:5px;}
#logout{color:#FFF;padding:0 10px 0 5px;}
#view_index{color:#FFF;}
.menu{padding-left:1em;font-size:12px;font-weight:700;float:left;margin:4px 4px 0 0;list-style:none;}
.menu li{float:left;}
.menu li.sep{float:left;height:35px;width:10px;background:url(${basePath}res/jeecms/img/admin/sep.jpg) left 3px no-repeat;}
.menu li a{display:block;height:35px;float:left;line-height:35px;padding:0 14px;color:#000;outline:none;hide-focus:expression(this.hideFocus=true);}
.menu li.current{background-color: blue;}
/*.menu li.current{background:url(${basePath}res/jeecms/img/admin/nav_current.jpg) left top no-repeat;} */
.menu li.current a{color:#fff;}
.undis{display:none;}
.dis{display:block;}
</style>

<script type="text/javascript">
	function g(o){
		return document.getElementById(o);
	}
	function HoverLi(m,n,counter){
		for(var i=1;i<=counter;i++){
			g('tb_'+m+i).className='';
		}
		g('tb_'+m+n).className='current';
	}
</script>
</head>

<body>
<div id="top">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="223">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"  background="${basePath}res/jeecms/img/admin/top_bg.jpg">
      <tr>
        <td><img src="${basePath}res/jeecms/img/admin/logo.png"></td>
      </tr>
      <tr>
        <td height="33" align="center" background="${basePath}res/jeecms/img/admin/time_bg.jpg">
		<img src="${basePath}res/jeecms/img/admin/ico3.jpg">&nbsp;现在时间：
       <script language="javascript">
		var day="";
		var month="";
		var ampm="";
		var ampmhour="";
		var myweekday="";
		var year="";
		mydate=new Date();
		myweekday=mydate.getDay();
		mymonth=mydate.getMonth()+1;
		myday= mydate.getDate();
		year= mydate.getFullYear();
		if(myweekday == 0)
		weekday=" 星期日 ";
		else if(myweekday == 1)
		weekday=" 星期一 ";
		else if(myweekday == 2)
		weekday=" 星期二 ";
		else if(myweekday == 3)
		weekday=" 星期三 ";
		else if(myweekday == 4)
		weekday=" 星期四 ";
		else if(myweekday == 5)
		weekday=" 星期五 ";
		else if(myweekday == 6)
		weekday=" 星期六 ";
		document.write(year+"年"+mymonth+"月"+myday+"日 "+weekday);
	   </script>
       </td>
      </tr>
    </table></td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="54"><img src="${basePath}res/jeecms/img/admin/top_bg.jpg"></td>
        <td background="${basePath}res/jeecms/img/admin/top_bg.jpg"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="500px" height="30">
				<img src="${basePath}res/jeecms/img/admin/welconlogin-icon.png"><span id="welcome">用户名字&nbsp;&nbsp;[角色]</span>
				<img src="${basePath}res/jeecms/img/admin/loginout-icon.png"><a id="logout" href="${basePath}mg/logout.htm" target="_top" >注销</a>&nbsp;&nbsp;
				<%--<span id="welcome">首页[<a href="${basePath}cn/" id="logout" target="_blank">中文</a>&nbsp;<a href="${basePath}en/" id="logout" target="_blank">英文</a>]</span>--%>
			</td>
            <td align="right">&nbsp;
            </td>
            <td width="100">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><img src="${basePath}res/jeecms/img/admin/top_07.jpg"></td>
        <td background="${basePath}res/jeecms/img/admin/nav_bg.jpg">
		   <ul class="menu">			
			<li class="current" id="tb_11" onclick="HoverLi(1,1,4);"><a href="${basePath}mg/frame/home.htm" target="mainFrame">首页</a></li>
			<li class="sep"></li><li id="tb_12" onclick="HoverLi(1,2,4);"><a href="${basePath}mg/post/news/index.htm" target="mainFrame">新闻</a></li>
			<li class="sep"></li><li id="tb_13" onclick="HoverLi(1,3,4);"><a href="${basePath}mg/post/notices/index.htm" target="mainFrame">通知公告</a></li>
			<li class="sep"></li><li id="tb_14" onclick="HoverLi(1,4,4);"><a href="${basePath}mg/links/index.htm" target="mainFrame">快捷入口管理</a></li>
			</ul>
		</td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
</body>
</html>