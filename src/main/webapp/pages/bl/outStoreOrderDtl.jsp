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
	<meta http-equiv="Content-Type" content="text/html;">  
	<script src="js/lib/jquery-1.8.2.js" type="text/javascript"></script>
	<script src="js/common/common.js" type="text/javascript"></script>
	<script src="js/common/calendar.js" type="text/javascript"></script>
	
    <link href="css/common/common.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript">
		jQuery(document).ready(function(){
			var id = "";
			$("input:text").each(function(){ 
				id = $(this).attr("id");
				if(id == "transSerial" || id == "transFee" || id == "actualTransFee" || id == "transCompany"){return;}
				$(this).attr("readonly","true");
				$(this).attr("disabled","true");
	        });
			
			$("#transSerial").focus();
			$("input").keydown(enterToTab);
		});
		
		function check(){
			var id = $("#id").val();
			var transSerial = $("#transSerial").val();
			var transFee = $("#transFee").val();
			var actualTransFee = $("#actualTransFee").val();
			var transCompany = $("#transCompany").val();
			var param = "id=" + id + "&transSerial=" + transSerial + "&transFee=" + transFee + 
						"&actualTransFee=" + actualTransFee + "&transCompany=" + transCompany;
			proxyRequest("<%=basePath%>bl/OutStoreManagerAction!updateOrder.action", param);
		}	
		
	</script>
  </head>
  
<body>
	<input type="hidden" id="optype" name="optype" value="${optype}"/>
	<input type="hidden" id="id" name="id" value="${outStore.id}"/>
	<table class="editTable" width="580px" height="200px">
		<tr class="trTitle">
			<th colspan="4">
				商品出库维护
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				出库单价：
			</td>
			<td class="tdInput">
				<input type="text" id="price" name="price" value="${outStore.price}"/>
			</td>
			<td class="tdLabel">
				出库数量：
			</td>
			<td class="tdInput">
				<input type="text" id="count" name="count" value="${outStore.count}"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				运单号：
			</td>
			<td class="tdInput">
				<input type="text" id="transSerial" name="transSerial" maxlength="32" value="${outStore.transSerial}"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				物流公司：
			</td>
			<td class="tdInput">
				<input type="text" id="transCompany" name="transCompany" maxlength="32" value="${outStore.transCompany}"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				预估运费：
			</td>
			<td class="tdInput">
				<input type="text" id="transFee" name="transFee" maxlength="32" 
					   value="${outStore.transFee}" onblur="setDefNumValue(this,0)"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				实际运费：
			</td>
			<td class="tdInput">
				<input type="text" id="actualTransFee" name="actualTransFee" maxlength="32" 
					   value="${outStore.actualTransFee}" onblur="setDefNumValue(this,0)"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trFoot" align="center">
			<td colspan="4">
				<input type="button" class="btn" value="保存" onclick="check()" />
				<input type="button"  class="btn" value="关闭" onclick="window.close()"/>
			</td>
		</tr>
	</table>
</body>
</html>
