<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
  	window.onbeforeunload = function onbeforeload() { 
		refreshDlg();
	};
  	function add(){
		openDlg("<%=basePath%>bl/RepairManagerAction!gotoDtl.action?optype=add", 650, 368);
	}
  
  	function update(){
  		var id = "";
  		$("input[name='cboMainChoice']:checkbox").each(function(){ 
            if($(this).attr("checked")){
            	id = $(this).val();
               return false;
            }
        });
  		var arr = [];
  		arr = id.split(",");
  		id = arr[0];
  		if(!id){
  			return;
  		}
  		openDlg("<%=basePath%>bl/RepairManagerAction!gotoDtl.action?id=" + id + "&optype=update", 650, 368);
  	}
  	
  	function query(){
  		openDlg("<%=basePath%>bl/RepairManagerAction!searchAllBrandInfo.action?warranty=0", 750, 450);
  	}
  	
  	function queryByCondition(id, phone){
  		var frm = document.getElementsByTagName("form")[0];
  		$("#id").val(id);
  		$("#phone").val(phone);
  		$("#curPage").val("1");
  	    frm.action = "<%=basePath%>bl/RepairManagerAction!query.action";
  		frm.submit();
  	}
  	
  	function del(){
  		$("input[name='cboMainChoice']:checkbox").each(function(){ 
            if($(this).attr("checked")){
            	id = $(this).val();
            	return false;
            }
        });
  		var arr = [];
  		arr = id.split(",");
  		id = arr[0];
  		$("#id").val(id);
  		if(!id){
  			return;
  		}
  		if(!confirm("确认删除该条记录?")){return;}
  		var frm = document.getElementsByTagName("form")[0];
  		frm.action = "<%=basePath%>bl/RepairManagerAction!del.action";
  		frm.submit();
  	}
  	function turnToBCD(){
  		$("input[name='cboMainChoice']:checkbox").each(function(){ 
            if($(this).attr("checked")){
            	id = $(this).val();
               return false;
            }
        });
  		var arr = [];
  		arr = id.split(",");
  		id = arr[0];
  		repairStatus = arr[1];
  		if(repairStatus=="已寄回客户"){
  			alert("此售后订单操作已结束");
  		}
  		else{
  			openDlg("<%=basePath%>bl/RepairManagerAction!repairTransFee.action?id=" + id, 301, 125);
  		}
  	}
  	function actualFee(){
  		$("input[name='cboMainChoice']:checkbox").each(function(){ 
            if($(this).attr("checked")){
            	id = $(this).val();
               return false;
            }
        });
  		var arr = [];
  		arr = id.split(",");
  		id = arr[0];
  		openDlg("<%=basePath%>bl/RepairManagerAction!repairTransFee.action?id=" + id + "&repairStatus=update", 600, 300);
  	}
  	
  </script>
  <body>
   <form action="" method="post">
   	   <input type="hidden" id="refresh" name="refresh" value="bl/RepairManagerAction!query.action"/>
   	   <a id="reload" href="<%=basePath%>bl/RepairManagerAction!query.action" style="display:none">reload...</a>
	   <!-- condition begin -->
	   <input type="hidden" id="id" name="id" value="${repair.id}"/>
	   <input type="hidden" id="phone" name="phone" value="${repair.phone}"/>
	   <!-- condition end-->
		<div class="center" align="center">
		<fieldset>
			<legend><strong class="fieldTitle">售后信息维护</strong></legend>	
			<div id="info" class="info">${info}&nbsp;</div>
			<div class="show">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
				<th width="25px">
					<input type="checkbox" id="cboMainAll" name="cboMainAll" value="" onclick="selAll('cboMainAll','cboMainChoice')"/>						
				</th>
				<th>购买日期</th>
				<th>品牌</th>
				<th>型号</th>
				<th>颜色</th>
				<th>独立序列号</th>
				<th>外观</th>
				<th>维修金额</th>
				<th>实际维修金额</th>
				<th>收取运费合计</th>
				<th>实际运费</th>
				<th>订单号</th>
				<th>姓名</th>
				<th>旺旺</th>
				<th>电话</th>
				<th>地址</th>
				<th>状态</th>
				<c:forEach var="rb" items="${resultList}" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr class="trEven">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr class="trOdd">
					</c:if>
						<td>
							<input type="checkbox" id="cboMainChoice${state.count }" name="cboMainChoice" value="${rb.id },${rb.repairStatus}" onclick="doCheck('cboMainChoice${state.count }')"/> 
						</td>
						<td>${rb.purchaseDate}&nbsp;</td>
						<td>${rb.brand}&nbsp;</td>
						<td>${rb.type}&nbsp;</td>
						<td>${rb.color}&nbsp;</td>
						<td>${rb.headsetSerial}&nbsp;</td>
						<td>${rb.appearance}&nbsp;</td>
						<td>${rb.price}&nbsp;</td>
						<td>${rb.actualPrice}&nbsp;</td>
						<td>${rb.repairFeeABCD}&nbsp;</td>
						<td>${rb.actualRepairFee}&nbsp;</td>
						<td>${rb.orderId}&nbsp;</td>
						<td>${rb.name}&nbsp;</td>
						<td>${rb.wangwangId}&nbsp;</td>
						<td>${rb.phone}&nbsp;</td>
						<td>${rb.address}&nbsp;</td>
						<td>${rb.repairStatus}&nbsp;</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="${repair.pageSize - 1 }" step="1" varStatus="state">
					<tr><td colspan="5" style="border-bottom:0">&nbsp;</td></tr>
				</c:forEach>
			</table>
			</div>
			<!-- data end -->
			<!-- menu begin -->
			<table id="tblPage" class="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="left" style="padding-left:5px">
						<input type="button" class="btn" value='增加' onclick="add()">
						<input type="button" class="btn" value='修改' onclick="update()"> 
						<input type="button" class="btn" value='查询' onclick="query()">
						<input type="button" class="btn" value='删除' onclick="del()">
						<input type="button" class="btn" value='修改状态' onclick="turnToBCD()">
						<input type="button" class="btn" value='实际运费' onclick="actualFee()">
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