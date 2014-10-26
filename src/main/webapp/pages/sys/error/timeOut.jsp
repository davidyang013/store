<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery-1.8.2.js"></script>
<script type="text/javascript">
$(function(){
	$("#toLogin").click(function(){
		window.top.location.href="<%=basePath%>/sys/UserManagerAction!toLogin.action";
		
	});
});
</script>
</head>
<body>
<center>
<font color="red" size="3">对不起，会话已超时！请<a href="#" id="toLogin">重新登录</a>。</font>
</center>
</body>
</html>