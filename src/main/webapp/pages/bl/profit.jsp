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
  	
  	function query(){
  		openDlg("<%=basePath%>pages/bl/profitQuery.jsp", 300, 120);
  	}
  	
  	function queryDtl(){
  		var month = "";
  		$("input[name='cboMainChoice']:radio").each(function(){ 
            if($(this).attr("checked")){
            	month = $(this).val();
               return false;
            }
        });
  		if(!month){
  			return;
  		}
  		openDlg("<%=basePath%>bl/ProfitManagerAction!queryEach.action?month=" + month, 600, 450);
  	}
  	
  </script>
  <body>
   <form action="" method="post">
   	   <input type="hidden" id="refresh" name="refresh" value="bl/ProfitManagerAction!query.action"/>
   	   <!-- condition begin -->
	   <input type="hidden" id="month" name="month" value="${profit.month}"/>
	   <!-- condition end-->
		<div class="center" align="center">
		<fieldset>
			<legend><strong class="fieldTitle">每月结算报表</strong></legend>	
			<div id="info" class="info">${info}&nbsp;</div>
			<div class="show">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
				<th width="25px">
					&nbsp;						
				</th>
				<th>时间节点</th>
				<th>实际售价</th>
				<th>实际进价</th>
				<th>运费收益</th>
				<th>结算收益</th>
				<c:forEach var="rb" items="${resultList}" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr class="trEven">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr class="trOdd">
					</c:if>
						<td>
							<input type="radio" id="cboMainChoice${state.count }" name="cboMainChoice" value="${rb.month }"/> 
						</td>
						<td>${rb.month}&nbsp;</td>
						<td>${rb.price}&nbsp;</td>
						<td>${rb.purchasePrice}&nbsp;</td>
						<td>${rb.transFee}&nbsp;</td>
						<td>${rb.profit}&nbsp;</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="${profit.pageSize - 1 }" step="1" varStatus="state">
					<tr><td colspan="5" style="border-bottom:0">&nbsp;</td></tr>
				</c:forEach>
			</table>
			</div>
			<!-- data end -->
			<!-- menu begin -->
			<table id="tblPage" class="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="left" style="padding-left:5px">
						<input type="button" class="btn" value='查询详细' onclick="queryDtl()">
						<!-- <input type="button" class="btn" value='查询' onclick="query()"> -->
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