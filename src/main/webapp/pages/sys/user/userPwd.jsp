<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if(request.getSession().getAttribute("loginName") == null)
	response.sendRedirect(basePath + "pages/sys/login.jsp");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="js/sys/pwd.js" type="text/javascript" language="javascript"></script>
    <link href="css/common/common.css" rel="stylesheet" type="text/css">
    <link href="css/sys/pwd.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
   <div class="main">
	
	<div class="center" align="center">
		<fieldset style="width:90%">
			  	<legend><strong class="fieldTitle">密码修改</strong></legend>	
		  <form action="sys/UserManagerAction!updatePwd.action" method="post">
		  <table border="0" width="100%">
		  	<tr>
		  		<td width="30%">
		  			&nbsp;
		  		</td>
		  		<td align="right" width="100px" class="font">
		  			<font color="red">*</font>原密码:
		  		</td>
		  		<td width="100px">
		  			<input class="text" type="password" id="pwdOld" name="pwdOld">
		  		</td>
		  		<td align="left">
		  			<font color="red" size="2px" id="oldInfo">${info }</font>&nbsp;
		  		</td>
		  	</tr>
		  	 <tr>
		  	 	<td width="30%">
		  			&nbsp;
		  		</td>
		  		<td align="right" width="100px" class="font">
		  			<font color="red">*</font>新密码:
		  		</td>
		  		<td width="100px">
		  			<input class="text" type="password" id="pwd" name="pwd">
		  		</td>
		  		<td align="left">
		  			<font color="red" size="2px" id="newInfo"></font>&nbsp;
		  		</td>
		  	</tr>
		  	<tr>
		  		<td width="30%">
		  			&nbsp;
		  		</td>
		  		<td align="right" width="100px" class="font">
		  			<font color="red">*</font>重复新密码:
		  		</td>
		  		<td width="100px">
		  			<input class="text" type="password" id="pwdRepeat" name="pwdRepeat">
		  		</td>
		  		<td align="left">
		  			<font color="red" size="2px" id="repeatInfo"></font>&nbsp;
		  		</td>
		  	</tr>
		  </table>
		  <br/>
		  <table border="0" width="100%">
		  	<tr>
		  		<td width="40%">
		  			&nbsp;
		  		</td>
		  		<td id="" align="left" width="10%">
		  		<input type="button" id="btnSave" class="btn" value="保存" onclick="upValidate()"/>
		  		</td>
		  		<td id="" align="left" width="10%">
		  		<input type="reset" id="btnReset"  class="btn" value="重置" onclick="resetInfo()"/>
		  		</td>
		  		<td width="40%">
		  		&nbsp;
		  		</td>
		  	</tr>
		  </table>
		  </form>
		  </fieldset>
	  </div>
	</div>
  </body>
</html>
