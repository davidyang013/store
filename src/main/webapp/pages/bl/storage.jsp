<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/taglib/frame" prefix="f"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
if(request.getSession().getAttribute("loginName") == null)
	response.sendRedirect(basePath + "pages/sys/login.jsp");
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
  </head>
  <script type="text/javascript">
  	
  	function query(){
  		openDlg("<%=basePath%>pages/bl/storageQuery.jsp", 550, 120);
  	}
  	
  	function exp(){
  		openDlg("<%=basePath%>pages/bl/storageQuery.jsp", 300, 120);
  	}
  	
	function calc(){
		var type = $("#type").val();
  		var serial = $("#serial").val();
  		var beginDate = $("#beginDate").val();
  		var endDate = $("#endDate").val();
  		var param = "type=" + type + "&serial=" + serial + "&beginDate=" + beginDate + "&endDate=" + endDate;
  		openDlg("<%=basePath%>/bl/StorageManagerAction!queryCalc.action?" + encode(param), 550, 120);
  	}
  	
  	function queryByCondition(type, serial, beginDate, endDate){
  		var frm = document.getElementsByTagName("form")[0];
  		$("#type").val(type);
  		$("#serial").val(serial);
  		$("#beginDate").val(beginDate);
  		$("#endDate").val(endDate);
  		$("#curPage").val("1");
  	    frm.action = "<%=basePath%>bl/StorageManagerAction!query.action";
  		frm.submit();
  	}
  	
  	function queryDtl(){
  		var serial = $("#oneSerial").val();
  		var inDate = $("#oneInDate").val();
  		var color = $("#oneColor").val();
  		var count = $("#oneCount").val();
  		if(!serial || !inDate || !color){
  			alert("请选择一项");
  			return;
  		}
  		if(!count || count == 0){
  			alert("无库存");
  			return;
  		}
  		var param = "serial=" + serial + "&inDate=" + inDate + "&color=" + color;
  		openDlg("<%=basePath%>/bl/StorageManagerAction!queryEach.action?" + encode(param), 800, 450);
  	}
  	
  	function saveParam(cbo){
  		var $tr=$(cbo.parentNode.parentNode);
  		$("#oneSerial").val($tr.find("td:eq(1)").text());
  		$("#oneInDate").val($tr.find("td:eq(4)").text());
  		$("#oneColor").val($tr.find("td:eq(5)").text());
  		$("#oneCount").val($tr.find("td:eq(7)").text());
  	}
  	
  </script>
  <body>
   <form action="" method="post">
   	   <input type="hidden" id="refresh" name="refresh" value="bl/StorageManagerAction!query.action"/>
	   <!-- param to detail begin -->
	   <input type="hidden" id="oneSerial" name="oneSerial" value=""/>
	   <input type="hidden" id="oneInDate" name="oneInDate" value=""/>
	   <input type="hidden" id="oneColor" name="oneColor" value=""/>
	   <input type="hidden" id="oneCount" name="oneCount" value=""/>
	   <!-- param to detail end-->
	   <!-- condition begin -->
	   <input type="hidden" id="type" name="type" value="${storage.type}"/>
	   <input type="hidden" id="serial" name="serial" value="${storage.serial}"/>
	   <input type="hidden" id="beginDate" name="beginDate" value="${storage.beginDate}"/>
	   <input type="hidden" id="endDate" name="endDate" value="${storage.endDate}"/>
	   <!-- condition end-->
		<div class="center" align="center">
		<fieldset>
			<legend><strong class="fieldTitle">商品库存管理</strong></legend>	
			<div id="info" class="info">${info}&nbsp;</div>
			<div class="show">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
				<th width="25px">
					&nbsp;						
				</th>
				<th>商品序列号</th>
				<th>品牌</th>
				<th>型号</th>
				<th>入库日期</th>
				<th>颜色</th>
				<th>售价</th>
				<th>数量</th>
				<c:forEach var="rb" items="${resultList}" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr class="trEven">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr class="trOdd">
					</c:if>
						<td>
							<input type="radio" id="cboMainChoice${state.count }" name="cboMainChoice" onclick="saveParam(this)"/> 
						</td>
						<td>${rb.serial == null ? "&nbsp;" : rb.serial}</td>
						<td>${rb.brand}&nbsp;</td>
						<td>${rb.type}&nbsp;</td>
						<td>${rb.inDate == null ? "&nbsp;" : rb.inDate}</td>
						<td>${rb.color == null ? "&nbsp;" : rb.color}</td>
						<td>${rb.salePrice}&nbsp;</td>
						<td>${rb.count}&nbsp;</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="${storage.pageSize - 1 }" step="1" varStatus="state">
					<tr><td colspan="8" style="border-bottom:0">&nbsp;</td></tr>
				</c:forEach>
			</table>
			</div>
			<!-- data end -->
			<!-- menu begin -->
			<table id="tblPage" class="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="left" style="padding-left:5px">
						<input type="button" class="btn" value='查询' onclick="query()">
						<f:permission menuId="4001">
							<input type="button" class="btn" value='查询明细' onclick="queryDtl()">
						</f:permission>
						<!-- <input type="button" class="btn" value='导出' onclick="exp()"> -->
						<f:permission menuId="4002">
							<input type="button" class="btn" value='统计' onclick="calc()">
						</f:permission>
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
		</fieldset>
		</div>
	</form>
  </body>
</html>