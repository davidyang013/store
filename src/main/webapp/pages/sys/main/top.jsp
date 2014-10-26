<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE1 {
	font-size: 12px;
	color: #FFFFFF;
}
.STYLE2 {font-size: 9px}
.STYLE3 {
	color: #033d61;
	font-size: 12px;
}
-->
</style>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery-1.8.2.js"></script>
<script type="text/javascript">
$(function(){});
</script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="70" background="<%=basePath%>images/main_05.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" height="24" background="<%=basePath%>images/main_03.gif">&nbsp;</td>
            <td width="505" background="<%=basePath%>images/main_04.gif">&nbsp;</td>
            <td>&nbsp;</td>
            <td width="21"><img src="<%=basePath%>images/main_07.gif" width="21" height="24"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" height="38" background="<%=basePath%>images/main_09.gif">&nbsp;</td>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="77%" height="25" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="50" height="19">&nbsp;</td>
                    <td width="50">&nbsp;</td>
                    <td width="50">&nbsp;</td>
                    <td width="50">&nbsp;</td>
                    <td width="50">&nbsp;</td>
                    <td width="26">&nbsp;</td>
                    <td width="100">&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                </table></td>
                <td width="220" valign="bottom"  nowrap="nowrap"><div align="right"><span class="STYLE1"><span class="STYLE2"></span> </span></div> <font id="timme" ></font></td>
              </tr>
            </table></td>
            <td width="21"><img src="<%=basePath%>images/main_11.gif" width="21" height="38"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="8" style=" line-height:8px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="270" background="<%=basePath%>images/main_29.gif" style=" line-height:8px;">&nbsp;</td>
            <td width="505" background="<%=basePath%>images/main_30.gif" style=" line-height:8px;">&nbsp;</td>
            <td style=" line-height:8px;">&nbsp;</td>
            <td width="21" style=" line-height:8px;"><img src="<%=basePath%>images/main_31.gif" width="21" height="8"></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="28" background="<%=basePath%>images/main_36.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="177" height="28" background="<%=basePath%>images/main_32.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%"  height="22">&nbsp;</td>
            <td width="59%" valign="bottom"><div align="center" class="STYLE1">当前用户:<%=session.getAttribute("loginName") %></div></td>
            <td width="21%">&nbsp;</td>
          </tr>
        </table></td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
           
            <td width="65" height="28">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="23" valign="bottom"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td id="userCenter" height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(<%=basePath%>images/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"> <div align="center" class="STYLE3"><a href="<%=basePath%>pages/sys/user/userPwd.jsp" target="iframeright">修改密码</a></div></td>
                  </tr>
                </table></td>
              </tr>
            </table>
            </td>
            <td width="3"><img src="<%=basePath%>images/main_34.gif" width="3" height="28"></td>
           <td width="65" height="28">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="23" valign="bottom"><table width="58" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td id="userCenter" height="20" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(<%=basePath%>images/bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#a6d0e7'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'"> <div align="center" class="STYLE3"><a href="<%=basePath%>sys/UserManagerAction!toLogin.action" target="_parent">退出系统</a></div></td>
                  </tr>
                </table></td>
              </tr>
            </table>
            </td>
            <td width="3"><img src="<%=basePath%>images/main_34.gif" width="3" height="28"></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
        <td width="21"><img src="<%=basePath%>images/main_37.gif" width="21" height="28"></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>

