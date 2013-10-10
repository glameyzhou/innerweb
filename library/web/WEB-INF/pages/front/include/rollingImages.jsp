<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="youlian1" style="margin-left:5px;">
    <div class="tupian_tit">
        <ul>
            <li>图片滚动</li>
            <li style="background-image:url(${basePath}res/front/library/images/focus_title2.png); float:right; line-height:normal; font-size:12px; font-family:'新宋体'; font-weight:normal; margin-top:8px; padding-right:10px;">
                <a href="#">更多</a></li>
        </ul>
    </div>
    <div id="colee_left" style="overflow:hidden;width:980px;margin-left:10px;">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td id="colee_left1" valign="top" align="center">
                    <table cellpadding="0" cellspacing="5" border="0">
                        <tr align="center">
                            <td>
                                <a href="#">
                                    <p>
                                        <img src="${basePath}res/front/library/images/tupian_1.jpg" height="147" width="212"/>
                                    </p>
                                </a>
                            </td>
                            <td>
                                <a href="#">
                                    <p>
                                        <img src="${basePath}res/front/library/images/tupian_2.jpg" height="147" width="212"/>
                                    </p>
                                </a>
                            </td>
                            <td>
                                <a href="#">
                                    <p>
                                        <img src="${basePath}res/front/library/images/tupian_2.jpg" height="147" width="212"/>
                                    </p>
                                </a>
                            </td>
                            <td>
                                <a href="#">
                                    <p>
                                        <img src="${basePath}res/front/library/images/tupian_1.jpg" height="147" width="212"/>
                                    </p>
                                </a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td id="colee_left2" valign="top"></td>
            </tr>
        </table>
    </div>
</div>
<script>
    /*使用div时，请保证colee_left2与colee_left1是在同一行上.*/
    var speed = 30//速度数值越大速度越慢
    var colee_left2 = document.getElementById("colee_left2");
    var colee_left1 = document.getElementById("colee_left1");
    var colee_left = document.getElementById("colee_left");
    colee_left2.innerHTML = colee_left1.innerHTML
    function Marquee3() {
        if (colee_left2.offsetWidth - colee_left.scrollLeft <= 0)/*offsetWidth 是对象的可见宽度*/
            colee_left.scrollLeft -= colee_left1.offsetWidth /*scrollWidth 是对象的实际内容的宽，不包边线宽度*/
        else {
            colee_left.scrollLeft++
        }
    }
    var MyMar3 = setInterval(Marquee3, speed)
    colee_left.onmouseover = function () {
        clearInterval(MyMar3)
    }
    colee_left.onmouseout = function () {
        MyMar3 = setInterval(Marquee3, speed)
    }
</script>