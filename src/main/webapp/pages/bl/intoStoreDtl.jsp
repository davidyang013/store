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
			var optype = $("#optype").val();
			$("#brand").attr("readonly","true");
			$("#brand").attr("disabled","true");
			$("#type").attr("readonly","true");
			$("#type").attr("disabled","true");
			if(optype == "update"){
				$("#depSerial").attr("readonly","true");
				$("#depSerial").attr("disabled","true");
				$("#serial").attr("readonly","true");
				$("#serial").attr("disabled","true");
				$("#supply").focus();
				proxyBrand();
			} else {
				$("#serial").focus();
			}
			$("input").keydown(enterToTab);
			$("#serial").blur(proxyBrand);
		});
		
		function init(isOut){
			if(isOut && "已出库" == isOut){
				alert("无法修改(该商品已出库)");
				window.close();
			}
		}
	
		function check(){
			var optype = $("#optype").val();
			var id = $("#id").val();
			var depSerial = $("#depSerial").val();
			var serial = $("#serial").val();
			var brand = $("#brand").val();
			var type = $("#type").val();
			var supply = $("#supply").val();
			var color = $("#color").val();
			var count = $("#count").val();
			var purchasePrice = $("#purchasePrice").val();
			var comm = $("#comm").val();
			if(!supply || !color || !count || !purchasePrice){
				alert("必填项不能为空");
				return false;
			}
			if(depSerial && count != 1){
				alert("有独立序列号时数量必为1");
				return false;
			}
			if(serial && brand == "无关联信息" && type == "无关联信息"){
				alert("该商品序列号未维护");
				return false;
			}
			var param = "id=" + id + "&depSerial=" + depSerial + "&serial=" + serial + 
						"&supply=" + supply + "&color=" + color +
						"&count=" + count + "&purchasePrice=" + purchasePrice +
						"&comm=" + comm;
			if(optype == "update"){
				proxyRequest("<%=basePath%>bl/IntoStoreManagerAction!update.action", param);
			} else{
				proxyRequest("<%=basePath%>bl/IntoStoreManagerAction!insert.action", param);
			}
		}	
		
		function proxyBrand(){
			var serial = $("#serial").val();
			if(!serial){return;}
			var param = "serial=" + serial;
			proxyRequest("<%=basePath%>bl/IntoStoreManagerAction!proxyBrand.action", param);
		}
	
		function proxyBrandCallback(brand, type){
			$("#brand").val(brand);
			$("#type").val(type);
		}
	</script>
  </head>
  
<body onload="init('${intoStore.isOut}')">
	<input type="hidden" id="optype" name="optype" value="${optype}"/>
	<input type="hidden" id="id" name="id" value="${intoStore.id}"/>
	<table class="editTable" width="580px" height="200px">
		<tr class="trTitle">
			<th colspan="4">
				商品入库维护
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				商品序列号：
			</td>
			<td class="tdInput">
				<input type="text" id="serial" name="serial" maxlength="32" value="${intoStore.serial}"/>
			</td>
			<td class="tdLabel">
				独立序列号：
			</td>
			<td class="tdInput">
				<input type="text" id="depSerial" name="depSerial" maxlength="32" value="${intoStore.depSerial}"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				商品品牌：
			</td>
			<td class="tdInput">
				<input type="text" id="brand" name="brand"/>
			</td>
			<td class="tdLabel">
				商品型号：
			</td>
			<td class="tdInput">
				<input type="text" id="type" name="type"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				供应商：
			</td>
			<td class="tdInput">
				<input type="text" id="supply" name="supply" maxlength="32" value="${intoStore.supply == null ? "无" : intoStore.supply}"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				颜色：
			</td>
			<td class="tdInput">
				<input type="text" id="color" name="color"  maxlength="32" value="${intoStore.color == null ? "无" : intoStore.color}"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				进价：
			</td>
			<td class="tdInput">
				<input type="text" id="purchasePrice" name="purchasePrice"  maxlength="13" 
					   value="${intoStore.purchasePrice == null ? 0 : intoStore.purchasePrice}"
					   onblur="setDefNumValue(this,0)"/>
				<font color="red">*</font>
			</td>
			<td class="TdLabel">
				数量：
			</td>
			<td class="tdInput">
				<input type="text" id="count" name="count" maxlength="13" 
					   value="${intoStore.count == null ? 1 : intoStore.count}"
					   onblur="setDefNumValue(this,1)"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				备注：
			</td>
			<td class="tdInput" colspan="3">
				<input type="text" id="comm" name="comm" maxlength="256" value="${intoStore.comm}"/>
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
