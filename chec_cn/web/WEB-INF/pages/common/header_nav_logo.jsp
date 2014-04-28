<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true"%>
<%@ page isELIgnored="false" %>
<link href="${basePath}res/front/flash/css/orman.css" rel="stylesheet" type="text/css" />
<link href="${basePath}res/front/flash/css/nivo-slider.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${basePath}res/front/flash/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="${basePath}res/front/flash/js/jquery.nivo.slider.pack.js"></script>
<script type="text/javascript">
    $(window).load(function() {
        $('#slider').nivoSlider({
            controlNav:true
        });
    });
</script>
<div class="slider-wrapper theme-orman">
    <div class="ribbon"></div>
    <div id="slider" class="nivoSlider">
        <img src="${basePath}res/front/flash/img/01.jpg" alt="Homepage Slider" title="务实 创新 高效 和谐" />
        <img src="${basePath}res/front/flash/img/02.jpg" alt="Web Design" title="拼搏进取 追求卓越" />
        <img src="${basePath}res/front/flash/img/03.jpg" alt="New Template" title="务实 创新 高效 和谐" />
        <img src="${basePath}res/front/flash/img/04.jpg" alt="Business Website" title="拼搏进取 追求卓越" />
    </div>
    <div class="nivo-controlNav-bg"></div>
</div>