//页面load时设置要显示的option
function setLimitField(limitField){
	var cboLimit = document.getElementById("limitField");
	for(var i = 0; i < cboLimit.options.length; i++){
		if(cboLimit.options[i].value != limitField)
			continue;
		cboLimit.selectedIndex = i;
	}
}

function enterToTab(){
    if(event.srcElement.type != 'button'
	   && event.srcElement.type != 'textarea'
       && event.keyCode == 13){
        event.keyCode = 9;
    }
}

//转向页面
//郁君俊 2012年2月27日
//page:
//maxPage:总页数
//args:后接自己的参数时要加&
function toPage(args) {
	var frm = document.getElementsByTagName("form")[0];
	var link = document.all.refresh.value;
    var txtPage = document.getElementById("txtPage");
    var maxPage = document.getElementById("maxPage").innerHTML;
    if(!args){args = '';}
    if (txtPage == undefined)
        return;
    var newValue = txtPage.value;
    if (isNaN(txtPage.value) || parseInt(txtPage.value) < 1) {
        newValue = 1;
    }
    if (parseInt(txtPage.value) > parseInt(maxPage)) {
        newValue = maxPage;
    }
    frm.action = link + "?curPage=" + newValue + args;
	frm.submit();
}

//跳转到第一页
function getFirstPage() {
	var frm = document.getElementsByTagName("form")[0];
	var link = document.all.refresh.value;
    var curPage = document.getElementById("curPage");
    var maxPage = document.getElementById("maxPage");
	if (parseInt(curPage.innerHTML) == parseInt(maxPage.innerHTML))
		return;
    if (link.indexOf("?") == -1) {
    	frm.action = link + "?curPage=1";
    	frm.submit();
    }
    else {
    	frm.action = link + "&curPage=1";
        frm.submit();
    }
}

//跳转到下一页
function getNextPage() {
	var frm = document.getElementsByTagName("form")[0];
	var link = document.all.refresh.value;
    var curPage = document.getElementById("curPage");
    var maxPage = document.getElementById("maxPage");
    curPage.innerHTML = parseInt(curPage.innerHTML) + 1;
    if (parseInt(curPage.innerHTML) > parseInt(maxPage.innerHTML)) {
        curPage.innerHTML = maxPage.innerHTML;
        return;
    }
    if (link.indexOf("?") == -1) {
    	frm.action = link + "?curPage=" + curPage.innerHTML;
    	frm.submit();
    }
    else {
    	frm.action = link + "&curPage=" + curPage.innerHTML;
    	frm.submit();
    }
}

//跳转到上一页
function getLastPage() {
	var frm = document.getElementsByTagName("form")[0];
	var link = document.all.refresh.value;
    var curPage = document.getElementById("curPage");
    curPage.innerHTML = parseInt(curPage.innerHTML) - 1;
    if (parseInt(curPage.innerHTML) < 1) {
        curPage.innerHTML = 1;
        return;
    }
    if (link.indexOf("?") == -1) {
    	frm.action = link + "?curPage=" + curPage.innerHTML;
    	frm.submit();
    }
    else {
    	frm.action = link + "&curPage=" + curPage.innerHTML;
    	frm.submit();
    }
}

//跳转到最后一页
function getFinalPage() {
	var frm = document.getElementsByTagName("form")[0];
	var link = document.all.refresh.value;
    var curPage = document.getElementById("curPage");
    var maxPage = document.getElementById("maxPage");
	if (parseInt(curPage.innerHTML) == parseInt(maxPage.innerHTML))
		return;
    if (link.indexOf("?") == -1) {
    	frm.action = link + "?curPage=" + maxPage.innerHTML;
    	frm.submit();
    }
    else {
    	frm.action = link + "&curPage=" + maxPage.innerHTML;
    	frm.submit();
    }
}

