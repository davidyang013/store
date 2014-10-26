<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<base target="_self">
<title>获取客户信息</title>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script src="js/lib/jquery-1.8.2.js" type="text/javascript"></script>
<script src="js/common/common.js" type="text/javascript"></script>
<script src="js/common/calendar.js" type="text/javascript"></script>

<link href="css/common/common.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
  	//根据会员号或者客户姓名查询数据库记录
  	function searchCustomerInfo(){
  		var frm = document.getElementsByTagName("form")[0];
  		var link = document.all.refresh.value;
  	    frm.action = link;
  		frm.submit();
  	}
  	
  	//刷新售后页面信息
  	function returnCustomerToRepair(result){
		var arr = [];
  		arr = result.split(",");
  		memberId = arr[0];
  		customerId = arr[1];
  		name = arr[2];
  		wangwangId = arr[3];
  		phone = arr[4];
  		address = arr[5];
  		
  		if(memberId!='undefined'&&memberId !='null'){
  			window.dialogArguments.memberId.value = memberId;
  		}
  		if(customerId!='undefined'&&customerId !='null'){
  			window.dialogArguments.customerId.value = customerId;
  		}
  		if(name!='undefined'&&name !='null'){
  			window.dialogArguments.custName.value = name;
  		}
  		if(wangwangId!='undefined'&&wangwangId !='null'){
  			window.dialogArguments.wangwangId.value = wangwangId;
  		}
  		if(phone!='undefined'&&phone !='null'){
  			window.dialogArguments.phone.value = phone;
  		}
  		if(address!='undefined'&&address !='null'){
  			window.dialogArguments.address.value = address;
  		}
  		window.close();
  	}
  	
  </script>
<body style="overflow:hidden">
	<form action="" method="post">
	<input type="hidden" id="refresh" name="refresh" value="bl/RepairManagerAction!searchAllCustomerInfo.action"/>
		<!-- condition begin -->
		<!-- condition end-->
		<table class="editTable" width="100%" height="50px">
			<tr class="trTitle">
				<th colspan="5">客户信息查询</th>
			</tr>
			<tr class="trMid">
				<td class="TdLabel">会员卡号：</td>
				<td class="tdInput"><input type="text" id="memberId"
					name="memberId" maxlength="32" value="${repair.memberId}" /></td>
				<td class="tdLabel">客户姓名 ：</td>
				<td class="tdInput"><input type="text" id="name" name="name"
					maxlength="32" value="${repair.name}" /></td>
				<td class="tdInput"><input type="button" class="btn" value="查询"
					onclick="searchCustomerInfo()" /></td>
			</tr>
		</table>
		<div class="show" style="padding:0px">
			<!-- data begin -->
			<div class="scroll">
				<table id="tblMain" class="tblMain" align="center" cellpadding="0"
					cellspacing="0"
					onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})">
					<th>会员卡号</th>
					<th type="hidden">客户ID</th>
					<th>客户姓名</th>
					<th>旺旺账号</th>
					<th>联系方式</th>
					<th>联系地址</th>


					<c:forEach var="rb" items="${resultList}" varStatus="state">
						<c:if test="${state.count % 2 == 0}">
							<tr class="trEven"
								ondblclick="returnCustomerToRepair('${rb.memberId},${rb.customerId},${rb.name},${rb.wangwangId},${rb.phone},${rb.address}')">
						</c:if>
						<c:if test="${state.count % 2 != 0}">
							<tr class="trOdd"
								ondblclick="returnCustomerToRepair('${rb.memberId},${rb.customerId},${rb.name},${rb.wangwangId},${rb.phone},${rb.address}')">
						</c:if>
						<td>${rb.memberId == null ? "&nbsp;" : rb.memberId}</td>
						<td type="hidden">${rb.customerId == null ? "&nbsp;" :
							rb.customerId}</td>
						<td>${rb.name == null ? "&nbsp;" : rb.name}</td>
						<td>${rb.wangwangId == null ? "&nbsp;" : rb.wangwangId}</td>
						<td>${rb.phone == null ? "&nbsp;" : rb.phone}</td>
						<td>${rb.address == null ? "&nbsp;" : rb.address}</td>

						</tr>
					</c:forEach>
					<c:forEach begin="${fn:length(resultList) }" end="${repair.pageSize - 1 }" step="1" varStatus="state">
						<tr><td colspan="8" style="border-bottom:0">&nbsp;</td></tr>
					</c:forEach>
				</table>
			</div>
			<!-- data end -->
			<!-- menu begin -->
			<table id="tblPage" class="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="left" style="padding-left:5px">
					&nbsp;
					</td>
					<td align="right" style="padding-right:5px">
						<span id="curPage" >${curPage }</span>/<span id="maxPage" >${maxPage }</span>
						<input id="txtPage" type="text" size="4" style="height:18px; width:20px; border:1px solid #999999;" /> 
						<input type="button" class="btn" value='跳转'
							   onclick="toPage()">
						<input type="button" class="btn" value='前页'
							   onclick="getLastPage()">
						<input type="button" class="btn" value='后页' 
						       onclick="getNextPage()"> 
					</td>
				</tr>
			</table>
			<!-- menu end -->
		</div>
	</form>
</body>
</html>