<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
	<meta http-equiv="Content-Type" content="text/html;">  
	<script src="js/lib/jquery-1.8.2.js" type="text/javascript"></script>
	<script src="js/common/common.js" type="text/javascript"></script>
	
    <link href="css/common/common.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript">
	jQuery(document).ready(function(){
		$("#repairFeeABCD").attr("readonly","true");
		$("#repairFeeABCD").attr("disabled","true");
		$("#cha").attr("readonly","true");
		$("#cha").attr("disabled","true");
		
		var repairStatus = $("#repairStatus").val();
		if(repairStatus=="客户已返修"){
			$("#repairFeeB").attr("readonly","true");
			$("#repairFeeB").attr("disabled","true");
			$("#repairFeeC").attr("readonly","true");
			$("#repairFeeC").attr("disabled","true");
			$("#repairFeeD").attr("readonly","true");
			$("#repairFeeD").attr("disabled","true");
			$("#repairSerialB").attr("readonly","true");
			$("#repairSerialB").attr("disabled","true");
			$("#repairSerialC").attr("readonly","true");
			$("#repairSerialC").attr("disabled","true");
			$("#repairSerialD").attr("readonly","true");
			$("#repairSerialD").attr("disabled","true");
  		}
		if(repairStatus=="寄往代理商"){
			$("#repairFeeC").attr("readonly","true");
			$("#repairFeeC").attr("disabled","true");
			$("#repairFeeD").attr("readonly","true");
			$("#repairFeeD").attr("disabled","true");
			$("#repairSerialC").attr("readonly","true");
			$("#repairSerialC").attr("disabled","true");
			$("#repairSerialD").attr("readonly","true");
			$("#repairSerialD").attr("disabled","true");
  		}
		if(repairStatus=="代理商收回"){
			$("#repairFeeD").attr("readonly","true");
			$("#repairFeeD").attr("disabled","true");
			$("#repairSerialD").attr("readonly","true");
			$("#repairSerialD").attr("disabled","true");
  		}
		
		
		var repairFeeA = $("#repairFeeA").val();
		var repairFeeB = $("#repairFeeB").val();
		var repairFeeC = $("#repairFeeC").val();
		var repairFeeD = $("#repairFeeD").val();
		var actualRepairFee = $("#actualRepairFee").val();
		var repairFeeABCD = parseInt(repairFeeA) + parseInt(repairFeeB) + parseInt(repairFeeC) + parseInt(repairFeeD);
		$("#repairFeeABCD").val(repairFeeABCD);
		var cha = parseInt(repairFeeABCD) - parseInt(actualRepairFee);
		$("#cha").val(cha);
		$("input").keydown(enterToTab);
	});
		
		function checkFee(){
			var repairFeeA = $("#repairFeeA").val();
			var repairFeeB = $("#repairFeeB").val();
			var repairFeeC = $("#repairFeeC").val();
			var repairFeeD = $("#repairFeeD").val();
			var actualRepairFee = $("#actualRepairFee").val();
			
			if(repairFeeA && ( repairFeeA < 0 || repairFeeA > 999.99)){
				alert("客户已返修运费" + repairFeeA + "金额不正确！");
				$("#repairFeeA").val("");
				$("#repairFeeA").focus();
				return;
			}
			if(repairFeeB && ( repairFeeB < 0 || repairFeeB > 999.99)){
				alert("寄往代理商运费" + repairFeeB + "金额不正确！");
				$("#repairFeeB").val("");
				$("#repairFeeB").focus();
				return;
			}
			if(repairFeeC && ( repairFeeC < 0 || repairFeeC > 999.99)){
				alert("代理商收回运费" + repairFeeC + "金额不正确！");
				$("#repairFeeC").val("");
				$("#repairFeeC").focus();
				return;
			}
			if(repairFeeD && ( repairFeeD < 0 || repairFeeD > 999.99)){
				alert("已寄回客户运费" + repairFeeD + "金额不正确！");
				$("#repairFeeD").val("");
				$("#repairFeeD").focus();
				return;
			}
			if(actualRepairFee && ( actualRepairFee < 0 || actualRepairFee > 999.99)){
				alert("实际运费合计" + actualRepairFee + "金额不正确！");
				$("#actualRepairFee").val("");
				$("#actualRepairFee").focus();
				return;
			}
			var repairFeeABCD = parseInt(repairFeeA) + parseInt(repairFeeB) + parseInt(repairFeeC) + parseInt(repairFeeD);
			$("#repairFeeABCD").val(repairFeeABCD);
			var cha = parseInt(repairFeeABCD) - parseInt(actualRepairFee);
			$("#cha").val(cha);
		}
		function save(){
			checkFee();
			var id = $("#id").val();
			var repairSerialA = $("#repairSerialA").val();
			var repairFeeA = $("#repairFeeA").val();
			var repairSerialB = $("#repairSerialB").val();
			var repairFeeB = $("#repairFeeB").val();
			var repairSerialC = $("#repairSerialC").val();
			var repairFeeC = $("#repairFeeC").val();
			var repairSerialD = $("#repairSerialD").val();
			var repairFeeD = $("#repairFeeD").val();
			var actualRepairFee = $("#actualRepairFee").val();
			var param =  "id=" + id + "&repairSerialA=" + repairSerialA + "&repairFeeA=" + repairFeeA +
									  "&repairSerialB=" + repairSerialB + "&repairFeeB=" + repairFeeB +
									  "&repairSerialC=" + repairSerialC + "&repairFeeC=" + repairFeeC +
									  "&repairSerialD=" + repairSerialD + "&repairFeeD=" + repairFeeD +
									  "&actualRepairFee=" + actualRepairFee + "&repairStatus=update";
			proxyRequest("<%=basePath%>bl/RepairManagerAction!updateTransFee.action", param);
            window.close();
		}
	</script>
  </head>
  