//特殊字符校验
function check(str) {
	var mess = "";
	if (str.indexOf(";") >= 0) {
		mark = "no";
		mess += " ; ";
	}
	if (str.indexOf("\"") >= 0) {
		mark = "no";
		mess += " \" ";
	}
	if (str.indexOf("&") >= 0) {
		mark = "no";
		mess += " & ";
	}
	if (str.indexOf("<") >= 0) {
		mark = "no";
		mess += " < ";
	}
	if (str.indexOf(">") >= 0) {
		mark = "no";
		mess += " > ";
	}
	if (str.indexOf("--") >= 0) {
		mark = "no";
		mess += " -- ";
	}
	if (str.indexOf("/") >= 0) {
		mark = "no";
		mess += " / ";
	}
	if (str.indexOf("%") >= 0) {
		mark = "no";
		mess += " % ";
	}
	if (str.indexOf("'") >= 0) {
		mark = "no";
		mess += " ' ";
	}
	if (str.indexOf(" ") >= 0) {
		mark = "no";
		mess += "   ";
	}
	if (str.indexOf("　") >= 0) {
		mark = "no";
		mess += " 　 ";
	}
	
	return mess;
}

//隔行变色效果
function changeColor(className,begin) {
	return;
	var trs = document.getElementsByTagName("tr");
	var cnt = 0;
	if(isNaN(begin) || begin < 0)
		return;
	for(var i = 0; i < trs.length; i++){
		if(trs[i].className != className)
			continue;
		cnt = i;
		break;
	}
	for(var i = cnt + begin; i < trs.length; i++ ){		
		if(i%2 == 0){
			trs[i].className = "trOdd";
		}else if(i%2 == 1){
			trs[i].className = "trEven";
		}
	}
}

//光棒效果
//tblId要以字符串形式传入
function lightEffect(tblId, limit){
	var table = document.getElementById(tblId);   
	var rows = table.getElementsByTagName("tr");  
	if(!limit || limit > rows.length){
		limit = rows.length;
	}
	for (var i = 1; i < limit; i++){
	     rows[i].style.backgroundColor;   
	     
	     rows[i].onmouseover = function(){   
	    	 this.style.backgroundColor = '#FFF4C4';
	    	 //this.style.cursor="hand"; 
	     };  
	       
	     rows[i].onmouseout = function(){   
	    	 this.style.backgroundColor = '';   
	     };   
	}   
}

//复选框的选择以及取消选择操作
function doSel(id){
	var sel = document.getElementById(id);
	
	if(sel == undefined)
		return;
	sel.checked = !sel.checked;
}


//复选框的选择操作
function doCheck(id){
	var sel = document.getElementById(id);
	if(sel == undefined)
		return;
	if(sel.value == "null" || sel.value == "0")
		sel.checked = false;
}

//复选框全选
//郁君俊 2012年2月27日
//cboAll:用于全选的复选框的id
//cboName:复选框集合的name
function selAll(cboAll,cboName){
	var checkBox = document.getElementsByName(cboName);
	var checkAll = document.getElementById(cboAll);
	for(var i = 0;i < checkBox.length;i+=1)
	{
		if(checkBox[i].value != "null" && checkBox[i].value != "0"){
			checkBox[i].checked = checkAll.checked;
		}
		else{
			checkBox[i].checked = false;
		}
	}
}

//获取已选的复选框
function getChoice(name){
	var choice = document.getElementsByName(name);
	var choiceArr = new Array();
	for(var i = 0; i < choice.length; i++){
		if(!choice[i].checked)
			continue;
		choiceArr.push(choice[i]);
	}
	return choiceArr;
}

//在指定域设置当前年份
function setYear(id){
	var text = document.getElementById(id);
	text.value = (new Date()).getYear();
}

