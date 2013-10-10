<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="jiaodiantu">
    <div id="xxx">
        <script>
            var box = new PPTBox();
            box.width = 264; //宽度
            box.height = 200;//高度
            box.autoplayer = 2;//自动播放间隔时间
            box.add({"url": "${basePath}res/front/library/images/jiaodiantu1.jpg"})
            box.add({"url": "${basePath}res/front/library/images/jiaodiantu2.jpg"})
            box.add({"url": "${basePath}res/front/library/images/jiaodiantu3.jpg"})
            box.add({"url": "${basePath}res/front/library/images/jiaodiantu4.jpg"})
            box.show();
        </script>
    </div>
</div>