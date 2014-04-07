//添加到收藏夹
$("addFavorites").click(function () {
    var ctrl = (navigator.userAgent.toLowerCase()).indexOf('mac') != -1 ? 'Command/Cmd' : 'CTRL';
    if (document.all) {
        window.external.addFavorite(window.location, document.title);
    }
    else if (window.sidebar) {
        window.sidebar.addPanel(document.title, window.location);

    }
    else {//添加收藏的快捷键

        alert('添加失败\n您可以尝试通过快捷键' + ctrl + ' + D 加入到收藏夹~');
    }
});


//设置主页
$("#addHomePage").click(function () {
    if (document.all) {//设置IE
        document.body.style.behavior = 'url(#default#homepage)';
        document.body.setHomePage(document.URL);

    }
    else {//网上可以找到设置火狐主页的代码，但是点击取消的话会有Bug，因此建议手动设置
        alert("设置首页失败，请手动设置！");
    }
});