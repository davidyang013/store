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
			$("#id").focus();
			$("input").keydown(enterToTab);
		});
	
		function check(){
			var id = $("#id").val();
			var phone = $("#phone").val();
            dialogArguments.queryByCondition(id, phone);
            window.close();
		}
	
	</script>
  </head>
  
<body>
	<table class="editTable" width="300px" height="120px">
		<tr class="trTitle">
			<th colspan="4">
				会员信息查询
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				会员卡号：
			</td>
			<td class="tdInput" colspan="3">
				<input type="text" id="id" name="id" maxlength="32"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				联系方式：
			</td>
			<td class="tdInput" colspan="3">
				<input type="text" id="phone" name="phone" maxlength="16"/>
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
