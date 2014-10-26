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
//清除缓存
if (request.getProtocol().compareTo("HTTP/1.0")==0)
    response.setHeader("Pragma","no-cache");
if (request.getProtocol().compareTo("HTTP/1.1")==0)
    response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<base href="<%=basePath%>" >
	<base target="_self">
    <title></title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<script src="js/lib/jquery-1.8.2.js" type="text/javascript"></script>
	<script src="js/common/common.js" type="text/javascript"></script>
	<script src="js/common/calendar.js" type="text/javascript"></script>
	
    <link href="css/common/common.css" rel="stylesheet" type="text/css">
  </head>
  <script type="text/javascript">
  
  	window.onbeforeunload = function onbeforeload() { 
  		//refreshDlg();
	};
  
  	function update(){
  		var id = "";
  		$("input[name='cboMainChoice']:radio").each(function(){ 
            if($(this).attr("checked")){
               id = $(this).val();
               return false;
            }
        });
  		if(!id){
  			return;
  		}
  		openDlg("<%=basePath%>bl/OutStoreManagerAction!gotoDtl.action?id=" + id + "&optype=orderDtl", 580, 205);
  	}

  	function del(){
  		var cnt = 0;
  		$("input[name='cboMainChoice']:checkbox").each(function(){ 
            if($(this).attr("checked")){
               cnt++;
            }
        });
  		if(cnt == 0){
  			return;
  		}
  		if(!confirm("确认删除该条记录?")){return;}
  		var frm = document.getElementsByTagName("form")[0];
  		frm.action = "<%=basePath%>bl/OutStoreManagerAction!del.action";
  		frm.submit();
  	}
  
  </script>
  <body>
   <form action="" method="post">
   		<a id="reload" href="<%=basePath%>bl/OutStoreManagerAction!gotoDtl.action?orderId=${outStore.orderId }&optype=order" style="display:none">reload...</a>
		<div class="center" align="center">
		<fieldset>
			<legend><strong class="fieldTitle">订单详细信息</strong></legend>	
			<div id="info" class="info">${info}&nbsp;</div>
			<div class="show">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
				<th width="25px">
					&nbsp;						
				</th>
				<th>订单号</th>
				<th>独立序列号</th>
				<th>品牌</th>
				<th>型号</th>
				<th>颜色</th>
				<th>售价</th>
				<th>保修时长</th>
				<th>出库单价</th>
				<th>出库数量</th>
				<th>运单号</th>
				<th>预估运费</th>
				<th>实际运费</th>
				<th>物流公司</th>
				<c:forEach var="rb" items="${resultList}" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr class="trEven">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr class="trOdd">
					</c:if>
						<td>
							<input type="radio" id="cboMainChoice${state.count }" name="cboMainChoice" value="${rb.id }"/> 
						</td>
						<td>${rb.orderId}&nbsp;</td>
						<td>${rb.depSerial}&nbsp;</td>
						<td>${rb.brand}&nbsp;</td>
						<td>${rb.type}&nbsp;</td>
						<td>${rb.color}&nbsp;</td>
						<td>${rb.salePrice}&nbsp;</td>
						<td>${rb.warranty}&nbsp;</td>
						<td>${rb.price}&nbsp;</td>
						<td>${rb.count}&nbsp;</td>
						<td>${rb.transSerial}&nbsp;</td>
						<td>${rb.transFee}&nbsp;</td>
						<td>${rb.actualTransFee}&nbsp;</td>
						<td>${rb.transCompany}&nbsp;</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="4" step="1" varStatus="state">
					<tr><td colspan="14" style="border-bottom:0">&nbsp;</td></tr>
				</c:forEach>
			</table>
			</div>
			<!-- data end -->
			<!-- menu begin -->
			<table id="tblPage" class="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="left" style="padding-left:5px">
						<f:permission menuId="3002">
							<input type="button" class="btn" style="width:100px" value='修改物流信息' onclick="update()">
						</f:permission>
						<!-- <input type="button" class="btn" value='删除' onclick="del()"> -->
						<input type="button" class="btn" value="关闭" onclick="window.close();" />
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