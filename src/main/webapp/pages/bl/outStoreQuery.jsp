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
	<script src="js/common/calendar.js" type="text/javascript"></script>
	
    <link href="css/common/common.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript">
		jQuery(document).ready(function(){
			$("#orderId").focus();
			$("input").keydown(enterToTab);
		});
	
		function check(){
			var orderId = $("#orderId").val();
			var transSerial = $("#transSerial").val();
			var type = $("#type").val();
			var depSerial = $("#depSerial").val();
			var beginDate = $("#beginDate").val();
			var endDate = $("#endDate").val();
            dialogArguments.queryByCondition(orderId, transSerial, type, depSerial, beginDate, endDate);
            window.close();
		}
	</script>
  </head>
  
<body>
	<table class="editTable" width="550px" height="100%">
		<tr class="trTitle">
			<th colspan="4">
				商品出库维护
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				订单号：
			</td>
			<td class="tdInput">
				<input type="text" id="orderId" name="orderId" maxlength="32"/>
			</td>
			<td class="tdLabel">
				运单号：
			</td>
			<td class="tdInput">
				<input type="text" id="transSerial" name="transSerial" maxlength="32"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				商品型号：
			</td>
			<td class="tdInput">
				<input type="text" id="type" name="type" maxlength="32"/>
			</td>
			<td class="tdLabel">
				独立序列号：
			</td>
			<td class="tdInput">
				<input type="text" id="depSerial" name="depSerial" maxlength="32"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				出库日期(开始)：
			</td>
			<td class="tdInput">
				<input type="text" id="beginDate" name="beginDate" maxlength="10" readonly onclick="getDate(this)"/>
			</td>
			<td class="TdLabel">
				出库日期(结束)：
			</td>
			<td class="tdInput">
				<input type="text" id="endDate" name="endDate" maxlength="10" readonly onclick="getDate(this)"/>
			</td>
		</tr>
		<tr class="trFoot" align="center">
			<td colspan="4">
				<input type="button" class="btn" value="查询" onclick="check()" />
				<input type="button"  class="btn" value="关闭" onclick="window.close()"/>
			</td>
		</tr>
	</table>
</body>
</html>
