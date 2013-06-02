<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    function search(){
        var kw = document.getElementById("kw").value ;
        window.location = "${basePath}search.htm?kw=" + encodeURI(kw) ;
    }

</script>
<div class="body_left_1" style="margin-top: 10px;">
	<div class="body_left_tit">
		<ul class="tit_biao">
			<li><img src="${basePath}res/front/images/left_tit_biao2.png" />
			</li>
			<li style="padding-left: 15px;">全文检索</li>
		</ul>
	</div>
	<div class="body_left_con1">
		<ul>
			<li><input name="kw" id="kw" type="text" class="searchtext" value="${kw}" />
			</li>
			<li><a href="javascript:search();"><img
					src="${basePath}res/front/images/botton_search.jpg" />
			</a>
			</li>
		</ul>
	</div>
</div>
<div class="left_guanggao">
	<a href="${basePath}library-0-0-1.htm"><img src="${basePath}res/front/images/guanggao1.jpg" border="0"/></a>
</div>
<div class="left_guanggao">
	<img src="${basePath}res/front/images/kyzy.jpg" border="0"/>
</div>