//去空格函数
function trim(str) { // 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

//统计输入长度
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

function openDlg(loc, width, height){
    ret = showModalDialog(loc, window, "status:false;scroll:yes;dialogWidth:" + width
                    				 + "px;dialogHeight:" + height + "px");
    if(ret == "refresh"){
    	if(!document.all.refresh){alert("请维护refresh标签");return;}
    	window.location.href = document.all.refresh.value; 
    	return;
    }
    
    if(ret == "refreshDlg"){
    	reload.click();
    }
}

function refresh(){
	window.returnValue = "refresh";
}

function refreshDlg(){
	window.returnValue = "refreshDlg";
}

function closeWindow(){
	window.close();
}

function proxyRequest(action, parameter) {
    var objXMLReq = null;
    if(window.ActiveXObject){
    	objXMLReq = new ActiveXObject("Microsoft.XMLHTTP");
    } else if(window.XMLHttpRequest){ 
    	objXMLReq = new XMLHttpRequest(); 
    } 
    var strURL = action;
    objXMLReq.open("POST", strURL, false);
    objXMLReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");  
    objXMLReq.send(parameter ? parameter : "");
    var strResult = objXMLReq.responseText;
    if(strResult.indexOf("PartRefresh:") == 0){
        eval(strResult.substring(12));
    }else{
    	document.createElement();
        document.write(strResult);
    }
}

function encode(url){
	return encodeURI(encodeURI(url));
}

function attachEvent(obj,eventName,fun,param){
	var fn = fun;
	if(param)
	{
		fn = function(e)
		{
			fun.call(e, param);  //继承监听函数,并传入参数以初始化;
		};
	}
	if(obj.attachEvent){
		obj.attachEvent(eventName,fn);
	}else if(obj.addEventListener){
		obj.addEventListener(eventName,fn,false);
	}else{
		obj[eventName] = fn;
	}
}

function removeTblRows(table){
	rows = table.rows;
	while(rows.length > 1){rows[1].removeNode(true);}
	//兼容火狐等浏览器
	//while(rows.length > 1){rows[1].parentNode.removeChild(rows[1]);} 
}

Array.prototype.remove = function(dx) {
	if (isNaN(dx) || dx > this.length) {
		return false;
	}
	for ( var i = 0, n = 0; i < this.length; i++) {
		if (this[i] != this[dx]) {
			this[n++] = this[i];
		}
	}
	this.length -= 1;
};  

function cloneObject(o) {
	if (!o || 'object' != typeof o) {
		return o;
	}
	var c = Object.prototype.toString.call(o) == '[object Array]' ? [] : {};
	var p = null, v;
	for (p in o) {
		if (o.hasOwnProperty(p)) {
			v = o[p];
			if (v && 'object' == typeof v) {
				c[p] = cloneObject(v);
			} else {
				c[p] = v;
			}
		}
	}
	return c;
}

function isChinese(str){
	if (str.value=="")
		return false;
	var reg = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
	if (reg.test(str))
		return true;
	else
		return false;
}

//为value不是数字的对象设置默认value
function setDefNumValue(obj, value){
	if(!obj || !isNaN(obj.value)){
		return;
	}
	obj.value = value;
}

// 打包成json数据格式
function toJSON(txtOrObj,hasIndent){
	var data=txtOrObj;
	if(typeof data=='string') try{data=eval('('+data+')');}catch(e){return "";};
	var draw=[],isLast=true;
	function notify(name,value,isLast,formObj){
		if(value&&value.constructor==Array){
			draw.push((formObj?('"'+name+'":'):'')+'[');
			for (var i=0;i<value.length;i++) notify(i,value[i],i==value.length-1,false);
			draw.push(']'+(isLast?'':(',')));
		}else	if(value&&typeof value=='object'){
			draw.push((formObj?('"'+name+'":'):'')+'{');
			var len=0,i=0;
			for(var key in value){len++;};
			for(var key in value)notify(key,value[key],++i==len,true);
			draw.push('}'+(isLast?'':(',')));
		}else{
			if(typeof value=='string')value='"'+value+'"';
			draw.push((formObj?('"'+name+'":'):'')+value+(isLast?'':','));
		};
	};
	notify('',data,isLast,false);
	return draw.join('');
}
