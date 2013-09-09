/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-9-10
 * Time: 上午12:59
 * To change this template use File | Settings | File Templates.
 */
var submitStatus = '0' ;
function stringTrim(str) {
    return str.replace(/^\s*/g, "").replace(/\s*$/g, "");
}
function pageOnBlur(itemName){
    var obj = document.getElementById(itemName);
    var value = stringTrim(obj.value);
    if(value == ''){
        document.getElementById(itemName + '_li').innerText = '必填项' ;
        submitStatus = '0' ;
    }else{
        /*检测用户名*/
        if(itemName == 'username'){
//                    alert('username=' + value);
            $.ajax({
                url: '${basePath}register_userExist.htm',
                type: 'POST',
                data: 'username=' + value,
                cache: false,
                async : false, //默认为true 异步
                dataType : 'json' ,
                error:function(a,b,c){
//                            alert(a + " " + b + "  " + c);
                    document.getElementById('username_li').innerText = '检测超时,请稍后重试.';
                },
                success: function(data) {
//                            alert(data);
                    if(data.regStatus == 'empty' || data.regStatus == 'exist'){
                        $("#username_li").html(data.regMessage);
                        submitStatus = '0' ;
                    }else{
                        $("#username_li").html(data.regMessage);
                        submitStatus = '1' ;
                    }
                }
            });
        }
    }
}
function pageOnUp(itemName,length){
    var obj = document.getElementById(itemName);
    var value = stringTrim(obj.value);
    if(length > 0){
        if(value.length < length){
            document.getElementById(itemName + '_li').innerText = '长度必须大于' + length ;
            submitStatus = '0' ;
        }else{
            document.getElementById(itemName + '_li').innerText = '' ;
            submitStatus = '1' ;
        }
        if(itemName == 'passwdRp'){
            var passwd = stringTrim(document.getElementById('passwd').value);
            var passwdRp = stringTrim(document.getElementById('passwdRp').value);
            if(passwd != passwdRp){
                document.getElementById('passwdRp_li').innerText = '两次输入的密码不一致' ;
                submitStatus = '0' ;
            }
        }
    }else{
        document.getElementById(itemName + '_li').innerText = '' ;
        submitStatus = '1' ;
    }

}
function pageOnSubmit(){
    if(submitStatus == '0'){
        pageOnUp('username',2);
        pageOnUp('nickname',2);
        pageOnUp('passwd',6);
        pageOnUp('passwdRp',6);
        pageOnUp('company',0);
        pageOnUp('dept',0);
        pageOnUp('mobile',0);
        pageOnUp('phone',0);
        pageOnUp('email',0);
        return false;
    }
    else{
        var content = 'username=' + stringTrim($("#username").attr("value")) + '&nickname=' + stringTrim($("#nickname").attr("value"))
            + '&passwd=' + stringTrim($("#passwd").attr("value")) + '&passwdRp=' + stringTrim($("#passwdRp").attr("value"))
            + '&company=' + stringTrim($("#company").attr("value")) + '&dept=' + stringTrim($("#dept").attr("value"))
            + '&mobile=' + stringTrim($("#mobile").attr("value")) + '&phone=' + stringTrim($("#phone").attr("value"))
            + '&email=' + stringTrim($("#email").attr("value")) ;
//                alert(content);
        $.ajax({
            url: '${basePath}register.htm',
            type: 'POST',
            data: content,
            cache: false,
            async : false, //默认为true 异步
            error:function(a,b,c){
//                        alert(a + " " + b + "  " + c);
                document.getElementById('username_li').innerText = '检测超时,请稍后重试.';
            },
            success: function(data) {
                if(data == '1'){
                    window.location = 'http://www.sina.com' ;
                }
                else{
                    document.getElementById("resultDiv").style.display = 'block' ;
                    $("#register_message").html('注册失败');

                }
            }
        });
    }
}
/*$().ready( function() {
 var submitStatus = '0' ;
 var $username = $("#username");
 $username.blur(function(){
 var value = stringTrim($username.attr("value"));
 if(value == ''){
 $("#username_li").html('必填项');
 }
 });
 $("#username").keyup(function(){
 var value = stringTrim($username.attr("value"));
 if(value != ''){
 $("#username_li").html('');
 }
 });
 });*/