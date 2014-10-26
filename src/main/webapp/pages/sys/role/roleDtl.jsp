<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
			$("input").keydown(enterToTab);
		});
	
		function check(){
			var name = $("#name").val();
			var id = $("#id").val();
			var optype = $("#optype").val();
			var cboMainChoice = "";
			if(!name){
				alert("必填项不能为空");
				return false;
			}
			$("input[name='cboMainChoice']:checkbox").each(function(){ 
	            if($(this).attr("checked")){
	               cboMainChoice += "&cboMainChoice=" + $(this).val();
	            }
	        });
			var param = "name=" + name + "&id=" + id + cboMainChoice;
			if(optype == "update"){
				proxyRequest("<%=basePath%>sys/RoleManagerAction!update.action", param);
			} else{
				proxyRequest("<%=basePath%>sys/RoleManagerAction!insert.action", param);
			}
		}	
	
	</script>
  </head>
  
<body style="width:100%;overflow:hidden;margin:0px;padding:0px">
   <form action="" method="post">
		<div style="width:100%;" align="center">
			<div class="show" style="margin:0px;padding:0px;background-color:#e7edf3;">
			<input type="hidden" id="id" name="id" value="${role.id}"/>
			<input type="hidden" id="optype" name="optype" value="${optype}"/>
			<table class="editTable" width="100%">
				<tr class="trTitle">
					<th colspan="2">
						角色信息管理
					</th>
				</tr>
				<tr class="trMid">
					<td class="tdLabel" width="35%">
						角色名：
					</td>
					<td class="tdInput">
						<input type="text" id="name" name="name" maxlength="32" value="${role.name}"/>
						<font color="red">*</font>
					</td>
				</tr>
			</table>
			<div class="scroll" style="height:220px;overflow-y: auto">
				<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
					<th width="25px">
						<input type="checkbox" id="cboMainAll" name="cboMainAll" value="" onclick="selAll('cboMainAll','cboMainChoice')"/>						
					</th>
					<th>权限分配</th>
					<c:forEach var="rb" items="${resultList}" varStatus="state">
						<c:set var="flag" value="0"/>
						<c:forEach var="ra" items="${roleAuthList}">
							<c:if test="${ra.authId == rb.id}">
								<c:set var="flag" value="1"/>
							</c:if>
						</c:forEach>
						<c:if test="${state.count % 2 == 0}">
							<tr class="trEven">
						</c:if>
						<c:if test="${state.count % 2 != 0}">
							<tr class="trOdd">
						</c:if>
							<td>
								<c:if test="${flag == 0}">
									<input type="checkbox" id="cboMainChoice${state.count }" name="cboMainChoice" value="${rb.id }"/> 
								</c:if>
								<c:if test="${flag == 1}">
									<input type="checkbox" id="cboMainChoice${state.count }" name="cboMainChoice" value="${rb.id }" checked/> 
								</c:if>
							</td>
							<td>${rb.name }&nbsp;</td>
						</tr>
				    </c:forEach>
				</table>
			</div>
			<div>
				<input type="button" class="btn" value="保存" onclick="check()" />
				<input type="button" class="btn" value="关闭" onclick="window.close()"/>
			</div>
			</div>
		</div>
	</form>
</body>
</html>
