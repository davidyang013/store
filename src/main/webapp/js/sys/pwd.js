function upValidate(){
	var pwdOld = document.getElementById("pwdOld").value;
	var pwdNew = document.getElementById("pwd").value;
	var pwdRepeat = document.getElementById("pwdRepeat").value;
	var oldInfo = document.getElementById("oldInfo");
	var newInfo = document.getElementById("newInfo");
	var repeatInfo = document.getElementById("repeatInfo");
	oldInfo.innerText = newInfo.innerText = repeatInfo.innerText = "";
	if(pwdOld == ""){
		oldInfo.innerText = "原密码不能为空!";
		return;
	}
	oldInfo.innerText = newInfo.innerText = repeatInfo.innerText = "";
	
	if(pwdNew == ""){
		newInfo.innerText = "新密码不能为空!";
		return;
	}
	oldInfo.innerText = newInfo.innerText = repeatInfo.innerText = "";
	
	if(pwdRepeat == ""){
		repeatInfo.innerText = "重复密码不能为空!";
		return;
	}
	oldInfo.innerText = newInfo.innerText = repeatInfo.innerText = "";
	
	if(pwdNew != pwdRepeat){
		newInfo.innerText = "两次输入的新密码不一致!";
		return;
	}
	oldInfo.innerText = newInfo.innerText = repeatInfo.innerText = "";
	
	if(len(pwdNew) < 6){
		newInfo.innerText = "密码长度不能小于6位";
		return;
	}
	oldInfo.innerText = newInfo.innerText = repeatInfo.innerText = "";
	if(len(pwdNew) > 20){
		newInfo.innerText = "密码长度不能超过20位";
		return;
	}
	oldInfo.innerText = newInfo.innerText = repeatInfo.innerText = "";
	document.forms[0].submit();
}

function resetInfo(){
	document.getElementById("oldInfo").innerText = "";
	document.getElementById("newInfo").innerText = "";
	document.getElementById("repeatInfo").innerText = "";
}

function len(s) {
	var length = 0;
	var a = s.split("");
	for (var i = 0; i < a.length; i++) {
	 if (a[i].charCodeAt(0) < 299) {
		 length++;
	 } else {
		 length+=2;
	 }
	}
	return length;
} 
