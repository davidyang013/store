<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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

.STYLE3 {
	font-size: 12px;
	color: #033d61;
}
-->
</style>
<style type="text/css">
.menu_title SPAN {
	FONT-WEIGHT: bold;
	LEFT: 3px;
	COLOR: #ffffff;
	POSITION: relative;
	TOP: 2px
}

.menu_title2 SPAN {
	FONT-WEIGHT: bold;
	LEFT: 3px;
	COLOR: #FFCC00;
	POSITION: relative;
	TOP: 2px
}
</style>
<table width="165" height="100%" border="0" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="28" background="<%=basePath%>images/main_40.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="19%">
						&nbsp;
					</td>
					<td width="81%" height="20">
						<span class="STYLE1">管理菜单</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<table width="151" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<c:forEach var="item" items="${resultList}">
				<c:if test="${item.parentId >= 0}">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td background="<%=basePath%>images/main_51.gif" id="submenu1">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="90%" border="0" align="center"
										cellpadding="0" cellspacing="0">
									<tr>
										<td width="16%" height="25">
											<div align="center">
												<img src="<%=basePath%>images/left.gif" width="10" height="10" />
											</div>
										</td>
										<td width="84%" height="23">
											<table width="95%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td height="20" style="cursor: hand"
														onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
														onmouseout="this.style.borderStyle='none'">
														<span class="STYLE3">
														<a href="${item.url}" target="iframeright" style="text-decoration: none;">${item.name }</a>
														</span>
													</td>
												</tr>
												</table>
											</td>
										</tr>
										</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</c:if>
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td height="18" background="<%=basePath%>images/main_58.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="18" valign="bottom">
						<div align="center" class="STYLE3">
							版本： V1.1.3 </br>
							© 2014 Kingking Yu
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script>
function showsubmenu(sid)
{
whichEl = eval("submenu" + sid);
imgmenu = eval("imgmenu" + sid);
if (whichEl.style.display == "none")
{
eval("submenu" + sid + ".style.display=\"\";");
imgmenu.background="<%=basePath%>/../images/main_47.gif";
}
else
{
eval("submenu" + sid + ".style.display=\"none\";");
imgmenu.background="<%=basePath%>/../images/main_48.gif";
}
}

</script>