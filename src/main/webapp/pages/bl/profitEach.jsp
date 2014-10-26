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
 
  </script>
  <body>
   <form action="" method="post">
   	   <input type="hidden" id="refresh" name="refresh" value="bl/ProfitManagerAction!queryEach.action"/>
	    <input type="hidden" id="month" name="month" value="${profit.month}"/>
		<div class="center" align="center">
		<fieldset>
			<legend><strong class="fieldTitle">月结详细信息</strong></legend>	
			<div id="info" class="info">${info}&nbsp;</div>
			<div class="show">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
				<!-- <th width="25px">
					&nbsp;						
				</th> -->
				<th>订单号</th>
				<th>实售</th>
				<th>进价</th>
				<th>预估运费</th>
				<th>实际运费</th>
				<th>单笔收益</th>
				<c:forEach var="rb" items="${resultList}" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr class="trEven">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr class="trOdd">
					</c:if>
						<%-- <td>
							<input type="radio" id="cboMainChoice${state.count }" name="cboMainChoice" value="${rb.orderId }"/> 
						</td> --%>
						<td>${rb.orderId}&nbsp;</td>
						<td>${rb.price}&nbsp;</td>
						<td>${rb.purchasePrice}&nbsp;</td>
						<td>${rb.transFee}&nbsp;</td>
						<td>${rb.actualTransFee}&nbsp;</td>
						<td>${rb.profit}&nbsp;</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="${profit.pageSize - 1 }" step="1" varStatus="state">
					<tr><td colspan="6" style="border-bottom:0">&nbsp;</td></tr>
				</c:forEach>
			</table>
			</div>
			<!-- data end -->
			<!-- menu begin -->
			<table id="tblPage" class="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="left" style="padding-left:5px">
						<input type="button" class="btn" value="关闭" onclick="window.close()" />
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