<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	if (request.getSession().getAttribute("loginName") == null)
		response.sendRedirect(basePath + "pages/sys/login.jsp");
	String info = "  ";
	String warranty = (String)request.getAttribute("warranty");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<base target="_self">
<title>获取商品信息</title>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script src="js/lib/jquery-1.8.2.js" type="text/javascript"></script>
<script src="js/common/common.js" type="text/javascript"></script>
<script src="js/common/calendar.js" type="text/javascript"></script>

<link href="css/common/common.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
  	//根据订单号、耳机序列号、购买日期区间查询数据库记录
  	function searchBrandInfo(){
  		var frm = document.getElementsByTagName("form")[0];
  		var link = document.all.refresh.value;
  	    frm.action = link;
  		frm.submit();
  	}
  	
  	//刷新售后页面信息
  	function returnBrandToRepair(result){
  		//使查询页面双击回显功能失效
  		var warranty = <%=warranty %>;
  	    if(warranty == '0' || warranty == 0){
  	     	return;
  	    }
  	    
		var arr = [];
  		arr = result.split(",");
  		headsetSerial = arr[0];
  		purchaseDate = arr[1];
  		orderId = arr[2];
  		brand = arr[3];
  		type = arr[4];
		color = arr[5];
		appearance = arr[6];
		
		if(headsetSerial!='undefined'&&headsetSerial !='null'){
			window.dialogArguments.headsetSerial.value = headsetSerial;
  		}
  		if(purchaseDate!='undefined'&&purchaseDate !='null'){
  			window.dialogArguments.purchaseDate.value = purchaseDate;
  		}
  		if(brand!='undefined'&&brand !='null'){
  			window.dialogArguments.brand.value = brand;
  		}
  		if(type!='undefined'&&type !='null'){
  			window.dialogArguments.type.value = type;
  		}
  		if(color!='undefined'&&color !='null'){
  			window.dialogArguments.color.value = color;
  		}
  		if(appearance!='undefined'&&appearance !='null'){
  			window.dialogArguments.appearance.value = appearance;
  		}
  		if(orderId!='undefined'&&orderId !='null'){
  			window.dialogArguments.orderId.value = orderId;
  			window.dialogArguments.flag.value = "1";
  		}
  		
  		window.close();
  	}
  	
  </script>
<body style="overflow:hidden">
	<form action="" method="post">
   	   <input type="hidden" id="refresh" name="refresh" value="bl/RepairManagerAction!searchAllBrandInfo.action"/>
		<!-- condition begin -->
		<!-- condition end-->
		<table class="editTable" width="100%" height="100px">
			<tr class="trTitle">
				<th colspan="5">商品信息查询</th>
			</tr>
			<tr class="trMid">
				<td class="TdLabel">订单号：</td>
				<td class="tdInput"><input type="text" id="orderId"
					name="orderId" maxlength="32" value="${repair.orderId}" /></td>
				<td class="tdLabel">商品型号 ：</td>
				<td class="tdInput" colspan="2"><input type="text" id="type"
					name="type" maxlength="32" value="${repair.type}" /></td>
			</tr>
			<tr class="trMid">
				<td class="TdLabel">购买日期(开始)：</td>
				<td class="tdInput"><input type="text" id="beginDate" value="${repair.beginDate}"
					name="beginDate" maxlength="10" readonly onclick="getDate(this)" />
				</td>
				<td class="tdLabel">购买日期(结束)：</td>
				<td class="tdInput"><input type="text" id="endDate" value="${repair.endDate}"
					name="endDate" maxlength="10" readonly onclick="getDate(this)" />
				</td>
				<td class="tdInput"><input type="button" class="btn" value="查询"
					onclick="searchBrandInfo()" /></td>
			</tr>
		</table>
		<div class="show" style="padding:0px">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0"
				cellspacing="0"
				onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})">
				<th>独立序列号</th>
				<th>购买日期</th>
				<th>订单号</th>
				<th>品牌</th>
				<th>型号</th>
				<th>颜色</th>
				<th>外观</th>
				<th>保修时长</th>
				<c:if test="${repair.warranty!= 0}">
					<c:forEach var="rb" items="${resultList}" varStatus="state">
						<c:if test="${state.count % 2 == 0}">
							<tr class="trEven"
								ondblclick="returnBrandToRepair('${rb.headsetSerial},${rb.purchaseDate},${rb.orderId},${rb.brand},${rb.type},${rb.color},${rb.appearance}')">
						</c:if>
						<c:if test="${state.count % 2 != 0}">
							<tr class="trOdd"
								ondblclick="returnBrandToRepair('${rb.headsetSerial},${rb.purchaseDate},${rb.orderId},${rb.brand},${rb.type},${rb.color},${rb.appearance}')">
						</c:if>
						<td>${rb.headsetSerial == null ? "&nbsp;" :
							rb.headsetSerial}</td>
						<td>${rb.purchaseDate == null ? "&nbsp;" : rb.purchaseDate}</td>
						<td>${rb.orderId == null ? "&nbsp;" : rb.orderId}</td>
						<td>${rb.brand == null ? "&nbsp;" : rb.brand}</td>
						<td>${rb.type == null ? "&nbsp;" : rb.type}</td>
						<td>${rb.color == null ? "&nbsp;" : rb.color}</td>
						<td>${rb.appearance == null ? "&nbsp;" : rb.appearance}</td>
						<td>${rb.warranty == null ? "&nbsp;" : rb.warranty}</td>

						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${repair.warranty== 0}">
					<c:forEach var="rb" items="${resultList}" varStatus="state">
						<c:if test="${state.count % 2 == 0}">
							<tr class="trEven">
						</c:if>
						<c:if test="${state.count % 2 != 0}">
							<tr class="trOdd">
						</c:if>
						<td>${rb.headsetSerial == null ? "&nbsp;" :
							rb.headsetSerial}</td>
						<td>${rb.purchaseDate == null ? "&nbsp;" : rb.purchaseDate}</td>
						<td>${rb.orderId == null ? "&nbsp;" : rb.orderId}</td>
						<td>${rb.brand == null ? "&nbsp;" : rb.brand}</td>
						<td>${rb.type == null ? "&nbsp;" : rb.type}</td>
						<td>${rb.color == null ? "&nbsp;" : rb.color}</td>
						<td>${rb.appearance == null ? "&nbsp;" : rb.appearance}</td>
						<td>${rb.warranty == null ? "&nbsp;" : rb.warranty}</td>
						</tr>
					</c:forEach>
				</c:if>
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