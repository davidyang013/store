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
		function proxyCalc(){
			var radioCalc = $('input[name=radioCalc][checked]').val();
			var type = $("#type").val();
	  		var serial = $("#serial").val();
	  		var beginDate = $("#beginDate").val();
	  		var endDate = $("#endDate").val();
			if(!radioCalc){return;}
			var param = "radioCalc=" + radioCalc + "&type=" + type + "&serial=" + serial + 
						"&beginDate=" + beginDate + "&endDate=" + endDate;
			proxyRequest("<%=basePath%>bl/StorageManagerAction!proxyCalc.action", param);
		}
		
		function proxyCalcCallback(result){
			$("#result").text(result);
		}
	</script>
  </head>
  
<body>
	<!-- condition store begin -->
    <input type="hidden" id="type" name="type" value="${storage.type}"/>
    <input type="hidden" id="serial" name="serial" value="${storage.serial}"/>
    <input type="hidden" id="beginDate" name="beginDate" value="${storage.beginDate}"/>
    <input type="hidden" id="endDate" name="endDate" value="${storage.endDate}"/>
    <!-- condition store end-->
	<table class="editTable" width="550px" height="100%">
		<tr class="trTitle">
			<th colspan="2">
				商品库存维护
			</th>
		</tr>
		<tr class="trMid">
			<td colspan="2" align="center">
				<input type="radio" id="calcPrice" name="radioCalc" value="1">单价
				<input type="radio" id="calcCount" name="radioCalc" value="2">数量
				<input type="radio" id="calcTotl" name="radioCalc" value="3" checked>金额
			</td>
		</tr>
		<tr class="trFoot" align="center">
			<td class="tdLabel" width="35%">
				结果:
			</td>
			<td id="result" align="left" width="65%">
				&nbsp;
			</td>
		</tr>
		<tr class="trFoot" align="center">
			<td colspan="3">
				<input type="button" class="btn" value="计算" onclick="proxyCalc()" />
				<input type="button"  class="btn" value="关闭" onclick="window.close()"/>
			</td>
		</tr>
	</table>
</body>
</html>
