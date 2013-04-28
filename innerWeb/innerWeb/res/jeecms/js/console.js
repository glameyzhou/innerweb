function stringTrim(str) {
	return str.replace(/^\s*/g, "").replace(/\s*$/g, ""); 
}
function getRadioValue(radioName){
	var aa = document.getElementsByName(radioName);
    for (var i=0; i<aa.length; i++){
     if(aa[i].checked){
    	 return aa[i].value;
     }
    }
}
function checkAll(itemName,flag){
	var all_checkbox = document.getElementsByName(itemName);
	for(var i=0;i<all_checkbox.length;i++){
		if(flag == true)
			all_checkbox[i].checked = true;
		else
			all_checkbox[i].checked = false;
	}
	
}
function isChecked(itemName){
	var all_checkbox = document.getElementsByName(itemName);
	var len = all_checkbox.length;
	var isChecked = false ;
	for(var i=0;i<len ;i++){
		if(all_checkbox[i].checked == true){
			isChecked = true ;
			break ;
		}
	}
	return isChecked ;
}	   
function delCheck(itemName){
	var all_checkbox = document.getElementsByName(itemName);
	var len = all_checkbox.length;
	if(isChecked(itemName) == false ){
		alert('至少选择一项');
	}else{
		if(!confirm('确定要删除'))return;
		var values = "";
		for(var i=0;i<len ;i++){
			if(all_checkbox[i].checked)
				values += "," + all_checkbox[i].value;
		}
		if(itemName == 'domainId'){
			window.location = '../delCheckbox?flag=domainId&ids='+values;
		} else if(itemName == 'ipId'){
			window.location = '../delCheckbox?flag=ipId&ids='+values;
		} else{
			window.location = '../delCheckbox?flag=dynamicId&ids='+values;
		}
	}
}
