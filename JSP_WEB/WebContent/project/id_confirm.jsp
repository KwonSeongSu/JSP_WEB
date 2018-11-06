<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="account.accountDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<title>TEST_WEB</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		accountDAO dao = new accountDAO();
		if(dao.idConfirm(id) == 0){
			PrintWriter script = response.getWriter();
			script.println("<div>");
			script.println("사용 가능한 아이디입니다.<br>");
			script.println("<input type='button' value='돌아가기' onclick='window.close()'/>");
			script.println("</div>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<div>");
			script.println("현재 사용중인 아이디입니다.<br>");
			script.println("<input type='button' value='돌아가기' onclick='window.close()'/>");
			script.println("</div>");
		}
	%>
</body>
</html>