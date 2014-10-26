PartRefresh:
<%@ page isThreadSafe="true" contentType="text/html;charset=GBK" %>
<jsp:useBean id="jsContent" scope="request" class="com.yu.store.sys.util.JsContent"/>
<%= jsContent.toString() %>