<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	margin: 0px;
	padding: 0px;
	padding-left: 3px;
	padding-right: 3px;
	background-color: #EEF2FB;
	background: url(<%=basePath%>images/main.bmp) repeat-y repeat-x;
	font-family: 宋体;
}
-->
</style>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery-1.8.2.js"></script>
</head>
<body>
<!-- 会话超时校验 -->
<c:if test="${sessionScope.loginName == null}">
	<c:redirect url="/pages/sys/error/timeOut.jsp" />
</c:if>
 
</body>
</html>
