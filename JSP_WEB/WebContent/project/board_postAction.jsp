<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="bMgr" class="infobean.InfoMgr"/>
<%
	  bMgr.insertBoard(request);
	  response.sendRedirect("index.jsp?CONTENTPAGE=Info_List");
%>