/**
 * Created with IntelliJ IDEA.
 * User: zy
 * Date: 13-9-11
 * Time: 下午7:26
 * To change this template use File | Settings | File Templates.
 */
function showTxDiv(obj,content,title) {
    var billingCodeTbodyHtml = "<tr><td><img height='130px' width='260px' src='" + content + "'/><td></tr>" ;
    $("#txTbody").html("");
    $("#txTbody").append($(billingCodeTbodyHtml));
    $("#txDivTitle").html(title);

    var h=0, l=0, w=0;
    while(obj != null) {
        h += obj.offsetTop;
        l += obj.offsetLeft;
        obj = obj.offsetParent;
    }
    w = $(obj).width();
    $("#txDiv").css({'top':h+5+'px','left':(l-300)+'px'});
    $("#txDiv").show();
}
function closeTxDiv() {
    $("#txDiv").hide();
}