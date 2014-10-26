<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>EarSight库存管理系统</title>
</head>
<frameset rows="98,*,8" frameborder="no" border="0" framespacing="0">
  <frame src="<%=basePath %>pages/sys/main/top.jsp" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" />
  <frame src="<%=basePath%>pages/sys/main/center.jsp" name="mainFrame" id="mainFrame" />
  <frame src="<%=basePath %>pages/sys/main/down.jsp" name="bottomFrame" scrolling="no" noresize="noresize" id="bottomFrame" />
</frameset>
<noframes>
<body>
</body>
</noframes></html>
