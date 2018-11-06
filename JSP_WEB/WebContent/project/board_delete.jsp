<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<%@page import="board.boardDTO"%>
<jsp:useBean id="bMgr" class="infobean.InfoMgr" />
<html>
<head>
<%
	request.setCharacterEncoding("EUC-KR");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	bMgr.deleteBoard(num);
	String url = "index.jsp?CONTENTPAGE=manager_Info_List&nowPage=" + nowPage;
	response.sendRedirect(url);
%>
<script type="text/javascript">
	function check() {
		document.delFrm.submit();
	}
</script>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<form name="delFrm" method="post" action="Info_Delete.jsp">
	<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
	<input type="hidden" name="num" value="<%=num%>">
</form>
	
</body>
</html>