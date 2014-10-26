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
		openDlg("<%=basePath%>bl/MemberManagerAction!gotoDtl.action?optype=add", 582, 145);
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
  		openDlg("<%=basePath%>bl/MemberManagerAction!gotoDtl.action?id=" + id + "&optype=update", 582, 145);
  	}
  	
  	function query(){
  		openDlg("<%=basePath%>pages/bl/memberQuery.jsp", 302, 122);
  	}
  	
  	function queryByCondition(id, phone){
  		var frm = document.getElementsByTagName("form")[0];
  		$("#id").val(id);
  		$("#phone").val(phone);
  		$("#curPage").val("1");
  	    frm.action = "<%=basePath%>bl/MemberManagerAction!query.action";
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
  		frm.action = "<%=basePath%>bl/MemberManagerAction!del.action";
  		frm.submit();
  	}
  
  </script>
  <body>
   <form action="" method="post">
	   <input type="hidden" id="refresh" name="refresh" value="bl/MemberManagerAction!query.action"/>
	   <!-- condition begin -->
	   <input type="hidden" id="id" name="id" value="${member.id}"/>
	   <input type="hidden" id="phone" name="phone" value="${member.phone}"/>
	   <!-- condition end-->
		<div class="center" align="center">
		<fieldset>
			<legend><strong class="fieldTitle">会员信息维护</strong></legend>	
			<div id="info" class="info">${info}&nbsp;</div>
			<div class="show">
			<!-- data begin -->
			<div class="scroll">
			<table id="tblMain" class="tblMain" align="center" cellpadding="0" cellspacing="0" onmouseover="lightEffect('tblMain', ${fn:length(resultList) + 1})" >
				<th width="25px">
					<input type="checkbox" id="cboMainAll" name="cboMainAll" value="" onclick="selAll('cboMainAll','cboMainChoice')"/>						
				</th>
				<th>会员卡号</th>
				<th>客户姓名</th>
				<th>联系方式</th>
				<th>会员积分</th>
				<th>VIP选项</th>
				<th>消费金额</th>
				<th>消费日期</th>
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
						<td>${rb.id}&nbsp;</td>
						<td>${rb.name}&nbsp;</td>
						<td>${rb.phone}&nbsp;</td>
						<td>${rb.credit}&nbsp;</td>
						<td>${rb.vipType}&nbsp;</td>
						<td>${rb.price}&nbsp;</td>
						<td>${rb.outDate}&nbsp;</td>
					</tr>
				</c:forEach>
				<c:forEach begin="${fn:length(resultList) }" end="${member.pageSize - 1 }" step="1" varStatus="state">
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