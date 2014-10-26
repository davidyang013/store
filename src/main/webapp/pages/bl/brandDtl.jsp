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
	<script src="js/common/common.js" type="text/javascript" encoding="utf-8" ></script>
	
    <link href="css/common/common.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript">
		jQuery(document).ready(function(){
			var optype = $("#optype").val();
			if(optype == "update"){
				$("#serial").attr("readonly","true");
				$("#serial").attr("disabled","true");
				$("#brand").focus();
			} else {
				$("#serial").focus();
			}
			$("input").keydown(enterToTab);
		});
	
		function check(){
			var optype = $("#optype").val();
			var serial = $("#serial").val();
			var brand = $("#brand").val();
			var type = $("#type").val();
			var warranty = $("#warranty").val();
			var salePrice = $("#salePrice").val();
			var comm = $("#comm").val();
			if(!serial || !brand || !type || !warranty || !salePrice){
				alert("必填项不能为空");
				return false;
			}
			var param = "serial=" + serial + "&brand=" + brand + 
						"&type=" + type + "&warranty=" + warranty + 
						"&salePrice=" + salePrice + "&comm=" + comm;
			if(optype == "update"){
				proxyRequest("<%=basePath%>bl/BrandManagerAction!update.action", param);
			} else{
				proxyRequest("<%=basePath%>bl/BrandManagerAction!insert.action", param);
			}
		}	
	
	</script>
  </head>
  
<body>
	<input type="hidden" id="optype" name="optype" value="${optype}"/>
	<table class="editTable" width="580px" height="100px">
		<tr class="trTitle">
			<th colspan="4">
				商品型号维护
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				商品序列号：
			</td>
			<td class="tdInput">
				<input type="text" id="serial" name="serial" maxlength="32" value="${brand.serial}"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				商品品牌：
			</td>
			<td class="tdInput">
				<input type="text" id="brand" name="brand" maxlength="32" value="${brand.brand}"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				商品型号：
			</td>
			<td class="tdInput">
				<input type="text" id="type" name="type" maxlength="32" value="${brand.type}"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				保修时长：
			</td>
			<td class="tdInput">
				<input type="text" id="warranty" name="warranty" maxlength="5" 
					   value="${brand.warranty == null ? 1 : brand.warranty}" onblur="setDefNumValue(this,1)"/>
				月
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				售价：
			</td>
			<td class="tdInput">
				<input type="text" id="salePrice" name="salePrice" maxlength="13" 
					   value="${brand.salePrice == null ? 0 : brand.salePrice}" onblur="setDefNumValue(this,0)"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				备注：
			</td>
			<td class="tdInput">
				<input type="text" id="comm" name="comm" maxlength="256" value="${brand.comm}"/>
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
