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
  	function add(){
		openDlg("<%=basePath%>bl/IntoStoreManagerAction!gotoDtl.action?optype=add", 580, 205);
	}
  
  	function update(){
  		var id = "";
  		$("input[name='cboMainChoice']:checkbox").each(function(){ 
            if($(this).attr("checked")){
               id = $(this).val();
               return false;
            }
        });
  		if(!id){
  			return;
  		}
  		openDlg("<%=basePath%>bl/IntoStoreManagerAction!gotoDtl.action?id=" + id + "&optype=update", 580, 205);
  	}
  	
  	function query(){
  		openDlg("<%=basePath%>pages/bl/intoStoreQuery.jsp",550, 160);
  	}
  	
  	function queryByCondition(depSerial, serial, type, beginDate, endDate){
  		var frm = document.getElementsByTagName("form")[0];
  		$("#depSerial").val(depSerial);
  		$("#serial").val(serial);
  		$("#type").val(type);
  		$("#beginDate").val(beginDate);
  		$("#endDate").val(endDate);
  		$("#curPage").val("1");
  	    frm.action = "<%=basePath%>bl/IntoStoreManagerAction!query.action";
  		frm.submit();
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
  		frm.action = "<%=basePath%>bl/IntoStoreManagerAction!del.action";
  		frm.submit();
  	}
  
  </script>
  <body>
   <form action="" method="post">
   	   <input type="hidden" id="refresh" name="refresh" value="bl/IntoStoreManagerAction!query.action"/>
	   <!-- condition begin -->
	   <input type="hidden" id="depSerial" name="depSerial" value="${intoStore.depSerial}"/>
	   <input type="hidden" id="serial" name="serial" value="${intoStore.serial}"/>
	   <input type="hidden" id="type" name="type" value="${intoStore.type}"/>
	   <input type="hidden" id="beginDate" name="beginDate" value="${intoStore.beginDate}"/>
	   <input type="hidden" id="endDate" name="endDate" value="${intoStore.endDate}"/>
	   <!-- condition end-->
		<div class="center" align="center">
		<fieldset>
			<legend><strong class="fieldTitle">商品入库维护</strong></legend>	
			<div id="info" class="info">${info}&nbsp;</div>
			<div class="show">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
				<th width="25px">
					<input type="checkbox" id="cboMainAll" name="cboMainAll" value="" onclick="selAll('cboMainAll','cboMainChoice')"/>						
				</th>
				<th>独立序列号</th>
				<th>商品序列号</th>
				<th>型号</th>
				<th>供应商</th>
				<th>入库日期</th>
				<th>颜色</th>
				<th>数量</th>
				<th>售价</th>
				<th>进价</th>
				<th>出库状态</th>
				<th>备注</th>
				<c:forEach var="rb" items="${resultList}" varStatus="state">
					<c:if test="${state.count % 2 == 0}">
						<tr class="trEven">
					</c:if>
					<c:if test="${state.count % 2 != 0}">
						<tr class="trOdd">
					</c:if>
						<td>
							<input type="checkbox" id="cboMainChoice${state.count }" name="cboMainChoice" value="${rb.id }" onclick="doCheck('cboMainChoice${state.count }')"/> 
						</td>
						<td>${rb.depSerial}&nbsp;</td>
						<td>${rb.serial}&nbsp;</td>
						<td>${rb.type}&nbsp;</td>
						<td>${rb.supply}&nbsp;</td>
						<td>${rb.inDate}&nbsp;</td>
						<td>${rb.color}&nbsp;</td>
						<td>${rb.count}&nbsp;</td>
						<td>${rb.salePrice}&nbsp;</td>
						<td>${rb.purchasePrice}&nbsp;</td>
						<td>${rb.isOut}&nbsp;</td>
						<td>${rb.comm}&nbsp;</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="${intoStore.pageSize - 1 }" step="1" varStatus="state">
					<tr><td colspan="12" style="border-bottom:0">&nbsp;</td></tr>
				</c:forEach>
			</table>
			</div>
			<!-- data end -->
			<!-- menu begin -->
			<table id="tblPage" class="tblPage" cellpadding="0" cellspacing="0" >
				<tr class="trFoot">
					<td align="left" style="padding-left:5px">
						<input type="button" class="btn" value='入库' onclick="add()">
						<input type="button" class="btn" value='修改' onclick="update()"> 
						<input type="button" class="btn" value='查询' onclick="query()">
						<input type="button" class="btn" value='删除' onclick="del()">
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