<body>
<input type="hidden" id="repairStatus" name="repairStatus" value="${repair.repairStatus}"/>
	<input type="hidden" id="id" name="id" value="${repair.id}"/>
	<table class="editTable" width="598px" height="298px">
		<tr class="trTitle">
			<th colspan="4">
					修改运费
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				客户已返修运费单号：
			</td>
			<td class="tdInput">
				<input type="text" id="repairSerialA" name="repairSerialA" maxlength="32" value="${repair.repairSerialA}"/>
			</td>
			<td class="tdLabel">
				运费金额：
			</td>
			<td class="tdInput">
				<input type="text" id="repairFeeA" name="repairFeeA" maxlength="6" value="${repair.repairFeeA}" onblur="checkFee()"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				寄往代理商运费单号：
			</td>
			<td class="tdInput">
				<input type="text" id="repairSerialB" name="repairSerialB" maxlength="32"  value="${repair.repairSerialB}"/>
			</td>
			<td class="tdLabel">
				运费金额：
			</td>
			<td class="tdInput">
				<input type="text" id="repairFeeB" name="repairFeeB" maxlength="6" value="${repair.repairFeeB}" onblur="checkFee()"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				代理商收回运费单号：
			</td>
			<td class="tdInput">
				<input type="text" id="repairSerialC" name="repairSerialC" maxlength="32"  value="${repair.repairSerialC}"/>
			</td>
			<td class="tdLabel">
				运费金额：
			</td>
			<td class="tdInput">
				<input type="text" id="repairFeeC" name="repairFeeC" maxlength="6" value="${repair.repairFeeC}" onblur="checkFee()"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				已寄回客户运费单号：
			</td>
			<td class="tdInput">
				<input type="text" id="repairSerialD" name="repairSerialD" maxlength="32"  value="${repair.repairSerialD}"/>
			</td>
			<td class="tdLabel">
				运费金额：
			</td>
			<td class="tdInput">
				<input type="text" id="repairFeeD" name="repairFeeD" maxlength="6" value="${repair.repairFeeD}" onblur="checkFee()"/>
			</td>
		</tr>
		<tr class="trMid">
			<td  colspan="2">
			</td>
			<td class="tdLabel">
				收取运费的合计数：
			</td>
			<td class="tdInput">
				<input type="text" id="repairFeeABCD" name="repairFeeABCD" value="${repair.repairFeeABCD}"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				实际运费合计：
			</td>
			<td class="tdInput">
				<input type="text" id="actualRepairFee" name="actualRepairFee" maxlength="6" value="${repair.actualRepairFee}" onblur="checkFee()"/>
			</td>
			<td class="tdLabel">
				运费盈亏：
			</td>
			<td class="tdInput">
				<input type="text" id="cha" name="cha"/>
			</td>
		</tr>
		<tr class="trFoot" align="center">
			<td colspan="4">
				<input type="button" class="btn" value="保存" onclick="save()" />
				<input type="button"  class="btn" value="关闭" onclick="window.close()"/>
			</td>
		</tr>
	</table>
</body>
</html>
