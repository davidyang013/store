<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
if(request.getSession().getAttribute("loginName") == null)
	response.sendRedirect(basePath + "pages/sys/login.jsp");
String info = "  "; 
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
	
	<script type="text/javascript">
	jQuery(document).ready(function(){
		var optype = $("#optype").val();
		$("#orderId").attr("readonly","true");
		$("#orderId").attr("disabled","true");
		if(optype == "update"){
			$("#repairSerialA").attr("readonly","true");
			$("#repairSerialA").attr("disabled","true");
			$("#repairFeeA").attr("readonly","true");
			$("#repairFeeA").attr("disabled","true");
			
			$("#headsetSerial").attr("readonly","true");
			$("#headsetSerial").attr("disabled","true");
			$("#purchaseDate").attr("readonly","true");
			$("#purchaseDate").attr("disabled","true");
			$("#brand").attr("readonly","true");
			$("#brand").attr("disabled","true");
			$("#type").attr("readonly","true");
			$("#type").attr("disabled","true");
			$("#color").attr("readonly","true");
			$("#color").attr("disabled","true");
			$("#appearance").attr("readonly","true");
			$("#appearance").attr("disabled","true");
		} else {
			$("#price").focus();
		}
		$("input").keydown(enterToTab);
	});
		function checkPrice(){
			var price = $("#price").val();
			var actualPrice = $("#actualPrice").val();
			if(price && ( price < 0 || price > 9999999999999.99)){
				alert("预估维修金额" + price + "金额不正确！");
				$("#price").val("");
				$("#price").focus();
			}
			if(actualPrice && ( actualPrice < 0 || actualPrice > 9999999999999.99)){
				alert("实际维修金额" + actualPrice + "金额不正确！");
				$("#actualPrice").val("");
				$("#actualPrice").focus();
			}
		}
		function checkFee(){
			var repairFeeA = $("#repairFeeA").val();
			if(repairFeeA && ( repairFeeA < 0 || repairFeeA > 999.99)){
				alert("客户已返修运费" + repairFeeA + "金额不正确！");
				$("#repairFeeA").val("");
				$("#repairFeeA").focus();
			}
		}	
		function checkAll(){
			var id = $("#id").val();
			var price = $("#price").val();
			var actualPrice = $("#actualPrice").val();
			var repairSerialA = $("#repairSerialA").val();
			var repairFeeA = $("#repairFeeA").val();
			
			var memberId = $("#memberId").val();
			var customerId = $("#customerId").val();
			var custName = $("#custName").val();
			var wangwangId = $("#wangwangId").val();
			var phone = $("#phone").val();
			var address = $("#address").val();
			
			var orderId = $("#orderId").val();
			var purchaseDate = $("#purchaseDate").val();
			var headsetSerial = $("#headsetSerial").val();
			var brand = $("#brand").val();
			var type = $("#type").val();
			var color = $("#color").val();
			var appearance = $("#appearance").val();
			var optype = $("#optype").val();
			if(!price || !actualPrice || 
					!custName || !wangwangId ||!phone || !address ||
					!brand || !color ){
				alert("必填项不能为空");
				return false;
			}
			if(!repairFeeA ){
				repairFeeA = "0";
			}
			var param = "id=" + id + "&price=" + price + "&actualPrice=" + actualPrice + 
						 "&repairSerialA=" + repairSerialA + "&repairFeeA=" + repairFeeA + "&repairStatus=客户已返修"  +
						 "&memberId=" + memberId + "&customerId=" + customerId + 
						 "&name=" + custName + "&wangwangId=" + wangwangId + "&phone=" + phone + "&address=" + address + 
						 "&orderId=" + orderId + "&purchaseDate=" + purchaseDate + "&headsetSerial=" + headsetSerial +
						 "&brand=" + brand + "&type=" + type + "&color=" + color + "&appearance=" + appearance;
			if(optype == "update"){
				proxyRequest("<%=basePath%>bl/RepairManagerAction!update.action", param);
			} else{
				proxyRequest("<%=basePath%>bl/RepairManagerAction!insert.action", param);
			}
		}
		function searchCustomerInfo(){
			openDlg("<%=basePath%>bl/RepairManagerAction!searchAllCustomerInfo.action", 750, 408);
		}
		
		function searchBrandInfo(){
			openDlg("<%=basePath%>bl/RepairManagerAction!searchAllBrandInfo.action", 750, 450);
		}
		function checkBrandInfo(){
			var flag = $("#flag").val();
			var orderId = $("#orderId").val();
			var headsetSerial = $("#headsetSerial").val();
			var purchaseDate = $("#purchaseDate").val();
			var brand = $("#brand").val();
			var type = $("#type").val();
			var color = $("#color").val();
			var appearance = $("#appearance").val();
			if('1'==flag){
				if(orderId!=''&&orderId !='null'){
					$("#orderId").attr("readonly","true");
					$("#orderId").attr("disabled","true");
		  		}
				if(headsetSerial!=''&&headsetSerial !='null'){
					$("#headsetSerial").attr("readonly","true");
					$("#headsetSerial").attr("disabled","true");
		  		}
				if(purchaseDate!=''&&purchaseDate !='null'){
					$("#purchaseDate").attr("readonly","true");
					$("#purchaseDate").attr("disabled","true");
		  		}
				if(brand!=''&&brand !='null'){
					$("#brand").attr("readonly","true");
					$("#brand").attr("disabled","true");
		  		}
				if(type!=''&&type !='null'){
					$("#type").attr("readonly","true");
					$("#type").attr("disabled","true");
		  		}
				if(color!=''&&color !='null'){
					$("#color").attr("readonly","true");
					$("#color").attr("disabled","true");
		  		}
				if(appearance!=''&&appearance !='null'){
					$("#appearance").attr("readonly","true");
					$("#appearance").attr("disabled","true");
		  		}
			}
		}
	</script>
  </head>
  
