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
		function load(){
			var repairStatus = $("#repairStatus").val();
			var divA= document.getElementById("divA");
			var divB= document.getElementById("divB");
			var divC= document.getElementById("divC");
			if(repairStatus=="客户已返修"){
				divA.style.display="block";
				divB.style.display="none";
				divC.style.display="none";
			}else if(repairStatus=="寄往代理商"){
				divA.style.display="none";
				divB.style.display="block";
				divC.style.display="none";
			}else if(repairStatus=="代理商收回"){
				divA.style.display="none";
				divB.style.display="none";
				divC.style.display="block";
			}
		}
	
		function save(){
			var repairSerialX = $("#repairSerialX").val();
			var repairFeeX = $("#repairFeeX").val();
			var repairStatus = $("#repairStatus").val();
			var id = $("#id").val();
			var param = "repairSerialX=" + repairSerialX + "&repairFeeX=" + repairFeeX + 
						"&repairStatus=" + repairStatus + "&id=" + id;
			proxyRequest("<%=basePath%>bl/RepairManagerAction!updateTransFee.action", param);
            window.close();
		}
		function checkFee(){
			var repairFeeX = $("#repairFeeX").val();
			if(repairFeeX && ( repairFeeX < 0 || repairFeeX > 999.99)){
				alert("运费" + repairFeeX + "金额不正确！");
				$("#repairFeeX").val("");
				$("#repairFeeX").focus();
			}
		}	
	
	</script>
  </head>
  
<body onload="load()">
	<input type="hidden" id="repairStatus" name="repairStatus" value="${repair.repairStatus}"/>
	<input type="hidden" id="id" name="id" value="${repair.id}"/>
	<table class="editTable" width="300px" height="120px">
		<tr class="trTitle">
			<th colspan="4">
				<div id="divA" class="none">
					寄往代理商运费信息
				</div>
				<div id="divB" class="none">
					代理商收回运费信息
				</div>
				<div id="divC" class="none">
					已寄回客户运费信息
				</div>
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				返修运费单号：
			</td>
			<td class="tdInput" colspan="3">
				<input type="text" id="repairSerialX" name="repairSerialX" maxlength="32"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				返修运费：
			</td>
			<td class="tdInput" colspan="3">
				<input type="text" id="repairFeeX" name="repairFeeX" maxlength="6" onblur="checkFee()"/>
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
