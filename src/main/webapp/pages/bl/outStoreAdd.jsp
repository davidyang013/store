<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
if(request.getSession().getAttribute("loginName") == null)
	response.sendRedirect(basePath + "pages/sys/login.jsp");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<base href="<%=basePath%>">
    <title></title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<script src="js/lib/jquery-1.8.2.js" type="text/javascript"></script>
	<script src="js/common/common.js" type="text/javascript"></script>
	<script src="js/common/calendar.js" type="text/javascript"></script>
	
    <link href="css/common/common.css" rel="stylesheet" type="text/css">
  </head>
  <script type="text/javascript">
  	var MAX_RIGHT = 5;
  	var selLeftArray = new Array();
  	var selRightArray = new Array();
  	var rightArray = new Array();
  	
  	jQuery(document).ready(function(){
		$("input").keydown(enterToTab);
	});
  
  	function add(){
		var payType = $("#payType").val();
		var buyType = $("#buyType").val();
		var memberId = $("#memberId").val();
		var comm = $("#comm").val();
		if(!payType || !buyType){
			alert("必填项不能为空");
			return false;
		}

		var paramsArr = new Array();
		if(rightArray.length <= 0){
			alert("请选择出库项");
			return false;
		}
		if(!confirm("确认出库?(请再次确认金额后出库)")){return;}
		for(var i = 0; i < rightArray.length; i++){
			if(rightArray[i].isDel){continue;}
			var tmp = {
				"inId" : rightArray[i].id,
				"count" : rightArray[i].count,
				"price" : rightArray[i].salePrice,
				"transSerial" : rightArray[i].transSerial,
				"transFee" : rightArray[i].transFee,
				"transCompany" : rightArray[i].transCompany
			};
			paramsArr.push(tmp);
		}
		var param = "payType=" + payType + "&buyType=" + buyType + "&comm=" + comm + "&memberId=" + memberId;
		param += "&params=" + toJSON(paramsArr);
		proxyRequest("<%=basePath%>bl/OutStoreManagerAction!insert.action", param);
	}
  
  	function chooseLeft(tr){
  		choose(tr, selLeftArray);
  	}
  	
  	function chooseRight(tr){
  		choose(tr, selRightArray);
  	}
  	
	function toLeft(){
		var table = document.getElementById("tblMainRight");
		removeTblRows(table);
		for(var i = 0; i < selRightArray.length; i++){
			for(var j = 0; j < rightArray.length; j++){
				if(selRightArray[i].id == rightArray[j].id){
					if(rightArray[j].count > 1){
						rightArray[j].count--;
					}else{
						rightArray[j].isDel = true;
						selRightArray[i].isDel = true;
					}
				}
			}
		}
		refreshRight(table);
	}  	
	
	function toRight(){
		if(getLeft2RightLen() > MAX_RIGHT){
			alert("右侧列表中不得超过" + MAX_RIGHT +  "条");
			return;
		}
		var table = document.getElementById("tblMainRight");
		removeTblRows(table);
		var isRep = false;
		var repObj = null;
		var addObj = null;
		//避免将重复项加入右侧表格
		for(var i = 0; i < selLeftArray.length; i++){
			if(selLeftArray[i].count <= 0){continue;}
			isRep = false;
			for(var j = 0; j < rightArray.length; j++){
				if(selLeftArray[i].id == rightArray[j].id){
					isRep = true;
					repObj = rightArray[j];
					break;
				}
			}
			if(!isRep){
				addObj = cloneObject(selLeftArray[i]);
				addObj.count = 1;
				setDepdenceValue(addObj);
				rightArray.push(addObj);
			}else{
				if(repObj.isDel){
					repObj.count = 1;
					repObj.isDel = false;
					setDepdenceValue(repObj);
				}else{
					if(selLeftArray[i].count > 1 && selLeftArray[i].count > repObj.count){
						repObj.count++;
						setDepdenceValue(repObj);
					}
				}
			}
		}
		refreshRight(table);
	}
  	
  	function proxyIntoStore(){
  		var depSerial = $("#depSerial").val();
  		var serial = $("#serial").val();
  		var color = $("#color").val();
  		var beginDate = $("#beginDate").val();
  		var endDate = $("#endDate").val();
  		var type = $("#type").val();
  		var brand = $("#brand").val();
  		var param = "depSerial=" + depSerial + "&serial=" + serial + 
  					"&color=" + color + "&beginDate=" + beginDate + "&endDate=" + endDate + 
  					"&type=" + type + "&brand=" + brand + "&callback=?";
  		var url = "<%=basePath%>bl/OutStoreManagerAction!proxyQuery.action";
  		$.ajax({
  			type:'post',
  			url:url,
			data:encode(param),
			dataType:'jsonp',
			jsonpCallback:'proxyIntoStoreCallback',
			error:function(req, errorInfo, errorThrown){
				alert("错误信息:" + errorInfo + "状态码:" + req.readyState + "错误码:" + req.status);
			}
		});
  		
  	}
  	
  	function proxyIntoStoreCallback(resultList){
  		var table = document.getElementById("tblMainLeft");
		removeTblRows(table);
		selLeftArray.length = 0;
		if(!resultList){alert("没有库存");return;}
		$.each(
				resultList,
				function(index,list) {
					var tr = table.insertRow(-1);
					tr.id = list.id;
					attachEvent(tr, "onclick", chooseLeft, tr);
					setValue(tr, index, list);
				}
		);
  	}
  	
  	function refreshRight(table){
  		var dataLen = 0;
  		//将左侧选中行加入右侧表格
		for(var i = 0; i < rightArray.length; i++){
			var list = rightArray[i];
			if(list.isDel){continue;}
			var tr = table.insertRow(-1);
			tr.id = list.id;
			for(var j = 0; j < selRightArray.length; j++){
				if(selRightArray[j].id == tr.id){
					tr.style.backgroundColor = '#fff4c4';
				}
			}
			attachEvent(tr, "onclick", chooseRight, tr);
			setValue(tr, i, list);
			dataLen++;
		}
		//填充满右侧表格
		for(var i = dataLen; i < 15; i++){
			var tr = table.insertRow(-1);
			setValue(tr, i);
		}
  	}
  	
  	function choose(tr, arr){
  		var $tr=$(tr); 
  		if(tr.style.backgroundColor == ''){
  			tr.style.backgroundColor = '#fff4c4';
  			//增加列时同步修改处
  			arr.push({
  	  			id: tr.id,
  	  			depSerial: $tr.find("td:eq(0)").text(),
  	  			serial: $tr.find("td:eq(1)").text(),
  	  			type: $tr.find("td:eq(2)").text(),
  	  		    inDate: $tr.find("td:eq(3)").text(),
  	  		    color: $tr.find("td:eq(4)").text(),
  	  		    count: $tr.find("td:eq(5)").text(),
  	  		    salePrice: $tr.find("td:eq(6)").text(),
  	  		    warranty: $tr.find("td:eq(7)").text(),
  	  		    isDel: false
  	  		});
  		}else if(tr.style.backgroundColor = '#fff4c4'){
  			tr.style.backgroundColor = '';
  			for(var i = 0; i < arr.length; i++){
  				if(arr[i].id == tr.id){
  					arr.remove(i);
  		  	  		break;
  				}
  			}
  		}
  	}
  	
  	function setDepdenceValue(obj){
  		obj.salePrice = $("#price").val();
  		obj.transSerial = $("#transSerial").val();
  		obj.transFee = $("#transFee").val();
  		obj.transCompany = $("#transCompany").val();
  	}
  	
  	function setValue(tr, index, list){
  		if(index % 2 == 0){
			tr.className = "trOdd";
		}else{
			tr.className = "trEven";
		}
  		if(list){
  			//增加列时同步修改处
			td = tr.insertCell(-1);
			td.innerHTML = list.depSerial == null ? "&nbsp;" : list.depSerial;
			td = tr.insertCell(-1);
			td.innerHTML = list.serial == null ? "&nbsp;" : list.serial;
			td = tr.insertCell(-1);
			td.innerHTML = list.type == null ? "&nbsp;" : list.type;
			td = tr.insertCell(-1);
			td.innerHTML = list.inDate == null ? "&nbsp;" : list.inDate;
			td = tr.insertCell(-1);
			td.innerHTML = list.color == null ? "&nbsp;" : list.color;
			td = tr.insertCell(-1);
			td.innerHTML = list.count == null ? "0" : list.count;
			td = tr.insertCell(-1);
			td.innerHTML = list.salePrice == null ? "0" : list.salePrice;
  		}else{
  			//增加列时同步修改处
  			tr.insertCell(-1);
			tr.insertCell(-1);
			tr.insertCell(-1);
			tr.insertCell(-1);
			tr.insertCell(-1);
			tr.insertCell(-1);
			tr.insertCell(-1);
  		}
  	}
  
  	function getLeft2RightLen(){
  		
  		var rightCnt = 0;
  		var repCnt = 0;
  		
  		for(var i = 0; i < rightArray.length; i++){
  			if(!rightArray[i].isDel){rightCnt++;}
  		}
  		
  		//计算左右列表中重复类别的个数
  		for(var i = 0; i < rightArray.length; i++){
  			
  			if(rightArray[i].isDel){
  				continue;
  			}
  			
  			for(var j = 0; j < selLeftArray.length; j++){
  				if(selLeftArray[j].id == rightArray[i].id){repCnt++;break;}
  			}
  		}
  		
  		return (rightCnt + selLeftArray.length - repCnt);
  	}
  
  </script>
  <body style="width:100%;overflow:hidden;margin:0px;padding:0px">
   <form action="" method="post">
		<div style="width:100%;" align="center">
			<div class="show" style="margin:0px;padding:0px;background-color:#e7edf3;">
			<table class="editTable" width="100%">
				<tr class="trTitle">
					<th colspan="6">
						通用信息
					</th>
				</tr>
				<tr class="trMid">
					<td class="tdLabel">
						支付方式：
					</td>
					<td class="tdInput">
						<select id="payType" name="payType">
							<option>现金</option>
							<option>刷卡</option>
							<option>支付宝</option>
							<option>银行汇款</option>
						</select>
						<font color="red">*</font>
					</td>
					<td class="tdLabel">
						会员号：
					</td>
					<td class="tdInput">
						<input type="text" id="memberId" name="memberId"  maxlength="32"/>
					</td>
				</tr>
				<tr class="trMid">
					<td class="tdLabel">
						购买类别：
					</td>
					<td class="tdInput">
						<select id="buyType" name="buyType">
							<option>门店</option>
							<option>网络</option>
							<option>批发</option>
						</select>
						<font color="red">*</font>
					</td>
					<td class="tdLabel">
						备注：
					</td>
					<td class="tdInput">
						<input type="text" id="comm" name="comm"  maxlength="256"/>
					</td>
				</tr>
				<tr class="trTitle">
					<th colspan="6">
						独立信息
					</th>
				</tr>
				<tr class="trMid">
					<td class="tdLabel">
						出库单价：
					</td>
					<td class="tdInput">
						<input type="text" id="price" name="price" maxlength="13" value="0" onblur="setDefNumValue(this, 0)"/>
						<font color="red">*</font>
					</td>
					<td class="tdLabel">
						运单号：
					</td>
					<td class="tdInput">
						<input type="text" id="transSerial" name="tranSerial" maxlength="32" value=""/>
					</td>
				</tr>
				<tr class="trMid">
					<td class="tdLabel">
						预估运费：
					</td>
					<td class="tdInput">
						<input type="text" id="transFee" name="tranFee" maxlength="13" value="0" onblur="setDefNumValue(this, 0)"/>
					</td>
					<td class="TdLabel">
						物流公司：
					</td>
					<td class="tdInput">
						<input type="text" id="transCompany" name="tranCompany"/>
					</td>
				</tr>
				<tr class="trTitle">
					<th colspan="6">
						库存搜索
					</th>
				</tr>
				<tr class="trMid">
					<td class="tdLabel">
						独立序列号：
					</td>
					<td class="tdInput">
						<input type="text" id="depSerial" name="depSerial" maxlength="32"/>
					</td>
					<td class="tdLabel">
						商品序列号：
					</td>
					<td class="tdInput">
						<input type="text" id="serial" name="serial" maxlength="32"/>
					</td>
				</tr>
				<tr class="trMid">
					<td class="tdLabel">
						商品型号：
					</td>
					<td class="tdInput">
						<input type="text" id="type" name="type"  maxlength="32"/>
					</td>
					<td class="tdLabel">
						商品品牌：
					</td>
					<td class="tdInput">
						<input type="text" id="brand" name="brand" maxlength="32"/>
					</td>
					<td class="tdLabel">
						颜色：
					</td>
					<td class="tdInput">
						<input type="text" id="color" name="color" maxlength="32"/>
					</td>
				</tr>
				<tr class="trMid">
					<td class="tdLabel">
						入库开始日：
					</td>
					<td class="tdInput">
						<input type="text" id="beginDate" name="beginDate"  maxlength="10" readonly onclick="getDate(this)"/>
					</td>
					<td class="tdLabel">
						入库结束日：
					</td>
					<td class="tdInput">
						<input type="text" id="endDate" name="endDate"  maxlength="10" readonly onclick="getDate(this)"/>
					</td>
				</tr>
				<tr class="trMid">
					<td align="center" colspan="6">
						<input type="button" class="btn" value='获取' style="margin-right:10px" onclick="proxyIntoStore()">
					</td>
				</tr>
			</table>
			<div style="overflow-x:auto;overflow-y:auto;width:45%;height:325px;float:left;cursor:hand">
			<table id="tblMainLeft" class="tblMain" align="center" cellpadding="0" cellspacing="0">
				<th>独立序列号</th>
				<th>商品序列号</th>
				<th>型号</th>
				<th>批次</th>
				<th>颜色</th>
				<th>数量</th>
				<th>售价</th>
				<c:forEach var="rb" items="${resultList}" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr id="${rb.id}" class="trEven" onclick="chooseLeft(this)">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr id="${rb.id}"class="trOdd" onclick="chooseLeft(this)">
					</c:if>
						<td>${rb.depSerial == null ? "&nbsp;" : rb.depSerial}</td>
						<td>${rb.serial == null ? "&nbsp;" : rb.serial}</td>
						<td>${rb.type == null ? "&nbsp;" : rb.type}</td>
						<td>${rb.inDate == null ? "&nbsp;" : rb.inDate}</td>
						<td>${rb.color == null ? "&nbsp;" : rb.color}</td>
						<td>${rb.count == null ? "0" : rb.count}</td>
						<td>${rb.salePrice == null ? "0" : rb.salePrice}</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="14" step="1" varStatus="state">
					<tr><td colspan="7" style="border-bottom:0">&nbsp;</td></tr>
				</c:forEach>
			</table>
			</div>
			<div style="width:10%;height:325px;float:left;padding-top:130px;text-align:center;background-color:#e7edf3;">
				<input type="button" class="btn" value="&gt;&gt;" onclick="toRight()" style="margin-bottom:10px">
				<input type="button" class="btn" value="&lt;&lt;" onclick="toLeft()" style="margin-top:10px"> 
			</div>
			<div style="overflow-x:auto;overflow-y:auto;width:45%;height:325px;float:right;cursor:hand">
			<table id="tblMainRight"  class="tblMain" align="center" cellpadding="0" cellspacing="0">
				<th>独立序列号</th>
				<th>商品序列号</th>
				<th>型号</th>
				<th>批次</th>
				<th>颜色</th>
				<th>数量</th>
				<th>实售</th>
				<c:forEach begin="0" end="14" step="1" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr class="trEven">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr class="trOdd">
					</c:if>
						<td colspan="7" style="border-bottom:0">&nbsp;</td>
					</tr>
				</c:forEach>
			</table>
			</div>
			<!-- menu begin -->
			<table id="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="center">
						<input type="button" class="btn" value='确定' style="margin-right:10px" onclick="add()">
						<input type="button" class="btn" value='关闭' style="margin-left:10px" onclick="window.close()"> 
					</td>
				</tr>
			</table>
			<!-- menu end -->
			</div>
		</div>
	</form>
  </body>
</html>