<body onload="checkBrandInfo()">
	<input type="hidden" id="optype" name="optype" value="${optype}"/>
	<input type="hidden" id="flag" name="flag" onpropertychange="checkBrandInfo()"/>
	<input type="hidden" id="id" name="id" value="${repair.id}"/>
	<input type="hidden" id="memberId" name="memberId" value="${repair.memberId}"/>
	<input type="hidden" id="customerId" name="customerId" value="${repair.customerId}"/>
	<table class="editTable" width="650px" height="100px">
		<tr class="trTitle">
			<th colspan="4">
				售后信息维护
			</th>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				预估维修金额：
			</td>
			<td class="tdInput">
				<input type="text" id="price" name="price" maxlength="16" value="${repair.price}" onblur="checkPrice()"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				实际维修金额 ：
			</td>
			<td class="tdInput">
				<input type="text" id="actualPrice" name="actualPrice" maxlength="16" value="${repair.actualPrice}" onblur="checkPrice()"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				客户已返修运费单号：
			</td>
			<td class="tdInput">
				<input type="text" id="repairSerialA" name="repairSerialA" maxlength="32" value="${repair.repairSerialA}"/>
			</td>
			<td class="tdLabel">
				客户已返修运费：
			</td>
			<td class="tdInput">
				<input type="text" id="repairFeeA" name="repairFeeA" maxlength="6" value="${repair.repairFeeA}" onblur="checkFee()"/>
			</td>
		</tr>
		<tr class="trTitle">
			<th colspan="4">
				客户信息维护
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				客户姓名：
			</td>
			<td class="tdInput">
				<input type="text" id="custName" name="custName" maxlength="32" value="${repair.name}"/>
				<font color="red">*</font>
			</td>
			<td colspan="2">
				<input type="button" class="btn" value="获取" onclick="searchCustomerInfo()" />
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				旺旺：
			</td>
			<td class="tdInput">
				<input type="text" id="wangwangId" name="wangwangId" maxlength="32" value="${repair.wangwangId}"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				联系电话：
			</td>
			<td class="tdInput">
				<input type="text" id="phone" name="phone" maxlength="16" value="${repair.phone}"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				联系地址：
			</td>
			<td class="tdInput" colspan="3">
				<input type="text" id="address" name="address" maxlength="128" value="${repair.address}"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trTitle">
			<th colspan="4">
				商品信息维护
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				订单号：
			</td>
			<td class="tdInput">
				<input type="text" id="orderId" name="orderId" maxlength="32" value="${repair.orderId}"/>(选填)
			</td>
			<td colspan="2">
				<input type="button" class="btn" value="获取" onclick="searchBrandInfo()" />
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				购买日期：
			</td>
			<td class="tdInput">
				<input type="text" id="purchaseDate" name="purchaseDate" maxlength="16" value="${repair.purchaseDate}" readonly onclick="getDate(this)"/>
			</td>
			<td class="tdLabel">
				独立序列号：
			</td>
			<td class="tdInput">
				<input type="text" id="headsetSerial" name="headsetSerial" maxlength="32" value="${repair.headsetSerial}"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				品牌：
			</td>
			<td class="tdInput">
				<input type="text" id="brand" name="brand" maxlength="32" value="${repair.brand}"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				型号：
			</td>
			<td class="tdInput">
				<input type="text" id="type" name="type" maxlength="32" value="${repair.type}"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				颜色：
			</td>
			<td class="tdInput">
				<input type="text" id="color" name="color" maxlength="32" value="${repair.color}"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				外观：
			</td>
			<td class="tdInput">
				<input type="text" id="appearance" name="appearance" maxlength="32" value="${repair.appearance}"/>
			</td>
		</tr>
		<tr class="trFoot" align="center">
			<td colspan="4">
				<input type="button" class="btn" value="保存" onclick="checkAll()" />
				<input type="button"  class="btn" value="关闭" onclick="window.close()"/>
			</td>
		</tr>
	</table>
</body>
</html>
