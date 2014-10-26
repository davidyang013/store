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
			if(optype == "update"){
				$("#id").attr("readonly","true");
				$("#id").attr("disabled","true");
				$("#name").attr("readonly","true");
				$("#name").attr("disabled","true");
				$("#birthday").focus();
			} else {
				$("#id").focus();
			}
			$("input").keydown(enterToTab);
		});
	
		function checkAll(){
			var optype = $("#optype").val();
			var id = $("#id").val();
			var name = $("#name").val();
			var birthday = $("#birthday").val();
			var phone = $("#phone").val();
			var vipType = $("#vipType").val();
			if(!id || !name || !vipType){
				alert("必填项不能为空");
				return false;
			}
			var param = "id=" + id + "&name=" + name + 
						"&birthday=" + birthday + "&phone=" + phone + "&vipType=" + vipType;
			if(optype == "update"){
				proxyRequest("<%=basePath%>bl/MemberManagerAction!update.action", param);
			} else{
				proxyRequest("<%=basePath%>bl/MemberManagerAction!insert.action", param);
			}
		}	
	
	</script>
  </head>
  
<body>
	<input type="hidden" id="optype" name="optype" value="${optype}"/>
	<table class="editTable" width="580px" height="100px">
		<tr class="trTitle">
			<th colspan="4">
				会员信息维护
			</th>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				会员卡号：
			</td>
			<td class="tdInput">
				<input type="text" id="id" name="id" maxlength="32" value="${member.id}"/>
				<font color="red">*</font>
			</td>
			<td class="tdLabel">
				客户姓名：
			</td>
			<td class="tdInput">
				<input type="text" id="name" name="name" maxlength="32" value="${member.name}"/>
				<font color="red">*</font>
			</td>
		</tr>
		<tr class="trMid">
			<td class="TdLabel">
				生日：
			</td>
			<td class="tdInput">
				<input type="text" id="birthday" name="birthday" maxlength="16" value="${member.birthday}" readonly onclick="getDate(this)"/>
			</td>
			<td class="tdLabel">
				联系方式：
			</td>
			<td class="tdInput">
				<input type="text" id="phone" name="phone" maxlength="16" 
					   value="${member.phone}"/>
			</td>
		</tr>
		<tr class="trMid">
			<td class="tdLabel">
				VIP选项：
			</td>
			<td class="tdInput">
				<c:if test="${member.vipType == 'VIP'}">
					<select id="vipType" name="vipType" value="${member.vipType}">
						<option>普通会员</option>
						<option selected>VIP</option>
					</select>
				</c:if>
				<c:if test="${member.vipType != 'VIP'}">
					<select id="vipType" name="vipType">
						<option selected>普通会员</option>
						<option>VIP</option>
					</select>
				</c:if>
				<font color="red">*</font>
			</td>
			<td colspan="2" class="tdLabel">
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
