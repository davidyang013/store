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
String userId = (String)request.getSession().getAttribute("loginName");
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
  	jQuery(document).ready(function(){
  		$("input[name='cboMainChoice']:radio:first").attr("checked", "checked");
	});
  
  	function add(){
		openDlg("<%=basePath%>bl/OutStoreManagerAction!gotoDtl.action?optype=add", 800, 660);
	}
  
  	function query(){
  		openDlg("<%=basePath%>pages/bl/outStoreQuery.jsp", 550, 160);
  	}
  	
  	function queryDtl(){
  		var orderId = "";
  		$("input[name='cboMainChoice']:radio").each(function(){ 
            if($(this).attr("checked")){
            	orderId = $(this).val();
               return false;
            }
        });
  		if(!orderId){
  			return;
  		}
  		openDlg("<%=basePath%>bl/OutStoreManagerAction!gotoDtl.action?orderId=" + orderId + "&optype=order", 800, 300);
  	}
  	
  	function exp(){
  		var frm = document.getElementsByTagName("form")[0];
  		var param = null;
  		$("input[name='cboMainChoice']:radio").each(function(){ 
            if($(this).attr("checked")){
            	param = $(this).val();
            	return false;
            }
        });
  		if(!param){return;}
  	    frm.action = "<%=basePath%>sys/ReportManagerAction!execute.action?" +
  	    			  "reportId=1&param=" + param + "&param=<%= userId%>";
  		frm.submit();
  	}
  	
  	function queryByCondition(orderId, transSerial, type, depSerial, beginDate, endDate){
  		var frm = document.getElementsByTagName("form")[0];
  		$("#orderId").val(orderId);
  		$("#transSerial").val(transSerial);
  		$("#type").val(type);
  		$("#depSerial").val(depSerial);
  		$("#beginDate").val(beginDate);
  		$("#endDate").val(endDate);
  		$("#curPage").val("1");
  	    frm.action = "<%=basePath%>bl/OutStoreManagerAction!query.action";
  		frm.submit();
  	}
  	
  	function reQuery(){
  		var frm = document.getElementsByTagName("form")[0];
  	    frm.action = "<%=basePath%>bl/OutStoreManagerAction!query.action";
  		frm.submit();
  	}
  	
  	function del(){
  		var id = null;
  		$("input[name='cboMainChoice']:radio").each(function(){ 
            if($(this).attr("checked")){
            	id = $(this).val();
                return false;
            }
        });
  		if(!id){return;}
  		if(!confirm("确认删除该条记录?")){return;}
  		var frm = document.getElementsByTagName("form")[0];
  		frm.action = "<%=basePath%>bl/OutStoreManagerAction!del.action?id=" + id;
  		frm.submit();
  	}
  	
  </script>
  <body>
   <form action="" method="post">
   	   <input type="hidden" id="refresh" name="refresh" value="bl/OutStoreManagerAction!query.action"/>
   	   <a id="reload" href="javascript:void(0)" onclick="reQuery()" style="display:none">reload...</a>
	   <!-- condition begin -->
	   <input type="hidden" id="orderId" name="orderId" value="${outStore.orderId}"/>
	   <input type="hidden" id="transSerial" name="transSerial" value="${outStore.transSerial}"/>
	   <input type="hidden" id="type" name="type" value="${outStore.type}"/>
	   <input type="hidden" id="depSerial" name="depSerial" value="${outStore.depSerial}"/>
	   <input type="hidden" id="beginDate" name="beginDate" value="${outStore.beginDate}"/>
	   <input type="hidden" id="endDate" name="endDate" value="${outStore.endDate}"/>
	   <!-- condition end-->
		<div class="center" align="center">
		<fieldset>
			<legend><strong class="fieldTitle">商品出库维护</strong></legend>	
			<div id="info" class="info">${info}&nbsp;</div>
			<div class="show">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
				<th width="25px">
					&nbsp;						
				</th>
				<th>订单号</th>
				<th>出库金额汇总</th>
				<th>出库数量汇总</th>
				<th>出库时间</th>
				<th>运输费用汇总</th>
				<th>支付方式</th>
				<th>购买类别</th>
				<th>操作员</th>
				<th>备注</th>
				<c:forEach var="rb" items="${resultList}" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr class="trEven">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr class="trOdd">
					</c:if>
						<td>
							<input type="radio" id="cboMainChoice${state.count }" name="cboMainChoice" value="${rb.orderId }"/> 
						</td>
						<td>${rb.orderId}&nbsp;</td>
						<td>${rb.price}&nbsp;</td>
						<td>${rb.count}&nbsp;</td>
						<td>${rb.outDate}&nbsp;</td>
						<td>${rb.transFee}&nbsp;</td>
						<td>${rb.payType}&nbsp;</td>
						<td>${rb.buyType}&nbsp;</td>
						<td>${rb.operator}&nbsp;</td>
						<td>${rb.comm}&nbsp;</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="14" step="1" varStatus="state">
					<tr><td colspan="10" style="border-bottom:0">&nbsp;</td></tr>
				</c:forEach>
			</table>
			</div>
			<!-- data end -->
			<!-- menu begin -->
			<table id="tblPage" class="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="left" style="padding-left:5px">
						<input type="button" class="btn" value='出库' onclick="add()">
						<input type="button" class="btn" value='查询明细' onclick="queryDtl()">
						<input type="button" class="btn" value='导出打印' onclick="exp()"> 
						<input type="button" class="btn" value='查询' onclick="query()">
						<f:permission menuId="3001">
							<input type="button" class="btn" value='删除' onclick="del()"> 
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